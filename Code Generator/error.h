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
	EmptyFileError,				// 空文件
	DefinitionAfterMainError,	// main 函数后存在内容
	NoMainFunctionError,		// 缺少 main 函数
	MissingComponentError,		// 缺少重要组成部分
	ArrIndexError,				// 数组大小不是无符号整数
	TypeMismatchError,			// 赋值语句类型不匹配
	UnknownError				// 未定义错误
};

enum SemanticErrorCode {
	MultipleDefinitionError,			// 重复定义
	NoVariableDefinitionError,			// 变量未定义
	NoFunctionDefinitionError,			// 函数未定义
	IndexOutOfRangeError,				// 数组下标超过索引
	TypeNotMatchError,					// 类型不匹配
	VariableNotCallableError,			// 符号表中类型错误
	ValueExpectedError,					// 调用空函数参与值运算
	NoneValueParamError,				// 空值参数错误
	ExtraParameterError,				// 过多函数参数错误			
	MissingParameterError,				// 缺失函数参数错误
	CriticalAssignmentError,			// 赋值对象错误
	ConflictingCaseEntryError,			// case 入口值重复
	DivisionByZeroError,				// 除 0 错误
};

enum ReturnErrorCode {
	ValueReturnedInVoidFunctionError,	// 空函数返回值
	VoidReturnedInNonVoidFunctionError,	// 非空函数返回空值
	NoReturnError						// 无返回语句
};

enum TypeWarningCode {
	IlligalCharWarning,					// 单字符变量超出范围
	ConflictingCaseTypeWarning,			// case 类型不匹配
	ConversionAssignmentWarning,		// 赋值类型错误
	ConflictingParameterTypeWarning,	// 函数参数类型错误
	ConflictingComparisonTypeWarning,	// 条件表达式比较非整型
	ConflictingReturnTypeWarning,		// 函数返回值不匹配
	ArrayIndexConversionWarning			// 数组下标类型转换
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