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
	// ����������
	//bool isDefined(string id, string functionName);
	// ���ӱ�ʶ�����
	int checkFactorId(string identifier, string funcName);
	// ����ʶ�����
	void checkStatementId(string identifier);
	// ��������±������
	int checkArrayId(string identifier, string funcName, bool expSurable, int index = 0);
	// �������еĺ���������Ҫ���з���ֵ
	void checkFuncCall(string identifier, bool isInExp, vector<ValueType> paramType);
	bool checkFuncType(string funcName);
	void checkType(ValueType s, ValueType t) {
		if (s == CharType && t == IntType) {
			error.SemanticError(ConversionAssignmentError, getLine(), getIndex(), "");
		}
	}

	int checkAssignId(string identifier, string funcName);

	void checkCaseEntry(vector<int> cases);
	void checkSwitchType(ValueType s, ValueType t) {
		if (s != t) {
			error.SemanticError(ConflictingCaseEntryError, getLine(), getIndex(), "");
		}
	}

	void checkFuncReturn(string funcName);
	void checkFuncReturn(string funcName, ValueType retType);
};
#endif