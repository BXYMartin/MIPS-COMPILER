#include "stdafx.h"

#include "syntax.h"
#include "function.h"
#include <iostream>
#include <cstdarg>
#include <iomanip>

#define _CRT_SECURE_NO_WARNINGS

using namespace std;

extern int VarCount;

// ��ʼ��ȫ�������������
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


//������ں���
void Syntax::startAnalysis() {
	bool next;
	next = lexical.nextSym();	// ��ȡ��һ������
	if (next) {					// ������һ������
		if (!enter_procedure()) // ��ʼ��������
			return;
	}
	else {
		error.SyntaxError(EmptyFileError, getLine(), getIndex()); // �޷���ȡ����ʶ��, ���ļ�
		return;
	}
	// �ڳ���ĩβ��������Ԫ��
	if (!lexical.isFinished()) {
		error.SyntaxError(DefinitionAfterMainError, getLine(), getIndex());
	}
}


// ������::=�ۣ�����˵�����ݣۣ�����˵������{���з���ֵ�������壾|���޷���ֵ�������壾}����������
bool Syntax::enter_procedure() {
	markSyntax("Procedure");
	//�ۣ�����˵�����ݼ��
	enter_constDescription("GLOBAL");
	//�ۣ�����˵�����ݼ��
	enter_varDescription(true, "GLOBAL");
	// {���з���ֵ�������壾|���޷���ֵ�������壾} ����Ƿ���ں�������, ʶ�� main ��������
	printLevel++;
	enter_functionDefinition();
	// ���������� ����, ��Ҫ�����������ַ������������͹����
	SymbolCode symbol;
	// ��� main ��������
	symbol = lexical.getSymbol();
	if (!(symbol == MAINSY && voidMain)) {
		error.SyntaxError(NoMainFunctionError, getLine(), getIndex());
		return false;
	}
	//�������,main��������ű�
	pushItem("main", "GLOBAL", VoidType);
	if (!getncheckComponent(LSBRACKET, "Missing ( in main(){...} definition"))
		return false;
	if (!getncheckComponent(RSBRACKET, "Missing ) in main(){...} definition"))
		return false;
	// ��ȡ�������������
	getncheckComponent(LBBRACKET, "Missing { in main(){...} definition");
	if (!getncheckEnd("Missing Compound Statement in main function"))
		return false;
	// �������
	pushPseudoCode(FunctionDef, null, false, VoidType, "main");
	enter_compoundStatement("main");
	if (!checkComponent(RBBRACKET, "Missing } in main(){...} definition"))
		return false;
	lexical.nextSym();
	printLevel--;
	markSyntax("End.");
	// �����������
	return true;
}

//������˵���� ::=  const���������壾;{ const���������壾;} 
void Syntax::enter_constDescription(string funcName) {
	if (!checkSymbol(CONSTSY))
		return;
	markSyntax("const");
	do{
		if (!getncheckEnd("Missing identifier after const prefix"))
			return;
		// ����<��������>
		enter_constDefinition(funcName);
		if (!checkComponent(SEMICOLON, "Missing ; after const declaration"))
			return;
		if (!getncheckSymbol(CONSTSY, "Const definition"))
			return;
	} while (true);
	return;
}

// ���������壾   :: = int����ʶ��������������{ ,����ʶ�������������� } | char����ʶ���������ַ���{ ,����ʶ���������ַ��� }
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
			// ����
			enter_integer();
			// ����ű�
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
			// ����ű�
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

// ������˵���� ::= ���������壾;{���������壾;}
// ��ȫ�ֺ����������� FIRST���ཻ���⣬��Ҫ����
void Syntax::enter_varDescription(bool isGlobal, string funcName) {
	bool next;
	SymbolCode symbol;
	int point;
	SymbolCode symbolCode;
	do{
		// ����ȫ�ֺ�������ͱ�������
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
							if (symbol == LSBRACKET || symbol == LBBRACKET) {	// ( �� {
								lexical.reset(point, symbolCode);
								return;
							}
						}
					}
				}
				// ����ָ�벢��������
				lexical.reset(point, symbolCode);
			}
			else {
				return;
			}
		}
		// �������ȫ�ֵ�,����������
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


