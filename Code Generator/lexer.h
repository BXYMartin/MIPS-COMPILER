#pragma once

#ifndef LEXER_H
#define LEXER_H
#include <string>
#include "constant.h"
#include "error.h"

using namespace std;

extern const char *Keywords[KEY_NUM];
extern const char *Symbols[SYM_NUM];

class Lexer
{
private:
	string	targetFile;		// 编译的目标文件
	long	fileSize;		// 目标文件长度
	int		index;			// 索引
	bool	finished;		// 读取状态
	bool	paused;			// 超前读取到错误内容则保持不动
	char	currentChar;	// 当前字符
	string	currentString;	// 当前字符串
	int		currentNumber;	// 当前数字
	int		currentLine;	// 当前代码行数
	enum	SymbolCode currentSymbol;			// 当前标识符类型
	Error	&currentError;	// 错误处理类引用,全局公用
	
	void drawChar() {
		index--;
	}

	char getChar() {
		if (index >= fileSize) {
			return EOF;
		}
		return targetFile[index++];
	}
	
	void lower(char* target);	// 转换为小写字符串
	
	int isReserved(char* target);	// 查找保留字

public:
	// 构造函数
	Lexer(Error &error);

	void readFile(string FilePath);
	// 处理词法中的异常错误
	bool handleError(char temp, LexicalErrorCode c);
	// 语法分析程序调用,读取一个词
	bool nextSym();
	// 设置跳读程序
	void skip(char end);

	int getLine();
	int getIndex();
	string getString();
	char getLetter();
	int getNumber();
	void rest();
	void reset(int ind, SymbolCode sym);
	SymbolCode getSymbol();
	
	bool isFinished();
	// 测试词法分析程序
	void testLexer();
};

#endif