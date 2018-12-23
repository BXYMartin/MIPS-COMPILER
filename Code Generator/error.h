#pragma once
#ifndef ERROR_H
#define ERROR_H
#include <iostream>
#include <string>
#include "constant.h"

using namespace std;

#define SURROUND 16

enum LexicalErrorCode {
	SingleCharIllegal,
	StringIllegal,
	ContentIllegal,
	NotEqualSymIllegal
};

enum SyntaxErrorCode {
	EmptyFileError,				// ���ļ�
	DefinitionAfterMainError,	// main �������������
	NoMainFunctionError,		// ȱ�� main ����
	MissingComponentError,		// ȱ����Ҫ��ɲ���
	ArrIndexError,				// �����С�����޷�������
	TypeMismatchError,			// ��ֵ������Ͳ�ƥ��
	UnknownError				// δ�������
};

enum SemanticErrorCode {
	MultipleDefinitionError,			// �ظ�����
	NoVariableDefinitionError,			// ����δ����
	NoFunctionDefinitionError,			// ����δ����
	IndexOutOfRangeError,				// �����±곬������
	TypeNotMatchError,					// ���Ͳ�ƥ��
	VariableNotCallableError,			// ���ű������ʹ���
	ValueExpectedError,					// ���ÿպ�������ֵ����
	NoneValueParamError,				// ��ֵ��������
	ExtraParameterError,				// ���ຯ����������			
	MissingParameterError,				// ȱʧ������������
	CriticalAssignmentError,			// ��ֵ�������
	ConflictingCaseEntryError,			// case ���ֵ�ظ�
	DivisionByZeroError,				// �� 0 ����
};

enum ReturnErrorCode {
	ValueReturnedInVoidFunctionError,	// �պ�������ֵ
	VoidReturnedInNonVoidFunctionError,	// �ǿպ������ؿ�ֵ
	NoReturnError						// �޷������
};

enum TypeWarningCode {
	IlligalCharWarning,					// ���ַ�����������Χ
	ConflictingCaseTypeWarning,			// case ���Ͳ�ƥ��
	ConversionAssignmentWarning,		// ��ֵ���ʹ���
	ConflictingParameterTypeWarning,	// �����������ʹ���
	ConflictingComparisonTypeWarning,	// �������ʽ�ȽϷ�����
	ConflictingReturnTypeWarning,		// ��������ֵ��ƥ��
	ArrayIndexConversionWarning			// �����±�����ת��
};

class Error
{
private:
	void reportPosition(int index);

public:
	string targetFile;
	void LexicalError(LexicalErrorCode errorCode, int currentLine, int index);
	void SyntaxError(SyntaxErrorCode errorCode, int currentLine, int index);
	void SyntaxError(SyntaxErrorCode errorCode, int currentLine, int index, string info);
	void SemanticError(SemanticErrorCode errorCode, int currentLine, int index, string identifier);
	void ReturnError(ReturnErrorCode errorCode, int currentLine, int index, string funcName);
	void TypeWarning(TypeWarningCode warningCode, int currentLine, int index, ValueType src, ValueType dst);
};

#endif