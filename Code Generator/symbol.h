#pragma once
#ifndef SYMBOL_H
#define SYMBOL_H

#include "constant.h"
#include <string>
#include <vector>

using namespace std;

class SymbolTableItem
{
private:
	static		int itemCount;
	string		identifier;		// 标识符
	int			order;			// 符号表中索引
	string		functionName;	// 函数作用域索引
	ItemType	itemType;		// 标识符类型
	ValueType	valueType;		// 值类型
	FuncType	functionType;	// 函数类型
	int			constIntValue;	// 常量
	char		constCharValue;	// 常量
	int			length;			// 若为数组则记录长度
	int			weight;			// 记录变量的权重

public:
	SymbolTableItem(string id, string funcName);

	int getOrder() {
		return order;
	}
	string getId() {
		return identifier;
	}
	string getFuncName() {
		return functionName;
	}
	ItemType getItemType() {
		return itemType;
	}
	ValueType getValueType() {
		return valueType;
	}
	FuncType getFuncType() {
		return functionType;
	}
	int getArrSize() {
		return length;
	}
	int getConstInt() {
		return constIntValue;
	}
	char getConstChar() {
		return constCharValue;
	}
	void setItemType(ItemType type) {
		itemType = type;
	}
	void setValueType(ValueType type) {
		valueType = type;
	}
	void setArrSize(int size) {
		length = size;
	}
	void setConstInt(int value) {
		constIntValue = value;
	}
	void setConstChar(char value) {
		constCharValue = value;
	}
	void setFuncType(FuncType type) {
		functionType = type;
	}
	void addWeight(int num) {
		weight += num;
	}
	int getWeight() {
		return weight;
	}
};

#endif