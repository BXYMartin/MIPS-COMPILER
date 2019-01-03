#pragma once
#ifndef GLOBALFUNCTION_H
#define GLOBALFUNCTION_H
#define _CRT_SECURE_NO_WARNINGS
#include "constant.h"
#include "symbol.h"
#include <string>
#include <vector>
using namespace std;

string getLabel();
string getVar();
int integerConversion(string);

void genQuaterCode(ofstream &out, MiddleCode item);
void writeMiddleCode();
void writeOptimizedMiddleCode();
void writeAssemblyCode();
void writeOptimizedAssemblyCode();
void writeSimulatedAssemblyCode();
void getDataSegment(ofstream &);
void getTextSegment(ofstream &, vector<MiddleCode> QuaterCode);
void getOptimizedTextSegment(ofstream &);

void cancelEscapeChar(string & target);

#endif