# MIPS Profiling Compiler
A MIPS Assembly Generator for C0 Syntax, intended for Compiler Principle Curriculum. This Compiler separates each syntax elements with different functions and calls them recursively according to the recursive descent method.

## Syntax

＜add＞ ::= +｜-
＜multiply＞  ::= *｜/
＜relations＞  ::=  <｜<=｜>｜>=｜!=｜==
＜字母＞   ::= ＿｜a｜．．．｜z｜A｜．．．｜Z
＜数字＞   ::= ０｜１｜．．．｜９
＜字符＞    ::=  '＜加法运算符＞'｜'＜乘法运算符＞'｜'＜字母＞'｜'＜数字＞'
＜字符串＞   ::=  "｛十进制编码为32,33,35-126的ASCII字符｝"
＜程序＞    ::= ［＜常量说明＞］［＜变量说明＞］{＜有返回值函数定义＞|＜无返回值函数定义＞}＜主函数＞
＜常量说明＞ ::=  const＜常量定义＞;{ const＜常量定义＞;}
＜常量定义＞   ::=   int＜标识符＞＝＜整数＞{,＜标识符＞＝＜整数＞}
                            | char＜标识符＞＝＜字符＞{,＜标识符＞＝＜字符＞}
＜无符号整数＞  ::= ＜数字＞｛＜数字＞｝
＜整数＞        ::= ［＋｜－］＜无符号整数＞
＜标识符＞    ::=  ＜字母＞｛＜字母＞｜＜数字＞｝
＜声明头部＞   ::=  int＜标识符＞|char＜标识符＞
＜变量说明＞  ::= ＜变量定义＞;{＜变量定义＞;}
＜变量定义＞  ::= ＜类型标识符＞(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’){,(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’) } //＜无符号整数＞表示数组元素的个数，其值需大于0
＜类型标识符＞      ::=  int | char
＜有返回值函数定义＞  ::=  ＜声明头部＞‘(’＜参数表＞‘)’ ‘{’＜复合语句＞‘}’|＜声明头部＞‘{’＜复合语句＞‘}’  //第一种选择为有参数的情况，第二种选择为无参数的情况
＜无返回值函数定义＞  ::= void＜标识符＞(’＜参数表＞‘)’‘{’＜复合语句＞‘}’| void＜标识符＞{’＜复合语句＞‘}’//第一种选择为有参数的情况，第二种选择为无参数的情况
＜复合语句＞   ::=  ［＜常量说明＞］［＜变量说明＞］＜语句列＞
＜参数表＞    ::=  ＜类型标识符＞＜标识符＞{,＜类型标识符＞＜标识符＞}
＜主函数＞    ::= void main‘(’‘)’ ‘{’＜复合语句＞‘}’
＜表达式＞    ::= ［＋｜－］＜项＞{＜加法运算符＞＜项＞}  //[+|-]只作用于第一个<项>
＜项＞     ::= ＜因子＞{＜乘法运算符＞＜因子＞}
＜因子＞    ::= ＜标识符＞｜＜标识符＞‘[’＜表达式＞‘]’｜＜整数＞|＜字符＞｜＜有返回值函数调用语句＞|‘(’＜表达式＞‘)’
＜语句＞    ::= ＜条件语句＞｜＜循环语句＞| ‘{’＜语句列＞‘}’｜<情况语句>|＜有返回值函数调用语句＞;
                      |＜无返回值函数调用语句＞;｜＜赋值语句＞;｜＜读语句＞;｜＜写语句＞;｜＜空＞;｜＜返回语句＞;
＜赋值语句＞   ::=  ＜标识符＞＝＜表达式＞|＜标识符＞‘[’＜表达式＞‘]’=＜表达式＞
＜条件语句＞  ::=  if ‘(’＜条件＞‘)’＜语句＞else <语句>
＜条件＞    ::=  ＜表达式＞＜关系运算符＞＜表达式＞｜＜表达式＞ //表达式为0条件为假，否则为真
＜循环语句＞   ::=  do＜语句＞while ‘(’＜条件＞‘)’
＜常量＞   ::=  ＜整数＞|＜字符＞
＜情况语句＞  ::=  switch ‘(’＜表达式＞‘)’ ‘{’＜情况表＞＜缺省＞ ‘}’
＜情况表＞   ::=  ＜情况子语句＞{＜情况子语句＞}
＜情况子语句＞  ::=  case＜常量＞：＜语句＞
＜缺省＞   ::=  default : ＜语句＞
＜有返回值函数调用语句＞ ::= ＜标识符＞‘(’＜值参数表＞‘)’|<标识符> //第一种选择为有参数的情况，第二种选择为无参数的情况
＜无返回值函数调用语句＞ ::= ＜标识符＞‘(’＜值参数表＞‘)’|<标识符> //第一种选择为有参数的情况，第二种选择为无参数的情况
＜值参数表＞   ::= ＜表达式＞{,＜表达式＞}
＜语句列＞   ::=｛＜语句＞｝
＜读语句＞    ::=  scanf ‘(’＜标识符＞{,＜标识符＞}‘)’
＜写语句＞    ::=  printf‘(’＜字符串＞,＜表达式＞‘)’|printf ‘(’＜字符串＞‘)’|printf ‘(’＜表达式＞‘)’
＜返回语句＞   ::=  return[‘(’＜表达式＞‘)’]
附加说明：
（1）char类型的变量或常量，用字符的ASCII码对应的整数参加运算
（2）标识符不区分大小写字母
（3）写语句中，字符串原样输出，单个字符类型的变量或常量输出字符，其他表达式按整型输出
（4）数组的下标从0开始
（5）情况语句中，switch后面的表达式和case后面的常量只允许出现int和char类型；每个情况子语句执行完毕后，不继续执行后面的情况子语句


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
