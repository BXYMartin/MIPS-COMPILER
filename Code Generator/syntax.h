#pragma once
#ifndef SYNTAXANALYSIS_H
#define SYNTAXANALYSIS_H
#define _CRT_SECURE_NO_WARNINGS
#include "lexer.h"
#include "error.h"
#include "semantic.h"
#include "constant.h"
#include "symbol.h"
#include "function.h"
#include <iomanip>
#include <algorithm>
using namespace std;

extern vector<SymbolTableItem> SymbolTable;
extern vector<MiddleCode> MiddleCodeArr;
// 表达式返回值
struct assign {
	string name;			// 表达式的临时变量
	bool determined;		// 确定值
	ValueType type;			// 返回值类型
	int number;				// 对应数值
	char character;			// 对应字母
	bool null;				// 是否是空的
};
// 情况表入口识别结构体
struct entry {
	int constValue;			// 入口值
	bool recognize;			// 是否出错
	string label;			// 入口标签
};

class Syntax
{
private:
	Error &error;	// 公用错误处理
	Lexer &lexical; // 公用词法分析
	Semantic &semantic;	// 公用语义分析
	string log = "Program Syntax Structure:";
	int printLevel = 0;
	bool voidMain;
	int getInteger;
	string getFunctionID;
	SymbolCode cmp;	// 关系运算符
	vector<MiddleCode> null;
	bool haveReturn;
	bool getncheckComponent(SymbolCode symbol, string message);
	bool getnskipComponent(SymbolCode symbol, string message, char end);
	bool getncheckSymbol(SymbolCode symbol, string message);
	bool checkComponent(SymbolCode symbol, string message);
	bool checknskipComponent(SymbolCode symbol, string message, char end);
	bool skipComponent(SymbolCode symbol, string message, char end);
	bool getncheckEnd(string message);
	bool checkSymbol(SymbolCode symbol);
	void pushMiddleCode(MiddleCode code, bool isCache, vector<MiddleCode> &cache);

	void reverseCMP() {
		switch (cmp) {
		case LSS:
			cmp = GTR;
			break;
		case GTR:
			cmp = LSS;
			break;
		case LEQ:
			cmp = GEQ;
			break;
		case GEQ:
			cmp = LEQ;
			break;
		}
	}

	void prefixConversion(vector<PostfixItem>input, vector<PostfixItem> & output) {
		vector<PostfixItem> op;
		if (input.size() == 1) {	// 单个元素不需要计算
			output.push_back(input.at(0));
			return;
		}
		if (input.size() > 0) {		// 添加起始符号为 0 解决起始负号问题或抹除前导加号
			PostfixItem t = input.at(0);
			if (t.type == CharType && t.nonOp == false) {
				if (t.number == '-') {
					t.type = IntType;
					t.number = 0;
					input.insert(input.begin(), t);
				}
				else if (t.number == '+') {
					input.erase(input.begin());
				}
			}
		}
		for (unsigned int i = 0; i < input.size(); i++) {
			PostfixItem item = input.at(i);
			if (item.type == CharType) {
				switch (item.number) {
				case '+':
				case '-':
					if (item.nonOp) {
						output.push_back(item);
						break;
					}
					while (op.size() != 0) {
						output.push_back(op.at(op.size() - 1));
						op.pop_back();
					}
					op.push_back(item);
					break;
				case '*':
				case '/':
					if (item.nonOp) {
						output.push_back(item);
						break;
					}
					while (op.size() != 0) {
						if (op.at(op.size() - 1).number == '*' || op.at(op.size() - 1).number == '/') {
							output.push_back(op.at(op.size() - 1));
							op.pop_back();
						}
						else {
							break;
						}
					}
					op.push_back(item);
					break;
				default:output.push_back(item);
				}
			}
			else {
				output.push_back(item);
			}
		}
		while (op.size() != 0) {		// 推出剩余的符号
			output.push_back(op.at(op.size() - 1));
			op.pop_back();
		}
	}

