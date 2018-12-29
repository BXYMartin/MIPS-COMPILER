#include "stdafx.h"

#include "syntax.h"
#include "function.h"
#include <iostream>
#include <cstdarg>
#include <iomanip>

#define _CRT_SECURE_NO_WARNINGS

using namespace std;

extern int VarCount;

// 初始化全局语义分析函数
Syntax::Syntax(Error &error, Lexer &lexical, Semantic &semantic) :error(error), lexical(lexical), semantic(semantic) {
	voidMain = false;
	getInteger = 0;
	getFunctionID = "GLOBAL";
}

bool Syntax::getncheckEnd(string message) {
	bool next;
	next = lexical.nextSym();
	if (!next) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message + " with unexpected endings");
		return false;
	}
	return true;
}


bool Syntax::checkComponent(SymbolCode symbol, string message) {
	SymbolCode currentSymbol;
	if (lexical.isFinished()) {
		return false;
	}
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message);
		lexical.rest();
	}
	return true;
}

bool Syntax::checknskipComponent(SymbolCode symbol, string message, char end) {
	SymbolCode currentSymbol;
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message);
		lexical.skip(end);
		lexical.rest();
	}
	return true;
}


bool Syntax::skipComponent(SymbolCode symbol, string message, char end) {
	SymbolCode currentSymbol;
	if (lexical.isFinished()) {
		return false;
	}
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message);
		lexical.skip(end);
	}
	return true;
}


bool Syntax::getncheckComponent(SymbolCode symbol, string message) {
	SymbolCode currentSymbol;
	if (!getncheckEnd(message))
		return false;
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message);
		lexical.rest();
	}
	return true;
}


bool Syntax::getnskipComponent(SymbolCode symbol, string message, char end) {
	SymbolCode currentSymbol;
	if (!getncheckEnd(message))
		return false;
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), message);
		lexical.skip(end);
		return false;
	}
	return true;
}



bool Syntax::getncheckSymbol(SymbolCode symbol, string message) {
	SymbolCode currentSymbol;
	if (!getncheckEnd(message))
		return false;
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		return false;
	}
	return true;
}

bool Syntax::checkSymbol(SymbolCode symbol) {
	SymbolCode currentSymbol;
	if (lexical.isFinished()) {
		return false;
	}
	currentSymbol = lexical.getSymbol();
	if (currentSymbol != symbol) {
		return false;
	}
	return true;
}

void Syntax::pushMiddleCode(MiddleCode code, bool isCache, vector<MiddleCode> &cache) {
	if (isCache)
		cache.push_back(code);
	else
		MiddleCodeArr.push_back(code);
}


//程序入口函数
void Syntax::startAnalysis() {
	bool next;
	next = lexical.nextSym();	// 读取下一个符号
	if (next) {					// 存在下一个符号
		if (!enter_procedure()) // 开始分析程序
			return;
	}
	else {
		error.SyntaxError(EmptyFileError, getLine(), getIndex()); // 无法读取到标识符, 空文件
		return;
	}
	// 在程序末尾还有其他元素
	if (!lexical.isFinished()) {
		error.SyntaxError(DefinitionAfterMainError, getLine(), getIndex());
	}
}


// ＜程序＞::=［＜常量说明＞］［＜变量说明＞］{＜有返回值函数定义＞|＜无返回值函数定义＞}＜主函数＞
bool Syntax::enter_procedure() {
	markSyntax("Procedure");
	//［＜常量说明＞］检查
	enter_constDescription("GLOBAL");
	//［＜变量说明＞］检查
	enter_varDescription(true, "GLOBAL");
	// {＜有返回值函数定义＞|＜无返回值函数定义＞} 检查是否存在函数定义, 识别到 main 函数返回
	printLevel++;
	enter_functionDefinition();
	// ＜主函数＞ 分析, 需要函数分析部分返回主函数类型供检查
	SymbolCode symbol;
	// 检查 main 函数修饰
	symbol = lexical.getSymbol();
	if (!(symbol == MAINSY && voidMain)) {
		error.SyntaxError(NoMainFunctionError, getLine(), getIndex());
		return false;
	}
	//进入填表,main函数入符号表
	pushItem("main", "GLOBAL", VoidType);
	if (!getncheckComponent(LSBRACKET, "Missing ( in main(){...} definition"))
		return false;
	if (!getncheckComponent(RSBRACKET, "Missing ) in main(){...} definition"))
		return false;
	// 读取主函数组成内容
	getncheckComponent(LBBRACKET, "Missing { in main(){...} definition");
	if (!getncheckEnd("Missing Compound Statement in main function"))
		return false;
	// 复合语句
	pushPseudoCode(FunctionDef, null, false, VoidType, "main");
	enter_compoundStatement("main");
	if (!checkComponent(RBBRACKET, "Missing } in main(){...} definition"))
		return false;
	lexical.nextSym();
	printLevel--;
	markSyntax("End.");
	// 程序分析结束
	return true;
}

//＜常量说明＞ ::=  const＜常量定义＞;{ const＜常量定义＞;} 
void Syntax::enter_constDescription(string funcName) {
	if (!checkSymbol(CONSTSY))
		return;
	markSyntax("const");
	do{
		if (!getncheckEnd("Missing identifier after const prefix"))
			return;
		// 分析<常量定义>
		enter_constDefinition(funcName);
		if (!checkComponent(SEMICOLON, "Missing ; after const declaration"))
			return;
		if (!getncheckSymbol(CONSTSY, "Const definition"))
			return;
	} while (true);
	return;
}

// ＜常量定义＞   :: = int＜标识符＞＝＜整数＞{ ,＜标识符＞＝＜整数＞ } | char＜标识符＞＝＜字符＞{ ,＜标识符＞＝＜字符＞ }
void Syntax::enter_constDefinition(string funcName) {
	SymbolCode symbol;
	string id;
	symbol = lexical.getSymbol();
	if (symbol == INTSY) {
		do{
			if (!getnskipComponent(ID, "Missing identifier after const int definition", ';'))
				return;
			id = lexical.getString();
			if (!getnskipComponent(ASSIGN, "Missing = after const int definition", ';'))
				return;
			if (!getncheckEnd("Missing integer in const int definition"))
				return;
			// 整数
			enter_integer();
			// 填符号表
			pushItem(id, funcName, getInteger);
			if (!checkSymbol(COMMA))
				return;
		} while (true);

	}
	else if (symbol == CHARSY) {
		do {
			if (!getnskipComponent(ID, "Missing identifier after const char definition", ';'))
				return;
			id = lexical.getString();
			if (!getnskipComponent(ASSIGN, "Missing = after const char definition", ';'))
				return;
			if (!getnskipComponent(CHAR, "Missing char after const char definition", ';'))
				return;
			// 填符号表
			pushItem(id, funcName, lexical.getLetter());
			if (!getncheckSymbol(COMMA, "Const definition"))
				return;
		} while (true);
	}
	else {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Invalid const definition");
		lexical.skip(';');
		return;
	}
	return;
}