// ���������壾  ::= �����ͱ�ʶ����(����ʶ����|����ʶ������[�����޷�����������]��){,(����ʶ����|����ʶ������[�����޷�����������]��) }
bool Syntax::enter_varDefinition(string funcName) {
	ValueType valueType;
	string id;
	int length;
	// ʶ�����ͱ�ʶ��
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
		// ʶ��[
		if (checkSymbol(LMBRACKET)) {
			if (!getnskipComponent(INT, "Missing unsigned integer in array definition", ';'))
				return false;
			length = lexical.getNumber();
			if (length == 0) {	// �����±궨����������
				error.SyntaxError(ArrIndexError, getLine(), getIndex());
				lexical.skip(';');
				return false;
			}
			getncheckComponent(RMBRACKET, "Missing ] after array definition");
			pushItem(id, funcName, valueType, length);
			// Ԥ��
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

//<�������岿��> ::= {���з���ֵ�������壾|���޷���ֵ�������壾}
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

// ���з���ֵ�������壾 ::= ������ͷ������(������������)�� ��{����������䣾��}��|������ͷ������{����������䣾��}��
bool Syntax::enter_functionDefinitionWithReturn() {
	string funcName;
	haveReturn = false;	// ��¼����ֵ״̬
	markSyntax("function definition with return");
	enter_headDeclaration();
	funcName = getFunctionID;	// ���غ�����

	if (lexical.isFinished()) {
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Missing content for function declaration");
		return false;
	}
	// ����Ƿ�Ϊ������
	if (checkSymbol(LSBRACKET)) {
		if (!getncheckEnd("Missing parameter table in (...)"))
			return false;
		// ¼�������
		enter_parameterTable(funcName);
		checkComponent(RSBRACKET, "Missing ) for function parameter table");
		// Ԥ��
		lexical.nextSym();
	}
	// {
	checkComponent(LBBRACKET, "Missing { for function body");

	if (!getncheckEnd("Missing function body"))
		return false;
	// �������
	// ��VarCount����Ϊ0
	VarCount = 0;
	enter_compoundStatement(funcName);
	checkComponent(RBBRACKET, "Missing } for function body");
	if (!haveReturn) {
		error.ReturnError(NoReturnError, getLine(), getIndex(), funcName);
	}
	// Ԥ��
	lexical.nextSym();
	return true;
}

// ���޷���ֵ�������壾 ::= void����ʶ����(������������)����{����������䣾��}��| void����ʶ����{����������䣾��}��
bool Syntax::enter_functionDefinitionWithoutReturn() {
	string funcName;
	markSyntax("function definition without return");
	// void
	if (!checkSymbol(VOIDSY)) {
		return false;
	}
	if (!getncheckEnd("Missing function identifier"))
		return false;
	// ��ʶ��
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
	// ����Ƿ������
	if (checkSymbol(LSBRACKET)) {
		if (!getncheckEnd("Missing parameter table contents"))
			return false;
		// ������
		enter_parameterTable(funcName);

		checkComponent(RSBRACKET, "Missing ) for parameter table");
		// Ԥ��
		lexical.nextSym();
	}
	// {
	checkComponent(LBBRACKET, "Missing { for function body");
	
	if (!getncheckEnd("Missing function body"))
		return false;
	//�������
	//��VarCount����Ϊ0
	VarCount = 0;
	enter_compoundStatement(funcName);
	checkComponent(RBBRACKET, "Missing } for function body");
	// Ԥ��
	lexical.nextSym();
	pushPseudoCode(Return, null, false, false, VoidType, "");
	return true;
}

//�������� ::= �����ͱ�ʶ��������ʶ����{,�����ͱ�ʶ��������ʶ����}
bool Syntax::enter_parameterTable(string funcName) {
	ValueType valueType;
	string id;
	// ���ͱ�ʶ�� int|char
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

// ��������䣾 ::= �ۣ�����˵�����ݣۣ�����˵�����ݣ�����䣾��
bool Syntax::enter_compoundStatement(string funcName) {
	enter_constDescription(funcName);
	enter_varDescription(false, funcName);
	while (true) {
		if (!(enter_statement(funcName, false, null, 1)))//��ʼΪ1
			break;
	}
	return true;
}

// �����ʽ�� ::= �ۣ������ݣ��{���ӷ�����������}
assign Syntax::enter_expression(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	bool x_flag = false;	// ǰ׺���־
	bool isSure = false;	// ֵ�Ƿ�ȷ��
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
			// Ԥ��
			if (!getncheckEnd("Missing item"))
				break;
		}
		// <��>
		enter_item(input, funcName, isCache, cache, weight);

		if (lexical.isFinished()) {
			break;
		}
		if (!checkSymbol(ADD) && !checkSymbol(SUB)) {
			break;
		}
	} while (true);

	// ���ʽ����
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

// ��� ::= �����ӣ�{���˷�������������ӣ�}
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

// �����ӣ� ::= ����ʶ����������ʶ������[�������ʽ����]������������|���ַ��������з���ֵ����������䣾|��(�������ʽ����)��
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
		// ��ʶ���Ѿ�ʶ��
		if (checkSymbol(LMBRACKET)) {	// [
			if (!getncheckEnd("Missing expression after [ in array"))
				return;
			// <���ʽ>
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
					item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO ȷ�ϼ���˳���������Ӱ��Ч��
				else
					item.str = id;
			}
			checkComponent(RMBRACKET, "Missing ] in array a[...]");
		}
		else if (checkSymbol(LSBRACKET)) {	// (
			if (!getncheckEnd("Missing parameter table"))
				return;
			// <ֵ������>
			vector<ValueType> retParamTable = enter_callParameterTable(funcName, isCache, cache, weight);
			semantic.checkFuncCall(id, true, retParamTable);
			pushPseudoCode(FunctionCall, cache, isCache, id);
			
			item.type = StringType;
			if (INORD)
				item.str = pushPseudoCode(Pass, cache, isCache, "Ret", '+', "0", "", "", false, false);//id; // TODO ȷ�ϼ���˳���������Ӱ��Ч��
			else
				item.str = "Ret";
			item.nonChar = semantic.checkFuncType(id);
			
			obj.push_back(item);

			checkComponent(RSBRACKET, "Missing ) in parameter table");
		}
		else {	// �����Ǳ�ʶ��,����Ԥ��
			preRead = false;
			int orderx = semantic.checkFactorId(id, funcName);
			if (orderx >= 0) {
				// ��Ҫ����Ƿ����޲εĺ���
				SymbolTableItem tableElement = SymbolTable.at(orderx);
				if (tableElement.getItemType() == Constant) {
					item.type = tableElement.getValueType();
					item.number = (item.type == IntType) ? (tableElement.getConstInt()) : (tableElement.getConstChar());
					if (item.type == CharType)
						item.nonOp = true;
				}
				else if (tableElement.getItemType() == Function) { // �޲����Ĵ�����ֵ�ĺ�������
					pushPseudoCode(FunctionCall, cache, isCache, id);
					item.type = StringType;
					if (INORD)
						item.str = pushPseudoCode(Pass, cache, isCache, "Ret", '+', "0", "", "", false, false);//id; // TODO ȷ�ϼ���˳���������Ӱ��Ч��
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
						item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO ȷ�ϼ���˳���������Ӱ��Ч��
					else
						item.str = id;
					addWeight(orderx, weight);
				}
			}
			else {
				item.type = StringType;
				item.nonChar = true;
				if (INORD)
					item.str = pushPseudoCode(Pass, cache, isCache, id, '+', "0", "", "", false, false);//id; // TODO ȷ�ϼ���˳���������Ӱ��Ч��
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

		// <���ʽ>
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
	//Ԥ��
	if (preRead)
		lexical.nextSym();
	return;
}

// ����䣾   ::= ��������䣾����ѭ����䣾|��{��������У���}����<������>|���з���ֵ����������䣾;  
// | ���޷���ֵ����������䣾; ������ֵ��䣾; ��������䣾; ����д��䣾; �����գ�; ����������䣾;
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
			// <���>
			if (!enter_statement(funcName, isCache, cache, weight))
				break;
		}
		checkComponent(RBBRACKET, "Missing } in block {...}");
		markSyntax("End");
		break;
	case ID:	// ��ֵ�����������
		id = lexical.getString();

		if (!getncheckEnd("Unexpected statement"))
			return false;

		if (checkSymbol(SEMICOLON)) {//�޲ε���
			markSyntax("function call without parameter");
			semantic.checkStatementId(id);//����Ƿ��Ǻ���
			pushPseudoCode(FunctionCall, cache, isCache, id);
			break;
		}
		else if (checkSymbol(LSBRACKET)) {	// �вε���
			markSyntax("function call with parameter");
			if (!getncheckEnd("Missing parameter table"))
				return false;

			// <ֵ������>
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
	case SEMICOLON:	// �����
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
	// Ԥ��
	if (preRead)
		lexical.nextSym();
	return true;
}


// ����䣾   ::= ��������䣾����ѭ����䣾|��{��������У���}����<������>|���з���ֵ����������䣾;  
// | ���޷���ֵ����������䣾; ������ֵ��䣾; ��������䣾; ����д��䣾; �����գ�; ����������䣾;
bool Syntax::enter_statement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	printLevel++;
	bool ret = enter_statement_inside(funcName, isCache, cache, weight);
	
	printLevel--;
	return ret;
}


