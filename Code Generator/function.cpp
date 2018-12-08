#include "stdafx.h"

#include "function.h"
#include <fstream>
#include <cstring>
#include <map>
#include "error.h"

using namespace std;

/*
######### Memory ###########
4G	=====================
	|					|
	|-------------------|
	|		...			|
	|-------------------|
	|					|
	|Temporary Variables|
	|					|
	|-------------------| <- Temporary Variables $k0
	|	  Variables		|
	|-------------------| <- Local Variables $k1
	|	  Parameter		|
	|-------------------|	(Function Stack)
	|	Frame Pointer	|
	|-------------------|
	|   Return Address	|
	|-------------------| <- Current Frame Pointer $fp
	|					|
	|		$s0-7		|
	|		$t4-9		|
	|		$k0-1		|	(Runtime Stack For Register)
	|					|
	|-------------------|
	|		...			|
	|-------------------|
	|		main		|
	|```````````````````| <- dataSegmentAddress + dataBaseAddress = functionStackAddress
	|-------------------| %- align to 4
	|					|
	|	 Data Segment	|	  (String Storage)
	|					|
	|-------------------| <- dataBaseAddress
	|					|
	|-------------------|
	|					|
	|  Global Variables	|	(Global Variables)
	|					|
	|-------------------| <- Global Pointer $gp
	|                   |
0	=====================
*/





static int labelCount = 0;//全局标签计数器
int VarCount = 0;//全局临时变量计数器
static string funcName = "GLOBAL";//临时变量的所属域,当域发生变化,整个计数器重新洗牌
static int globalStrCount = 0;//全局字符串计数器


static unsigned dataSegmentAddress = 0;//字符串占据的大小
unsigned int functionStackAddress;//临时参数栈空间指针
unsigned int currentFunctionStackAddress;//当前参数栈指针的地址
const int maxFunctionStack = 100;//设置临时参数栈最大为100字节(最多有25个参数)
const unsigned int dataBaseAddress = 0x10010000;//数据段起始地址
unsigned int returnValueAddress;//函数返回值存放点
unsigned int functionStackTop;//整体函数栈的起始地址(即全局数据区域起始地址)

extern const string opCodeToFileName = "OptimizedMiddleCode.txt";
extern const string tmpCodeToFileName = "MiddleCode.txt";
extern const string mipsCodeToFileName = "Assembly.asm";
extern const string finalCodeToFileName = "OptimizedAssembly.asm";
extern const string simuCodeToFileName = "SimulatedAssembly.asm";

extern vector<SymbolTableItem> SymbolTable;

vector<MiddleCode> MiddleCodeArr; // 中间代码生成集合
extern vector<MiddleCode> optimizedMiddleCodeArr;
extern map<int, string> varToRegisterMap;

vector<string> constStringSet; // 程序需要打印的常量字符串集合,放在.data域
map<string, string> stringWithLabel; // 字符串与伪指令标签
map<string, unsigned> maxTempOrderMap; // 每个函数最大的临时变量编号
map<string, unsigned> maxVarOrderMap;

string getLabel() {
	labelCount++;
	return ("$Label" + to_string(labelCount));
}

string getVar() {
	return ("#" + to_string(VarCount++));
}

string getStringLabel() {
	globalStrCount++;
	return ("$String" + to_string(globalStrCount));
}

int getMaxTemp(string funcName) {
	int maxTempOrder = 0;
	map<string, unsigned int>::iterator itr;
	for (itr = maxTempOrderMap.begin(); itr != maxTempOrderMap.end(); itr++) {
		if (itr->first == funcName) {
			maxTempOrder = itr->second;
			break;
		}
	}
	if (itr == maxTempOrderMap.end())
		return 0;
	else
		return (maxTempOrder > TEMP_REGISTER)? TEMP_REGISTER + 1:maxTempOrder + 1;
}


int getMaxVar(string funcName) {
	int maxTempOrder = 0;
	for (map<string, unsigned int>::iterator itr = maxVarOrderMap.begin(); itr != maxVarOrderMap.end(); itr++) {
		if (itr->first == funcName)
			maxTempOrder = itr->second;
	}
	return maxTempOrder;
}

// 让字符串原样输出
void cancelEscapeChar(string  & target) {
	vector< unsigned int> indexSets;
	for (unsigned int i = 0; i < target.size(); i++) {
		if (target.at(i) == '\\') {
			indexSets.push_back(i);
		}
	}
	for (unsigned int i = 0; i < indexSets.size(); i++) {
		target.insert(indexSets.at(i) + i, "\\");
	}
}

int integerConversion(string target) {
	return atoi(target.c_str());
}