// ＜变量说明＞ ::= ＜变量定义＞;{＜变量定义＞;}
// 和全局函数声明存在 FIRST集相交问题，需要特判
void Syntax::enter_varDescription(bool isGlobal, string funcName) {
	bool next;
	SymbolCode symbol;
	int point;
	SymbolCode symbolCode;
	do{
		// 区分全局函数定义和变量定义
		if (isGlobal) {
			point = lexical.getIndex();
			symbolCode = lexical.getSymbol();
			symbol = lexical.getSymbol();
			if (symbol == CHARSY || symbol == INTSY) {
				next = lexical.nextSym();
				if (next) {
					symbol = lexical.getSymbol();
					if (symbol == ID) {
						next = lexical.nextSym();
						if (next) {
							symbol = lexical.getSymbol();
							if (symbol == LSBRACKET || symbol == LBBRACKET) {	// ( 或 {
								lexical.reset(point, symbolCode);
								return;
							}
						}
					}
				}
				// 回退指针并正常分析
				lexical.reset(point, symbolCode);
			}
			else {
				return;
			}
		}
		// 如果不是全局的,则正常分析
		markSyntax("variable");
		if (!enter_varDefinition(funcName))
			return;

		if (!checkComponent(SEMICOLON, "Missing ; after variable definition"))
			return;

		if (!getncheckEnd("Missing main function declaration"))
			return;
	}while (true);
	return;
}


// ＜变量定义＞  ::= ＜类型标识符＞(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’){,(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’) }
bool Syntax::enter_varDefinition(string funcName) {
	ValueType valueType;
	string id;
	int length;
	// 识别类型标识符
	if (checkSymbol(INTSY))
		valueType = IntType;
	else if (checkSymbol(CHARSY))
		valueType = CharType;
	else
		return false;
	do{
		if (!getnskipComponent(ID, "Missing identifier in variable definition", ';'))
			return false;
		id = lexical.getString();
		if (!getncheckEnd("Variable declaration"))
			return false;
		// 识别[
		if (checkSymbol(LMBRACKET)) {
			if (!getnskipComponent(INT, "Missing unsigned integer in array definition", ';'))
				return false;
			length = lexical.getNumber();
			if (length == 0) {	// 数组下标定义必须大于零
				error.SyntaxError(ArrIndexError, getLine(), getIndex());
				lexical.skip(';');
				return false;
			}
			getncheckComponent(RMBRACKET, "Missing ] after array definition");
			pushItem(id, funcName, valueType, length);
			// 预读
			lexical.nextSym();
		}
		else {
			pushItem(id, funcName, Variable, valueType);
		}
		if (!checkSymbol(COMMA))
			return true;
	} while (true);
	return true;
}

//<函数定义部分> ::= {＜有返回值函数定义＞|＜无返回值函数定义＞}
void Syntax::enter_functionDefinition() {
	while(true){
		if (checkSymbol(INTSY) || checkSymbol(CHARSY)) {
			enter_functionDefinitionWithReturn();
		}
		else if (checkSymbol(VOIDSY)) {
			enter_functionDefinitionWithoutReturn();
		}
		else {
			return;
		}
		if (lexical.isFinished())
			return;
	}
	return;
}

// ＜有返回值函数定义＞ ::= ＜声明头部＞‘(’＜参数表＞‘)’ ‘{’＜复合语句＞‘}’|＜声明头部＞‘{’＜复合语句＞‘}’
bool Syntax::enter_functionDefinitionWithReturn() {
	string funcName;
	haveReturn = false;	// 记录返回值状态
	markSyntax("function definition with return");
	enter_headDeclaration();
	funcName = getFunctionID;	// 返回函数名

	if (lexical.isFinished()) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Missing content for function declaration");
		return false;
	}
	// 检查是否为带参数
	if (checkSymbol(LSBRACKET)) {
		if (!getncheckEnd("Missing parameter table in (...)"))
			return false;
		// 录入参数表
		enter_parameterTable(funcName);
		checkComponent(RSBRACKET, "Missing ) for function parameter table");
		// 预读
		lexical.nextSym();
	}
	// {
	checkComponent(LBBRACKET, "Missing { for function body");

	if (!getncheckEnd("Missing function body"))
		return false;
	// 复合语句
	// 将VarCount设置为0
	VarCount = 0;
	enter_compoundStatement(funcName);
	checkComponent(RBBRACKET, "Missing } for function body");
	if (!haveReturn) {
		error.ReturnError(NoReturnError, getLine(), getIndex(), funcName);
	}
	// 预读
	lexical.nextSym();
	return true;
}

// ＜无返回值函数定义＞ ::= void＜标识符＞(’＜参数表＞‘)’‘{’＜复合语句＞‘}’| void＜标识符＞{’＜复合语句＞‘}’
bool Syntax::enter_functionDefinitionWithoutReturn() {
	string funcName;
	markSyntax("function definition without return");
	// void
	if (!checkSymbol(VOIDSY)) {
		return false;
	}
	if (!getncheckEnd("Missing function identifier"))
		return false;
	// 标识符
	if (!checkSymbol(ID)) {
		if (checkSymbol(MAINSY)) {
			voidMain = true;
			return true;
		}
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Missing function identifier");
		lexical.skip(';');
		return false;
	}

	funcName = lexical.getString();
	pushItem(funcName, "GLOBAL", VoidType);
	pushPseudoCode(FunctionDef, null, false, VoidType, funcName);

	if (!getncheckEnd("Missing function body"))
		return false;
	// 检查是否带参数
	if (checkSymbol(LSBRACKET)) {
		if (!getncheckEnd("Missing parameter table contents"))
			return false;
		// 参数表
		enter_parameterTable(funcName);

		checkComponent(RSBRACKET, "Missing ) for parameter table");
		// 预读
		lexical.nextSym();
	}
	// {
	checkComponent(LBBRACKET, "Missing { for function body");
	
	if (!getncheckEnd("Missing function body"))
		return false;
	//复合语句
	//将VarCount设置为0
	VarCount = 0;
	enter_compoundStatement(funcName);
	checkComponent(RBBRACKET, "Missing } for function body");
	// 预读
	lexical.nextSym();
	pushPseudoCode(Return, null, false, false, VoidType, "");
	return true;
}

