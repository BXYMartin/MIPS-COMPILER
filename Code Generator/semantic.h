#pragma once
#ifndef SEMANTIC_H
#define SEMANTIC_H

#include <vector>
#include <string>
#include "lexer.h"
#include "error.h"
#include "semantic.h"
#include "constant.h"
#include "symbol.h"
#include "function.h"

class Semantic
{
private:
	Error &error;
	Lexer &lexical;
	int getLine() {
		return lexical.getLine();
	}
	int getIndex() {
		return lexical.getIndex();
	}
public:
	Semantic(Error &error, Lexer &lexical);
	bool inSymbolTable(string id, string functionName);
	// 检查变量定义
	//bool isDefined(string id, string functionName);
	// 因子标识符检查
	int checkFactorId(string identifier, string funcName);
	// 语句标识符检查
	void checkStatementId(string identifier);
	// 检查数组下标和类型
	int checkArrayId(string identifier, string funcName, bool expSurable, int index = 0);
	// 因子项中的函数调用需要具有返回值
	void checkFuncCall(string identifier, bool isInExp, vector<ValueType> paramType);
	bool checkFuncType(string funcName);
	void checkType(ValueType s, ValueType t) {
		if (s != t) {
			error.TypeWarning(ConversionAssignmentWarning, getLine(), getIndex(), s, t);
		}
	}
	void checkCondition(ValueType s, ValueType t) {
		if (s != IntType || t != IntType) {
			error.TypeWarning(ConflictingComparisonTypeWarning, getLine(), getIndex(), s, t);
		}
	}

	int checkAssignId(string identifier, string funcName);

	void checkCaseEntry(vector<int> cases);
	void checkSwitchType(ValueType s, ValueType t) {
		if (s != t) {
			error.TypeWarning(ConflictingCaseTypeWarning, getLine(), getIndex(), s, t);
		}
	}

	void checkFuncReturn(string funcName);
	void checkFuncReturn(string funcName, ValueType retType);
};
#endif