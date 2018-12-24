.data
	$String28:.asciiz "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !"
	$String29:.asciiz "test of comp symbol"
	$String30:.asciiz "a==b"
	$String31:.asciiz "a<b"
	$String32:.asciiz "c>a"
	$String33:.asciiz "d"
	$String34:.asciiz "error"
	$String35:.asciiz "a<=c"
	$String36:.asciiz "error!"
	$String37:.asciiz "test global variable and constance"
	$String38:.asciiz "before change para="
	$String39:.asciiz "after change para="
	$String40:.asciiz "test for expression"
	$String41:.asciiz "--12--12--12-+12+-12--12--12--12--12="
	$String42:.asciiz "10*-5="
	$String43:.asciiz "10/+4="
	$String44:.asciiz "fib(12)-fib(14)="
	$String45:.asciiz "c + 12 = "
	$String46:.asciiz "c*12/1="
	$String47:.asciiz "1-(((12+1)))="
	$String48:.asciiz "arr[1]*'b'+fib(3)="
	$String49:.asciiz "addone(g_v_char_h)+add(1, fib(5))/G_v_int_a1 - tag[6]="
	$String50:.asciiz "please input an integer"
	$String51:.asciiz "please input 2 integers press enter for each integer"
	$String52:.asciiz " "
	$String53:.asciiz "input the number of fib you want(1~10)"
	$String54:.asciiz "this is a permutation of ABCDE"