//＜参数表＞ ::= ＜类型标识符＞＜标识符＞{,＜类型标识符＞＜标识符＞}
bool Syntax::enter_parameterTable(string funcName) {
	ValueType valueType;
	string id;
	// 类型标识符 int|char
	do{
		if (!checkSymbol(INTSY) && !checkSymbol(CHARSY)) {
			if (checkSymbol(RSBRACKET))
				error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Empty parameter table (...)");
			else {
				error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Illigal prefix in parameter table");
				lexical.skip(')');
			}
			return false;
		}
		valueType = (checkSymbol(INTSY)) ? IntType : CharType;
		if (!getnskipComponent(ID, "Missing identifier in parameter table", ')'))
			return false;
		id = lexical.getString();
		pushItem(id, funcName, Parameter, valueType);
		pushPseudoCode(ParamDef, null, false, valueType, id);

		if (!getncheckEnd("Unexpected ending in parameter table"))
			return false;
		if (!checkSymbol(COMMA)) {
			return true;
		}
		if (!getncheckEnd("Missing variable type in parameter table"))
			return false;
	} while (true);
	return true;
}

// ＜复合语句＞ ::= ［＜常量说明＞］［＜变量说明＞］｛＜语句＞｝
bool Syntax::enter_compoundStatement(string funcName) {
	enter_constDescription(funcName);
	enter_varDescription(false, funcName);
	while (true) {
		if (!(enter_statement(funcName, false, null, 1)))//初始为1
			break;
	}
	return true;
}

// ＜表达式＞ ::= ［＋｜－］＜项＞{＜加法运算符＞＜项＞}
assign Syntax::enter_expression(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	bool x_flag = false;	// 前缀项标志
	bool isSure = false;	// 值是否确认
	int expResult = 0;
	ValueType type;
	vector<PostfixItem> input, output;
	assign returnValue;
	do{
		// [+ | -]
		if (checkSymbol(ADD) || checkSymbol(SUB)) {
			x_flag = true;
			PostfixItem item;
			item.type = CharType;
			item.number = (checkSymbol(ADD)) ? '+' : '-';
			item.nonOp = false;
			input.push_back(item);
			// 预读
			if (!getncheckEnd("Missing item"))
				break;
		}
		// <项>
		enter_item(input, funcName, isCache, cache, weight);

		if (lexical.isFinished()) {
			break;
		}
		if (!checkSymbol(ADD) && !checkSymbol(SUB)) {
			break;
		}
	} while (true);

	// 表达式计算
	returnValue.null = (input.size() == 0);
	prefixConversion(input, output);
	returnValue.name = expressionCalculator(output, isSure, type, expResult, getLine(), isCache, cache, funcName);
	returnValue.determined = isSure;
	if (input.size() > 1)
		type = IntType;
	returnValue.type = type;
	if (isSure) {
		if (type == IntType)
			returnValue.number = expResult;
		else
			returnValue.character = expResult;
	}
	return returnValue;
}

// ＜项＞ ::= ＜因子＞{＜乘法运算符＞＜因子＞}
void Syntax::enter_item(vector<PostfixItem> &obj, string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	enter_factor(obj, funcName, isCache, cache, weight);
	while (true) {
		if (lexical.isFinished()) {
			break;
		}
		if (!checkSymbol(MULT) && !checkSymbol(DIV)) {
			break;
		}
		PostfixItem item;
		item.type = CharType;
		item.number = (checkSymbol(MULT)) ? '*' : '/';
		item.nonOp = false;
		obj.push_back(item);
		if (!getncheckEnd("Missing factor"))
			break;
		enter_factor(obj, funcName, isCache, cache, weight);
	}
	return;
}

