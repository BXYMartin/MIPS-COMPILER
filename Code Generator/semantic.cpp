#include "stdafx.h"

#include "semantic.h"
#include "syntax.h"
#include "function.h"
using namespace std;

Semantic::Semantic(Error &error, Lexer &lexical) :error(error), lexical(lexical) {

}

// 检查是否可填表
bool Semantic::inSymbolTable(string id, string functionName) {
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		// 作用域相同,名字也相同
		if (functionName == item.getFuncName() && id == item.getId()) {
			error.SemanticError(MultipleDefinitionError, getLine(), getIndex(), id);
			return false;
		}
	}
	return true;
}

// ＜标识符＞‘[’＜表达式＞‘]’ 需要检查:标识符存不存在，标识符对应的是不是数组，如果是数组,表达式对应的下标值是否越界
int Semantic::checkArrayId(string identifier, string funcName, bool expSurable, int index) {
	bool globalIndexOut = false;	// 在全局中发现此为数组且但越界
	bool globalNotArray = false;	// 全局中发现不是数组
	bool isDefined = false;
	int order = -1;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {
			if (item.getId() == identifier) {	// 标识符名相同
				isDefined = true;
				if (item.getArrSize() > 0) {	// 是数组
					if (expSurable) {			// 数组下标值确定
						if (index >= item.getArrSize() || index < 0) {	// 越界
							globalIndexOut = true;
						}
						else {
							order = item.getOrder();
						}
					}
					else {
						order = item.getOrder();
					}
				}
				else {							// 不是数组
					globalNotArray = true;
				}
			}
		}
		else if (item.getFuncName() == funcName) {// 在函数作用域内发现
			if (item.getId() == identifier) {
				isDefined = true;
				if (item.getArrSize() > 0) {
					if (expSurable) {
						if (index >= item.getArrSize() || index < 0) {// 越界
							error.SemanticError(IndexOutOfRangeError, getLine(), getIndex(), identifier);
							return -1;
						}
						else {
							return item.getOrder();
						}
					}
					else {
						return item.getOrder();
					}
				}
				else {// 不是数组
					if (globalIndexOut) {
						break;
					}
					else {
						error.SemanticError(TypeNotMatchError, getLine(), getIndex(), identifier);
						return -1;
					}
				}
			}
		}
	}

	if (globalIndexOut) {
		error.SemanticError(IndexOutOfRangeError, getLine(), getIndex(), identifier);
		return -1;
	}
	if (globalNotArray) {
		error.SemanticError(TypeNotMatchError, getLine(), getIndex(), identifier);
		return -1;
	}
	// 标识符未定义
	if (!isDefined) {
		error.SemanticError(NoVariableDefinitionError, getLine(), getIndex(), identifier);
		return -1;
	}
	return order;
}


int Semantic::checkFactorId(string identifier, string funcName) {
	bool foundInGlobal = false;		// 全局变量中发现此结构存在问题
	bool isDefined = false;
	int orderInGlobal = -1;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {			// 全局作用域
			if (item.getId() == identifier) {			// 相同的标识符
				isDefined = true;
				if (item.getArrSize() > 0) {			// 不可能是数组
					foundInGlobal = true;
				}
				else if (item.getItemType() == Function && item.getFuncType() == VOIDSY) {
					foundInGlobal = true;
				}
				else {
					orderInGlobal = item.getOrder();
				}
			}
		}
		else if (item.getFuncName() == funcName) {		// 作用域相同
			if (item.getId() == identifier) {
				isDefined = true;
				if (item.getArrSize() > 0) {			// 报错
					error.SemanticError(TypeNotMatchError, getLine(), getIndex(), identifier);
					return -1;
				}
				else {
					return item.getOrder();
				}
			}
		}
	}
	if (foundInGlobal) {
		error.SemanticError(TypeNotMatchError, getLine(), getIndex(), identifier);
		return -1;
	}
	// 未定义标识符
	if (!isDefined) {
		error.SemanticError(NoVariableDefinitionError, getLine(), getIndex(), identifier);
		return -1;
	}
	return orderInGlobal;
}


void Semantic::checkStatementId(string identifier) {
	// 只分析全局
	bool isDefined = false;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {
			if (item.getId() == identifier) {
				isDefined = true;
				if (item.getItemType() == Function)
					return;
			}
		}
	}
	if (!isDefined) {
		error.SemanticError(NoFunctionDefinitionError, getLine(), getIndex(), identifier);
		return;
	}
	error.SemanticError(VariableNotCallableError, getLine(), getIndex(), identifier);
}


