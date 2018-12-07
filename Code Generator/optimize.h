#pragma once
#ifndef OPT_H
#define OPT_H

#define _CRT_SECURE_NO_WARNINGS
#include "constant.h"
#include "function.h"
#include "syntax.h"
#include "symbol.h"
#include <vector>
#include <map>

enum BlockType {
	FuncBlock,
	DAGBlock,
	CallBlock,
	ReadBlock,
	WriteBlock,
	RetBlock,
	LabelBlock,
	BranchBlock,
	ArrayBlock
};

struct Block {
	int index;
	BlockType type;
};

struct NodeTable {
	map<string, int> table;
	map<int, vector<string>> final;
};


struct Node {
	int code;
	int left;
	int right;
	char op;//+ - * / = [ 
	string value;// ���Ҷ�ӽ��
	vector<int> parent;
	// ���Ҷ�ڵ����ò��ڽ����еı���(ֻ��Ա���)
	string target;//���м�ڵ�ɶ��û���˵�ʱ��,�������µ�
	bool isInitial;
	bool isLeftLeaf;
	bool isRightLeaf;
};



void runOptimization();

#endif