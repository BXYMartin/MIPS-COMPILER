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





static int labelCount = 0;//ȫ�ֱ�ǩ������
int VarCount = 0;//ȫ����ʱ����������
static string funcName = "GLOBAL";//��ʱ������������,�������仯,��������������ϴ��
static int globalStrCount = 0;//ȫ���ַ���������


static unsigned dataSegmentAddress = 0;//�ַ���ռ�ݵĴ�С
unsigned int functionStackAddress;//��ʱ����ջ�ռ�ָ��
unsigned int currentFunctionStackAddress;//��ǰ����ջָ��ĵ�ַ
const int maxFunctionStack = 100;//������ʱ����ջ���Ϊ100�ֽ�(�����25������)
const unsigned int dataBaseAddress = 0x10010000;//���ݶ���ʼ��ַ
unsigned int returnValueAddress;//��������ֵ��ŵ�
unsigned int functionStackTop;//���庯��ջ����ʼ��ַ(��ȫ������������ʼ��ַ)
int tempVariableOffsetAddress = 0;

extern const string opCodeToFileName = "OptimizedMiddleCode.txt";
extern const string tmpCodeToFileName = "MiddleCode.txt";
extern const string mipsCodeToFileName = "Assembly.asm";
extern const string finalCodeToFileName = "OptimizedAssembly.asm";
extern const string simuCodeToFileName = "SimulatedAssembly.asm";

extern vector<SymbolTableItem> SymbolTable;

vector<MiddleCode> MiddleCodeArr; // �м�������ɼ���
extern vector<MiddleCode> optimizedMiddleCodeArr;
extern map<int, string> varToRegisterMap;
extern map<string, bool> inlinable;
extern map<int, string> inlineRegisterMap;
extern map<string, int> maxTempUsingMap;
static string inlineName = "GLOBAL";

map<string, int> framePointerOffset;
vector<string> constStringSet; // ������Ҫ��ӡ�ĳ����ַ�������,����.data��
map<string, string> stringWithLabel; // �ַ�����αָ���ǩ
map<string, unsigned> maxTempOrderMap; // ÿ������������ʱ�������
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
	int maxTempUsed = 0;
	map<string, unsigned int>::iterator itr;
	map<string, int>::iterator f = maxTempUsingMap.find(funcName);
	if (f != maxTempUsingMap.end()) {
		maxTempUsed = f->second;
	}
	else {
		maxTempUsed = VAR_REGISTER;
	}
	for (itr = maxTempOrderMap.begin(); itr != maxTempOrderMap.end(); itr++) {
		if (itr->first == funcName) {
			maxTempOrder = itr->second;
			break;
		}
	}
	if (itr == maxTempOrderMap.end())
		return 0;
	else {
		maxTempOrder = (maxTempOrder < maxTempUsed) ? maxTempOrder : maxTempUsed ;
		return (maxTempOrder > TEMP_REGISTER) ? TEMP_REGISTER + 1 : maxTempOrder + 1;
	}
}


int getMaxVar(string funcName) {
	int maxTempOrder = 0;
	for (map<string, unsigned int>::iterator itr = maxVarOrderMap.begin(); itr != maxVarOrderMap.end(); itr++) {
		if (itr->first == funcName)
			maxTempOrder = itr->second;
	}
	return maxTempOrder;
}

// ���ַ���ԭ�����
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
			// ��ѯ�Ƿ�Ϊ��ʱ����
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