// ����ֵ��䣾 ::= ����ʶ�����������ʽ��|����ʶ������[�������ʽ����]��=�����ʽ��
// ���б�ʶ�����������еõ����������� �������ʽ��|��[�������ʽ����]��=�����ʽ��
bool Syntax::enter_assignStatement(string funcName, string id, bool isCache, vector<MiddleCode> & cache, int weight) {
	// ��ʶ���������Ԥ���õ�
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
		// <���ʽ>
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
		//<���ʽ>
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
		// = <���ʽ>
		if (!getncheckEnd("Missing expression in assignment"))
			return false;
		// <���ʽ>
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

// ��������䣾::= if ��(������������)������䣾else����䣾
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

	// <����>
	if (!getncheckEnd("Missing condition statement in if(...)"))
		return false;
	string left = "0", right = "0";
	enter_condition(funcName, isCache, cache, weight, left, right);
	// �ж�
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

	// <���>
	if (!getncheckEnd("Missing statement in if(){...}"))
		return false;
	VarCount = 0;
	enter_statement(funcName, isCache, cache, weight);
	// ��������������ת
	pushPseudoCode(Jump, cache, isCache, label2);

	pushPseudoCode(Label, cache, isCache, label1);


	// else
	if (!skipComponent(ELSESY, "Missing else symbol in if-else statement", '\n'))
		return false;
	markSyntax("else");
	// <���>
	if (!getncheckEnd("Missing statement in if(){}else{...}"))
		return false;
	
	enter_statement(funcName, isCache, cache, weight);
	VarCount = 0;
	pushPseudoCode(Label, cache, isCache, label2);
	//VarCount = tmpVarCountCopy;
	return true;
}