	// 计算表达式
	string expressionCalculator(vector<PostfixItem> & input, bool & determined, ValueType & t, int & ret, int line, bool isCache, vector<MiddleCode> & cache, string funcName) {
		PostfixItem inputItem, expItem;
		string left, right;
		determined = false;
		vector<PostfixItem> tmp;
		if (input.size() == 1) {
			inputItem = input.at(0);
			if (inputItem.type == IntType || inputItem.type == CharType) {
				t = inputItem.type;
				ret = inputItem.number;
				determined = true;
				return "";
			}
			else {
				if (!inputItem.nonChar) {// 是字符型变量
					t = CharType;
				}
				else
					t = IntType;
				return inputItem.str;
			}
		}
		else {
			t = IntType;
			for (unsigned int i = 0; i < input.size(); i++) {
				inputItem = input.at(i);
				if (inputItem.type == CharType) {
					switch (inputItem.number) {
					case '+':
					case '-': {
						if (inputItem.nonOp) {
							tmp.push_back(inputItem);
							break;
						}
						if (tmp.size() > 1) {
							bool calculate = true;
							int leftDigit, rightDigit;
							
							if (tmp.at(tmp.size() - 1).type == StringType) {
								right = tmp.at(tmp.size() - 1).str;
								tmp.pop_back();
								calculate = false;
							}
							else {
								right = to_string(tmp.at(tmp.size() - 1).number);
								rightDigit = tmp.at(tmp.size() - 1).number;
								tmp.pop_back();
							}
							if (tmp.at(tmp.size() - 1).type == StringType) {
								left = tmp.at(tmp.size() - 1).str;
								tmp.pop_back();
								calculate = false;
							}
							else {
								left = to_string(tmp.at(tmp.size() - 1).number);
								leftDigit = tmp.at(tmp.size() - 1).number;
								tmp.pop_back();
							}
							if (calculate) {
								expItem.type = IntType;
								expItem.number = (inputItem.number == '+') ? (leftDigit + rightDigit) : (leftDigit - rightDigit);
								tmp.push_back(expItem);
								break;
							}
							expItem.type = StringType;
							if (inputItem.number == '+' && right == "0")
								expItem.str = left;
							else
								expItem.str = pushPseudoCode(Pass, cache, isCache, left, inputItem.number, right, "", "", false, false);
							tmp.push_back(expItem);
						}
						break;
					}
					case '*':
					case '/': {
						if (inputItem.nonOp) {
							tmp.push_back(inputItem);
							break;
						}
						if (tmp.size() > 1) {
							bool isAbleDirect = true;
							int leftDigit, rightDigit;

							if (tmp.at(tmp.size() - 1).type == StringType) {
								right = tmp.at(tmp.size() - 1).str;
								isAbleDirect = false;
								tmp.pop_back();
							}
							else {
								right = to_string(tmp.at(tmp.size() - 1).number);
								rightDigit = tmp.at(tmp.size() - 1).number;
								tmp.pop_back();
							}
							if (tmp.at(tmp.size() - 1).type == StringType) {
								left = tmp.at(tmp.size() - 1).str;
								isAbleDirect = false;
								tmp.pop_back();
							}
							else {
								left = to_string(tmp.at(tmp.size() - 1).number);
								leftDigit = tmp.at(tmp.size() - 1).number;
								tmp.pop_back();
								if (inputItem.number == '/' && right == "0") {
									error.SemanticError(DivisionByZeroError, getLine(), getIndex(), "x/0");
									break;
								}
							}
							if (isAbleDirect) {
								expItem.type = IntType;
								expItem.number = (inputItem.number == '*') ? (leftDigit*rightDigit) : (leftDigit / rightDigit);
								tmp.push_back(expItem);
								break;
							}
							expItem.type = StringType;
							if (inputItem.number == '+' && right == "0")
								expItem.str = left;
							else
								expItem.str = pushPseudoCode(Pass, cache, isCache, left, inputItem.number, right, "", "", false, false);
							tmp.push_back(expItem);
						}
						break;
					}
					default:tmp.push_back(inputItem);
					}
				}
				else {
					tmp.push_back(inputItem);
				}
			}
			if (tmp.size() >= 1) {
				if (tmp.at(0).type == IntType) {
					determined = true;
					t = IntType;
					ret = tmp.at(0).number;
					return "";
				}
				return tmp.at(0).str;
			}
			else {
				return "";
			}
		}
	}

	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, ValueType valueType, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case ParamDef:		// ValueType(valueType) ParamName(target)
			code.valueType = valueType;
			code.target = target;
			break;
		case Read:		// Read ValueType(valueType) Value(target)
			code.valueType = valueType;
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case End:
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case FunctionCall:	// Call FuncName(target)
			code.target = target;
			break;
		case Label:			// Label Name(target)
			code.target = target;
			break;
		case ParamPass:	// Para ParaName(target)
			code.target = target;
			break;
		case Jump:		// Jump Label(target)
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, string left, char op, string right, string indexTargetArr, string indexLeftArr, bool isLeftArr, bool isTargetArr) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case Pass:			// Assign Target(target) = Left(left) Op(op) Right(right) indexTargetArr indexLeftArr leftArray targetArray
			code.target = getVar();
			code.left = left;
			code.op = op;
			code.right = right;
			code.indexTargetArr = indexTargetArr;
			code.indexLeftArr = indexLeftArr;
			code.isLeftArr = isLeftArr;
			code.isTargetArr = isTargetArr;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, string left, string right, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case BEZ:			// Branch Var(left) Var(right) Label(target)
		case BNZ:
		case BLZ:
		case BLEZ:
		case BGZ:
		case BGEZ:
			code.left = left;
			code.right = right;
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, bool isVal, ValueType valueType, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case Print:		// Print VarType(isVar) ValueType(valueType) Value(target)
			code.isVal = isVal;
			code.valueType = valueType;
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, bool isVal, FuncType funcType, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case Return:	// Return VarType(isVar) FuncType(funcType) Value(target)
			code.isVal = isVal;
			code.funcType = funcType;
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}
	string pushPseudoCode(TmpCodeType type, vector<MiddleCode> &cache, bool isCache, FuncType funcType, string target) {
		MiddleCode code;
		code.type = type;
		switch (type) {
		case FunctionDef:	// FuncType(funcType) FuncName(target)
			code.funcType = funcType;
			code.target = target;
			break;
		}
		pushMiddleCode(code, isCache, cache);
		return code.target;
	}

	int getLine() {
		return lexical.getLine();
	}
	int getIndex() {
		return lexical.getIndex();
	}
	// 整数常量
	void pushItem(string id, string functionName, int num) {
		if (!semantic.inSymbolTable(id, functionName))
			return;
		SymbolTableItem newItem(id, functionName);
		newItem.setItemType(Constant);
		newItem.setValueType(IntType);
		newItem.setConstInt(num);
		SymbolTable.push_back(newItem);
	}
	// 字符常量
	void pushItem(string id, string functionName, char character) {
		if (!semantic.inSymbolTable(id, functionName))
			return;
		SymbolTableItem newItem(id, functionName);
		newItem.setItemType(Constant);
		newItem.setValueType(CharType);
		newItem.setConstChar(character);
		SymbolTable.push_back(newItem);
	}
	// 数组变量
	void pushItem(string id, string functionName, ValueType valueType, int size) {
		if (!semantic.inSymbolTable(id, functionName))
			return;
		SymbolTableItem newItem(id, functionName);
		newItem.setItemType(Variable);
		newItem.setValueType(valueType);
		newItem.setArrSize(size);
		SymbolTable.push_back(newItem);
	}
	// 变量
	void pushItem(string id, string functionName, ItemType itemType, ValueType valueType) {
		if (!semantic.inSymbolTable(id, functionName))
			return;
		SymbolTableItem newItem(id, functionName);
		newItem.setItemType(itemType);
		newItem.setValueType(valueType);
		SymbolTable.push_back(newItem);
	}
	// 函数定义
	void pushItem(string id, string functionName, FuncType funcType) {
		if (!semantic.inSymbolTable(id, functionName))
			return;
		SymbolTableItem newItem(id, functionName);
		newItem.setItemType(Function);
		newItem.setFuncType(funcType);
		SymbolTable.push_back(newItem);
	}
	

	//优化部分的函数
	void addWeight(int order, int weight);//需要检查是否符合要求

	void markSyntax(string content) {
		log += "\n";
		for (int i = 0; i < printLevel; i++)
			log += ">>";
		log += content;
	}

	