// ＜因子＞ ::= ＜标识符＞｜＜标识符＞‘[’＜表达式＞‘]’｜＜整数＞|＜字符＞｜＜有返回值函数调用语句＞|‘(’＜表达式＞‘)’
void Syntax::enter_factor(vector<PostfixItem> & obj, string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	SymbolCode symbol;
	bool preRead = true;
	symbol = lexical.getSymbol();
	PostfixItem item;
	assign exp;
	MiddleCode code;
	string id;

	switch (symbol) {
	case ID:
		id = lexical.getString();
		if (!getncheckEnd("Unexpected end in factor"))
			return;
		// 标识符已经识别
		if (checkSymbol(LMBRACKET)) {	// [
			if (!getncheckEnd("Missing expression after [ in array"))
				return;
			// <表达式>
			exp = enter_expression(funcName, isCache, cache, weight);
			string var;
			int orderx;
			if (exp.determined) {
				semantic.checkArrayIndex(exp.type);
				orderx = semantic.checkArrayId(id, funcName, true, (exp.type == CharType) ? exp.character : exp.number);
				string index = (exp.type == CharType) ? to_string(exp.character) : to_string(exp.number);
				var = index;
			}
			else {
				orderx = semantic.checkArrayId(id, funcName, false);
				var = exp.name;
			}
			if (orderx >= 0) {
				item.type = StringType;
				SymbolTableItem t = SymbolTable.at(orderx);
				item.nonChar = true;
				if (t.getValueType() == CharType)
					item.nonChar = false;
				item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", var, true, false);
				obj.push_back(item);
			}
			else {
				item.type = StringType;
				if (INORD)
					item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO 确认计算顺序规则，严重影响效率
				else
					item.str = id;
			}
			checkComponent(RMBRACKET, "Missing ] in array a[...]");
		}
		else if (checkSymbol(LSBRACKET)) {	// (
			if (!getncheckEnd("Missing parameter table"))
				return;
			// <值参数表>
			vector<ValueType> retParamTable = enter_callParameterTable(funcName, isCache, cache, weight);
			semantic.checkFuncCall(id, true, retParamTable);
			pushPseudoCode(FunctionCall, cache, isCache, id);
			
			item.type = StringType;
			if (INORD)
				item.str = pushPseudoCode(Pass, cache, isCache, "Ret", '+', "0", "", "", false, false);//id; // TODO 确认计算顺序规则，严重影响效率
			else
				item.str = "Ret";
			item.nonChar = semantic.checkFuncType(id);
			
			obj.push_back(item);

			checkComponent(RSBRACKET, "Missing ) in parameter table");
		}
		else {	// 仅仅是标识符,无需预读
			preRead = false;
			int orderx = semantic.checkFactorId(id, funcName);
			if (orderx >= 0) {
				// 需要检查是否是无参的函数
				SymbolTableItem tableElement = SymbolTable.at(orderx);
				if (tableElement.getItemType() == Constant) {
					item.type = tableElement.getValueType();
					item.number = (item.type == IntType) ? (tableElement.getConstInt()) : (tableElement.getConstChar());
					if (item.type == CharType)
						item.nonOp = true;
				}
				else if (tableElement.getItemType() == Function) { // 无参数的带返回值的函数调用
					pushPseudoCode(FunctionCall, cache, isCache, id);
					item.type = StringType;
					if (INORD)
						item.str = pushPseudoCode(Pass, cache, isCache, "Ret", '+', "0", "", "", false, false);//id; // TODO 确认计算顺序规则，严重影响效率
					else
						item.str = "Ret";
					item.nonChar = (tableElement.getFuncType() == ReturnCharType) ? false : true;
				}
				else {
					item.nonChar = true;
					if ((tableElement.getItemType() == Variable || tableElement.getItemType() == Parameter) && tableElement.getValueType() == CharType)
						item.nonChar = false;
					item.type = StringType;
					if (INORD && tableElement.getFuncName() == "GLOBAL")
						item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO 确认计算顺序规则，严重影响效率
					else
						item.str = id;
					addWeight(orderx, weight);
				}
			}
			else {
				item.type = StringType;
				item.nonChar = true;
				if (INORD)
					item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO 确认计算顺序规则，严重影响效率
				else
					item.str = id;
			}
			obj.push_back(item);
		}
		break;
	case INT:
	case ADD:
	case SUB:
		enter_integer();
		item.type = IntType;
		item.number = getInteger;
		obj.push_back(item);
		preRead = false;
		break;
	case CHAR:
		item.type = CharType;
		item.number = lexical.getLetter();
		item.nonOp = true;
		obj.push_back(item);
		break;
	case LSBRACKET:
		if (!getncheckEnd("Missing content after ("))
			return;

		// <表达式>
		exp = enter_expression(funcName, isCache, cache, weight);
		if (exp.determined) {
			item.type = IntType;
			item.number = (exp.type == IntType) ? exp.number : exp.character;
		}
		else {
			item.type = StringType;
			item.str = exp.name;
			item.nonChar = (exp.type == IntType) ? true : false;
		}
		obj.push_back(item);
		// )
		checkComponent(RSBRACKET, "Missing ) in (...)");
		break;
	default:
		return;
	}
	//预读
	if (preRead)
		lexical.nextSym();
	return;
}

// ＜语句＞   ::= ＜条件语句＞｜＜循环语句＞|‘{’＜语句列＞‘}’｜<情况语句>|＜有返回值函数调用语句＞;  
// | ＜无返回值函数调用语句＞; ｜＜赋值语句＞; ｜＜读语句＞; ｜＜写语句＞; ｜＜空＞; ｜＜返回语句＞;
bool Syntax::enter_statement_inside(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	SymbolCode symbol;
	symbol = lexical.getSymbol();
	bool preRead = true;
	string id;
	MiddleCode code;
	code.type = FunctionCall;
	switch (symbol) {
	case IFSY:
		markSyntax("if");
		enter_conditionStatement(funcName, isCache, cache, weight);
		markSyntax("endif");
		preRead = false;
		break;
	case DOSY:
		markSyntax("while");
		enter_doStatement(funcName, isCache, cache, 10 * weight);
		markSyntax("endwhile");
		preRead = false;
		break;
		/*
		case WHILESY:
		enter_whileStatement(funcName, isCache, cache, 10 * weight);
		preRead = false;
		break;
		*/
	case LBBRACKET:
		if (!getncheckEnd("Missing block content"))
			return false;
		markSyntax("Block");
		while (true) {
			// <语句>
			if (!enter_statement(funcName, isCache, cache, weight))
				break;
		}
		checkComponent(RBBRACKET, "Missing } in block {...}");
		markSyntax("End");
		break;
	case ID:	// 赋值语句与调用语句
		id = lexical.getString();

		if (!getncheckEnd("Unexpected statement"))
			return false;

		if (checkSymbol(SEMICOLON)) {//无参调用
			markSyntax("function call without parameter");
			semantic.checkStatementId(id);//检查是否是函数
			pushPseudoCode(FunctionCall, cache, isCache, id);
			break;
		}
		else if (checkSymbol(LSBRACKET)) {	// 有参调用
			markSyntax("function call with parameter");
			if (!getncheckEnd("Missing parameter table"))
				return false;

			// <值参数表>
			vector<ValueType> retParamTable = enter_callParameterTable(funcName, isCache, cache, weight);
			semantic.checkFuncCall(id, false, retParamTable);
			code.target = id;
			if (isCache) {
				cache.push_back(code);
			}
			else {
				MiddleCodeArr.push_back(code);
			}
			checkComponent(RSBRACKET, "Missing ) in parameter table (...)");
			getncheckComponent(SEMICOLON, "Missing ; at the end of line");
		}
		else if (checkSymbol(ASSIGN) || checkSymbol(LMBRACKET)) {
			markSyntax("assignment");
			enter_assignStatement(funcName, id, isCache, cache, weight);
			checkComponent(SEMICOLON, "Missing ; at the end of line");
		}
		else {
			error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Unexpected content after identifier in statement");
			lexical.skip('\n');
			return false;
		}
		break;
	case SCANFSY:
		markSyntax("scanf");
		enter_readStatement(funcName, isCache, cache, weight);
		checkComponent(SEMICOLON, "Missing ; at the end of line");
		break;
	case PRINTFSY:
		markSyntax("printf");
		enter_writeStatement(funcName, isCache, cache, weight);
		checkComponent(SEMICOLON, "Missing ; at the end of line");
		break;
	case SEMICOLON:	// 空语句
		markSyntax("empty");
		break;
	case SWITCHSY:
		markSyntax("switch");
		enter_switchStatement(funcName, isCache, cache, weight);
		markSyntax("endswitch");
		preRead = false;
		break;
	case RETURNSY:
		markSyntax("return");
		enter_returnStatement(funcName, isCache, cache, weight);
		checknskipComponent(SEMICOLON, "Missing ; at the end of line", ';');
		break;
	default:
		return false;
		break;
	}
	// 预读
	if (preRead)
		lexical.nextSym();
	return true;
}