void genQuaterCode(ofstream &out, MiddleCode item) {
	switch (item.type) {
	case End:
		out << "EXIT" << endl;
		break;
	case ParamPass:
		out << "PUSH " << item.target << endl;
		break;
	case FunctionCall:
		out << "CALL " << item.target << endl;
		break;
	case Pass:
		if (item.isTargetArr) {
			out << item.target << "[" << item.indexTargetArr << "] = ";
			if (item.isLeftArr) {
				out << item.left << "[" << item.indexLeftArr << "]" << endl;
			}
			else {
				out << item.left << " " << item.op << " " << item.right << endl;
			}
		}
		else {
			// 查询是否为临时变量
			if (item.target.size() > 0 && item.target.at(0) == '#') {
				map<string, unsigned>::iterator iter = maxTempOrderMap.find(funcName);
				unsigned order = integerConversion(item.target.substr(1));
				if (iter == maxTempOrderMap.end()) {
					maxTempOrderMap.insert(map<string, unsigned>::value_type(funcName, order));
				}
				else {
					if (iter->second < order)
						iter->second = order;
				}
			}
			out << item.target << " = ";
			if (item.isLeftArr) {
				out << item.left << "[" << item.indexLeftArr << "]" << endl;
			}
			else {
				out << item.left << " " << item.op << " " << item.right << endl;
			}
		}
		break;
	case Label:
		out << "LABEL " + item.target << endl;
		break;
	case FunctionDef:
		funcName = item.target;
		if (item.funcType == VoidType) {
			out << "FUNC void " + item.target << "()" << endl;
		}
		else if (item.funcType == ReturnIntType) {
			out << "FUNC int " + item.target << "()" << endl;
		}
		else {
			out << "FUNC char " + item.target << "()" << endl;
		}
		break;
	case ParamDef:
		if (item.valueType == IntType) {
			out << "PARA int " << item.target << endl;
		}
		else {
			out << "PARA char " << item.target << endl;
		}
		break;
	case Jump:
		out << "JMP " << item.target << endl;
		break;
	case BEZ:
		out << "BEZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case BNZ:
		out << "BNZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case BLZ:
		out << "BLZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case BLEZ:
		out << "BLEZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case BGZ:
		out << "BGZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case BGEZ:
		out << "BGEZ " << item.left << " " << item.right << " " << item.target << endl;
		break;
	case Read:
		if (item.valueType == IntType) {
			out << "READ int " << item.target << endl;
		}
		else {
			out << "READ char " << item.target << endl;
		}
		break;
	case Print:
		if (item.isVal == true) {
			out << "PRT id " << item.target << endl;
		}
		else if (item.valueType == StringType) {
			out << "PRT string " << '\"' << item.target << '\"' << endl;
			cancelEscapeChar(item.target);
			constStringSet.push_back(item.target);
		}
		else if (item.valueType == IntType)
			out << "PRT int " << integerConversion(item.target) << endl;
		else {
			if (item.target == "\n") {
				out << "ENTER" << endl;
			}
			else

				out << "PRT char " << '\'' << item.target.at(0) << '\'' << endl;
		}
		break;
	case Return:
		if (item.isVal == true)
			out << "RET id " << item.target << endl;
		else if (item.funcType == ReturnIntType)
			out << "RET int " << integerConversion(item.target) << endl;
		else if (item.funcType == ReturnCharType)
			out << "RET char " << '\'' << item.target.at(0) << '\'' << endl;
		else
			out << "RET" << endl;
		break;
	default:break;
	}
}

void writeMiddleCode() {
	maxTempOrderMap.clear();
	constStringSet.clear();
	stringWithLabel.clear();
	ofstream out(tmpCodeToFileName, ios::out);
	string funcName = "GLOBAL";
	for (unsigned int i = 0; i < MiddleCodeArr.size(); i++) {
		MiddleCode item = MiddleCodeArr.at(i);
		genQuaterCode(out, item);
	}
	out.close();
}

// 生成 text 和 data 段
void writeAssemblyCode() {
	ofstream out(mipsCodeToFileName, ios::out);
	// 生成 data 段
	out << ".data" << endl;
	getDataSegment(out);
	// 对齐 data 段栈顶地址
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// 设置临时参数栈为 data 段顶部
	functionStackAddress = dataSegmentAddress + 4 + dataBaseAddress;
	currentFunctionStackAddress = 0;
	returnValueAddress = dataSegmentAddress + dataBaseAddress;
	// 生成 main 函数声明
	out << ".globl main" << endl;
	// 生成 text 段
	funcName = "GLOBAL";
	out << ".text" << endl;
	getTextSegment(out, MiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}
// 生成 Data 段 最大值为 dataSegmentAddress
void getDataSegment(ofstream & out) {
	dataSegmentAddress = 0;
	for (unsigned int i = 0; i < constStringSet.size(); i++) {
		string item = constStringSet.at(i);
		// 检查是否是重复的公共字符串
		map<string, string>::iterator iter = stringWithLabel.find(item);
		if (iter != stringWithLabel.end())
			continue;
		dataSegmentAddress += item.size() + 1;//'\0'占一个字节
		string label = getStringLabel();
		out << "\t" << label << ":.asciiz \"" << item << "\"" << endl;
		stringWithLabel.insert(map<string, string>::value_type(item, label));
	}
}

int locateVariable(string target) {
	int order = -1;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {
			if (target == item.getId())
				order = item.getOrder();
		}
		else if (item.getFuncName() == funcName) {
			if (target == item.getId()) {
				order = item.getOrder();
			}
		}
	}
	return order;
}

