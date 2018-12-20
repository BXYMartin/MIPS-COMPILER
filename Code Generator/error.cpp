#include "stdafx.h"

#include <iostream>
#include <iomanip>
#include "error.h"
using namespace std;

bool Errors = false;

void Error::reportPosition(int index) {
	int begin, end, i;
	for (begin = index; begin >= 0 && (index - begin) <= SURROUND; begin--);
	if (targetFile[begin] != '\n') {
		cout << "... ";
	}
	else
		cout << ">>> ";
		

	begin++;
	for (end = index; end < targetFile.size() && targetFile[end] != '\n' && (end - index) <= SURROUND; end++);

	for (i = begin; i < end; i++)
		cout << targetFile[i];
	if (end != targetFile.size() && targetFile[end + 1] != '\n') {
		cout << " ...";
	}
	cout << endl;
	cout << "    ";
	for (i = begin; i < index - 1; i++)
		cout << " ";
	cout << "^" << endl;
}

void Error::LexicalError(LexicalErrorCode errorCode, int currentLine, int index) {
	Errors = true;
	reportPosition(index);
	cout << ">>> Error at line: ";
	cout << setw(4) << currentLine;
	cout << ", ";
	switch (errorCode) {
	case SingleCharIllegal:
		cout << "illegal char format." << endl;
		break;
	case StringIllegal:
		cout << "illegal string format." << endl;
		break;
	case ContentIllegal:
		cout << "illegal content." << endl;
		break;
	case NotEqualSymIllegal:
		cout << "illegal != format." << endl;
		break;
	default:break;
	}
}

void Error::SyntaxError(SyntaxErrorCode errorCode, int currentLine, int index) {
	Errors = true;
	reportPosition(index);
	cout << ">>> Error at line: ";
	cout << setw(4) << currentLine;
	cout << ", ";
	switch (errorCode) {
	case EmptyFileError:
		cout << " " << "Empty file." << endl;
		break;
	case DefinitionAfterMainError:
		cout << " " << "Illigal contents after void main(){} declaration." << endl;
		break;
	case NoMainFunctionError:
		cout << " " << "Missing main function entry." << endl;
		break;
	case ArrIndexError:
		cout << " " << "Illigal array initial compacity, should be greater than zero." << endl;
	default:break;
	}
}

void Error::SyntaxError(SyntaxErrorCode errorCode, int currentLine, int index, string info) {
	Errors = true;
	reportPosition(index);
	cout << ">>> Error at line: ";
	cout << setw(4) << currentLine;
	cout << ", ";
	switch (errorCode) {
	case MissingComponentError:
		cout << " " << info << endl;
		break;
	default:break;
	}
}

void Error::SemanticError(SemanticErrorCode errorCode, int currentLine, int index, string identifier) {
	Errors = true;
	reportPosition(index);
	cout << ">>> Error at line: ";
	cout << setw(4) << currentLine;
	cout << ", ";
	switch (errorCode) {
	case MultipleDefinitionError:
		cout << "Multiple definition fot identifier " << identifier << "." << endl;
		break;
	case NoVariableDefinitionError:
		cout << "Undefined identifier " << identifier << "." << endl;
		break;
	case NoFunctionDefinitionError:
		cout << "Undefined function " << identifier << "." << endl;
		break;
	case IndexOutOfRangeError:
		cout << "Array " << identifier << " index out of range." << endl;
		break;
	case TypeNotMatchError:
		cout << "Conflicting types for identifier " << identifier << "." << endl;
		break;
	case VariableNotCallableError:
		cout << "Calling non-function identifier " << identifier << "." << endl;
		break;
	case ValueExpectedError:
		cout << "Expected return value for function " << identifier << "." << endl;
		break;
	case NoneValueParamError:
		cout << "Missing parameter table for function " << identifier << "." << endl;
		break;
	case ExtraParameterError:
		cout << "Abundant parameters passed in calling function " << identifier << "." << endl;
		break;
	case MissingParameterError:
		cout << "Missing parameters in calling function " << identifier << "." << endl;
		break;
	case ConflictingParameterTypeError:
		cout << "Conflicting types in function " << identifier << " parameter declaration." << endl;
		break;
	case ConversionAssignmentError:
		cout << "Invalid assignment from int to char." << endl;
		break;
	case CriticalAssignmentError:
		cout << "Invalid assignment to a non-variable identifier " << identifier << "." << endl;
		break;
	case ConflictingCaseEntryError:
		cout << "Conflicting case entry value." << endl;
		break;
	case ConflictingCaseTypeError:
		cout << "Conflicting case type." << endl;
		break;
	case DivisionByZeroError:
		cout << "Divided By Zero." << endl;
		break;
	default:break;
	}
}

void Error::ReturnError(ReturnErrorCode errorCode, int currentLine, int index, string funcName) {
	Errors = true;
	reportPosition(index);
	cout << ">>> Error at line: ";
	cout << setw(4) << currentLine;
	cout << ", ";
	switch (errorCode) {
	case ValueReturnedInVoidFunctionError:
		cout << "Non-return function void " << funcName << "returned a value." << endl;
		break;
	case IntReturnedInCharFunctionError:
		cout << "Char function char " << funcName << " returned int, idicating illigal conversion from int to char." << endl;
		break;
	case NoReturnError:
		cout << "Missing return statement for function " << funcName << "." << endl;
		break;
	case VoidReturnedInNonVoidFunctionError:
		cout << "Missing return value for non-void function " << funcName << "." << endl;
		break;
	default:break;
	}
}