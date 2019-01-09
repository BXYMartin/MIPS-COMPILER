# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum. This Compiler separates each syntax elements with different functions and calls them recursively according to the recursive descent method.

![image](https://github.com/BXYMartin/MIPS-COMPILER/blob/master/Pictures/Flow.png)

## Syntax
```
＜add＞ ::= +｜-
＜multiply＞  ::= *｜/
＜relation＞  ::=  <｜<=｜>｜>=｜!=｜==
＜alphabet＞   ::= ＿｜a｜．．．｜z｜A｜．．．｜Z
＜number＞   ::= ０｜１｜．．．｜９
＜character＞    ::=  '＜add＞'｜'＜multiply＞'｜'＜alphabet＞'｜'＜number＞'
＜string＞   ::=  "｛ASCII number in 32,33,35-126｝"
＜program＞    ::= ［＜constant description＞］［＜variable description＞］
                    {＜function definition with return＞|＜function definition without return＞}＜main function＞
＜constant description＞ ::=  const＜constant definition＞;{ const＜constant definition＞;}
＜constant definition＞   ::=   int＜identifier＞＝＜integer＞{,＜identifier＞＝＜integer＞}
                            | char＜identifier＞＝＜character＞{,＜identifier＞＝＜character＞}
＜unsigned integer＞  ::= ＜number＞｛＜number＞｝
＜integer＞        ::= ［＋｜－］＜unsigned integer＞
＜identifier＞    ::=  ＜alphabet＞｛＜alphabet＞｜＜number＞｝
＜declaration head＞   ::=  int＜identifier＞|char＜identifier＞
＜variable description＞  ::= ＜variable definition＞;{＜variable definition＞;}
＜variable definition＞  ::= ＜type＞(＜identifier＞|＜identifier＞‘[’＜unsigned integer＞‘]’)
                              {,(＜identifier＞|＜identifier＞‘[’＜unsigned integer＞‘]’) }
＜type＞      ::=  int | char
＜function definition with return＞  ::=  ＜declaration head＞‘(’＜parameter table＞‘)’ ‘{’＜compound statement＞‘}’
                                          |＜declaration head＞‘{’＜compound statement＞‘}’
＜function definition without return＞  ::= void＜identifier＞(’＜parameter table＞‘)’
                                          ‘{’＜compound statement＞‘}’| void＜identifier＞{’＜compound statement＞‘}’
＜compound statement＞   ::=  ［＜constant description＞］［＜variable description＞］＜statement block＞
＜parameter table＞    ::=  ＜type＞＜identifier＞{,＜type＞＜identifier＞}
＜main function＞    ::= void main‘(’‘)’ ‘{’＜compound statement＞‘}’
＜expression＞    ::= ［＋｜－］＜item＞{＜add＞＜item＞}
＜item＞     ::= ＜factor＞{＜multiply＞＜factor＞}
＜factor＞    ::= ＜identifier＞｜＜identifier＞‘[’＜expression＞‘]’｜＜integer＞|＜character＞
                  ｜＜function call with return＞|‘(’＜expression＞‘)’
＜statement＞    ::= ＜condition statement＞｜＜loop statement＞| ‘{’＜statement block＞‘}’｜ <case statement> 
                      |＜function call with return＞; |＜function call without return＞;｜＜assignment＞;
                      ｜＜read＞;｜＜write＞;｜＜empty＞;｜＜return＞;
＜assignment＞   ::=  ＜identifier＞＝＜expression＞|＜identifier＞‘[’＜expression＞‘]’=＜expression＞
＜condition statement＞  ::=  if ‘(’＜condition＞‘)’＜statement＞else <statement>
＜condition＞    ::=  ＜expression＞＜relation＞＜expression＞｜＜expression＞
＜loop statement＞   ::=  do＜statement＞while ‘(’＜condition＞‘)’
＜constant＞   ::=  ＜integer＞|＜character＞
＜case statement＞  ::=  switch ‘(’＜expression＞‘)’ ‘{’＜case table＞＜default＞ ‘}’
＜case table＞   ::=  ＜case entry＞{＜case entry＞}
＜case entry＞  ::=  case＜constant＞：＜statement＞
＜default＞   ::=  default : ＜statement＞
＜function call with return＞ ::= ＜identifier＞‘(’＜parameter value table＞‘)’|<identifier>
＜function call without return＞ ::= ＜identifier＞‘(’＜parameter value table＞‘)’|<identifier>
＜parameter value table＞   ::= ＜expression＞{,＜expression＞}
＜statement block＞   ::=｛＜statement＞｝
＜read＞    ::=  scanf ‘(’＜identifier＞{,＜identifier＞}‘)’
＜write＞    ::=  printf‘(’＜string＞,＜expression＞‘)’|printf ‘(’＜string＞‘)’|printf ‘(’＜expression＞‘)’
＜return＞   ::=  return[‘(’＜expression＞‘)’]
Additional Requirements:
（1）Char uses its ASCII value in calculations.
（2）Identifiers are case-insensitive
（3）Write statement always write int value, except for string ane char type.
（4）Array index starts with zero.
（5）Case statement always breaks when finished, and entry value can only be char or int.
（6）Integer value in condition statement can be treated as 0-False, Other-True.
（7）Prefixed [+|-] applies for the first item in expression.
```

## Optimizations
### Direct Acyclic Graph (DAG) Reduction
After Basic Block Division, the compiler construct variable DAG Graph for each block and reduce the redundant calculations through intuitive deriviation algorithm.
### Constant Replacement
**Constant Variables** together with numbers used in source code will be automatically merged while semantic analysis during compiling. This feature is deeply implemented in every module.
### Register Allocation
For variables that matters (sorted by reference counts), the program further allocates global registers for global variables and local variables (Implemented as ***vector*** **varToRegisterMap**). Registers for local variables changes through functions and registers for global variables are always the same while the program is running.
### Inline Optimization
Functions that use less than 4 variables without array and do not call other functions can be put inline. Several problems must be taken care of. First, all labels inside the function must be renamed to avoid multiple inline block, including the return label. Second, for the sake of multiple returns, each of them must restore all temp registers used and jump to the end of inline block. Third, variables inside inline block is mapped to `$a0~$a3` registers. Last, when calling print syscall, the `$a0` register, if used, must be temporarily stored in another register and swap back later on.

## Profiling
### Optimize Register Allocation Strategy
In simulation, reference times for each variables in symbol table can be recorded and used to replace the original reference times for more efficient allocation.
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
| `Invalid Assignment` | Assigned to non-variable identifiers
| `Conflicting Case Entry` | Multiple entry found in `switch(){case:...}` block
| `Divided by Zero` | Set zero as denominator



### Return Error

|Error Type|Descriptions|
|---|---
| `Void Function Returned Non-void Value` | **`int`** or **`char`** type returned in void function
| `Non-void Function Returned Void Value` | Void type returned in **`int`** or **`char`** function
| `Missing Return` | Missing return statement in function

## Type Warnings

|Warning Type|Descriptions|
|---|---
| `Conflicting Return Value` | **`int`** type returned in **`char`** function
| `Conflicting Parameter Type` | Type mismatch during calling a function
| `Conflicting Assignment Type` | Invalid Conversion from **`int`** to **`char`**
| `Conflicting Comparison Type` | Invalid comparison involving **`char`**
| `Conflicting Case Entry Type` | Case entry type not match
| `Illegal Char` | Illegal elements(character other than alphabet plus operators) appears in `' '` 