void Semantic::checkFuncCall(string identifier, bool isInExp, vector<ValueType> paramType) {
	bool isDefined = false;
	bool flag = false;							// 函数无错误？
	vector<ValueType> actualParam;

	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {
			if (item.getId() == identifier) {
				if (item.getItemType() == Function) {		// 类型为函数
					isDefined = true;
					flag = true;
					if (isInExp && item.getFuncType() == VoidType) {
						error.SemanticError(ValueExpectedError, getLine(), getIndex(), identifier);
						return;
					}
					for (unsigned int j = i + 1; j < SymbolTable.size(); j++) {
						item = SymbolTable.at(j);
						if (item.getFuncName() == identifier && item.getItemType() == Parameter) {
							actualParam.push_back(item.getValueType());
						}
						else {
							break;
						}
					}
					break;
				}
			}
		}
	}
	// 进行参数表考察
	if (flag) {
		if (paramType.size() == 0) {
			error.SemanticError(NoneValueParamError, getLine(), getIndex(), identifier);
			return;
		}
		if (paramType.size() > actualParam.size()) {			// 无参函数却传参
			error.SemanticError(ExtraParameterError, getLine(), getIndex(), identifier);
			return;
		}
		if (paramType.size() < actualParam.size()) {			// 参数个数不匹配
			error.SemanticError(MissingParameterError, getLine(), getIndex(), identifier);
			return;
		}
		for (unsigned int i = 0; i < paramType.size(); i++) {
			ValueType first = actualParam.at(i);
			ValueType second = paramType.at(i);
			if (first != second) {								// 参数类型不匹配
				error.TypeWarning(ConflictingParameterTypeWarning, getLine(), getIndex(), first, second);
				return;
			}
		}
	}

	if (!isDefined) {
		error.SemanticError(NoFunctionDefinitionError, getLine(), getIndex(), identifier);
		return;
	}
}


int Semantic::checkAssignId(string identifier, string funcName) {
	bool isDefined = false;
	int order = -1;
	bool global = false;
	for (unsigned int i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getFuncName() == "GLOBAL") {
			if (item.getId() == identifier) {
				isDefined = true;
				if (item.getItemType() == Variable && item.getArrSize() == 0) {
					order = item.getOrder();
				}
				else {
					global = true;
				}
			}
		}
		else if (item.getFuncName() == funcName) {
			if (item.getId() == identifier) {
				isDefined = true;
				if ((item.getItemType() == Variable && item.getArrSize() == 0)
					|| (item.getItemType() == Parameter)) {			// 变量或参数
					return item.getOrder();
				}
				else {
					error.SemanticError(CriticalAssignmentError, getLine(), getIndex(), identifier);
					return -1;
				}
			}
		}
	}
	if (!isDefined) {
		error.SemanticError(NoVariableDefinitionError, getLine(), getIndex(), identifier);
		return -1;
	}
	else if (global) {
		error.SemanticError(CriticalAssignmentError, getLine(), getIndex(), identifier);
		return -1;
	}
	return order;
}


void Semantic::checkCaseEntry(vector<int> cases) {
	if (cases.size() == 0)
		return;
	sort(cases.begin(), cases.end());
	int prev = cases.at(0);
	for (unsigned int i = 1; i < cases.size(); i++) {
		int x = cases.at(i);
		if (x == prev) {
			error.SemanticError(ConflictingCaseEntryError, getLine(), getIndex(), "");
			return;
		}
		prev = x;
	}
}

void Semantic::checkFuncReturn(string funcName) {
	for (unsigned i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function && item.getId() == funcName) {
			if (item.getFuncType() != VoidType) {
				error.ReturnError(VoidReturnedInNonVoidFunctionError, getLine(), getIndex(), funcName);
			}
			return;
		}
	}
}

bool Semantic::checkFuncType(string funcName) {
	for (unsigned i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function && item.getId() == funcName) {
			if (item.getFuncType() == ReturnCharType) {
				return false;
			}
			else if (item.getFuncType() == ReturnIntType) {
				return true;
			}
			
		}
	}
	return true;
}

void Semantic::checkFuncReturn(string funcName, ValueType retType) {
	for (unsigned i = 0; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function && item.getId() == funcName) {
			if (item.getFuncType() == VoidType) {
				error.ReturnError(ValueReturnedInVoidFunctionError, getLine(), getIndex(), funcName);
			}
			else if ((item.getFuncType() == ReturnCharType && retType == IntType) || (item.getFuncType() == ReturnIntType && retType == CharType)) {
				error.TypeWarning(ConflictingReturnTypeWarning, getLine(), getIndex(), (ValueType)item.getFuncType(), retType);
			}
			return;
		}
	}
}

void Semantic::checkArrayIndex(ValueType type) {
	if(type != IntType)
		error.TypeWarning(ArrayIndexConversionWarning, getLine(), getIndex(), type, type);
}