void getVariable(string target, string targetReg, ofstream & out) {
	int order = locateVariable(target);
	SymbolTableItem symbol = SymbolTable.at(order);
	string funcName = symbol.getFuncName();
	string eleName = symbol.getId();
	int number = 0;
	unsigned int i;
	for (i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (funcName == "GLOBAL") {
			if (item.getItemType() != Constant)
				break;
		}
		else if (item.getId() == funcName) {
			if (item.getItemType() == Function) {
				i++;
				break;
			}
		}
	}
	for (; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (funcName != "GLOBAL")
			if (item.getItemType() == Constant)
				continue;
		if (item.getId() == eleName) {
			break;
		}
		if (item.getArrSize() == 0)
			number += 4;
		else
			number += item.getArrSize() * 4;
	}
	if (funcName == "GLOBAL") {
		out << "lw " << targetReg << " " << number << "($gp)" << endl;
	}
	else {
		out << "lw " << targetReg << " " << number + 8 << "($fp)" << endl;
	}
}

void getTemp(int order, string targetReg, ofstream & out) {
	// 若 order > TEMP_REGISTER 时需要读取内存
	out << "lw " << targetReg << " " << (order - 1 - TEMP_REGISTER) * 4 << "($k0)" << endl;
}

void locateVariableAddress(string target, string targetReg, ofstream & out) {
	int order = locateVariable(target);
	SymbolTableItem symbol = SymbolTable.at(order);
	string funcName = symbol.getFuncName();
	string eleName = symbol.getId();
	int number = 0;
	unsigned int i;
	for (i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (funcName == "GLOBAL") {
			if (item.getItemType() != Constant)
				break;
		}
		else if (item.getId() == funcName) {
			if (item.getItemType() == Function) {
				i++;
				break;
			}
		}
	}
	for (; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if(funcName != "GLOBAL")
			if (item.getItemType() == Constant)
				continue;
		if (item.getId() == eleName) {
			break;
		}
		if (item.getArrSize() == 0)
			number += 4;
		else
			number += item.getArrSize() * 4;
	}
	if (funcName == "GLOBAL") {
		out << "addiu " << targetReg << " $gp " << number << endl;
	}
	else {
		out << "addiu " << targetReg << " $fp " << number + 8 << endl;
	}
}

// 获取临时变量的地址
void locateTempAddress(int order, string targetReg, ofstream & out) {
	// 若 order > TEMP_REGISTER 时需要读取内存
	out << "addiu " << targetReg << " $k0 " << (order - 1 - TEMP_REGISTER) * 4 << endl;
}