public:
	Syntax(Error &error, Lexer &lexical, Semantic &semantic);
	void startAnalysis();
	void showStructure() {
		cout << log << endl;
		cout << "Program Structure End." << endl;
	}
	void printSymbolTable() {
		vector<SymbolTableItem>::iterator cursor;
		cout << "Program Symbol Table:" << endl;
		cout << setw(6) << "No.";
		cout << setw(20) << "Identifier";
		cout << setw(20) << "Scope";
		cout << setw(20) << "Type";
		cout << setw(10) << "Value";
		cout << endl;
		for (cursor = SymbolTable.begin(); cursor != SymbolTable.end(); cursor++) {
			cout << setw(6) << (*cursor).getOrder();
			cout << setw(20) << (*cursor).getId();
			cout << setw(20) << (*cursor).getFuncName();
			switch ((*cursor).getItemType()) {
			case Constant:
				if ((*cursor).getValueType() == IntType) {
					cout << setw(20) << "Const Int";
					cout << setw(10) << (*cursor).getConstInt();
					cout << endl;
				}
				else {
					cout << setw(20) << "Const Char";
					cout << setw(10) << "'" << (*cursor).getConstChar() << "'";
					cout << endl;
				}
				break;
			case Variable:
				if ((*cursor).getArrSize() > 0)
					if ((*cursor).getValueType() == IntType) {
						cout << setw(20) << "Array Int";
						cout << setw(10) << (*cursor).getArrSize();
						cout << endl;
					}
					else {
						cout << setw(20) << "Array Char";
						cout << setw(10) << (*cursor).getArrSize();
						cout << endl;
					}
				else if ((*cursor).getValueType() == IntType) {
					cout << setw(20) << "Var Int";
					cout << setw(10) << "-";
					cout << endl;
				}
				else {
					cout << setw(20) << "Var Char";
					cout << setw(10) << "-";
					cout << endl;
				}
				break;
			case Function:
				switch ((*cursor).getFuncType()) {
				case VoidType:
					cout << setw(20) << "Void Function";
					cout << setw(10) << "-";
					cout << endl;
					break;
				case ReturnIntType:
					cout << setw(20) << "Int Function";
					cout << setw(10) << "-";
					cout << endl;
					break;
				case ReturnCharType:
					cout << setw(20) << "Char Function";
					cout << setw(10) << "-";
					cout << endl;
					break;
				}
				break;
			case Parameter:
				if ((*cursor).getValueType() == IntType) {
					cout << setw(20) << "Parameter Int";
					cout << setw(10) << "-";
					cout << endl;
				}
				else {
					cout << setw(20) << "Parameter Char";
					cout << setw(10) << "-";
					cout << endl;
				}
				break;
			}
		}
		cout << "Program Symbol Table End." << endl;
	}
	bool enter_procedure();
	void enter_constDescription(string funcName);
	void enter_constDefinition(string funcName);
	void enter_varDescription(bool isGlobal, string funcName);
	bool enter_varDefinition(string funcName);
	void enter_functionDefinition();
	bool enter_functionDefinitionWithReturn();
	bool enter_functionDefinitionWithoutReturn();
	bool enter_parameterTable(string funcName);
	bool enter_compoundStatement(string funcName);
	assign enter_expression(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	void enter_item(vector<PostfixItem> &, string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	void enter_factor(vector<PostfixItem> &, string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_statement_inside(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_statement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_assignStatement(string funcName, string, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_conditionStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	void enter_condition(string funcName, bool isCache, vector<MiddleCode> &cache, int weight, string &left, string &right);
	bool enter_doStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_switchStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	vector<entry> enter_switchTable(string funcName, string endLabel, ValueType type, vector<MiddleCode> &, int weight);
	entry enter_caseStatement(string funcName, string endLabel, ValueType type, vector<MiddleCode> &, int weight);
	bool enter_defaultStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	vector<ValueType> enter_callParameterTable(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_readStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_writeStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	bool enter_returnStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight);
	void enter_integer();
	bool enter_headDeclaration();
};

#endif