// ���� text �� data ��
void writeAssemblyCode() {
	ofstream out(mipsCodeToFileName, ios::out);
	// ���� data ��
	out << ".data" << endl;
	getDataSegment(out);
	// ���� data ��ջ����ַ
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// ������ʱ����ջΪ data �ζ���
	functionStackAddress = dataSegmentAddress + 4 + dataBaseAddress;
	currentFunctionStackAddress = 0;
	returnValueAddress = dataSegmentAddress + dataBaseAddress;
	// ���� main ��������
	out << ".globl main" << endl;
	// ���� text ��
	funcName = "GLOBAL";
	out << ".text" << endl;
	getTextSegment(out, MiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}
// ���� Data �� ���ֵΪ dataSegmentAddress
void getDataSegment(ofstream & out) {
	dataSegmentAddress = 0;
	for (unsigned int i = 0; i < constStringSet.size(); i++) {
		string item = constStringSet.at(i);
		// ����Ƿ����ظ��Ĺ����ַ���
		map<string, string>::iterator iter = stringWithLabel.find(item);
		if (iter != stringWithLabel.end())
			continue;
		dataSegmentAddress += item.size() + 1;//'\0'ռһ���ֽ�
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
	// �� order > TEMP_REGISTER ʱ��Ҫ��ȡ�ڴ�
	out << "lw " << targetReg << " " << (order - 1 - TEMP_REGISTER) * 4 + tempVariableOffsetAddress << "($sp)" << endl;
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

void saveSpecialVariable(string target, string value, int offset, string reg, ofstream & out) {
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
		out << "addu " << reg << " $gp " << reg << endl;
		out << "sw " << value << " " << number + offset << "(" << reg << ")" << endl;
	}
	else {
		out << "addu " << reg << " $fp " << reg << endl;
		out << "sw " << value << " " << number + 8 + offset << "(" << reg << ")" << endl;
	}
}

// ��ȡ��ʱ�����ĵ�ַ
void locateTempAddress(int order, string targetReg, ofstream & out) {
	// �� order > TEMP_REGISTER ʱ��Ҫ��ȡ�ڴ�
	out << "addiu " << targetReg << " $sp " << (order - 1 - TEMP_REGISTER) * 4 + tempVariableOffsetAddress << endl;
}

void saveTemp(int order, string value, ofstream & out) {
	// �� order > TEMP_REGISTER ʱ��Ҫ��ȡ�ڴ�
	out << "sw " << value << " " << (order - 1 - TEMP_REGISTER) * 4 + tempVariableOffsetAddress << "($sp)" << endl;
}

void saveVariable(string target, string value, int offset, ofstream & out) {
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
		out << "sw " << value << " " << number + offset << "($gp)" << endl;
	}
	else {
		out << "sw " << value << " " << number + 8 + offset << "($fp)" << endl;
	}
}


// ����Text�δ���ĸ�������
/*
	��ֵĿ��Ϊ���� a[$t0] = $t1 ��ַ���� $t0 ������� $t1

*/
void locateArray(MiddleCode item, ofstream & out) {
	locateVariableAddress(item.target, "$t0", out);

	// �۲�indexTargetArr�������±�
	string indexTargetArr = item.indexTargetArr;
	if (IsNum(indexTargetArr.at(0))) {		// ��������
		int number = integerConversion(indexTargetArr);
		number = 4 * number;
		if(number != 0)
			out << "addiu $t0 $t0 " << number << endl;
	}
	else if (indexTargetArr.at(0) == '#') {	// ����ʱ����
									// ����$t1
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
	else {							// �Ǳ���
		map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexTargetArr));
		if (itr != varToRegisterMap.end()) {
			out << "sll $t1 " << itr->second << " 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
		else if (indexTargetArr == "Ret") {
			out << "sll $t1 $v0 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
		else {
			// ��ַ����$t1
			getVariable(indexTargetArr, "$t1", out);
			out << "sll $t1 $t1 2" << endl;
			out << "addu $t0 $t0 $t1" << endl;
		}
	}
}

void saveArray(MiddleCode item, string value, ofstream & out) {
	// �۲�indexTargetArr�������±�
	string indexTargetArr = item.indexTargetArr;
	if (IsNum(indexTargetArr.at(0))) {		// ��������
		int offset = integerConversion(indexTargetArr);
		offset = 4 * offset;
		saveVariable(item.target, value, offset, out);
	}
	else if (indexTargetArr.at(0) == '#') {	// ����ʱ����
											// ����$t1
		int g = integerConversion(indexTargetArr.substr(1));
		if (g > TEMP_REGISTER) {
			getTemp(g, "$t0", out);
			out << "sll $t0 $t0 2" << endl;
		}
		else {
			out << "sll $t0 " << "$t" << (g + 3) << " 2" << endl;
		}
		saveSpecialVariable(item.target, value, 0, "$t0", out);
		//out << "sw " << value << " 0($t0)" << endl;
	}
	else {							// �Ǳ���
		map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexTargetArr));
		if (itr != varToRegisterMap.end()) {
			out << "sll $t0 " << itr->second << " 2" << endl;
		}
		else if (indexTargetArr == "Ret") {
			out << "sll $t0 $v0 2" << endl;
		}
		else {
			// ��ַ����$t1
			getVariable(indexTargetArr, "$t0", out);
			out << "sll $t0 $t0 2" << endl;
		}
		saveSpecialVariable(item.target, value, 0, "$t0", out);
		//out << "sw " << value << " 0($t0)" << endl;
	}
}