// 0 - False / 1 - True
// �������� ::= �����ʽ������ϵ������������ʽ���������ʽ�� 
// ����ϵ������� ::= <��<=��>��>=��!=��==
void Syntax::enter_condition(string funcName, bool isCache, vector<MiddleCode> &cache, int weight, string &left, string &right) {
	SymbolCode symbol;
	bool isFixed = false;
	//int copy = VarCount;

	//<���ʽ>
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
			// �������й�ϵ���������֮��
			cmp = symbol;
			if (!getncheckEnd("Missing following statement in if(...) condition block"))
				return;
			// <���ʽ>
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

// ��ѭ����䣾 ::=  do����䣾 while ��(������������)��
bool Syntax::enter_doStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	MiddleCode code;

	string label = getLabel();

	//int tmpVarCountCopy = VarCount;

	// do
	if (!checkSymbol(DOSY))
		return false;

	pushPseudoCode(Label, cache, isCache, label);
	// <���>
	if (!getncheckEnd("Missing statement in do{...}while()"))
		return false;
	
	enter_statement(funcName, isCache, cache, weight);

	if (!checkComponent(WHILESY, "Missing while in do-while statement"))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in do{}while(...) statement");
	// <����>
	if (!getncheckEnd("Missing condition block in do{}while(...) statement"))
		return false;
	string left = "0", right = "0";
	enter_condition(funcName, isCache, cache, weight, left, right);
	// ����������ת
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

// �������䣾  :: = switch ��(�������ʽ����)�� �� { �����������ȱʡ�� �� }��
bool Syntax::enter_switchStatement(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	string endLabel = getLabel();	// ����������
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
	// <���ʽ>
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
	// left �Ƚ� case ���
	// )
	checkComponent(RSBRACKET, "Missing ) in switch(...){} statement");
	// {
	getncheckComponent(LBBRACKET, "Missing { in switch(){} statement");
	
	// �������������ȱʡ��
	if (!getncheckEnd("Missing situation table in switch(){...} statement"))
		return false;
	// ������ת label ����� case ֵͬ���
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
	// ������תָ��

	pushPseudoCode(Jump, cache, isCache, endLabel);
	// ��� cache �е�����
	for (unsigned int i = 0; i < myCache.size(); i++) {
		pushMiddleCode(myCache.at(i), isCache, cache);	// �����ݴ�����ݻ�����ݴ�
	}
	// ������ֹ��ǩ
	pushPseudoCode(Label, cache, isCache, endLabel);
	// }
	checkComponent(RBBRACKET, "Missing } in switch(){} statement");
	// Ԥ��
	lexical.nextSym();
	//VarCount = tmpVarCountCopy;
	VarCount = 0;
	return true;
}

// ������� ::= ���������䣾{���������䣾}
vector<entry> Syntax::enter_switchTable(string funcName, string endLabel, ValueType type, vector<MiddleCode> & cache, int weight) {
	// ������������
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

//���������䣾 ::= case��������������䣾
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

	// <����> ::= <����>|<�ַ�>
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
		// Ԥ��
		lexical.nextSym();
		break;
	default:
		error.SyntaxError(MissingComponentError, getLine(), getIndex(), "Missing constant in case table");
		lexical.skip('\n');
		return enter;
	}

	// :
	checkComponent(COLON, "Missing : in case table entry");
	
	// <���>
	if (!getncheckEnd("Missing statement inside case table"))
		return enter;
	// ���� label
	code.type = Label;
	code.target = enter.label;
	cache.push_back(code);

	enter_statement(funcName, true, cache, weight);
	// ��������ת��ĩβ
	code.type = Jump;
	code.target = endLabel;
	cache.push_back(code);
	enter.recognize = true;
	return enter;
}

