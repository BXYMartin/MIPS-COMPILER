# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum. This Compiler separates each syntax elements with different functions and calls them recursively according to the recursive descent method.

## Syntax

## Optimizations
### Direct Acyclic Graph (DAG) Reduction
After Basic Block Division, the compiler construct variable DAG Graph for each block and reduce the redundant calculations through intuitive deriviation algorithm.
### Bulit-in Constant
**Constant Variables** together with numbers used in source code will be automatically merged while semantic analysis during compiling. This feature is deeply implemented in every module.
### Register Allocation
For variables that matters, the program further allocates global registers for global variables and local variables (Implemented as ***vector*** **varToRegisterMap**). Registers for local variables changes through functions and registers for global variables are always the same while the program is running.

## Profiling
### Optimize Register Allocation Strategy

### Automatic BenchMark

## Error Handling
### Lexical Error
The compiler can handle error types as follows:

|Error Type|Descriptions|
|---|---
| `Illegal Char` | Multiple elements appears in `' '` 
| `Illegal String` | Illigal element (ASCII Code in `32~126` except for `34`) appears in `" "` 
| `Illegal Content` | Illegal content appears 
| `Incomplete Not Equal` | Missing '=' in `!=` 


### Syntax Error

### Semantic Error

### Return Error