// ＜语句＞   ::= ＜条件语句＞｜＜循环语句＞|‘{’＜语句列＞‘}’｜<情况语句>|＜有返回值函数调用语句＞;  
// | ＜无返回值函数调用语句＞; ｜＜赋值语句＞; ｜＜读语句＞; ｜＜写语句＞; ｜＜空＞; ｜＜返回语句＞;
bool Syntax::enter_statement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	printLevel++;
	bool ret = enter_statement_inside(funcName, isCache, cache, weight);
	
	printLevel--;
	return ret;
}


// ＜赋值语句＞ ::= ＜标识符＞＝＜表达式＞|＜标识符＞‘[’＜表达式＞‘]’=＜表达式＞
// 其中标识符在语句分析中得到接下来分析 ＝＜表达式＞|‘[’＜表达式＞‘]’=＜表达式＞
bool Syntax::enter_assignStatement(string funcName, string id, bool isCache, vector<MiddleCode> & cache, int weight) {
	// 标识符在语句中预读得到
	SymbolCode symbol;
	symbol = lexical.getSymbol();
	MiddleCode code;
	code.type = Pass;
	code.isTargetArr = code.isLeftArr = false;
	code.op = '+';
	code.right = "0";

	if (symbol == ASSIGN) {	// =
		if (!getncheckEnd("Missing expression in assignment"))
			return false;
		int orderx = semantic.checkAssignId(id, funcName);
		addWeight(orderx, weight);
		// <表达式>
		assign exp = enter_expression(funcName, isCache, cache, weight);
		if (orderx >= 0)
			semantic.checkType(SymbolTable.at(orderx).getValueType(), exp.type);
		code.target = id;
		if (exp.determined) {
			string x = (exp.type == IntType) ? to_string(exp.number):to_string(exp.character);
			code.left = x;
		}
		else {
			code.left = exp.name;
		}
		pushMiddleCode(code, isCache, cache);
	}
	else if (checkSymbol(LMBRACKET)) {	// [
		if (!getncheckEnd("Missing expression in assignment"))
			return false;
		//<表达式>
		code.isTargetArr = true;
		assign exp = enter_expression(funcName, isCache, cache, weight);
		int orderx;
		if (exp.determined) {
			if (exp.type == CharType) {
				semantic.checkArrayIndex(exp.type);
				orderx = semantic.checkArrayId(id, funcName, true, exp.character);
				string x = to_string(exp.character);
				code.indexTargetArr = x;
			}
			else {
				orderx = semantic.checkArrayId(id, funcName, true, exp.number);
				string x = to_string(exp.number);
				code.indexTargetArr = x;
			}
		}
		else {
			orderx = semantic.checkArrayId(id, funcName, false);
			code.indexTargetArr = exp.name;
		}
		if (orderx >= 0) {
			code.target = id;
		}
		// ]
		checkComponent(RMBRACKET, "Missing ] in array index [...]");
		// =
		if (!getnskipComponent(ASSIGN, "Missing = in array assignment", '\n'))
			return false;
		// = <表达式>
		if (!getncheckEnd("Missing expression in assignment"))
			return false;
		// <表达式>
		exp = enter_expression(funcName, isCache, cache, weight);
		if (exp.determined) {
			string x = (exp.type == IntType) ? to_string(exp.number) : to_string(exp.character);
			code.left = x;
		}
		else {
			code.left = exp.name;
		}
		if(orderx >= 0)
			semantic.checkType(SymbolTable.at(orderx).getValueType(), exp.type);
		pushMiddleCode(code, isCache, cache);
	}
	else {
		return false;
	}
	VarCount = 0;
	return true;
}

// ＜条件语句＞::= if ‘(’＜条件＞‘)’＜语句＞else＜语句＞
bool Syntax::enter_conditionStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	SymbolCode symbol;
	MiddleCode code;
	symbol = lexical.getSymbol();

	string label1 = getLabel();
	string label2 = getLabel();

	//int tmpVarCountCopy = VarCount;

	// if
	if (!checkComponent(IFSY, "Error occurred in if statement"))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in if(...) statement");

	// <条件>
	if (!getncheckEnd("Missing condition statement in if(...)"))
		return false;
	string left = "0", right = "0";
	enter_condition(funcName, isCache, cache, weight, left, right);
	// 判断
	switch (cmp) {
	case LSS:
		pushPseudoCode(BGEZ, cache, isCache, left, right, label1);
		break;
	case LEQ:
		pushPseudoCode(BGZ, cache, isCache, left, right, label1);

		break;
	case EQL:
		pushPseudoCode(BNZ, cache, isCache, left, right, label1);

		break;
	case GTR:
		pushPseudoCode(BLEZ, cache, isCache, left, right, label1);

		break;
	case GEQ:
		pushPseudoCode(BLZ, cache, isCache, left, right, label1);

		break;
	case NEQ:
		pushPseudoCode(BEZ, cache, isCache, left, right, label1);

		break;
	}


	checkComponent(RSBRACKET, "Missing ) in if(...) statement");

	// <语句>
	if (!getncheckEnd("Missing statement in if(){...}"))
		return false;
	VarCount = 0;
	enter_statement(funcName, isCache, cache, weight);
	// 结束的无条件跳转
	pushPseudoCode(Jump, cache, isCache, label2);

	pushPseudoCode(Label, cache, isCache, label1);


	// else
	if (!skipComponent(ELSESY, "Missing else symbol in if-else statement", '\n'))
		return false;
	markSyntax("else");
	// <语句>
	if (!getncheckEnd("Missing statement in if(){}else{...}"))
		return false;
	
	enter_statement(funcName, isCache, cache, weight);
	VarCount = 0;
	pushPseudoCode(Label, cache, isCache, label2);
	//VarCount = tmpVarCountCopy;
	return true;
}

