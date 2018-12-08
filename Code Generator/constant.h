#pragma once

/*
	������ȫ�ֶ���ͷ�ļ�
	���屣���֡���ʶ�����ַ��ȵ�����
*/

#ifndef CONSTANT_H
#define CONSTANT_H

#define _CRT_SECURE_NO_WARNINGS
#define KEY_NUM 15					// ��������������
#define SYM_NUM 39					// ���������

#define MAX_WORD_LENGTH 1024		// ����ʳ���

#define DEBUG true

#include <string>
#include <cstdio>
using namespace std;
#define VAR_REGISTER 2
#define TEMP_REGISTER 6 // $t3~$t9
#define IsChar(x) ((x >= 32) && (x <= 126) && (x != 34))	// �����ַ��ĺϷ���Χ
#define IsNum(x) (((x >= '0') && (x <= '9')) || x == '-' || x == '+')
/*
	�������Ͳ���
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
	�����ʶ�����Ƿ�
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
//��Ԫʽ�ṹ��
struct MiddleCode {
	TmpCodeType type;
	ValueType valueType;	// ��������
	FuncType funcType;
	string target;
	string indexTargetArr;
	bool isTargetArr;
	bool isLeftArr;
	bool isVal;				// ��ӡ����
	string left;
	string indexLeftArr;
	string right;
	char op;
};
//��׺���ʽת�沨�����ʽջ����ṹ��
struct PostfixItem {
	ValueType type;
	string str;
	int number;
	bool nonChar;//�Ƿ���char�ͱ�������˵��char������ĳ��Ԫ��
	bool nonOp;//�����char�ͳ���,�ǲ��������
};

#endif