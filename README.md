# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum. This Compiler separates each syntax elements with different functions and calls them recursively according to the recursive descent method.

## Syntax

## Optimizations
### Direct Acyclic Graph (DAG) Reduction
After Basic Block Division, the compiler construct variable DAG Graph for each block and reduce the redundant calculations through intuitive deriviation algorithm.
### Bulit-in Constant
**Constant Variables** together with numbers used in source code will be automatically merged while semantic analysis during compiling. This feature is deeply implemented in every module.
### Register Allocation
For variables that matters (sorted by reference counts), the program further allocates global registers for global variables and local variables (Implemented as ***vector*** **varToRegisterMap**). Registers for local variables changes through functions and registers for global variables are always the same while the program is running.

## Profiling
### Optimize Register Allocation Strategy

### Automatic BenchMark

## Error Handling
### Lexical Error
The compiler can handle error types as follows:

|Error Type|Descriptions|
|---|---
| `Illegal Char` | Multiple elements appears in `' '` 
| `Illegal String` | Illegal element (ASCII Code in `32~126` except for `34`) appears in `" "` 
| `Illegal Content` | Illegal content appears 
| `Incomplete Not Equal` | Missing '=' in `!=` 

### Syntax Error

|Error Type|Descriptions|
|---|---
| `Empty File` | Simply an empty file
| `Illegal Content After Main` | Illegal content appears after `void main(){}` definition 
| `Missing Main Function` | Lack of `void main(){}` definition
| `Illegal Array Index Definition` | Array index not greater than zero
| `Missing Component` | Missing critical component during syntax analysis

### Semantic Error


|Error Type|Descriptions|
|---|---
| `Multiple Definition` | Multiple Definition of an identifier
| `Missing Variable Definition` | Missing definition for variables
| `Missing Function Definition` | Missing definition for functions
| `Index Out Of Range` | Array index out of range (Larger than maximum or Less than zero)
| `Conflicting Types` | Identifier type not match in symbol table
| `Invalid Variable Call` | Calling a variable as a function
| `Invalid Return Value` | Void function involved in assignments
| `Missing Parameter Table` | Parameter count mismatch in calling a function
| `Abundant Parameter` | Extra parameter detected
| `Missing Parameter` | Missing parameter in calling a function 
| `Conflicting Parameter Type` | Type mismatch during calling a function
| `Invalid Type Conversion` | Invalid Conversion from **`int`** to **`char`**
| `Invalid Assignment` | Assigned to non-variable identifiers
| `Conflicting Case Entry` | Multiple entry found in `switch(){case:...}` block
| `Divided by Zero` | Set zero as denominator



### Return Error

|Error Type|Descriptions|
|---|---
| `Void Function Returned Non-void Value` | **`int`** or **`char`** type returned in void function
| `Char Function Returned Int Value` | **`int`** type returned in **`char`** function
| `Non-void Function Returned Void Value` | Void type returned in **`int`** or **`char`** function
| `Missing Return` | Missing return statement in function
