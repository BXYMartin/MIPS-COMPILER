# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum. This Compiler separates each syntax elements with different functions and calls them recursively according to the recursive descent method.

## Syntax

## Optimizations
### Direct Acyclic Graph (DAG) Reduction
After Basic Block Division, the compiler construct variable DAG Graph for each block and reduce the redundant calculations through intuitive deriviation algorithm.
### Bulit-in Constant
**Constant Variables** together with numbers used in source code will be automatically merged while semantic analysis during compiling. This feature is deeply implemented in every module.
### Register Allocation
For variables that matters, the program further allocates global registers for global variables and local variables (Implemented as *vector* **varToRegisterMap**). Registers for local variables changes through functions and registers for global variables are always the same while the program is running.

## Profiling
### Optimize Register Allocation Strategy

### Automatic BenchMark

## Error Handling
`Error Types`