void bestAssignment(MiddleCode item, ofstream & out) {
	if (item.isTargetArr) {
		string left = item.left;
		string right = item.right;
		char op = item.op;
		if (right == "0" && item.op == '*') {
			saveArray(item, "$0", out);
			return;
		}
		if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// ����
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
			saveArray(item, "$t1", out);
			return;
		}
		else if (IsNum(right.at(0))) {
			string tempReg = "$t1";
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (left == "Ret") {			// ����ֵ
				tempReg = "$v0";
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempReg = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (integerConversion(right) == 0 && (op == '+' || op == '-')) {
				saveArray(item, tempReg, out);
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
				saveArray(item, "$t1", out);
			}
			return;
		}
		else if (IsNum(left.at(0))) {
			string tempReg = "$t2";
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (right == "Ret") {			// ����ֵ
				tempReg = "$v0";
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
				if (itr != varToRegisterMap.end()) {
					tempReg = itr->second;
				}
				else {
					getVariable(right, "$t2", out);
				}
			}
			if (op == '+' && integerConversion(left) == 0) {
				saveArray(item, tempReg, out);
				return;
			}
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
				out << "div $t1 " << tempReg << endl;
				out << "mflo $t1" << endl;
			}
			saveArray(item, "$t1", out);
			return;
		}
		else {
			string tempLeft = "$t1", tempRight = "$t2";
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t1", out);
				}
				else {
					tempLeft = "$t" + to_string(g + 3);
				}
			}
			else if (left == "Ret") {			// ����ֵ
				tempLeft = "$v0";
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempLeft = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t2", out);
				}
				else {
					tempRight = "$t" + to_string(g + 3);
				}
			}
			else if (right == "Ret") {			// ����ֵ
				tempRight = "$v0";
			}
			else {								// ��ʶ��
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
				out << "div " << tempLeft << " " << tempRight << endl;
				out << "mflo $t1" << endl;
			}
			saveArray(item, "$t1", out);
			return;
		}
	}
	else {
		bool isVar = false;
		string targetReg = "$t0";
		int g, g1;
		if (item.target.at(0) == '#') {		// ��ʱ����
			g1 = g = integerConversion(item.target.substr(1));
			if (g > TEMP_REGISTER) {
				//locateTempAddress(integerConversion(item.target.substr(1)), "$t0", out);
			}
			else {
				targetReg = "$t" + to_string(g + 3);
				isVar = true;
			}
		}
		else {								// ��ʶ��
			map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(item.target));
			if (itr != varToRegisterMap.end()) {
				targetReg = itr->second;
				isVar = true;
			}
			else {
				//locateVariableAddress(item.target, "$t0", out);
			}
		}

		if (item.isLeftArr) {
			// ����������ȡֵ
			// ���������±�,�������ַȡ������$t1
			// �±��ַȡ������$t2
			string indexLeftArr = item.indexLeftArr;
			if (IsNum(indexLeftArr.at(0))) {			// ����
														// ȡ������,����$t1
				int order = locateVariable(item.left);
				SymbolTableItem symbol = SymbolTable.at(order);
				string funcName = symbol.getFuncName();
				string eleName = symbol.getId();
				int number = 0;
				unsigned int i;
				for (i = 0; i < SymbolTable.size(); i++) {
					SymbolTableItem tab = SymbolTable.at(i);
					if (funcName == "GLOBAL") {
						if (tab.getItemType() != Constant)
							break;
					}
					else if (tab.getId() == funcName) {
						if (tab.getItemType() == Function) {
							i++;
							break;
						}
					}
				}
				for (; i < SymbolTable.size(); i++) {
					SymbolTableItem tab = SymbolTable.at(i);
					if (funcName != "GLOBAL")
						if (tab.getItemType() == Constant)
							continue;
					if (tab.getId() == eleName) {
						break;
					}
					if (tab.getArrSize() == 0)
						number += 4;
					else
						number += tab.getArrSize() * 4;
				}
				if (funcName == "GLOBAL") {
					if (isVar)
						out << "lw " << targetReg << " " << number + 4 * integerConversion(indexLeftArr) << "($gp)" << endl;
					else {
						out << "lw $t1 " << number + 4 * integerConversion(indexLeftArr) << "($gp)" << endl;
						if (item.target.at(0) == '#') {
							saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
						}
						else {
							saveVariable(item.target, "$t1", 0, out);
						}
					}
				}
				else {
					if (isVar)
						out << "lw " << targetReg << " " << number + 8 + 4 * integerConversion(indexLeftArr) << "($fp)" << endl;
					else {
						out << "lw $t1 " << number + 8 + 4 * integerConversion(indexLeftArr) << "($fp)" << endl;
						if (item.target.at(0) == '#') {
							saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
						}
						else {
							saveVariable(item.target, "$t1", 0, out);
						}
					}
				}
			}
			else if (indexLeftArr.at(0) == '#') {		// ��ʱ����
				locateVariableAddress(item.left, "$t1", out);
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
				// ȡ������,����$t1
				if (isVar)
					out << "lw " << targetReg << " 0($t1)" << endl;
				else {
					out << "lw $t1 0($t1)" << endl;
					if (item.target.at(0) == '#') {
						saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
					}
					else {
						saveVariable(item.target, "$t1", 0, out);
					}
				}
			}
			else {								// ��ʶ��
				locateVariableAddress(item.left, "$t1", out);
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexLeftArr));
				if (itr != varToRegisterMap.end()) {
					out << "sll $t2 " << itr->second << " 2" << endl;
					out << "addu $t1 $t1 $t2" << endl;
				}
				else if (indexLeftArr == "Ret") {
					out << "sll $t2 $v0 2" << endl;
					out << "addu $t1 $t1 $t2" << endl;
				}
				else {
					getVariable(indexLeftArr, "$t2", out);
					out << "sll $t2 $t2 2" << endl;
					out << "addu $t1 $t1 $t2" << endl;
				}
				// ȡ������,����$t1
				if (isVar)
					out << "lw " << targetReg << " 0($t1)" << endl;
				else {
					out << "lw $t1 0($t1)" << endl;
					if (item.target.at(0) == '#') {
						saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
					}
					else {
						saveVariable(item.target, "$t1", 0, out);
					}
				}
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
				if (item.target.at(0) == '#') {
					saveTemp(integerConversion(item.target.substr(1)), "$0", out);
				}
				else {
					saveVariable(item.target, "$0", 0, out);
				}
				return;
		}
		if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// ����
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
				if (item.target.at(0) == '#') {
					saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
				}
				else {
					saveVariable(item.target, "$t1", 0, out);
				}
			}
			return;
		}
		else if (IsNum(right.at(0))) {
			string tempReg = "$t1";
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (left == "Ret") {			// ����ֵ
				tempReg = "$v0";
			}
			else {								// ��ʶ��
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
				if (integerConversion(right) == 0 && (op == '+' || op == '-')) {
					if (item.target.at(0) == '#') {
						saveTemp(integerConversion(item.target.substr(1)), tempReg, out);
					}
					else {
						saveVariable(item.target, tempReg, 0, out);
					}
					return;
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
				if (item.target.at(0) == '#') {
					saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
				}
				else {
					saveVariable(item.target, "$t1", 0, out);
				}
			}
			return;
		}
		else if (IsNum(left.at(0))) {
			string tempReg = "$t2";
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (right == "Ret") {			// ����ֵ
				tempReg = "$v0";
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
				if (itr != varToRegisterMap.end()) {
					tempReg = itr->second;
				}
				else {
					getVariable(right, "$t2", out);
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
					out << "div $t0 " << tempReg << endl;
					out << "mflo " << targetReg << endl;
				}
			}
			else {
				if (integerConversion(left) == 0 && op == '+') {
					if (item.target.at(0) == '#') {
						saveTemp(integerConversion(item.target.substr(1)), tempReg, out);
					}
					else {
						saveVariable(item.target, tempReg, 0, out);
					}
					return;
				}
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
					out << "div $t1 " << tempReg << endl;
					out << "mflo $t1" << endl;
				}
				if (item.target.at(0) == '#') {
					saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
				}
				else {
					saveVariable(item.target, "$t1", 0, out);
				}
			}
			return;
		}
		else {
			string tempLeft = "$t1", tempRight = "$t2";
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t1", out);
				}
				else {
					tempLeft = "$t" + to_string(g + 3);
				}
			}
			else if (left == "Ret") {			// ����ֵ
				tempLeft = "$v0";
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempLeft = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t2", out);
				}
				else {
					tempRight = "$t" + to_string(g + 3);
				}
			}
			else if (right == "Ret") {			// ����ֵ
				tempRight = "$v0";
			}
			else {								// ��ʶ��
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
					out << "div " << tempLeft << " " << tempRight << endl;
					out << "mflo " << targetReg << endl;
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
					out << "div " << tempLeft << " " << tempRight << endl;
					out << "mflo $t1" << endl;
				}
				if (item.target.at(0) == '#') {
					saveTemp(integerConversion(item.target.substr(1)), "$t1", out);
				}
				else {
					saveVariable(item.target, "$t1", 0, out);
				}
			}
			return;
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
		if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// ����
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
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (left == "Ret") {			// ����ֵ
				out << "move $t1 $v0" << endl;
			}
			else {								// ��ʶ��
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
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, tempReg, out);
				}
				else {
					tempReg = "$t" + to_string(g + 3);
				}

			}
			else if (right == "Ret") {			// ����ֵ
				out << "move $t2 $v0" << endl;
			}
			else {								// ��ʶ��
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
				out << "li $t1 " << integerConversion(left) << endl;
				out << "subu $t1 $t1 " << tempReg << endl;
			}
			else if (op == '*') {
				out << "mul $t1 " << tempReg << " " << integerConversion(left) << endl;
			}
			else if (op == '/') {
				out << "li $t1 " << integerConversion(left) << endl;
				out << "div $t1 " << tempReg << endl;
				out << "mflo $t1" << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
		else {
			string tempLeft = "$t1", tempRight = "$t2";
			if (left.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(left.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t1", out);
				}
				else {
					tempLeft = "$t" + to_string(g + 3);
				}
			}
			else if (left == "Ret") {			// ����ֵ
				out << "move $t1 $v0" << endl;
			}
			else {								// ��ʶ��
				map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
				if (itr != varToRegisterMap.end()) {
					tempLeft = itr->second;
				}
				else {
					getVariable(left, "$t1", out);
				}
			}
			if (right.at(0) == '#') {		// ��ʱ����
				int g = integerConversion(right.substr(1));
				if (g > TEMP_REGISTER) {
					getTemp(g, "$t2", out);
				}
				else {
					tempRight = "$t" + to_string(g + 3);
				}
			}
			else if (right == "Ret") {			// ����ֵ
				out << "move $t2 $v0" << endl;
			}
			else {								// ��ʶ��
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
				out << "div " << tempLeft << " " << tempRight << endl;
				out << "mflo $t1" << endl;
			}
			out << "sw $t1 0($t0)" << endl;
			return;
		}
	}
	else {
			bool isVar = false;
			string targetReg = "$t0";
			int g, g1;
			if (item.target.at(0) == '#') {		// ��ʱ����
				g1 = g = integerConversion(item.target.substr(1));
				if (g > TEMP_REGISTER) {
					locateTempAddress(integerConversion(item.target.substr(1)), "$t0", out);
				}
				else {
					targetReg = "$t" + to_string(g + 3);
					isVar = true;
				}
			}
			else {								// ��ʶ��
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
				// ����������ȡֵ
				// ���������±�,�������ַȡ������$t1
				locateVariableAddress(item.left, "$t1", out);
				// �±��ַȡ������$t2
				string indexLeftArr = item.indexLeftArr;
				if (IsNum(indexLeftArr.at(0))) {			// ����
					if(integerConversion(indexLeftArr) != 0)
						out << "addiu $t1 $t1 " << 4 * integerConversion(indexLeftArr) << endl;
				}
				else if (indexLeftArr.at(0) == '#') {		// ��ʱ����
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
				else {								// ��ʶ��
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(indexLeftArr));
					if (itr != varToRegisterMap.end()) {
						out << "sll $t2 " << itr->second << " 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
					else if (indexLeftArr == "Ret") {
						out << "sll $t2 $v0 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
					else {
						getVariable(indexLeftArr, "$t2", out);
						out << "sll $t2 $t2 2" << endl;
						out << "addu $t1 $t1 $t2" << endl;
					}
				}
				// ȡ������,����$t1
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
			if (IsNum(left.at(0)) && IsNum(right.at(0))) {			// ����
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
				if (left.at(0) == '#') {		// ��ʱ����
					int g = integerConversion(left.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, tempReg, out);
					}
					else {
						tempReg = "$t" + to_string(g + 3);
					}

				}
				else if (left == "Ret") {			// ����ֵ
					out << "move $t1 $v0" << endl;
				}
				else {								// ��ʶ��
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
				string tempReg = "$t2";
				if (right.at(0) == '#') {		// ��ʱ����
					int g = integerConversion(right.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, tempReg, out);
					}
					else {
						tempReg = "$t" + to_string(g + 3);
					}

				}
				else if (right == "Ret") {			// ����ֵ
					out << "move $t2 $v0" << endl;
				}
				else {								// ��ʶ��
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(right));
					if (itr != varToRegisterMap.end()) {
						tempReg = itr->second;
					}
					else {
						getVariable(right, "$t2", out);
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
						out << "div $t0 " << tempReg << endl;
						out << "mflo " << targetReg << endl;
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
						out << "div $t1 " << tempReg << endl;
						out << "mflo $t1" << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
			else {
				string tempLeft = "$t1", tempRight = "$t2";
				if (left.at(0) == '#') {		// ��ʱ����
					int g = integerConversion(left.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$t1", out);
					}
					else {
						tempLeft = "$t" + to_string(g + 3);
					}
				}
				else if (left == "Ret") {			// ����ֵ
					out << "move $t1 $v0" << endl;
				}
				else {								// ��ʶ��
					map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(left));
					if (itr != varToRegisterMap.end()) {
						tempLeft = itr->second;
					}
					else {
						getVariable(left, "$t1", out);
					}
				}
				if (right.at(0) == '#') {		// ��ʱ����
					int g = integerConversion(right.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$t2", out);
					}
					else {
						tempRight = "$t" + to_string(g + 3);
					}
				}
				else if (right == "Ret") {			// ����ֵ
					out << "move $t2 $v0" << endl;
				}
				else {								// ��ʶ��
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
						out << "div " << tempLeft << " " << tempRight << endl;
						out << "mflo " << targetReg << endl;
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
						out << "div " << tempLeft << " " << tempRight << endl;
						out << "mflo $t1" << endl;
					}
					out << "sw $t1 0($t0)" << endl;
				}
				return;
			}
	}
}

// ����ȫ�ֱ�����Ŀ
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

int initializeStack(string funcName, int offset, ofstream & out) {
	// ����������
	int parameterCount = 0;
	int number = 0;									// ���������г�ʼ��
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function && item.getId() == funcName) {
			for (unsigned int j = i + 1; j < SymbolTable.size(); j++) {
				item = SymbolTable.at(j);
				if (item.getFuncName() != funcName)
					break;
				if (item.getItemType() == Constant)
					continue;
				if (item.getItemType() == Parameter) {// �ǲ���
													  // ����$v1�Ĵ�����Ϊ��ת
					if (parameterCount < 4) {
						string id = item.getId();
						string aReg = "$a" + to_string(parameterCount);
						map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(id));
						if (itr != varToRegisterMap.end()) {
							out << "move " << itr->second << " " << aReg << endl;
						}
						else {
							out << "sw " << aReg << " " << 4 * parameterCount + offset << "($sp)" << endl;
						}
						parameterCount++;
						number += 4;
					}
					else
					{
						string id = item.getId();
						map<int, string>::iterator itr = varToRegisterMap.find(locateVariable(id));
						if (itr != varToRegisterMap.end()) {
							out << "lw " << itr->second << " -" << parameterCount * 4 - 12 << "($gp)" << endl;
						}
						else {
							out << "lw $v1 -" << parameterCount * 4 - 12 << "($gp)" << endl;
							out << "sw $v1 " << 4 * parameterCount + offset << "($sp)" << endl;
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
	// ������ʱ�������ÿռ�
	map<string, unsigned>::iterator iter = maxTempOrderMap.find(funcName);
	if (iter != maxTempOrderMap.end() && iter->second > TEMP_REGISTER) {
		tempVariableOffsetAddress = (iter->second - TEMP_REGISTER) * 4 * -1;
		return number + (iter->second - TEMP_REGISTER) * 4;
	}
	else {
		tempVariableOffsetAddress = 0;
		return number;
	}
}

void handleFunctionDefinition(string funcName, ofstream & out) {
	if (funcName == "main") {
		// main ����ֻ��Ҫ��ȫ�ֱ��������ݷ���
		int size = arrageGlobalVariable();
		int increment;
		//out << "li $k1 " << functionStackAddress << endl;
		out << "addiu $fp $gp " << size << endl;
		increment = 8 + initializeStack(funcName, 8, out);
		out << "addiu $sp $fp " << increment << endl;
		framePointerOffset[funcName] = increment;
	}
	else {
		// ������һ�������Ļ���ַ
		int increment = 16 + 4 * getMaxTemp(funcName) + 4 * getMaxVar(funcName) + initializeStack(funcName, 16 + 4 * getMaxTemp(funcName) + 4 * getMaxVar(funcName), out);
		out << "addiu $fp $sp " << 8 + 4 * getMaxTemp(funcName) + 4 * getMaxVar(funcName) << endl;
		out << "addiu $sp $sp " << increment << endl;
		framePointerOffset[funcName] = increment;
	}
}
// �����֧��ָ��
void handleBranch(MiddleCode item, ofstream & out) {
	// ���жϵı���ֵ����$t1�Ĵ�����,�ٵ���ת�ƺ���
	string obj = item.left;
	string branchReg0 = "$t1";
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
		else if (obj == "Ret")
			branchReg0 = "$v0";
		else if (obj == "$0")
			branchReg0 = obj;
		else {
			getVariable(obj, branchReg0, out);
		}
	}

	obj = item.right;
	string branchReg1 = "$t2";
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
		else if (obj == "Ret")
			branchReg1 = "$v0";
		else {
			getVariable(obj, branchReg1, out);
		}
	}

	switch (item.type)
	{
	case BEZ:
		out << "beq " << branchReg0 << " " << branchReg1 << " " << item.target << endl;
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


// �������ش���
void handleReturn(ofstream & out) {
	out << "jr $ra" << endl;
}

// �������յ�Text�δ���
void getTextSegment(ofstream & out, vector<MiddleCode> QuaterCode) {
	framePointerOffset.clear();
	map<string, bool>::iterator f;
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
				else if (item.target.at(0) == '#') {	// ��ʱ����
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
				else if (item.target == "Ret") {
					out << "move " << aReg << " $v0" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else {							// ��ʶ��
					getVariable(item.target, aReg, out);
					currentFunctionStackAddress += 4;
					break;
				}
			}
			else {
				// ���ݱ�����ַ
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "sw " << itr->second << " -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (IsNum(item.target.at(0))) {
					out << "li $v0 " << integerConversion(item.target) << endl;
					out << "sw $v0 -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else if (item.target.at(0) == '#') {	// ��ʱ����
					int g = integerConversion(item.target.substr(1));
					if (g > TEMP_REGISTER) {
						getTemp(g, "$v0", out);
						out << "sw $v0 -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
						currentFunctionStackAddress += 4;
						break;
					}
					else {
						out << "sw " << "$t" << (g + 3) << " -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
						currentFunctionStackAddress += 4;
						break;
					}
				}
				else if (item.target == "Ret") {
					out << "sw $v0 -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
				else {							// ��ʶ��
					getVariable(item.target, "$v0", out);
					out << "sw $v0 -" << currentFunctionStackAddress - 12 << "($gp)" << endl;
					currentFunctionStackAddress += 4;
					break;
				}
			}
			
		case FunctionCall:
			currentFunctionStackAddress = 0;// ���ú���ջ
			f = inlinable.find(item.target);
			if (f != inlinable.end() && f->second) {
				for (int i = 0; i < getMaxTemp(item.target); i++)
					out << "sw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
				inlineName = funcName;
				funcName = item.target;
			}
			else {

				// ��$k0,$k1�Ĵ�����ֵ������ջ
				//out << "sw $k0 0($sp)" << endl;
				//out << "sw $k1 4($sp)" << endl;

				for (int i = 0; i < getMaxTemp(item.target); i++)
					out << "sw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
				for (int i = 0; i < getMaxVar(item.target); i++)
					out << "sw $s" << i << " " << 8 + 4 * getMaxTemp(item.target) + 4 * i << "($sp)" << endl;
				out << "sw $ra " << 8 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << "($sp)" << endl;
				//out << "sw $fp " << 12 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << "($sp)" << endl;

				// ��������,��ת,��������ת��Ŀ�꺯������ջ�ռ���׵�ַ
				out << "jal " << item.target << endl;

				// ջָ��ָ���$fp
				//out << "move $sp $fp" << endl;
				// $k0 $k1�Ĵ���ֵ�ָ�
				out << "addiu $sp $fp -" << 8 + 4 * getMaxTemp(item.target) + 4 * getMaxVar(item.target) << endl;
				//out << "lw $k0 0($sp)" << endl;
				//out << "lw $k1 4($sp)" << endl;
				for (int i = 0; i < getMaxTemp(item.target); i++)
					out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
				for (int i = 0; i < getMaxVar(item.target); i++)
					out << "lw $s" << i << " " << 8 + 4 * getMaxTemp(item.target) + 4 * i << "($sp)" << endl;
				// ���ص�ַ����$ra
				out << "lw $ra 0($fp)" << endl;
				// ����ջ����ʼ��ַ�ָ�--->��һ����������ַ$fp�ָ�
				//out << "lw $fp 4($fp)" << endl;
				if (funcName == "main")
					out << "addiu $fp $sp -" << framePointerOffset[funcName] << endl;
				else
					out << "addiu $fp $sp -" << framePointerOffset[funcName] - (8 + 4 * getMaxTemp(funcName) + 4 * getMaxVar(funcName)) << endl;
			}

			break;
		case Pass:
			if(ULTOP)
				bestAssignment(item, out);
			else
				handleAssignment(item, out);
			break;
		case Label:
			if (item.target.at(0) == '$' && item.target.at(1) == '_') {
				funcName = inlineName;
			}
			out << item.target << ":" << endl;
			break;
		case FunctionDef:
			out << item.target << ":" << endl;//������ת��ǩ
			funcName = item.target;
			handleFunctionDefinition(item.target, out);
			break;
		case ParamDef:
			// ����Ҫ����
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
			if(ULTOP)
				saveVariable(item.target, "$v0", 0, out);
			else {
				locateVariableAddress(item.target, "$t0", out);
				out << "sw $v0 0($t0)" << endl;
			}
			
			break;
		}
		case Print: {
			map<string, bool>::iterator f;
			f = inlinable.find(funcName);
			if (f != inlinable.end() && f->second) {
				out << "move $k0 $a0" << endl;
			}
			if (item.isVal) {
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "move $a0 " << itr->second << endl;
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
				else if (item.target == "Ret") {
					out << "move $a0 $v0" << endl;
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
			if (f != inlinable.end() && f->second) {
				out << "move $a0 $k0" << endl;
			}
			break;
		}
		
		case Return:
			if (item.isVal) {
				itr = varToRegisterMap.find(locateVariable(item.target));
				if (itr != varToRegisterMap.end()) {
					out << "move $v0 " << itr->second << endl;
					f = inlinable.find(funcName);
					if (f != inlinable.end() && f->second) {
						for (int i = 0; i < getMaxTemp(funcName); i++)
							out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
						
					}
					else
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
				else if (item.target == "Ret") {
					;
				}
				else {
					getVariable(item.target, "$v0", out);
				}
				// ���ص�ַ
				f = inlinable.find(funcName);
				if (f != inlinable.end() && f->second) {
					for (int i = 0; i < getMaxTemp(funcName); i++)
						out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
					
				}
				else
					handleReturn(out);
			}
			else if (item.funcType == VoidType) {
				f = inlinable.find(funcName);
				if (f != inlinable.end() && f->second) {
					for (int i = 0; i < getMaxTemp(funcName); i++)
						out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
					
				}
				else
					handleReturn(out);
			}
			else {
				out << "li $v0 " << integerConversion(item.target) << endl;
				// ���ص�ַ
				f = inlinable.find(funcName);
				if (f != inlinable.end() && f->second) {
					for (int i = 0; i < getMaxTemp(funcName); i++)
						out << "lw $t" << i + 3 << " " << 8 + 4 * i << "($sp)" << endl;
				
				}
				else
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

void printVarIndexMap() {
	cout << "-----------------------------------" << endl;
	cout << "--- Variable To Index Map:" << endl;
	for (map<int, string>::iterator itr = varToRegisterMap.begin(); itr != varToRegisterMap.end(); itr++) {
		cout << "Order " << itr->first << " | Variable " << SymbolTable.at(itr->first).getId() << " | Register " << itr->second << " | Field " << SymbolTable.at(itr->first).getFuncName() << endl;
	}
	cout << "-----------------------------------" << endl;
}

void writeOptimizedAssemblyCode() {
	ofstream out(finalCodeToFileName, ios::out);
	// ���� data ��
	printVarIndexMap();
	out << ".data" << endl;
	getDataSegment(out);
	// ���� data ��ջ����ַ
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// ������ʱ����ջΪ data �ζ���
	functionStackAddress = dataSegmentAddress + dataBaseAddress;
	currentFunctionStackAddress = 0;
	functionStackTop = functionStackAddress + maxFunctionStack;
	// ���� main ��������
	out << ".globl main" << endl;
	// ���� text ��
	funcName = "GLOBAL";
	out << ".text" << endl;

	getTextSegment(out, optimizedMiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}

void writeSimulatedAssemblyCode() {
	ofstream out(simuCodeToFileName, ios::out);
	stringWithLabel.clear();
	printVarIndexMap();
	// ���� data ��
	out << ".data" << endl;
	getDataSegment(out);
	// ���� data ��ջ����ַ
	dataSegmentAddress = dataSegmentAddress + 4 - (dataSegmentAddress % 4);
	// ������ʱ����ջΪ data �ζ���
	functionStackAddress = dataSegmentAddress + dataBaseAddress;
	currentFunctionStackAddress = 0;
	functionStackTop = functionStackAddress + maxFunctionStack;
	// ���� main ��������
	out << ".globl main" << endl;
	// ���� text ��
	funcName = "GLOBAL";
	out << ".text" << endl;

	getTextSegment(out, optimizedMiddleCodeArr);

	out << "# End Of MIPS Assembly Code." << endl;
	out.close();
}