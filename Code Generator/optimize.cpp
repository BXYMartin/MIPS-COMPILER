#include "stdafx.h"

#include <iostream>
#include <string>
#include "optimize.h"
#include <map>
#include <algorithm>

using namespace std;


extern vector<MiddleCode> MiddleCodeArr;
extern vector<SymbolTableItem> SymbolTable;
extern map<string, unsigned> maxTempOrderMap;
extern map<string, unsigned> maxVarOrderMap;
map<string, vector<int>> functionVarIndexMap;
vector<int> globalVarIndexMap;
map<int, string> varToRegisterMap;
map<string, int> maxTempUsingMap;
vector<string> funcNameTable;
vector<MiddleCode> optimizedMiddleCodeArr;

map<string, bool> inlinable;
map<int, string> inlineRegisterMap;
map<string, vector<Block>> functionTable;
map<string, vector<Block>>::iterator currentFunction;

NodeTable nodeTable;
vector<Node> nodeGraph;

string funcName = "GLOBAL";


void allocateRegister() {
	funcName = "GLOBAL";
	unsigned int i = 0;
	unsigned int a = 0;
	// 跳过 Global 变量
	for (; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (SymbolTable.at(i).getItemType() != Function) {
			if (item.getItemType() == Variable && item.getArrSize() == 0)
				globalVarIndexMap.push_back(i);
			continue;
		}
		else
			break;
	}
	for (; i < SymbolTable.size(); i++) {
		SymbolTableItem item = SymbolTable.at(i);
		if (item.getItemType() == Function) {
			funcName = item.getId();
			vector<int> temp;
			functionVarIndexMap.insert(map<string, vector<int>>::value_type(funcName, temp));
		}
		else if ((item.getItemType() == Parameter) || (item.getItemType() == Variable && item.getArrSize() == 0)) { // (item.getItemType() == Parameter) || (item.getItemType() == Variable && item.getArrSize() == 0)
			map<string, vector<int>>::iterator iter = functionVarIndexMap.find(funcName);
			iter->second.push_back(i);
		}
	}
	for (int j = 0; j < funcNameTable.size(); j++) {
		map<string, vector<int>>::iterator iter = functionVarIndexMap.find(funcNameTable.at(j));
		if (iter->second.size() == 0)
			continue;
		for (unsigned int k = 0; k < iter->second.size() - 1; k++) {
			for (int l = k + 1; l < iter->second.size(); l++) {
				int w1 = SymbolTable.at(iter->second.at(k)).getWeight();
				int w2 = SymbolTable.at(iter->second.at(l)).getWeight();
				if (w1 < w2) {
					int t = iter->second.at(k);
					iter->second.at(k) = iter->second.at(l);
					iter->second.at(l) = t;
				}
			}
		}
		unsigned int k;
		for (k = 0; k < iter->second.size() && k < VAR_REGISTER; k++) {
			varToRegisterMap.insert(map<int, string>::value_type(SymbolTable.at(iter->second.at(k)).getOrder(), "$s" + to_string(k)));
		}
		maxVarOrderMap.insert(map<string, unsigned>::value_type(funcNameTable.at(j), k));
	}
	if (globalVarIndexMap.size() == 0)
		return;
	for (unsigned int k = 0; k < globalVarIndexMap.size() - 1; k++) {
		for (int l = k + 1; l < globalVarIndexMap.size(); l++) {
			int w1 = SymbolTable.at(globalVarIndexMap.at(k)).getWeight();
			int w2 = SymbolTable.at(globalVarIndexMap.at(l)).getWeight();
			if (w1 < w2) {
				int t = globalVarIndexMap.at(k);
				globalVarIndexMap.at(k) = globalVarIndexMap.at(l);
				globalVarIndexMap.at(l) = t;
			}
		}
	}
	for (unsigned int k = 0; k < globalVarIndexMap.size() && k < 8 - VAR_REGISTER; k++) {
		varToRegisterMap.insert(map<int, string>::value_type(SymbolTable.at(globalVarIndexMap.at(k)).getOrder(), "$s" + to_string(k + VAR_REGISTER)));
	}
}


