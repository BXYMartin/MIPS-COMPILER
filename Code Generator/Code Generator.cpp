// Generator.cpp: 定义控制台应用程序的入口点。
//
#include "stdafx.h"

#include <iostream>
#include <string>
#include "error.h"
#include "constant.h"
#include "syntax.h"
#include "semantic.h"
#include "function.h"
#include "optimize.h"
#include "operations.h"
#include "lexer.h"
#include <algorithm>

#define _CRT_SECURE_NO_WARNINGS
using namespace std;

string targetFile;

extern const char *Keywords[KEY_NUM];
extern const char *Symbols[SYM_NUM];
extern bool Errors;


int main()
{
	cout << "Please Enter Absolute Path:";

	getline(cin, targetFile);

	// 全局共用的错误处理类对象
	Error error;

	// 词法分析类对象
	Lexer lexical(error);

	lexical.readFile(targetFile);

	Semantic semantic(error, lexical);

	Syntax SyntaxAnalysis(error, lexical, semantic);
	SyntaxAnalysis.startAnalysis();
	if (DEBUG) {
		SyntaxAnalysis.showStructure();
		SyntaxAnalysis.printSymbolTable();
	}
	// 中间代码写入
	if (!Errors) {
		cout << "Successfully Compiled Source Code " << targetFile << "..." << endl;
		writeMiddleCode();
		cout << "Successfully Generated Quaternery Middle Code..." << endl;
		writeAssemblyCode();
		cout << "Successfully Generated MIPS Assembly Code..." << endl;
		runOptimization();
		cout << "Optimization Process Complete Successfully..." << endl;
		writeOptimizedMiddleCode();
		cout << "Successfully Generated Optimized Quaternery Middle Code..." << endl;
		writeOptimizedAssemblyCode();
		cout << "Successfully Generated Optimized MIPS Assembly Code..." << endl;
		runSimulation();
		cout << "Successfully Simulated MIPS Assembly Code..." << endl;
		writeSimulatedAssemblyCode();
		cout << "Successfully Generated Simulated MIPS Assembly Code..." << endl;
		checkOptimization();
		checkSimulation();
		cout << "Compiler Finished..." << endl;
	}
	else {
		cout << "Error Occurred During Compilation..." << endl;
	}

	cout << "Compiler Finished Processing." << endl;
	system("pause");
	return 0;
}

