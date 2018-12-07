#include "stdafx.h"

#include "symbol.h"
#include <vector>

using namespace std;

int SymbolTableItem::itemCount = 0;

// 初始化全局符号表
vector<SymbolTableItem> SymbolTable;

SymbolTableItem::SymbolTableItem(string id, string funcName) {
	order = itemCount++;
	functionName = funcName;
	identifier = id;
	length = 0;
	weight = 0;
}