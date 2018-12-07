#include "stdafx.h"

#include "symbol.h"
#include <vector>

using namespace std;

int SymbolTableItem::itemCount = 0;

// ��ʼ��ȫ�ַ��ű�
vector<SymbolTableItem> SymbolTable;

SymbolTableItem::SymbolTableItem(string id, string funcName) {
	order = itemCount++;
	functionName = funcName;
	identifier = id;
	length = 0;
	weight = 0;
}