// ��ȱʡ�� ::= default : ����䣾
bool Syntax::enter_defaultStatement(string funcName, bool isCache, vector<MiddleCode> &cache, int weight) {
	//����default
	if (!checkSymbol(DEFAULTSY))
		return false;
	// :
	getncheckComponent(COLON, "Missing : in case table entry");
	// <���>
	if (!getncheckEnd("Missing statement inside case table"))
		return false;
	enter_statement(funcName, isCache, cache, weight);
	return true;

}

// ��ֵ������ ::= �����ʽ��{,�����ʽ��}
vector<ValueType> Syntax::enter_callParameterTable(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	assign exp;
	MiddleCode code;

	vector<string> paramTable;
	vector<ValueType> retParamTable;
	// <���ʽ>
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

//������䣾 ::= scanf ��(������ʶ����{,����ʶ����}��)��
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
		// <��ʶ��>
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
	
	// Ԥ��
	lexical.nextSym();
	return true;
}

//��д��䣾 ::= printf ��(�� ���ַ�����,�����ʽ�� ��)��| printf ��(�����ַ����� ��)��| printf ��(�������ʽ����)��
bool Syntax::enter_writeStatement(string funcName, bool isCache, vector<MiddleCode> & cache, int weight) {
	MiddleCode code;

	int tmpVarCountCopy = VarCount;
	// printf
	if (!checkSymbol(PRINTFSY))
		return false;
	// (
	getncheckComponent(LSBRACKET, "Missing ( in printf() statement");
	//���Ӷ��Ĳ���
	if (!getncheckEnd("Unexpected end-of-file in printf() function"))
		return false;
	if (checkSymbol(STRING)) {
		pushPseudoCode(Print, cache, isCache, false, StringType, lexical.getString());
		// ,
		if (!getncheckEnd("Unexpected end-of-file in printf(...) function"))
			return false;
		//ֻ��Ϊ,�ż�������,��������
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
	// Ԥ��
	lexical.nextSym();
	return true;
}

//��������䣾 ::= return[��(�������ʽ����)��]
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
		// <���ʽ>
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

// �������� ::= �ۣ������ݣ��޷���������
void Syntax::enter_integer() {
	int value = 0;
	int sign = 1;	// ����λ
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
	// ��������
	getInteger = value;
	// Ԥ��
	lexical.nextSym();
	return;
}

//������ͷ���� ::= int ����ʶ���� | char ����ʶ����
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
	// Ԥ��
	lexical.nextSym();
	return true;
}


// ���ü���
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
// ��ѭ����䣾 ::= while ��(������������)������䣾
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
	// <����>
	if (!getncheckEnd("Missing condition block in while(...) statement"))
		return false;
	string judge = enter_condition(funcName, isCache, cache, weight);
	// ��ת
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

	// <���>
	if (!getncheckEnd("Missing statement in while(){...}"))
		return false;

	enter_statement(funcName, isCache, cache, weight);
	code.type = Jump;//��������ת��ѭ��
	code.target = label1;
	if (isCache) {
		cache.push_back(code);
	}
	else {
		MiddleCodeArr.push_back(code);
	}
	//ѭ��������
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