void pushBlock(int index, BlockType type) {
	Block b;
	b.index = index;
	b.type = type;
	if (type == FuncBlock) {
		vector<Block> v;
		v.push_back(b);
		functionTable.insert(map<string, vector<Block>>::value_type(funcName, v));
		currentFunction = functionTable.find(funcName);
	}
	else {
		currentFunction->second.push_back(b);
	}
}

void blockDivision() {
	bool callFlag = false;
	bool expFlag = false;
	for (unsigned int i = 0; i < MiddleCodeArr.size(); i++) {
		MiddleCode item = MiddleCodeArr.at(i);
		switch (item.type) {
		case FunctionDef: {
			expFlag = false;
			funcName = item.target;
			pushBlock(i, FuncBlock);
			funcNameTable.push_back(funcName);
			break;
		}
		case ParamPass: {
			expFlag = false;
			if (callFlag)
				break;
			callFlag = true;
			pushBlock(i, CallBlock);
			break;
		}
		case Pass: {
			if (item.isTargetArr) {
				expFlag = false;
				pushBlock(i, ArrayBlock);
				break;
			}
			if (item.left == "Ret") {
				break;
			}
			if (!expFlag) {
				expFlag = true;
				pushBlock(i, DAGBlock);
			}
			break;
		}
		case Label: {
			expFlag = false;
			pushBlock(i, LabelBlock);
			break;
		}
		case FunctionCall: {
			if (callFlag) {
				callFlag = false;
			}
			else {
				pushBlock(i, CallBlock);
			}
			break;
		}
		case Jump:
		case BEZ:
		case BNZ:
		case BLZ:
		case BLEZ:
		case BGZ:
		case BGEZ: {
			expFlag = false;
			pushBlock(i, BranchBlock);
			break;
		}
		case Read: {
			expFlag = false;
			pushBlock(i, ReadBlock);
			break;
		}
		case Print: {
			expFlag = false;
			pushBlock(i, WriteBlock);
			break;
		}
		case Return: {
			expFlag = false;
			pushBlock(i, RetBlock);
			break;
		}
		}
	}
}

bool isIn(vector<int> &obj, int target) {
	for (unsigned int i = 0; i < obj.size(); i++) {
		if (target == obj.at(i))
			return true;
	}
	return false;
}

void doFillCalSequ(vector<int> & calcNodes, vector<int>& interNodes, int code) {
	if (isIn(calcNodes, code))
		return;
	bool flag = true;
	for (unsigned int j = 0; j < nodeGraph.at(code).parent.size(); j++) {
		if (!isIn(calcNodes, nodeGraph.at(code).parent.at(j))) {
			flag = false;
			break;
		}
	}
	if (!flag)
		return;
	calcNodes.push_back(code);
	Node node = nodeGraph.at(code);
	Node left = nodeGraph.at(node.left);
	Node right = nodeGraph.at(node.right);
	if (!node.isLeftLeaf) {
		if (isIn(interNodes, left.code))
			doFillCalSequ(calcNodes, interNodes, left.code);
		if (isIn(interNodes, right.code))
			doFillCalSequ(calcNodes, interNodes, right.code);
	}
}

int searchDAG(int v1, int v2, char op) {
	for (unsigned int i = 0; i < nodeGraph.size(); i++) {
		Node node = nodeGraph.at(i);
		if (node.isLeftLeaf)
			continue;
		if (!((nodeGraph.at(node.left).code == v1 && nodeGraph.at(node.right).code == v2) ||
			(nodeGraph.at(node.left).code == v2 && nodeGraph.at(node.right).code == v1 && (op == '+' || op == '*'))))
			continue;
		if (node.op == op)
			return i;
	}
	return nodeGraph.size();
}