// 0 - False / 1 - True
// ＜条件＞ ::= ＜表达式＞＜关系运算符＞＜表达式＞｜＜表达式＞ 
// ＜关系运算符＞ ::= <｜<=｜>｜>=｜!=｜==
void Syntax::enter_condition(string funcName, bool isCache, vector<MiddleCode> &cache, int weight, string &left, string &right) {
	SymbolCode symbol;
	bool isFixed = false;
	//int copy = VarCount;

	//<表达式>
	assign leftExp = enter_expression(funcName, isCache, cache, weight);
	if (leftExp.determined) {
		string x = (leftExp.type == IntType) ? to_string(leftExp.number) : to_string(leftExp.character);
		left = x;
		isFixed = true;
	}
	else {
		left = leftExp.name;
	}

	if (!lexical.isFinished()) {
		symbol = lexical.getSymbol();
		if (symbol >= LSS && symbol <= GTR) {
			// 由于所有关系运算符都在之间
			cmp = symbol;
			if (!getncheckEnd("Missing following statement in if(...) condition block"))
				return;
			// <表达式>
			assign rightExp = enter_expression(funcName, isCache, cache, weight);
			semantic.checkCondition(leftExp.type, rightExp.type);
			if (rightExp.determined) {
				string x = (rightExp.type == IntType) ? to_string(rightExp.number) : to_string(rightExp.character);
				right = x;
				if (isFixed) {
					left = pushPseudoCode(Pass, cache, isCache, left, '-', right, "", "", false, false);
					right = "0";
					VarCount = 0;
					return;
				}
				else {
					VarCount = 0;
					return;
				}
			}
			else {
				
				if (isFixed) {
					right = left;
					left = rightExp.name;
					reverseCMP();
					VarCount = 0;
					return;
				}
				else {
					right = rightExp.name;
					VarCount = 0;
					return;
				}
			}
		}
	}
	cmp = NEQ;
	semantic.checkCondition(leftExp.type, IntType);
	if (isFixed) {
		right = left;
		left = "$0";
		VarCount = 0;
		return;
	}
	else {
		right = "0";
		VarCount = 0;
		return;
	}
}

// ＜循环语句＞ ::=  do＜语句＞ while ‘(’＜条件＞‘)’
bool Syntax::enter_doStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	MiddleCode code;

	string label = getLabel();

	//int tmpVarCountCopy = VarCount;

	// do
	if (!checkSymbol(DOSY))
		return false;

	pushPseudoCode(Label, cache, isCache, label);
	// <语句>
	if (!getncheckEnd("Missing statement in do{...}while()"))
		return false;
	
	enter_statement(funcName, isCache, cache, weight);

	if (!checkComponent(WHILESY, "Missing while in do-while statement"))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in do{}while(...) statement");
	// <条件>
	if (!getncheckEnd("Missing condition block in do{}while(...) statement"))
		return false;
	string left = "0", right = "0";
	enter_condition(funcName, isCache, cache, weight, left, right);
	// 设置条件跳转
	switch (cmp) {
	case LSS:
		pushPseudoCode(BLZ, cache, isCache, left, right, label);
		break;
	case LEQ:
		pushPseudoCode(BLEZ, cache, isCache, left, right, label);

		break;
	case EQL:
		pushPseudoCode(BEZ, cache, isCache, left, right, label);

		break;
	case GTR:
		pushPseudoCode(BGZ, cache, isCache, left, right, label);

		break;
	case GEQ:
		pushPseudoCode(BGEZ, cache, isCache, left, right, label);

		break;
	case NEQ:
		pushPseudoCode(BNZ, cache, isCache, left, right, label);
		break;
	}
	checkComponent(RSBRACKET, "Missing ) in do{}while() statement");
	//VarCount = tmpVarCountCopy;
	if (!getncheckEnd("Unexpected end after do-while statement"))
		return false;
	return true;
}

// ＜情况语句＞  :: = switch ‘(’＜表达式＞‘)’ ‘ { ’＜情况表＞＜缺省＞ ‘ }’
bool Syntax::enter_switchStatement(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	string endLabel = getLabel();	// 情况结束语句
	bool isFixed = false;
	MiddleCode code;
	string left;
	vector<MiddleCode> myCache;

	int tmpVarCountCopy = VarCount;
	// switch
	if (!checkSymbol(SWITCHSY))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in switch(...){} statement");
	// <表达式>
	if (!getncheckEnd("Missing expression in switch(...) statement"))
		return false;

	assign exp = enter_expression(funcName, isCache, cache, weight);
	if (exp.determined) {
		string x = (exp.type == IntType) ? to_string(exp.number) : to_string(exp.character);
		left = x;
		isFixed = true;
	}
	else {
		left = exp.name;
	}
	// left 比较 case 入口
	// )
	checkComponent(RSBRACKET, "Missing ) in switch(...){} statement");
	// {
	getncheckComponent(LBBRACKET, "Missing { in switch(){} statement");
	
	// 分析＜情况表＞＜缺省＞
	if (!getncheckEnd("Missing situation table in switch(){...} statement"))
		return false;
	// 生成跳转 label 并检查 case 同值入口
	vector<entry> caseTable = enter_switchTable(funcName, endLabel, exp.type, myCache, weight);
	vector<int> cases;
	for (unsigned int i = 0; i < caseTable.size(); i++) {
		entry t = caseTable.at(i);
		cases.push_back(t.constValue);
		string x = to_string(t.constValue);
		// judge - const
		if(isFixed)
			pushPseudoCode(BEZ, cache, isCache, pushPseudoCode(Pass, cache, isCache, left, '-', x, "", "", false, false), "0", t.label);
		else
			pushPseudoCode(BEZ, cache, isCache, left, x, t.label);
	}
	semantic.checkCaseEntry(cases);
	// default
	if (!checkComponent(DEFAULTSY, "Missing default entry for case table"))
		return false;
	printLevel++;
	markSyntax("default");
	enter_defaultStatement(funcName, isCache, cache, weight);
	markSyntax("enddefault");
	printLevel--;
	// 生成跳转指令

	pushPseudoCode(Jump, cache, isCache, endLabel);
	// 输出 cache 中的数据
	for (unsigned int i = 0; i < myCache.size(); i++) {
		pushMiddleCode(myCache.at(i), isCache, cache);	// 保存暂存的数据或继续暂存
	}
	// 生成终止标签
	pushPseudoCode(Label, cache, isCache, endLabel);
	// }
	checkComponent(RBBRACKET, "Missing } in switch(){} statement");
	// 预读
	lexical.nextSym();
	//VarCount = tmpVarCountCopy;
	VarCount = 0;
	return true;
}

