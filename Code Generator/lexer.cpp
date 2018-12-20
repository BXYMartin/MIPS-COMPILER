#include "stdafx.h"

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cctype>
#include <cstring>
#include <iomanip>
#include "lexer.h"

using namespace std;

extern const char *Keywords[KEY_NUM];
extern const char *Symbols[SYM_NUM];
extern bool Errors;

Lexer::Lexer(Error &error):currentError(error) {
	fileSize = 0;
	index = 0;
	currentChar = '\0';
	currentNumber = 0;
	currentLine = 1;
	paused = false;
	finished = false;
}

// 文件读取
void Lexer::readFile(string FilePath) {
	ifstream file(FilePath, ios::in);
	if (!file) {
		cout << "File Not Exist in Path \"" << FilePath << "\"" << endl;
		exit(EXIT_FAILURE);
	}
	istreambuf_iterator<char> begin(file), end;
	if (begin == end) {
		cout << "Empty File Detected" << endl;
		exit(EXIT_SUCCESS);
	}
	targetFile = string(begin, end);
	currentError.targetFile = targetFile;
	file.close();
	fileSize = targetFile.size();
	// 识别非法字符
	for (int i = 0; i < fileSize; i++) {
		if (targetFile[i] < -1) {
			cout << "Unrecognized ASCII Character Exists" << endl;
			exit(EXIT_SUCCESS);
		}
	}
	cout << "Loading Succeed, Total File Size: " << fileSize << " Bytes" << endl;
	if (DEBUG) {
		cout << "Line" << "\t";
		cout << setw(8) << "Symbol" << "\t";
		cout << "Content" << endl;
	}
}

bool Lexer::handleError(char temp, LexicalErrorCode c) {
	currentError.LexicalError(c, currentLine, index);
	while (temp != '\n' && temp != ';' && temp != EOF) {
		temp = getChar();
	}
	if (temp == '\n')
		drawChar();
	return nextSym();
}

// 获取到下一个单词则返回真,否则返回假
bool Lexer::nextSym() {
	// 弥补上一次多读取的错误内容
	if (paused) {
		paused = false;
		return true;
	}
	// 读取单词
	char str[MAX_WORD_LENGTH] = { '\0' };
	char temp = getChar();
	// 跳过无用字符
	while (isspace(temp)) {
		if (temp == '\n')
			currentLine++;
		temp = getChar();
	}
	// 检查文档是否结束
	if (temp == EOF) {
		finished = true;
		if (DEBUG) {
			cout << "Lexer Reached End-Of-File." << endl;
		}
		return false;
	}
	if (isalpha(temp) || temp == '_') {	// 标识符或者保留字
		while (isalnum(temp) || temp == '_') {
			str[strlen(str)] = temp;
			temp = getChar();
		}
		if (temp != EOF) {
			drawChar();
		}
		lower(str);
		int resultValue = isReserved(str);
		currentString = str;
		if (resultValue == -1) {
			currentSymbol = ID;
		}
		else {
			currentSymbol = (SymbolCode)resultValue;
		}
	}
	else if (isdigit(temp)) {	// 数字
		while (isdigit(temp)) {
			str[strlen(str)] = temp;
			temp = getChar();
		}
		if (temp != EOF)
			drawChar();
		currentNumber = atoi(str);
		currentSymbol = INT;
	}
	else if (temp == '+') {
		currentChar = '+';
		currentSymbol = ADD;
	}
	else if (temp == '-') {
		currentChar = '-';
		currentSymbol = SUB;
	}
	else if (temp == '*') {
		currentChar = '*';
		currentSymbol = MULT;
	}
	else if (temp == '/') {
		currentChar = '/';
		currentSymbol = DIV;
	}
	else if (temp == '<') {
		temp = getChar();
		if (temp != '=') {
			currentChar = '<';
			currentSymbol = LSS;
			drawChar();
		}
		else {
			currentString = "<=";
			currentSymbol = LEQ;
		}
	}
	else if (temp == '>') {
		temp = getChar();
		if (temp != '=') {
			currentChar = '>';
			currentSymbol = GTR;
			drawChar();
		}
		else {
			currentString = ">=";
			currentSymbol = GEQ;
		}
	}
	else if (temp == '!') {
		temp = getChar();
		if (temp != '=') {
			return handleError(temp, NotEqualSymIllegal);
		}
		else {
			currentString = "!=";
			currentSymbol = NEQ;
		}
	}
	else if (temp == ',') {
		currentChar = ',';
		currentSymbol = COMMA;
	}
	else if (temp == ':') {
		currentChar = ':';
		currentSymbol = COLON;
	}
	else if (temp == ';') {
		currentChar = ';';
		currentSymbol = SEMICOLON;
	}
	else if (temp == '(') {
		currentChar = '(';
		currentSymbol = LSBRACKET;
	}
	else if (temp == ')') {
		currentChar = ')';
		currentSymbol = RSBRACKET;
	}
	else if (temp == '[') {
		currentChar = '[';
		currentSymbol = LMBRACKET;
	}
	else if (temp == ']') {
		currentChar = ']';
		currentSymbol = RMBRACKET;
	}
	else if (temp == '{') {
		currentChar = '{';
		currentSymbol = LBBRACKET;
	}
	else if (temp == '}') {
		currentChar = '}';
		currentSymbol = RBBRACKET;
	}
	else if (temp == '=') {
		temp = getChar();
		if (temp != '=') {
			currentChar = '=';
			currentSymbol = ASSIGN;
			drawChar();
		}
		else {
			currentString = "==";
			currentSymbol = EQL;
		}
	}
	else if (temp == '\'') {
		temp = getChar();
		if (IsAlphaBet(temp)) { // 检查字符型变量的可用性
			currentChar = temp;
			temp = getChar();
			if (temp != '\'') {
				return handleError(temp, SingleCharIllegal);
			}
			currentSymbol = CHAR;
		}
		else {
			return handleError(temp, SingleCharIllegal);
		}
	}
	else if (temp == '"') {
		temp = getChar();
		while (IsChar(temp)) {
			str[strlen(str)] = temp;
			temp = getChar();
		}
		if (temp == '"') {
			currentString = str;
			currentSymbol = STRING;
		}
		else {
			return handleError(temp, StringIllegal);
		}
	}
	else {
		// handleError(temp, ContentIllegal);
		// currentError.LexicalError(ContentIllegal, currentLine);
		return handleError(temp, ContentIllegal);
	}
	if (DEBUG) {
		cout << currentLine << "\t";
		cout << setw(8) << Symbols[currentSymbol] << "\t";
		switch (currentSymbol) {
		case CONSTSY:
		case INTSY:
		case CHARSY:
		case VOIDSY:
		case MAINSY:
		case RETURNSY:
		case IFSY:
		case ELSESY:
		case SWITCHSY:
		case CASESY:
		case DEFAULTSY:
		case WHILESY:
		case SCANFSY:
		case PRINTFSY:
		case DOSY:
			cout << Keywords[currentSymbol] << endl;
			break;
		case ID:
		case LEQ:
		case GEQ:
		case NEQ:
		case EQL:
		case STRING:
			cout << currentString << endl;
			break;
		case INT:
			cout << currentNumber << endl;
			break;
		case CHAR:
		default:
			cout << currentChar << endl;
			break;
		}
	}
	return true;
}