int pushNode(bool hasValue, string target) {
	map<string, int>::iterator node = nodeTable.table.find(target);
	if (node == nodeTable.table.end()) {
		Node temp;
		temp.code = nodeGraph.size();
		temp.isLeftLeaf = temp.isRightLeaf = true;
		temp.value = target;
		temp.isInitial = hasValue;
		nodeGraph.push_back(temp);
		nodeTable.table.insert(map<string, int>::value_type(target, temp.code));
		return temp.code;
	}
	else {
		return node->second;
	}
}

int pushNode(int v1, int v2, char op, string target) {
	int v3 = searchDAG(v1, v2, op);
	if (v3 == nodeGraph.size()) {
		Node temp;
		temp.code = v3;
		temp.op = op;
		temp.left = v1;
		temp.right = v2;
		temp.isLeftLeaf = temp.isRightLeaf = false;
		temp.isInitial = false;
		temp.target = target;
		nodeGraph.at(v1).parent.push_back(v3);
		nodeGraph.at(v2).parent.push_back(v3);
		nodeGraph.push_back(temp);
	}
	else {
		nodeGraph.at(v3).target = target;
	}
	map<string, int>::iterator node = nodeTable.table.find(target);
	if (node == nodeTable.table.end()) {
		nodeTable.table.insert(map<string, int>::value_type(target, v3));
	}
	else {
		node->second = v3;
	}
	return v3;
}