// ＜情况表＞ ::= ＜情况子语句＞{＜情况子语句＞}
vector<entry> Syntax::enter_switchTable(string funcName, string endLabel, ValueType type, vector<MiddleCode> & cache, int weight) {
	// 分析情况子语句
	vector<entry> caseTable;
	int copy = VarCount;
	entry enter;
	do{
		printLevel++;
		markSyntax("case");
		enter = enter_caseStatement(funcName, endLabel, type, cache, weight);
		markSyntax("endcase");
		printLevel--;
		if (!enter.recognize)
			break;
		caseTable.push_back(enter);
		if (lexical.isFinished())
			break;
	} while (true);
	VarCount = copy;
	return caseTable;
}

//＜情况子语句＞ ::= case＜常量＞：＜语句＞
entry Syntax::enter_caseStatement(string funcName, string endLabel, ValueType type, vector<MiddleCode> & cache, int weight) {
	SymbolCode symbol;
	entry enter;
	MiddleCode code;

	enter.constValue = 0;
	enter.label = getLabel();
	enter.recognize = false;
	// case
	if (!checkSymbol(CASESY))
		return enter;

	// <常量> ::= <整数>|<字符>
	if (!getncheckEnd("Missing constant in case table"))
		return enter;

	symbol = lexical.getSymbol();
	switch (symbol) {
	case INT:
	case ADD:
	case SUB:
		enter_integer();
		enter.constValue = getInteger;
		semantic.checkSwitchType(type, IntType);
		break;
	case CHAR:
		enter.constValue = lexical.getLetter();
		semantic.checkSwitchType(type, CharType);
		// 预读
		lexical.nextSym();
		break;
	default:
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Missing constant in case table");
		lexical.skip('\n');
		return enter;
	}

	// :
	checkComponent(COLON, "Missing : in case table entry");
	
	// <语句>
	if (!getncheckEnd("Missing statement inside case table"))
		return enter;
	// 创建 label
	code.type = Label;
	code.target = enter.label;
	cache.push_back(code);

	enter_statement(funcName, true, cache, weight);
	// 无条件跳转至末尾
	code.type = Jump;
	code.target = endLabel;
	cache.push_back(code);
	enter.recognize = true;
	return enter;
}

// ＜缺省＞ ::= default : ＜语句＞
bool Syntax::enter_defaultStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	//分析default
	if (!checkSymbol(DEFAULTSY))
		return false;
	// :
	getncheckComponent(COLON, "Missing : in case table entry");
	// <语句>
	if (!getncheckEnd("Missing statement inside case table"))
		return false;
	enter_statement(funcName, isCache, cache, weight);
	return true;

}

// ＜值参数表＞ ::= ＜表达式＞{,＜表达式＞}
vector<ValueType> Syntax::enter_callParameterTable(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	assign exp;
	MiddleCode code;

	vector<string> paramTable;
	vector<ValueType> retParamTable;
	// <表达式>
	do{
		exp = enter_expression(funcName, isCache, cache, weight);
		if (!exp.null)
			retParamTable.push_back(exp.type);
		else {
			return retParamTable;
		}
		if (exp.determined) {
			string x = (exp.type == IntType) ? to_string(exp.number) : to_string(exp.character);
			paramTable.push_back(x);
		}
		else {
			paramTable.push_back(exp.name);
		}

		if (!checkSymbol(COMMA))
			break;
		if (!getncheckEnd("Unexpected end-of-file in case expression"))
			break;
	}while (true);

	for (unsigned int i = 0; i < paramTable.size(); i++) {
		pushPseudoCode(ParamPass, cache, isCache, paramTable.at(i));
	}
	return retParamTable;
}

//＜读语句＞ ::= scanf ‘(’＜标识符＞{,＜标识符＞}‘)’
bool Syntax::enter_readStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	MiddleCode code;
	int orderx;
	string id;
	// scanf
	if (!checkSymbol(SCANFSY))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in scanf statement");

	do{
		// <标识符>
		if (!getnskipComponent(ID, "Missing identifier in scanf(...) statement", ';'))
			return false;

		id = lexical.getString();
		orderx = semantic.checkAssignId(id, funcName);
		
		if (orderx >= 0) {
			addWeight(orderx, weight);
			pushPseudoCode(Read, cache, isCache, (SymbolTable.at(orderx).getValueType() == IntType) ? IntType : CharType, id);
		}

		if (!getncheckEnd("Unexpected end-of-file in scanf() statement"))
			return false;

		if (!checkSymbol(COMMA))
			break;
	} while (true);

	checkComponent(RSBRACKET, "Missing ) in scanf() statement");
	
	// 预读
	lexical.nextSym();
	return true;
}

//＜写语句＞ ::= printf ‘(’ ＜字符串＞,＜表达式＞ ‘)’| printf ‘(’＜字符串＞ ‘)’| printf ‘(’＜表达式＞‘)’
bool Syntax::enter_writeStatement(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	MiddleCode code;

	int tmpVarCountCopy = VarCount;
	// printf
	if (!checkSymbol(PRINTFSY))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in printf() statement");
	//复杂多变的部分
	if (!getncheckEnd("Unexpected end-of-file in printf() function"))
		return false;
	if (checkSymbol(STRING)) {
		pushPseudoCode(Print, cache, isCache, false, StringType, lexical.getString());
		// ,
		if (!getncheckEnd("Unexpected end-of-file in printf(...) function"))
			return false;
		//只有为,才继续分析,否则跳出
		if (checkSymbol(COMMA)) {
			if (!getncheckEnd("Unexpected end-of-file in printf(...,) function"))
				return false;
			assign exp = enter_expression(funcName, isCache, cache, weight);
			if (exp.determined) {
				string x;
				if (exp.type == IntType)
					x = to_string(exp.number);
				else {
					char t[1];
					t[0] = exp.character;
					x = t;
				}
				pushPseudoCode(Print, cache, isCache, false, exp.type, x);
			}
			else {
				pushPseudoCode(Print, cache, isCache, true, exp.type, exp.name);
			}
		}
		if(NEWLINE)
			pushPseudoCode(Print, cache, isCache, false, CharType, "\n");
	}
	else {
		assign exp = enter_expression(funcName, isCache, cache, weight);
		if (exp.determined) {
			
			string x;
			if (exp.type == IntType)
				x = to_string(exp.number);
			else {
				char t[1];
				t[0] = exp.character;
				x = t;
			}
			pushPseudoCode(Print, cache, isCache, false, exp.type, x);
		}
		else {
			pushPseudoCode(Print, cache, isCache, true, exp.type, exp.name);
		}
		if(NEWLINE)
			pushPseudoCode(Print, cache, isCache, false, CharType, "\n");
	}
	// )
	checkComponent(RSBRACKET, "Missing ) in printf() statement");
	VarCount = tmpVarCountCopy;
	// 预读
	lexical.nextSym();
	return true;
}

