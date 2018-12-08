#pragma once
#ifndef GLOBALFUNCTION_H
#define GLOBALFUNCTION_H
#define _CRT_SECURE_NO_WARNINGS
#include "constant.h"
#include "symbol.h"
#include <string>
#include <vector>
using namespace std;

//函数声明
string getLabel();
string getVar();
int integerConversion(string);
//文件操作
void genQuaterCode(ofstream &out, MiddleCode item);
//将中间代码写入到文件中
void writeMiddleCode();
void writeOptimizedMiddleCode();
//将中间代码翻译成最终的mips32汇编语言代码
void writeAssemblyCode();
void writeOptimizedAssemblyCode();
void writeSimulatedAssemblyCode();
void getDataSegment(ofstream &);
void getTextSegment(ofstream &, vector<MiddleCode> QuaterCode);
void getOptimizedTextSegment(ofstream &);

//取消字符串中的转义字符
void cancelEscapeChar(string & target);

#endif