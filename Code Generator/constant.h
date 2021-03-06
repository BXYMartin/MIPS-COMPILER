#pragma once

/*
	常量的全局定义头文件
	定义保留字、标识符和字符等的限制
*/

#ifndef CONSTANT_H
#define CONSTANT_H
#include <string>
#include <cstdio>
using namespace std;
#define _CRT_SECURE_NO_WARNINGS
#define KEY_NUM 15					// 保留字数量定义
#define SYM_NUM 39					// 记忆符数量

#define MAX_WORD_LENGTH 1024		// 最长单词长度
#define LEAST_REFERENCE 0
#define DEBUG	false
#define NEWLINE false
#define INORD	false
#define ULTOP	true
#define SPEED	true
#define INLINE	true

#define VAR_REGISTER	8	// 0~8
#define TEMP_REGISTER	6 // $t3~$t9
#define IsChar(x) ((x >= 32) && (x <= 126) && (x != 34))	// 定义字符的合法范围
#define IsNum(x) (((x >= '0') && (x <= '9')) || x == '-' || x == '+')
#define IsAlphaBet(x) ((x == '+') || (x == '-') || (x == '*') || (x == '/') || (x == '_') || isalnum(x))
/*
	定义类型部分
*/
enum ItemType {
	Constant,
	Variable,
	Function,
	Parameter
};

enum ValueType {
	IntType,
	CharType,
	StringType
};

enum FuncType {
	ReturnIntType,
	ReturnCharType,
	VoidType
};

/*
	定义标识符助记符
*/
enum SymbolCode {
	CONSTSY,	INTSY,		CHARSY,		VOIDSY,		MAINSY,		RETURNSY,
	IFSY,		ELSESY,		SWITCHSY,	CASESY,		DEFAULTSY,	DOSY,
	WHILESY,	SCANFSY,	PRINTFSY,	
	ID,			INT,		STRING,		CHAR,		
	ADD,		SUB,		MULT,		DIV,		
	LSS,		LEQ,		EQL,		GEQ,		NEQ,		GTR,		ASSIGN,
	COMMA,		COLON,
	SEMICOLON,	LSBRACKET,	RSBRACKET,	LMBRACKET,	RMBRACKET,	LBBRACKET,	RBBRACKET
};

enum TmpCodeType {
	ParamPass,
	FunctionCall,
	Pass,
	Label,
	FunctionDef,
	ParamDef,
	Jump,
	BEZ,
	BNZ,
	BLZ,
	BLEZ,
	BGZ,
	BGEZ,
	Read,
	Print,
	Return,
	End
};
//四元式结构体
struct MiddleCode {
	TmpCodeType type;
	ValueType valueType;	// 变量类型
	FuncType funcType;
	string target;
	string indexTargetArr;
	bool isTargetArr;
	bool isLeftArr;
	bool isVal;				// 打印变量
	string left;
	string indexLeftArr;
	string right;
	char op;
};

struct PostfixItem {
	ValueType type;
	string str;
	int number;
	bool nonChar;
	bool nonOp;
};

#endif