//＜返回语句＞ ::= return[‘(’＜表达式＞‘)’]
bool Syntax::enter_returnStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	bool preRead = true;
	MiddleCode code;
	int tmpVarCountCopy = VarCount;
	// return
	if (!checkSymbol(RETURNSY)) {
		return false;
	}
	// [...]
	if (!getncheckEnd("Unexpected end-of-file in return"))
		return false;
	// (
	if (checkSymbol(LSBRACKET)) {
		if (!getncheckEnd("Unexpected end-of-file in return(...)"))
			return false;
		// <表达式>
		assign exp = enter_expression(funcName, isCache, cache, weight);
		if (exp.determined) {
			if (exp.type == IntType) {
				string x = to_string(exp.number);
				pushPseudoCode(Return, cache, isCache, false, ReturnIntType, x);
			}
			else {
				string x = to_string(exp.character);
				pushPseudoCode(Return, cache, isCache, false, ReturnCharType, x);
			}
		}
		else {
			pushPseudoCode(Return, cache, isCache, true, (exp.type == IntType) ? ReturnIntType : ReturnCharType , exp.name);
		}
		semantic.checkFuncReturn(funcName, exp.type);
		// )
		checkComponent(RSBRACKET, "Missing ) in return statement");
		haveReturn = true;
	}
	else {
		if (funcName == "main") {
			semantic.checkFuncReturn(funcName);
			pushPseudoCode(End, cache, isCache);
		}
		else {
			semantic.checkFuncReturn(funcName);
			pushPseudoCode(Return, cache, isCache, false, VoidType, "");
		}
		preRead = false;
	}

	if (preRead)
		lexical.nextSym();
	VarCount = tmpVarCountCopy;
	return true;
}

// ＜整数＞ ::= ［＋｜－］＜无符号整数＞
void Syntax::enter_integer() {
	int value = 0;
	int sign = 1;	// 符号位
	if (checkSymbol(ADD) || checkSymbol(SUB)) {
		sign = (checkSymbol(ADD)) ? 1 : -1;
		if (!getnskipComponent(INT, "Missing integer after +/- sign", ';'))
			return;
		value = lexical.getNumber();
	}
	else if (checkSymbol(INT)) 
		value = lexical.getNumber();
	else {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Expected integer");
		lexical.skip(';');
		return;
	}
	value *= sign;
	// 返回整数
	getInteger = value;
	// 预读
	lexical.nextSym();
	return;
}

//＜声明头部＞ ::= int ＜标识符＞ | char ＜标识符＞
bool Syntax::enter_headDeclaration() {
	FuncType type;
	if (checkSymbol(INTSY) || checkSymbol(CHARSY)) {
		type = (checkSymbol(INTSY)) ? ReturnIntType : ReturnCharType;
		if (!getnskipComponent(ID, "Missing identifier in function declaration", ';'))
			return false;
		getFunctionID = lexical.getString();
		pushItem(getFunctionID, "GLOBAL", type);
		pushPseudoCode(FunctionDef, null, false, type, getFunctionID);
	}
	else {
		return false;
	}
	// 预读
	lexical.nextSym();
	return true;
}


// 引用计数
void Syntax::addWeight(int order, int weight) {
	if (order >= 0) {
		SymbolTableItem item = SymbolTable.at(order);
		if ((item.getItemType() == Variable || item.getItemType() == Parameter) && item.getFuncName() != "GLOBAL"
			&& item.getArrSize() == 0) {
			SymbolTable.at(order).addWeight(weight);
		}
	}
}

/*
// ＜循环语句＞ ::= while ‘(’＜条件＞‘)’＜语句＞
bool Syntax::enter_whileStatement(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	bool next;
	SymbolCode symbol;

	MiddleCode code;

	string label1 = getLabel();
	string label2 = getLabel();

	//int tmpVarCountCopy = VarCount;

	//while
	if (!checkComponent(WHILESY, "Missing while in while(){} statement"))
		return false;

	code.type = Label;
	code.target = label1;
	if (isCache) {
		cache.push_back(code);
	}
	else {
		MiddleCodeArr.push_back(code);
	}
	// (
	getncheckComponent(LSBRACKET, "Missing ( in while(...) statement");
	// <条件>
	if (!getncheckEnd("Missing condition block in while(...) statement"))
		return false;
	string judge = enter_condition(funcName, isCache, cache, weight);
	// 跳转
	switch (cmp) {
	case LSS:
		code.type = BGEZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	case LEQ:
		code.type = BGZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	case EQL:
		code.type = BNZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	case GTR:
		code.type = BLEZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	case GEQ:
		code.type = BLZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	case NEQ:
		code.type = BEZ;
		code.target = label2;
		code.left = judge;
		if (isCache) {
			cache.push_back(code);
		}
		else {
			MiddleCodeArr.push_back(code);
		}
		break;
	}

	checkComponent(RSBRACKET, "Missing ) in while() statement");

	// <语句>
	if (!getncheckEnd("Missing statement in while(){...}"))
		return false;

	enter_statement(funcName, isCache, cache, weight);
	code.type = Jump;//无条件跳转到循环
	code.target = label1;
	if (isCache) {
		cache.push_back(code);
	}
	else {
		MiddleCodeArr.push_back(code);
	}
	//循环跳出点
	code.type = Label;
	code.target = label2;
	if (isCache) {
		cache.push_back(code);
	}
	else {
		MiddleCodeArr.push_back(code);
	}
	//VarCount = tmpVarCountCopy;
	return true;
}
*/