void reduceExpression(int start, int end) {
	nodeTable.table.clear();
	nodeTable.final.clear();
	nodeGraph.clear();
	vector<MiddleCode> cache;
	for (int i = start; i < end; i++) {
		MiddleCode item = MiddleCodeArr.at(i);
		if (item.type == Pass) {
			int v1, v2, v3;
			map<string, int>::iterator iter;
			// 检查左节点,如果左节点是数组
			if (item.isLeftArr) {
				v1 = pushNode(false, item.left);
				if (item.indexLeftArr.at(0) == '#')
					v2 = pushNode(false, item.indexLeftArr);
				else
					v2 = pushNode(true, item.indexLeftArr);
				v3 = pushNode(v1, v2, '[', item.target);
			}
			else {
				if (item.left.at(0) == '#')
					v1 = pushNode(false, item.left);
				else
					v1 = pushNode(true, item.left);
				if (item.right.at(0) == '#')
					v2 = pushNode(false, item.right);
				else
					v2 = pushNode(true, item.right);
				
				v3 = pushNode(v1, v2, item.op, item.target);
			}
		}
	}
	vector<int> tempNodes;
	map<string, unsigned>::iterator itr = maxTempOrderMap.find(funcName);
	int tmpCount;
	if (itr == maxTempOrderMap.end())
		tmpCount = 0;
	else
		tmpCount = itr->second + 1;
	for (int i = 0; i < nodeGraph.size(); i++) {
		Node node = nodeGraph.at(i);
		if (node.isLeftLeaf && node.isInitial) { // 叶子结点
			map<string, int>::iterator iter = nodeTable.table.find(node.value);
			if (iter->second != node.code) { // 需要保存 Caution!
				/*
				MiddleCode tempMiddleCode;
				tempMiddleCode.isTargetArr = tempMiddleCode.isLeftArr = false;
				tempMiddleCode.type = Pass;
				tempMiddleCode.target = "#" + to_string(tmpCount++);
				tempMiddleCode.left = node.value;
				tempMiddleCode.right = "0";
				tempMiddleCode.op = '+';
				cache.push_back(tempMiddleCode);
				nodeGraph.at(i).value = tempMiddleCode.target;
				*/
				nodeGraph.at(i).value = node.value;
			}
		}
		else if (!node.isLeftLeaf)
			tempNodes.push_back(node.code);
	}
	if ((end - start) == tempNodes.size()) {
		for (int p = start; p < end; p++) {
			optimizedMiddleCodeArr.push_back(MiddleCodeArr.at(p));
		}
		return;
	}
	else {
		for (int p = 0; p < cache.size(); p++) {
			optimizedMiddleCodeArr.push_back(cache.at(p));
		}
	}

	
	for (int i = 0; i < tempNodes.size(); i++) {
		vector<string> vars;
		bool isVarIn = false;
		for (map<string, int>::iterator iter = nodeTable.table.begin(); iter != nodeTable.table.end(); iter++) {
			if (iter->second == tempNodes.at(i)) {
				if (iter->first.at(0) != '#')
					isVarIn = true;
				vars.push_back(iter->first);
			}
		}
		if (isVarIn) {
			for (unsigned int j = 0; j < vars.size(); j++) {
				if (vars.at(j).at(0) == '#') {
					vars.erase(vars.begin() + j);
					j--;
				}
			}
		}
		else {
			if (vars.size() == 0)
				vars.push_back(nodeGraph.at(tempNodes.at(i)).target);
		}
		nodeGraph.at(tempNodes.at(i)).value = vars.at(0);
		nodeTable.final.insert(map<int, vector<string>>::value_type(tempNodes.at(i), vars));
	}
	// 遍历中间节点,生成逆序计算顺序
	vector<int> calcNodes;
	while (calcNodes.size() != tempNodes.size()) {
		for (int i = tempNodes.size() - 1; i >= 0; i--) {
			doFillCalSequ(calcNodes, tempNodes, tempNodes.at(i));
		}
	}
	// 逆转计算序列
	reverse(calcNodes.begin(), calcNodes.end());
	// 生成新的四元式
	MiddleCode tempMiddleCode;
	for (unsigned int i = 0; i < calcNodes.size(); i++) {
		int code = calcNodes.at(i);
		map<int, vector<string>>::iterator iter = nodeTable.final.find(code);
		Node node = nodeGraph.at(code);
		Node left = nodeGraph.at(node.left);
		Node right = nodeGraph.at(node.right);
		char op = nodeGraph.at(code).op;

		tempMiddleCode.type = Pass;
		tempMiddleCode.isTargetArr = false;
		tempMiddleCode.left = left.value;
		switch (op) {
		case '+':
		case '-':
		case '*':
		case '/':
			tempMiddleCode.isLeftArr = false;
			tempMiddleCode.right = right.value;
			tempMiddleCode.op = op;
			break;
		case '[':
			tempMiddleCode.isLeftArr = true;
			tempMiddleCode.indexLeftArr = right.value;
			break;
		}
		for (vector<string>::iterator itr = nodeTable.final[code].begin(); itr != nodeTable.final[code].end(); itr++) {
			tempMiddleCode.target = *itr;
			optimizedMiddleCodeArr.push_back(tempMiddleCode);
		}
	}
}


void optimizeMiddleCode() {
	for (unsigned int i = 0; i < funcNameTable.size(); i++) {
		funcName = funcNameTable.at(i);
		currentFunction = functionTable.find(funcName);
		vector<Block> blockMiddleCode = currentFunction->second;
		for (unsigned int j = 0; j < blockMiddleCode.size(); j++) {
			Block block = blockMiddleCode.at(j);
			if (block.type == DAGBlock) {
				int end;
				if (blockMiddleCode.size() == j + 1) {
					for (end = block.index + 1; end != MiddleCodeArr.size() && MiddleCodeArr.at(end).type != FunctionDef; end++);
				}
				else {
					end = blockMiddleCode.at(j + 1).index;
				}
				reduceExpression(block.index, end);
			}
			else {
				int begin = block.index;
				int end;
				if (blockMiddleCode.size() == j + 1) {
					optimizedMiddleCodeArr.push_back(MiddleCodeArr.at(block.index));
					for (end = block.index + 1; end != MiddleCodeArr.size() && MiddleCodeArr.at(end).type != FunctionDef; end++) {
						optimizedMiddleCodeArr.push_back(MiddleCodeArr.at(end));
					}
				}
				else {
					end = blockMiddleCode.at(j + 1).index;
					for (int k = begin; k < end; k++) {
						optimizedMiddleCodeArr.push_back(MiddleCodeArr.at(k));
					}
				}
			}
		}
	}
}