.globl main
.text
foo1:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 20
addiu $sp $sp 36
addu $t3 $s0 $s1
move $v0 $t3
jr $ra
add:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 20
addiu $sp $sp 36
addu $t3 $s0 $s1
move $v0 $t3
jr $ra
addchar:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 20
addiu $sp $sp 36
addu $t3 $s0 $s1
move $v0 $t3
jr $ra
addone:
move $s0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
addiu $t3 $s0 1
move $v0 $t3
jr $ra
addint:
move $s0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
addiu $t3 $s0 1
move $v0 $t3
jr $ra
foo2:
move $s0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
ble $s0 99 $Label1
li $v0 47
jr $ra
j $Label2
$Label1:
li $v0 42
jr $ra
$Label2:
test_string_int:
addiu $fp $sp 12
addiu $sp $sp 24
li $s0 1
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 12
move $a0 $s0
li $v0 1
syscall
li $s0 -12
move $a0 $s0
li $v0 1
syscall
la $a0 $String28
li $v0 4
syscall
jr $ra
fib:
move $s0 $a0
addiu $fp $sp 32
addiu $sp $sp 44
bne $s0 1 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
bne $s0 2 $Label5
li $v0 1
jr $ra
$Label5:
$Label6:
$Label4:
subu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
subu $t5 $s0 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t6 $v0 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
test_lots_paras:
move $s0 $a0
move $s1 $a1
move $s2 $a2
move $s3 $a3
lw $v1 0($k1)
sw $v1 64($sp)
addiu $fp $sp 40
addiu $sp $sp 68
addu $t3 $s0 $s1
addu $t4 $t3 $s2
subu $t5 $t4 $s3
lw $t2 24($fp)
addu $t6 $t5 $t2
move $v0 $t6
jr $ra
test_all_cond:
addiu $fp $sp 24
addiu $sp $sp 48
li $s0 1
li $s2 2
li $s1 2
li $s3 65
la $a0 $String29
li $v0 4
syscall
bne $s2 $s1 $Label7
la $a0 $String30
li $v0 4
syscall
$Label7:
$Label8:
bge $s0 $s2 $Label9
la $a0 $String31
li $v0 4
syscall
$Label9:
$Label10:
ble $s1 $s0 $Label11
la $a0 $String32
li $v0 4
syscall
$Label11:
$Label12:
beq $s3 0 $Label13
la $a0 $String33
li $v0 4
syscall
$Label13:
$Label14:
bne $s0 1 $Label15
la $a0 $String34
li $v0 4
syscall
$Label15:
$Label16:
beq $s0 1 $Label17
la $a0 $String34
li $v0 4
syscall
$Label17:
$Label18:
bgt $s0 $s1 $Label19
la $a0 $String35
li $v0 4
syscall
$Label19:
$Label20:
blt $s0 $s1 $Label21
la $a0 $String36
li $v0 4
syscall
$Label21:
$Label22:
ble $s3 66 $Label23
la $a0 $String36
li $v0 4
syscall
$Label23:
$Label24:
jr $ra
test_diff_domain:
move $s0 $a0
addiu $fp $sp 20
addiu $sp $sp 36
li $a0 98
li $v0 11
syscall
li $s1 222
move $a0 $s1
li $v0 1
syscall
la $a0 $String37
li $v0 4
syscall
li $a0 1
li $v0 1
syscall
li $a0 102
li $v0 11
syscall
li $a0 98
li $v0 11
syscall
li $a0 98
li $v0 11
syscall
li $a0 2
li $v0 1
syscall
li $a0 3
li $v0 1
syscall
li $t1 72
sw $t1 60($gp)
lw $t3 60($gp)
move $a0 $t3
li $v0 11
syscall
li $t1 155
sw $t1 28($gp)
lw $t3 28($gp)
move $a0 $t3
li $v0 1
syscall
la $a0 $String38
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
mul $s0 $s0 2
la $a0 $String39
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s6 89
addiu $t3 $s6 0
move $a0 $t3
li $v0 11
syscall
jr $ra
test_expr:
addiu $fp $sp 44
addiu $sp $sp 136
la $a0 $String40
li $v0 4
syscall
li $s0 60
la $a0 $String41
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 -50
la $a0 $String42
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 2
la $a0 $String43
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 12
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 14
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
subu $s0 $t3 $t4
la $a0 $String44
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 111
la $a0 $String45
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 1188
la $a0 $String46
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 -12
la $a0 $String47
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $t1 15
sw $t1 16($fp)
lw $t3 16($fp)
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
mul $t5 $t3 98
addu $s0 $t5 $t4
la $a0 $String48
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s4 5
li $t1 12
sw $t1 84($fp)
li $s1 104
move $a0 $s1
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal addone
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
li $a0 1
move $a1 $t4
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal add
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t5 $v0 0
addiu $t6 $s4 0
lw $t7 84($fp)
div $t8 $t5 $t6
addu $t9 $t3 $t8
subu $s0 $t9 $t7
la $a0 $String49
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
jr $ra
test_scanf:
addiu $fp $sp 16
addiu $sp $sp 32
la $a0 $String50
li $v0 4
syscall
li $v0 5
syscall
move $s0 $v0
move $a0 $s0
li $v0 1
syscall
la $a0 $String51
li $v0 4
syscall
li $v0 5
syscall
move $s0 $v0
li $v0 5
syscall
move $s1 $v0
move $a0 $s0
li $v0 1
syscall
move $a0 $s1
li $v0 1
syscall
jr $ra
echo_char:
move $s0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
move $a0 $s0
li $v0 11
syscall
move $v0 $s0
jr $ra
really_void:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
really_void2:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
really_void3:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
permutation:
move $s1 $a0
move $s3 $a1
addiu $fp $sp 28
addiu $sp $sp 56
subu $t3 $s3 1
bge $s1 $t3 $Label25
addiu $t3 $s1 1
move $a0 $t3
move $a1 $s3
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $s2 20($sp)
sw $s3 24($sp)
sw $ra 28($sp)
jal permutation
addiu $sp $fp -28
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $s0 $s1 1
bge $s0 $s3 $Label27
$Label29:
addiu $t1 $gp 252
sll $t2 $s1 2
addu $t1 $t1 $t2
lw $s2 0($t1)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
sll $t0 $s1 2
addu $t0 $gp $t0
sw $t3 252($t0)
sll $t0 $s0 2
addu $t0 $gp $t0
sw $s2 252($t0)
addiu $t3 $s1 1
move $a0 $t3
move $a1 $s3
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $s2 20($sp)
sw $s3 24($sp)
sw $ra 28($sp)
jal permutation
addiu $sp $fp -28
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t1 $gp 252
sll $t2 $s1 2
addu $t1 $t1 $t2
lw $s2 0($t1)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
sll $t0 $s1 2
addu $t0 $gp $t0
sw $t3 252($t0)
sll $t0 $s0 2
addu $t0 $gp $t0
sw $s2 252($t0)
addiu $s0 $s0 1
blt $s0 $s3 $Label29
$Label27:
$Label28:
j $Label26
$Label25:
li $s0 0
$Label30:
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
sw $s0 8($sp)
sw $ra 12($sp)
jal echo_char
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -28
sw $v0 24($fp)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a1 24($fp)
beq $a1 $t3 $Label31
la $a0 $String34
li $v0 4
syscall
$Label31:
$Label32:
addiu $s0 $s0 1
blt $s0 5 $Label30
la $a0 $String52
li $v0 4
syscall
$Label26:
jr $ra
main:
li $k1 268501560
addiu $fp $gp 272
addiu $sp $fp 64
li $s0 0
bge $s0 10 $Label33
$Label35:
addiu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $ra 32($sp)
jal fib
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sll $t0 $s0 2
addu $t0 $fp $t0
sw $v0 8($t0)
addiu $s0 $s0 1
blt $s0 10 $Label35
$Label33:
$Label34:
la $a0 $String53
li $v0 4
syscall
li $v0 5
syscall
move $s1 $v0
li $v0 5
syscall
move $s2 $v0
subu $s0 $s1 1
$Label36:
la $a0 $String52
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $s0 $s0 1
blt $s0 $s2 $Label36
subu $s0 $s2 1
subu $t3 $s1 1
blt $s0 $t3 $Label37
$Label39:
la $a0 $String52
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
subu $s0 $s0 1
subu $t3 $s1 1
bge $s0 $t3 $Label39
$Label37:
$Label38:
li $a0 1
li $a1 98
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal foo1
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal add
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 97
li $a1 98
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal addchar
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 70
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal addone
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 16
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal addint
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 99
sw $s0 8($sp)
sw $ra 12($sp)
jal foo2
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 11
syscall
sw $s0 8($sp)
sw $ra 12($sp)
jal test_string_int
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 233
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal test_diff_domain
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $s0 36($sp)
sw $s1 40($sp)
sw $ra 44($sp)
jal test_expr
addiu $sp $fp -44
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
lw $s1 40($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $ra 24($sp)
jal test_all_cond
addiu $sp $fp -24
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal test_scanf
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 97
sw $s0 8($sp)
sw $ra 12($sp)
jal echo_char
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 1
li $a1 2
li $a2 99
li $a3 100
li $v0 5
sw $v0 0($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $s0 24($sp)
sw $s1 28($sp)
sw $s2 32($sp)
sw $s3 36($sp)
sw $ra 40($sp)
jal test_lots_paras
addiu $sp $fp -40
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $s0 24($sp)
lw $s1 28($sp)
lw $s2 32($sp)
lw $s3 36($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
sw $ra 8($sp)
jal really_void
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal really_void2
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal really_void3
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $t1 65
sw $t1 252($gp)
li $t1 66
sw $t1 256($gp)
li $t1 67
sw $t1 260($gp)
li $t1 68
sw $t1 264($gp)
li $t1 69
sw $t1 268($gp)
la $a0 $String54
li $v0 4
syscall
li $a0 0
li $a1 5
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $s2 20($sp)
sw $s3 24($sp)
sw $ra 28($sp)
jal permutation
addiu $sp $fp -28
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $v0 10
syscall
# End Of MIPS Assembly Code.