// 查找保留字
int Lexer::isReserved(char* target) {
	lower(target);	// 关键字不区分大小写
	for (int i = 0; i<KEY_NUM; i++) {
		if (_stricmp(Keywords[i], target) == 0) {
			return i;
		}
	}
	return -1;
}
// 小写化字母
void Lexer::lower(char* target) {
	for (; *target != '\0';) {
		if (*target >= 'A' && *target <= 'Z')
			*target = *target + 'a' - 'A';
		target++;
	}
}

void Lexer::skip(char end) {
	if (currentChar != end) {
		char temp = getChar();
		while (temp != EOF && temp != end && temp != '\n')
			temp = getChar();
		if (temp == '\n') {
			drawChar();
		}
	}
	nextSym();
}

void Lexer::testLexer() {
	cout << "Line" << "\t";
	cout << setw(8) << "Symbol" << "\t";
	cout << "Content" << endl;
	while (nextSym()) {
		cout << currentLine << "\t";
		cout << setw(8) << Symbols[currentSymbol] << "\t";
		switch (currentSymbol) {
		case CONSTSY:
		case INTSY:
		case CHARSY:
		case VOIDSY:
		case MAINSY:
		case RETURNSY:
		case IFSY:
		case ELSESY:
		case SWITCHSY:
		case CASESY:
		case DEFAULTSY:
		case WHILESY:
		case SCANFSY:
		case PRINTFSY:
		case DOSY:
			cout << Keywords[currentSymbol] << endl;
			break;
		case ID:
		case LEQ:
		case GEQ:
		case NEQ:
		case EQL:
		case STRING:
			cout << currentString << endl;
			break;
		case INT:
			cout << currentNumber << endl;
			break;
		case CHAR:
		default:
			cout << currentChar << endl;
			break;
		}
	}
	cout << "Testing Complete..." << endl;
}

int Lexer::getLine() {
	return currentLine;
}

int Lexer::getIndex() {
	return index;
}

bool Lexer::isFinished() {
	return finished;
}

SymbolCode Lexer::getSymbol() {
	return currentSymbol;
}

void Lexer::rest() {
	paused = true;
}

char Lexer::getLetter() {
	return currentChar;
}
string Lexer::getString() {
	return currentString;
}
int Lexer::getNumber() {
	return currentNumber;
}
void Lexer::reset(int ind, SymbolCode sym) {
	index = ind;
	currentSymbol = sym;
	return;
}