void printOptimize(MiddleCode item) {
	cout << ">>> Optimizing | ";
	if (item.type == Return)
		cout << "Deleted Redundant Return" << endl;
	else if (item.type == Jump)
		cout << "Deleted Redundant Jump " << item.target << " Code" << endl;
	else
		cout << "Deleted Quater Code " << item.target << " = " << item.left << " " << item.op << " " << item.right << endl;
}

void renameTemp(vector<MiddleCode>::iterator itr, string target, string altname) {
	for (itr++; itr != optimizedMiddleCodeArr.end(); itr++) {
		if (itr->type == Pass || (itr->type >= BEZ && itr->type <= BGEZ))
		{
			if (itr->left == target)
				itr->left = altname;
			if (itr->right == target)
				itr->right = altname;
			if (itr->isLeftArr && itr->indexLeftArr == target)
				itr->indexLeftArr = altname;
			if (itr->isTargetArr && itr->indexTargetArr == target)
				itr->indexTargetArr = altname;
			if (itr->target == target)
				return;
		}
		else if (itr->type == ParamPass || itr->type == Print) {
			if (itr->target == target)
				itr->target = altname;
		}
		else if (itr->type == Return) {
			if (itr->target == target)
				itr->target = altname;
			return;
		}
		else
			return;
	}
}

