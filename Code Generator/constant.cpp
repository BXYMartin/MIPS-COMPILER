#include "stdafx.h"

#include "constant.h"
using namespace std;

const char *Keywords[KEY_NUM] = {
	"const",  "int"    ,  "char" ,  "void" ,
	"main" ,  "return" ,  "if"   ,  "else" ,  "switch",
	"case" ,  "default",  "do"   ,	"while",  "scanf",  "printf"
};

const char *Symbols[SYM_NUM] = {
	"CONSTSY",      "INTSY",        "CHARSY",       "VOIDSY",
	"MAINSY",		"RETURNSY",     "IFSY",         "ELSESY",       "SWITCHSY",
	"CASESY",       "DEFAULTSY",	"DOSY",		    "WHILESY",      "SCANFSY",
	"PRINTFSY",     "ID",			"INT",
	"STRING",       "CHAR",         "ADD",          "SUB",
	"MULT",         "DIV",          "LSS",			"LEQ",
	"EQL",	        "GEQ",			"NEQ",			"GTR",			"ASSIGN",
	"COMMA",        "COLON",        "SEMICOLON",    "LSBRACKET",
	"RSBRACKET",    "LMBRACKET",    "RMBRACKET",    "LBBRACKET",
	"RBBRACKET"
};
