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
	string value;// 针对叶子结点
	vector<int> parent;
	// 针对叶节点引用不在结点表中的变量(只针对变量)
	string target;//当中间节点啥都没有了的时候,保存最新的
	bool isInitial;
	bool isLeftLeaf;
	bool isRightLeaf;
};



void runOptimization();

#endif