void fixTemp() {
	if (optimizedMiddleCodeArr.size() <= 2)
		return;
	for (vector<MiddleCode>::iterator itr = optimizedMiddleCodeArr.begin()+1; itr != optimizedMiddleCodeArr.end() && itr != optimizedMiddleCodeArr.end() - 1 && itr != optimizedMiddleCodeArr.end() - 2; itr++) {
		switch (itr->type) {
		case Pass:
			if (itr->target == itr->left && itr->op == '+' && itr->right == "0") {
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr+1);
			}
			
			if (itr->target == (itr + 1)->target && !IsNum(itr->left.at(0)) && itr->op == '+' && itr->right == "0" && itr->isLeftArr == false && (itr + 1)->type == Return && (itr->target.at(0) == '#')) {
				(itr + 1)->target = itr->left;
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			
			if (itr->target == (itr + 1)->left && (itr->isLeftArr == false || (itr + 1)->isTargetArr == false) && (itr + 1)->op == '+' && (itr + 1)->right == "0" && (itr->target.at(0) == '#'))
			{
				renameTemp(itr + 1, itr->target, (itr + 1)->target);
				itr->target = (itr + 1)->target;
				itr->isTargetArr = (itr + 1)->isTargetArr;
				itr->indexTargetArr = (itr + 1)->indexTargetArr;
				itr->isVal = (itr + 1)->isVal;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
				
			}
			if (itr->target == (itr + 1)->right && itr->target.at(0) == '#' && itr->isLeftArr == false && itr->op == '+' && itr->right == "0")
			{
				renameTemp(itr + 1, itr->target, itr->left);
				(itr + 1)->right = itr->left;
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			if (itr->target == (itr + 1)->left && itr->target.at(0) == '#' && itr->isLeftArr == false && itr->op == '+' && itr->right == "0")
			{
				renameTemp(itr + 1, itr->target, itr->left);
				(itr + 1)->left = itr->left;
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			break;
		case Return:
			if ((itr + 1)->type == Return) {
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			break;
		case Jump:
			if ((itr + 1)->type == Label && (itr + 1)->target == itr->target)
			{
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
				break;
			}
			if ((itr + 1)->type == Label && (itr + 2)->target == itr->target && (itr + 2)->type == Label)
			{
				itr--;
				printOptimize(*(itr + 1));
				optimizedMiddleCodeArr.erase(itr + 1);
				break;
			}
		}
	}
}

void evaluateOptimization() {
	int maxTempOrder = 0;
	for (map<string, unsigned int>::iterator itr = maxTempOrderMap.begin(); itr != maxTempOrderMap.end(); itr++) {
		if (itr->second >= TEMP_REGISTER)
			maxTempOrder++;
	}
	int maxVarOrder = 0;
	for (map<string, unsigned int>::iterator itr = maxVarOrderMap.begin(); itr != maxVarOrderMap.end(); itr++) {
		if (itr->second == VAR_REGISTER)
			maxVarOrder++;
	}
	cout << ">>> Optimizing | " << maxTempOrder << " Functions Reached Temp Variable Limit | " << maxVarOrder << " Functions Reached Variable Limit" << endl;

	if (maxTempOrder >= 3)
		cout << "--- Recommend  | Expand Register-Temp Variable Mapping Limit" << endl;
	if(maxVarOrder >= 3)
		cout << "--- Recommend  | Expand Register-Variable Mapping Limit" << endl;
}

int variableCount(string target) {
	int count = 0;
	for (vector<SymbolTableItem>::iterator itr = SymbolTable.begin(); itr != SymbolTable.end(); itr++) {
		if (itr->getFuncName() == target && itr->getItemType() != Constant)
			count++;
		if (itr->getFuncName() == target && itr->getArrSize() != 0)
			return 5;
	}
	return count;
}

// 函数内联性检查：要求无输入输出，局部变量个数小于等于4且临时变量个数小于等于6，函数不调用其他函数且函数内无数组
void inlineDetection() {
	string analysis = "";
	for (vector<MiddleCode>::iterator itr = optimizedMiddleCodeArr.begin(); itr != optimizedMiddleCodeArr.end(); itr++) {
		switch (itr->type) {
		case FunctionDef:
			analysis = itr->target;
			if (analysis == "main") {
				inlinable[analysis] = false;
				break;
			}
			else
				inlinable[analysis] = true;
			continue;
		case FunctionCall:
			inlinable[analysis] = false;
			continue;
		}
	}
	for (map<string, bool>::iterator itr = inlinable.begin(); itr != inlinable.end(); itr++) {
		if (maxTempOrderMap[itr->first] > TEMP_REGISTER || variableCount(itr->first) > 4)
			itr->second = false;	
	}
	int mapCount = 0;
	for (map<string, bool>::iterator itr = inlinable.begin(); itr != inlinable.end(); itr++) {
		mapCount = 0;
		if (itr->second) {
			cout << "%%% Inline Optimization Available for Function " << itr->first << endl;
			for (vector<SymbolTableItem>::iterator sym = SymbolTable.begin(); sym != SymbolTable.end(); sym++) {
				if (sym->getFuncName() == itr->first && sym->getItemType() != Constant) {
					inlineRegisterMap[sym->getOrder()] = "$a" + to_string(mapCount++);
				}
			}
		}
	}
	map<string, vector<MiddleCode>> insert;
	map<string, int> reference;
	map<string, int>::iterator r;
	analysis = "";
	for (vector<MiddleCode>::iterator itr = optimizedMiddleCodeArr.begin(); itr != optimizedMiddleCodeArr.end(); itr++) {
		map<string, bool>::iterator f;
		switch (itr->type) {
		case FunctionDef:
			if (analysis != "") {
				MiddleCode temp;
				temp.type = Label;
				temp.target = "$_" + analysis;
				insert[analysis].push_back(temp);
			}
			f = inlinable.find(itr->target);
			if (f != inlinable.end() && f->second)
				analysis = itr->target;
			else
				analysis = "";
			continue;
		case ParamDef:
			if (analysis != "") {
				itr--;
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			continue;
		case FunctionCall:
			reference[itr->target] = reference[itr->target] + 1;
			f = inlinable.find(itr->target);
			if (f != inlinable.end() && f->second) {
				for (vector<MiddleCode>::iterator i = insert[itr->target].begin(); i != insert[itr->target].end(); i++) {
					switch (i->type) {
					case Label:
					case Jump:
					case BEZ:
					case BGEZ:
					case BNZ:
					case BLZ:
					case BLEZ:
					case BGZ:
						i->target += "_" + to_string(reference[itr->target]);
					}
				}
				unsigned int offset = itr - optimizedMiddleCodeArr.begin();
				optimizedMiddleCodeArr.insert(itr + 1, insert[itr->target].begin(), insert[itr->target].end());
				itr = optimizedMiddleCodeArr.begin() + offset + 1;
			}
			continue;
		default:
			if (analysis != "") {
				insert[analysis].push_back(*itr);
				if (itr->type == Return) {
					MiddleCode temp;
					temp.type = Jump;
					temp.target = "$_" + analysis;
					insert[analysis].push_back(temp);
				}
				itr--;
				optimizedMiddleCodeArr.erase(itr + 1);
			}
			continue;
		}
	}
	// Replace varToRegisterMap
	for (map<int, string>::iterator itr = inlineRegisterMap.begin(); itr != inlineRegisterMap.end(); itr++) {
		varToRegisterMap[itr->first] = itr->second;
	}
}

void fixTempOrder() {
	vector<MiddleCode>::iterator scanner;
	map<string, bool>::iterator f;
	for (vector<MiddleCode>::iterator itr = optimizedMiddleCodeArr.begin(); itr != optimizedMiddleCodeArr.end(); itr++) {
		if (itr->type == FunctionDef) {
			maxTempUsingMap[itr->target] = -1;
		}
		else if (itr->type == FunctionCall) {
			scanner = itr;
			f = inlinable.find(itr->target);
			if (f != inlinable.end() && f->second) {
				for (; scanner != optimizedMiddleCodeArr.end() && scanner->type != Return; scanner++);
			}
			for (scanner++; scanner != optimizedMiddleCodeArr.end(); scanner++) {
				if (scanner->type == Pass) {
					bool flag = false;
					if (scanner->target.at(0) == '#') {
						flag = true;
						if (maxTempUsingMap[itr->target] <= atoi((scanner->target).substr(1).c_str()) - 1)
							maxTempUsingMap[itr->target] = atoi((scanner->target).substr(1).c_str()) - 1;
					}
					if (scanner->left.at(0) == '#') {
						flag = true;
						if (maxTempUsingMap[itr->target] <= atoi((scanner->left).substr(1).c_str()))
							maxTempUsingMap[itr->target] = atoi((scanner->left).substr(1).c_str());
					}
					if (scanner->right.at(0) == '#') {
						flag = true;
						if (maxTempUsingMap[itr->target] <= atoi((scanner->right).substr(1).c_str()))
							maxTempUsingMap[itr->target] = atoi((scanner->right).substr(1).c_str());
					}
					if (scanner->isLeftArr && scanner->indexLeftArr.at(0) == '#') {
						flag = true;
						if (maxTempUsingMap[itr->target] <= atoi((scanner->indexLeftArr).substr(1).c_str()))
							maxTempUsingMap[itr->target] = atoi((scanner->indexLeftArr).substr(1).c_str());
					}
					if (scanner->isTargetArr && scanner->indexTargetArr.at(0) == '#') {
						flag = true;
						if (maxTempUsingMap[itr->target] <= atoi((scanner->indexTargetArr).substr(1).c_str()))
							maxTempUsingMap[itr->target] = atoi((scanner->indexTargetArr).substr(1).c_str());
					}
					if (flag)
						break;
				}
				else
					break;
			}
		}
	}
	cout << endl;
}

void runOptimization() {
	blockDivision();
	optimizeMiddleCode();
	allocateRegister();
	if (ULTOP)
		fixTempOrder();
	if (INLINE) {
		inlineDetection();
	}
	fixTemp();
	evaluateOptimization();
}