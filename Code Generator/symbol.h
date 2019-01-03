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
	string		identifier;		// ��ʶ��
	int			order;			// ���ű�������
	string		functionName;	// ��������������
	ItemType	itemType;		// ��ʶ������
	ValueType	valueType;		// ֵ����
	FuncType	functionType;	// ��������
	int			constIntValue;	// ����
	char		constCharValue;	// ����
	int			length;			// ��Ϊ�������¼����
	int			weight;			// ��¼������Ȩ��

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