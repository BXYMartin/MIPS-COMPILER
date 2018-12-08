#pragma once
#ifndef GLOBALFUNCTION_H
#define GLOBALFUNCTION_H
#define _CRT_SECURE_NO_WARNINGS
#include "constant.h"
#include "symbol.h"
#include <string>
#include <vector>
using namespace std;

//��������
string getLabel();
string getVar();
int integerConversion(string);
//�ļ�����
void genQuaterCode(ofstream &out, MiddleCode item);
//���м����д�뵽�ļ���
void writeMiddleCode();
void writeOptimizedMiddleCode();
//���м���뷭������յ�mips32������Դ���
void writeAssemblyCode();
void writeOptimizedAssemblyCode();
void writeSimulatedAssemblyCode();
void getDataSegment(ofstream &);
void getTextSegment(ofstream &, vector<MiddleCode> QuaterCode);
void getOptimizedTextSegment(ofstream &);

//ȡ���ַ����е�ת���ַ�
void cancelEscapeChar(string & target);

#endif