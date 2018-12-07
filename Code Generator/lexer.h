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
	string	targetFile;		// �����Ŀ���ļ�
	long	fileSize;		// Ŀ���ļ�����
	int		index;			// ����
	bool	finished;		// ��ȡ״̬
	bool	paused;			// ��ǰ��ȡ�����������򱣳ֲ���
	char	currentChar;	// ��ǰ�ַ�
	string	currentString;	// ��ǰ�ַ���
	int		currentNumber;	// ��ǰ����
	int		currentLine;	// ��ǰ��������
	enum	SymbolCode currentSymbol;			// ��ǰ��ʶ������
	Error	&currentError;	// ������������,ȫ�ֹ���
	
	void drawChar() {
		index--;
	}

	char getChar() {
		if (index >= fileSize) {
			return EOF;
		}
		return targetFile[index++];
	}
	
	void lower(char* target);	// ת��ΪСд�ַ���
	
	int isReserved(char* target);	// ���ұ�����

public:
	// ���캯��
	Lexer(Error &error);

	void readFile(string FilePath);
	// ����ʷ��е��쳣����
	bool handleError(char temp, LexicalErrorCode c);
	// �﷨�����������,��ȡһ����
	bool nextSym();
	// ������������
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
	// ���Դʷ���������
	void testLexer();
};

#endif