// 生成Text段代码的辅助函数
/*
	赋值目标为数组 a[$t0] = $t1 地址存于 $t0 结果存于 $t1

*/
void locateArray(MiddleCode item, ofstream & out) {
	locateVariableAddress(item.target, "$t0", out);

	// 观察indexTargetArr即数组下标
	string indexTargetArr = item.indexTargetArr;
	if (IsNum(indexTargetArr.at(0))) {		// 属于数字
		int number = integerConversion(indexTargetArr);
		number = 4 * number;
		out << "addiu $t0 $t0 " << number << endl;
	}
	else if (indexTargetArr.at(0) == '#') {	// 是临时变量
									// 放在$t1
		int g = integerConversion(indexTargetArr.substr(1));
		if (g > TEMP_REGISTER) {
			getTemp(g, "$t1", out);
			out << "sll $t1 $t1 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
		else {
			out << "sll $t1 " << "$t" << (g + 3) << " 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
	}
	else {							// 是变量
		map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexTargetArr));
		if (itr != varToRegisterMap.end()) {
			out << "sll $t1 " << itr->second << " 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
		else {
			// 地址放在$t1
			getVariable(indexTargetArr, "$t1", out);
			out << "sll $t1 $t1 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
	}
}

void handleAssignment(MiddleCode item, ofstream & out) {
	if (item.isTargetArr) {
		string left = item.left;
		string right = item.right;
		char op = item.op;
		locateArray(item, out);
		if (right == "0" && item.op == '*') {
			out << "sw $0 0($t0)" << endl;
			return;
		}
		if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// 数字
			if (op == '+') {
				out << "li $t1 " << integerConversion(left) + integerConversion(right) << endl;
			}
			else if (op == '-') {
				out << "li $t1 " << integerConversion(left) - integerConversion(right) << endl;
			}
			else if (op == '*') {
				out << "li $t1 " << integerConversion(left) * integerConversion(right) << endl;
			}
			else if (op == '/') {
				out << "li $t1 " << integerConversion(left) / integerConversion(right) << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
		else if (IsNum(right.at(0))) {
			string tempReg = "$t1";
			if (left.at(0) == '#') {		// 临时变量
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (left == "Ret") {			// 返回值
				out << "move $t1 $v0" << endl;
			}
			else {								// 标识符
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempReg = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (op == '+') {
				out << "addiu $t1 " << tempReg << " " << integerConversion(right) << endl;
			}
			else if (op == '-') {
				out << "subu $t1 " << tempReg << " " << integerConversion(right) << endl;
			}
			else if (op == '*') {
				out << "mul $t1 " << tempReg << " " << integerConversion(right) << endl;
			}
			else if (op == '/') {
				out << "div $t1 " << tempReg << " " << integerConversion(right) << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
		else if (IsNum(left.at(0))) {
			string tempReg = "$t2";
			if (right.at(0) == '#') {		// 临时变量
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (right == "Ret") {			// 返回值
				out << "move $t2 $v0" << endl;
			}
			else {								// 标识符
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
				if (itr != varToRegisterMap.end()) {
					tempReg = itr->second;
				}
				else {
					getVariable(right, "$t2", out);
				}
			}
			if (op == '+') {
				out << "addiu $t1 " << tempReg << " " << integerConversion(left) << endl;
			}
			else if (op == '-') {
				out << "subu $t1 " << tempReg << " " << integerConversion(left) << endl;
			}
			else if (op == '*') {
				out << "mul $t1 " << tempReg << " " << integerConversion(left) << endl;
			}
			else if (op == '/') {
				out << "div $t1 " << tempReg << " " << integerConversion(left) << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
		else {
			string tempLeft = "$t1", tempRight = "$t2";
			if (left.at(0) == '#') {		// 临时变量
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t1", out);
				}
				else {
					tempLeft = "$t" + to_string(g + 3);
				}
			}
			else if (left == "Ret") {			// 返回值
				out << "move $t1 $v0" << endl;
			}
			else {								// 标识符
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempLeft = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (right.at(0) == '#') {		// 临时变量
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t2", out);
				}
				else {
					tempRight = "$t" + to_string(g + 3);
				}
			}
			else if (right == "Ret") {			// 返回值
				out << "move $t2 $v0" << endl;
			}
			else {								// 标识符
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
				if (itr != varToRegisterMap.end()) {
					tempRight = itr->second;
				}
				else {
					getVariable(right, "$t2", out);
				}
			}

			if (op == '+') {
				out << "addu $t1 " << tempLeft << " " << tempRight << endl;
			}
			else if (op == '-') {
				out << "subu $t1 " << tempLeft << " " << tempRight << endl;
			}
			else if (op == '*') {
				out << "mul $t1 " << tempLeft << " " << tempRight << endl;
			}
			else if (op == '/') {
				out << "div $t1 " << tempLeft << " " << tempRight << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
	}
	else {
			bool isVar = false;
			string targetReg = "$t0";
			int g, g1;
			if (item.target.at(0) == '#') {		// 临时变量
				g1 = g = integerConversion(item.target.substr(1));
				if (g > TEMP_REGISTER) {
					locateTempAddress(integerConversion(item.target.substr(1)), "$t0", out);
				}
				else {
					targetReg = "$t" + to_string(g + 3);
					isVar = true;
				}
			}
			else {								// 标识符
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					targetReg = itr->second;
					isVar = true;
				}
				else {
					locateVariableAddress(item.target, "$t0", out);
				}
			}

			if (item.isLeftArr) {
				// 单纯的数组取值
				// 分析索引下标,将数组地址取出放在$t1
				locateVariableAddress(item.left, "$t1", out);
				// 下标地址取出放在$t2
				string indexLeftArr = item.indexLeftArr;
				if (IsNum(indexLeftArr.at(0))) {			// 数字
					out << "addiu $t1 $t1 " << 4 * integerConversion(indexLeftArr) << endl;
				}
				else if (indexLeftArr.at(0) == '#') {		// 临时变量
					g = integerConversion(indexLeftArr.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$t2", out);
						out << "sll $t2 $t2 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
					else {
						out << "sll $t2 " << "$t" << (g + 3) << " 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
				}
				else {								// 标识符
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexLeftArr));
					if (itr != varToRegisterMap.end()) {
						out << "sll $t2 " << itr->second << " 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
					else {
						getVariable(indexLeftArr, "$t2", out);
						out << "sll $t2 $t2 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
				}
				// 取出数据,放在$t1
				if (isVar)
					out << "lw " << targetReg << " 0($t1)" << endl;
				else {
					out << "lw $t1 0($t1)" << endl;
					out << "sw $t1 0($t0)" << endl;
				}
				return;

			}


			string left = item.left;
			string right = item.right;
			char op = item.op;
			if (right == "0" && item.op == '*') {
				if (isVar)
					out << "move " << targetReg << " $0" << endl;
				else
					out << "sw $0 0($t0)" << endl;
				return;
			}
			if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// 数字
				if (isVar) {
					if (op == '+') {
						out << "li " << targetReg << " " << integerConversion(left) + integerConversion(right) << endl;
					}
					else if (op == '-') {
						out << "li " << targetReg << " " << integerConversion(left) - integerConversion(right) << endl;
					}
					else if (op == '*') {
						out << "li " << targetReg << " " << integerConversion(left) * integerConversion(right) << endl;
					}
					else if (op == '/') {
						out << "li " << targetReg << " " << integerConversion(left) / integerConversion(right) << endl;
					}
				}
				else
				{
					if (op == '+') {
						out << "li $t1 " << integerConversion(left) + integerConversion(right) << endl;
					}
					else if (op == '-') {
						out << "li $t1 " << integerConversion(left) - integerConversion(right) << endl;
					}
					else if (op == '*') {
						out << "li $t1 " << integerConversion(left) * integerConversion(right) << endl;
					}
					else if (op == '/') {
						out << "li $t1 " << integerConversion(left) / integerConversion(right) << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
			else if (IsNum(right.at(0))) {
				string tempReg = "$t1";
				if (left.at(0) == '#') {		// 临时变量
					int g = integerConversion(left.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, tempReg, out);
					}
					else {
						tempReg = "$t" + to_string(g + 3);
					}

				}
				else if (left == "Ret") {			// 返回值
					out << "move $t1 $v0" << endl;
				}
				else {								// 标识符
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
					if (itr != varToRegisterMap.end()) {
						tempReg = itr->second;
					}
					else {
						getVariable(left, "$t1", out);
					}
				}
				if (isVar) {
					if (op == '+') {
						out << "addiu " << targetReg << " " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '-') {
						out << "subu " << targetReg << " " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '*') {
						out << "mul " << targetReg << " " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '/') {
						out << "div " << targetReg << " " << tempReg << " " << integerConversion(right) << endl;
					}
				}
				else {
					if (op == '+') {
						out << "addiu $t1 " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '-') {
						out << "subu $t1 " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '*') {
						out << "mul $t1 " << tempReg << " " << integerConversion(right) << endl;
					}
					else if (op == '/') {
						out << "div $t1 " << tempReg << " " << integerConversion(right) << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
			else if (IsNum(left.at(0))) {
				string tempReg = "$t1";
				if (right.at(0) == '#') {		// 临时变量
					int g = integerConversion(right.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, tempReg, out);
					}
					else {
						tempReg = "$t" + to_string(g + 3);
					}

				}
				else if (right == "Ret") {			// 返回值
					out << "move $t1 $v0" << endl;
				}
				else {								// 标识符
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
					if (itr != varToRegisterMap.end()) {
						tempReg = itr->second;
					}
					else {
						getVariable(right, "$t1", out);
					}
				}
				if (isVar) {
					if (op == '+') {
						out << "addiu " << targetReg << " " << tempReg << " " << integerConversion(left) << endl;
					}
					else if (op == '-') {
						out << "li $t0 " << integerConversion(left) << endl;
						out << "subu " << targetReg << " $t0 " << tempReg << endl;
					}
					else if (op == '*') {
						out << "mul " << targetReg << " " << tempReg << " " << integerConversion(left) << endl;
					}
					else if (op == '/') {
						out << "li $t0 " << integerConversion(left) << endl;
						out << "div " << targetReg << " $t0 " << tempReg << endl;
					}
				}
				else {


					if (op == '+') {
						out << "addiu $t1 " << tempReg << " " << integerConversion(left) << endl;
					}
					else if (op == '-') {
						out << "li $t1 " << integerConversion(left) << endl;
						out << "subu $t1 $t1 " << tempReg << endl;
					}
					else if (op == '*') {
						out << "mul $t1 " << tempReg << " " << integerConversion(left) << endl;
					}
					else if (op == '/') {
						out << "li $t1 " << integerConversion(left) << endl;
						out << "div $t1 $t1 " << tempReg << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
			else {
				string tempLeft = "$t1", tempRight = "$t2";
				if (left.at(0) == '#') {		// 临时变量
					int g = integerConversion(left.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$t1", out);
					}
					else {
						tempLeft = "$t" + to_string(g + 3);
					}
				}
				else if (left == "Ret") {			// 返回值
					out << "move $t1 $v0" << endl;
				}
				else {								// 标识符
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
					if (itr != varToRegisterMap.end()) {
						tempLeft = itr->second;
					}
					else {
						getVariable(left, "$t1", out);
					}
				}
				if (right.at(0) == '#') {		// 临时变量
					int g = integerConversion(right.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$t2", out);
					}
					else {
						tempRight = "$t" + to_string(g + 3);
					}
				}
				else if (right == "Ret") {			// 返回值
					out << "move $t2 $v0" << endl;
				}
				else {								// 标识符
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
					if (itr != varToRegisterMap.end()) {
						tempRight = itr->second;
					}
					else {
						getVariable(right, "$t2", out);
					}
				}
				if (isVar) {
					if (op == '+') {
						out << "addu " << targetReg << " " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '-') {
						out << "subu " << targetReg << " " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '*') {
						out << "mul " << targetReg << " " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '/') {
						out << "div " << targetReg << " " << tempLeft << " " << tempRight << endl;
					}
				}
				else {
					if (op == '+') {
						out << "addu $t1 " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '-') {
						out << "subu $t1 " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '*') {
						out << "mul $t1 " << tempLeft << " " << tempRight << endl;
					}
					else if (op == '/') {
						out << "div $t1 " << tempLeft << " " << tempRight << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
	}
}

// 计算全局变量数目
int arrageGlobalVariable() {
	int number = 0;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function)
			break;
		if (item.getItemType() == Constant)
			continue;
		if (item.getArrSize() == 0)
			number += 4;
		else
			number += item.getArrSize() * 4;
	}
	return number;
}

void initializeStack(string funcName, ofstream & out) {
	// 参数计数器
	int parameterCount = 0;
	int number = 0;									// 变量不进行初始化
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function && item.getId() == funcName) {
			for (unsigned int j = i + 1; j < SymbolTable.size(); j++) {
				item = SymbolTable.at(j);
				if (item.getFuncName() != funcName)
					break;
				if (item.getItemType() == Constant)
					continue;
				if (item.getItemType() == Parameter) {// 是参数
													  // 借用$v1寄存器作为中转
					if (parameterCount < 4) {
						string id = item.getId();
						string aReg = "$a" + to_string(parameterCount);
						map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(id));
						if (itr != varToRegisterMap.end()) {
							out << "move " << itr->second << " " << aReg << endl;
						}
						else {
							out << "sw " << aReg << " " << 4 * parameterCount << "($sp)" << endl;
						}
						parameterCount++;
						number += 4;
					}
					else
					{
						string id = item.getId();
						map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(id));
						if (itr != varToRegisterMap.end()) {
							out << "lw " << itr->second << " " << parameterCount * 4 - 16 << "($k1)" << endl;
						}
						else {
							out << "lw $v1 " << parameterCount * 4 - 16 << "($k1)" << endl;
							out << "sw $v1 " << 4 * parameterCount << "($sp)" << endl;
						}
						parameterCount++;
						number += 4;
					}
					
				}
				else if (item.getItemType() == Variable) {
					if (item.getArrSize() == 0) {
						number += 4;
					}
					else {
						number += 4 * item.getArrSize();
					}
				}
			}
			break;
		}
	}
	// 分配临时变量所用空间
	map<string, unsigned>::iterator iter = maxTempOrderMap.find(funcName);
	if (iter != maxTempOrderMap.end() && iter->second > TEMP_REGISTER) {
		out << "addiu $sp $sp " << number + (iter->second - TEMP_REGISTER) * 4 << endl;
		out << "addiu $k0 $sp -" << (iter->second - TEMP_REGISTER) * 4 << endl;
	}
	else {
		out << "addiu $sp $sp " << number << endl;
		out << "move $k0 $sp" << endl;
	}
}

void handleFunctionDefinition(string funcName, ofstream & out) {
	if (funcName == "main") {
		// main 函数只需要做全局变量的数据分配
		int size = arrageGlobalVariable();
		out << "li $k1 " << functionStackAddress << endl;
		out << "addiu $fp $gp " << size << endl;
		out << "addiu $sp $fp 8" << endl;
		initializeStack(funcName, out);
	}
	else {
		// 设置上一级函数的基地址
		initializeStack(funcName, out);
	}
}
// 处理分支类指令
void handleBranch(MiddleCode item, ofstream & out) {
	// 把判断的变量值存入$a1寄存器中,再调用转移函数
	string obj = item.left;
	string branchReg0 = "$a1";
	map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(obj));
	if (itr != varToRegisterMap.end()) {
		branchReg0 = itr->second;
	}
	else {
		if (obj.at(0) == '#') {
			int g = integerConversion(obj.substr(1));
			if (g > TEMP_REGISTER) {
				getTemp(g, branchReg0, out);
			}
			else {
				branchReg0 = "$t" + to_string(g + 3);
			}
		}
		else {
			getVariable(obj, branchReg0, out);
		}
	}

	obj = item.right;
	string branchReg1 = "$a2";
	itr = varToRegisterMap.find(locateVariable(obj));
	if (itr != varToRegisterMap.end()) {
		branchReg1 = itr->second;
	}
	else {
		if (IsNum(obj.at(0))) {
			branchReg1 = obj;
		}
		else if (obj.at(0) == '#') {
			int g = integerConversion(obj.substr(1));
			if (g > TEMP_REGISTER) {
				getTemp(g, branchReg1, out);
			}
			else {
				branchReg1 = "$t" + to_string(g + 3);
			}
		}
		else {
			getVariable(obj, branchReg1, out);
		}
	}

	switch (item.type)
	{
	case BEZ:
		out << "beq " << branchReg0 << " " << branchReg1 <<" " << item.target << endl;
		break;
	case BNZ:
		out << "bne " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
		break;
	case BLZ:
		out << "blt " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
		break;
	case BLEZ:
		out << "ble " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
		break;
	case BGZ:
		out << "bgt " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
		break;
	case BGEZ:
		out << "bge " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
		break;
	default:
		break;
	}
}


// 函数返回处理
void handleReturn(ofstream & out) {
	
	out << "jr $ra" << endl;
}

// 生成最终的Text段代码
void getTextSegment(ofstream & out, vector<MiddleCode> QuaterCode) {
	for (unsigned int i = 0; i < QuaterCode.size(); i++) {
		MiddleCode item = QuaterCode.at(i);
		map<int, string>::iterator itr;
		switch (item.type) {
		case ParamPass:
			if (currentFunctionStackAddress / 4 < 4) {
				string aReg = "$a" + to_string(currentFunctionStackAddress / 4);
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "move " << aReg << " " << itr->second << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (IsNum(item.target.at(0))) {
					out << "li " << aReg << " " << integerConversion(item.target) << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (item.target.at(0) == '#') {	// 临时变量
					int g = integerConversion(item.target.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, aReg, out);
						currentFunctionStackAddress += 4;
						break;
					}
					else {
						out << "move " << aReg << " " << "$t" << (g + 3) << endl;
						currentFunctionStackAddress += 4;
						break;
					}
				}
				else {							// 标识符
					getVariable(item.target, aReg, out);
					currentFunctionStackAddress += 4;
					break;
				}
			}
			else {
				// 传递变量地址
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "sw " << itr->second << " " << currentFunctionStackAddress - 16 << "($k1)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (IsNum(item.target.at(0))) {
					out << "li $v0 " << integerConversion(item.target) << endl;
					out << "sw $v0 " << currentFunctionStackAddress - 16 << "($k1)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (item.target.at(0) == '#') {	// 临时变量
					int g = integerConversion(item.target.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$v0", out);
						out << "sw $v0 " << currentFunctionStackAddress - 16 << "($k1)" << endl;
						currentFunctionStackAddress += 4;
						break;
					}
					else {
						out << "sw " << "$t" << (g + 3) << " " << currentFunctionStackAddress - 16 << "($k1)" << endl;
						currentFunctionStackAddress += 4;
						break;
					}
				}
				else {							// 标识符
					getVariable(item.target, "$v0", out);
					out << "sw $v0 " << currentFunctionStackAddress - 16 << "($k1)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
			}
			
		case FunctionCall:
			currentFunctionStackAddress = 0;// 重置函数栈

															   // 将$k0,$k1寄存器的值保存入栈
			out << "sw $k0 0($sp)" << endl;
			//out << "sw $k1 4($sp)" << endl;

			for (int i = 0; i < getMaxTemp(item.target); i++)
				out << "sw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
			for (int i = 0; i < getMaxVar(item.target); i++)
				out << "sw $s" << i << " " << 8 + 4 * getMaxTemp(item.target) + 4 * i << "($sp)" << endl;
			out << "sw $ra " << 8 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << "($sp)" << endl;
			out << "sw $fp " << 12 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << "($sp)" << endl;
			out << "addiu $sp $sp " << 16 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << endl;
			out << "addiu $fp $sp -8" << endl;

										  // 函数调用,跳转,生成所跳转的目标函数运行栈空间的首地址
			out << "jal " << item.target << endl;

			// 栈指针恢复到$fp
			out << "move $sp $fp" << endl;
			// $k0 $k1寄存器值恢复
			out << "addiu $sp $sp -" << 8 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << endl;
			out << "lw $k0 0($sp)" << endl;
			//out << "lw $k1 4($sp)" << endl;
			for (int i = 0; i < getMaxTemp(item.target); i++)
				out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
			for (int i = 0; i < getMaxVar(item.target); i++)
				out << "lw $s" << i << " " << 8 + 4 * getMaxTemp(item.target) + 4 * i << "($sp)" << endl;
			// 返回地址存入$ra
			out << "lw $ra 0($fp)" << endl;
			// 函数栈区起始地址恢复--->上一级函数基地址$fp恢复
			out << "lw $fp 4($fp)" << endl;

			break;
		case Pass:
			handleAssignment(item, out);
			break;
		case Label:
			out << item.target << ":" << endl;
			break;
		case FunctionDef:
			out << item.target << ":" << endl;//生成跳转标签
			funcName = item.target;
			handleFunctionDefinition(item.target, out);
			break;
		case ParamDef:
			// 不需要处理
			break;
		case Jump:
			out << "j " << item.target << endl;
			break;
		case BEZ:
		case BNZ:
		case BLZ:
		case BLEZ:
		case BGZ:
		case BGEZ:
			handleBranch(item, out);
			break;
		case Read: {
			if (item.valueType == CharType)
				out << "li $v0 12" << endl;
			else
				out << "li $v0 5" << endl;
			out << "syscall" << endl;
			itr = varToRegisterMap.find(locateVariable(item.target));
			if (itr != varToRegisterMap.end()) {
				out << "move " << itr->second << " $v0" << endl;
				break;
			}
			locateVariableAddress(item.target, "$a3", out);
			out << "sw $v0 0($a3)" << endl;
			break;
		}
		case Print: {
			if (item.isVal) {
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "move $a0 " << itr->second << endl;
					if (item.valueType == CharType)
						out << "li $v0 11" << endl;
					else
						out << "li $v0 1" << endl;
					out << "syscall" << endl;
					break;
				}
				else if (item.target.at(0) == '#') {
					int g = integerConversion(item.target.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$a0", out);
					}
					else {
						out << "move $a0 " << "$t" << (g + 3) << endl;
					}
				}
				else {
					getVariable(item.target, "$a0", out);
				}

				if (item.valueType == CharType)
					out << "li $v0 11" << endl;
				else
					out << "li $v0 1" << endl;
				out << "syscall" << endl;
			}
			else if(item.valueType == StringType){
				cancelEscapeChar(item.target);
				map<string, string>::iterator iter = stringWithLabel.find(item.target);
				if (iter != stringWithLabel.end()) {
					out << "la $a0 " << iter->second << endl;
				}
				out << "li $v0 4" << endl;
				out << "syscall" << endl;
			}
			else if (item.valueType == CharType) {
				out << "li $a0 " << (int)item.target.at(0) << endl;
				out << "li $v0 11" << endl;
				out << "syscall" << endl;
			}
			else if (item.valueType == IntType) {
				out << "li $a0 " << integerConversion(item.target) << endl;
				out << "li $v0 1" << endl;
				out << "syscall" << endl;
			}
			break;
		}
		
		case Return:
			if (item.isVal) {
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "move $v0 " << itr->second << endl;
					handleReturn(out);
					break;
				}
				else if (item.target.at(0) == '#') {
					int g = integerConversion(item.target.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$v0", out);
					}
					else {
						out << "move $v0 $t" << (g + 3) << endl;
					}
				}
				else {
					getVariable(item.target, "$v0", out);
				}
				// 返回地址
				handleReturn(out);
			}
			else if (item.funcType == VoidType) {
				handleReturn(out);
			}
			else {
				out << "li $v0 " << integerConversion(item.target) << endl;
				// 返回地址
				handleReturn(out);
			}
			break;
		case End:
			out << "li $v0 10" << endl;
			out << "syscall" << endl;
		default:break;
		}
	}
}

void writeOptimizedMiddleCode() {
	maxTempOrderMap.clear();
	constStringSet.clear();
	stringWithLabel.clear();
	ofstream out(opCodeToFileName, ios::out);
	string funcName = "GLOBAL";
	for (unsigned int i = 0; i < optimizedMiddleCodeArr.size(); i++) {
		MiddleCode item = optimizedMiddleCodeArr.at(i);
		genQuaterCode(out, item);
	}
	out.close();
}

void writeOptimizedAssemblyCode() {
	ofstream out(finalCodeToFileName, ios::out);
	// 生成 data 段
	out << ".data" << endl;
	getDataSegment(out);
	// 对齐 data 段栈顶地址
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// 设置临时参数栈为 data 段顶部
	functionStackAddress = dataSegmentAddress + dataBaseAddress;
	currentFunctionStackAddress = 0;
	functionStackTop = functionStackAddress + maxFunctionStack;
	// 生成 main 函数声明
	out << ".globl main" << endl;
	// 生成 text 段
	funcName = "GLOBAL";
	out << ".text" << endl;

	getTextSegment(out, optimizedMiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}

void writeSimulatedAssemblyCode() {
	ofstream out(simuCodeToFileName, ios::out);
	stringWithLabel.clear();
	// 生成 data 段
	out << ".data" << endl;
	getDataSegment(out);
	// 对齐 data 段栈顶地址
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// 设置临时参数栈为 data 段顶部
	functionStackAddress = dataSegmentAddress + dataBaseAddress;
	currentFunctionStackAddress = 0;
	functionStackTop = functionStackAddress + maxFunctionStack;
	// 生成 main 函数声明
	out << ".globl main" << endl;
	// 生成 text 段
	funcName = "GLOBAL";
	out << ".text" << endl;

	getTextSegment(out, optimizedMiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}