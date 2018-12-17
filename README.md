# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum.

## Syntax

## Optimizations
### Direct Acyclic Graph (DAG) Reduction
After Basic Block Division, the compiler construct variable DAG Graph for each block and reduce the redundant calculations through intuitive deriviation algorithm.
### Bulit-in Constant

### Register Allocation
For variables that matters, the program further allocates global registers for global variables and local variables (Implemented as *vector* **varToRegisterMap**). Registers for local variables changes through functions and registers for global variables are always the same while the program is running.

## Profiling
### Optimize Register Allocation Strategy

### Automatic BenchMark
