#pragma once

/*
	常量的全局定义头文件
	定义保留字、标识符和字符等的限制
*/

#ifndef CONSTANT_H
#define CONSTANT_H

#define _CRT_SECURE_NO_WARNINGS
#define KEY_NUM 15					// 保留字数量定义
#define SYM_NUM 39					// 记忆符数量

#define MAX_WORD_LENGTH 1024		// 最长单词长度

#define DEBUG true

#include <string>
#include <cstdio>
using namespace std;
#define VAR_REGISTER 2
#define TEMP_REGISTER 6 // $t3~$t9
#define IsChar(x) ((x >= 32) && (x <= 126) && (x != 34))	// 定义字符的合法范围
#define IsNum(x) (((x >= '0') && (x <= '9')) || x == '-' || x == '+')
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
	VoidType,
	ReturnIntType,
	ReturnCharType
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
//中缀表达式转逆波兰表达式栈的项结构体
struct PostfixItem {
	ValueType type;
	string str;
	int number;
	bool nonChar;//是否是char型变量或者说是char型数组某个元素
	bool nonOp;//如果是char型常量,是不是运算符
};

#endif