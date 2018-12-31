.data
	$String28:.asciiz "test for expression"
	$String29:.asciiz "--12--12--12-+12+-12--12--12--12--12="
	$String30:.asciiz "10*-5="
	$String31:.asciiz "10/+4="
	$String32:.asciiz "fib(12)-fib(14)="
	$String33:.asciiz "c + 12 = "
	$String34:.asciiz "c*12/1="
	$String35:.asciiz "1-(((12+1)))="
	$String36:.asciiz "arr[1]*'b'+fib(3)="
	$String37:.asciiz "addone(g_v_char_h)+add(1, fib(5))/G_v_int_a1 - tag[6]="
	$String38:.asciiz "error"
	$String39:.asciiz " "
	$String40:.asciiz "input the number of fib you want(1~10)"
	$String41:.asciiz "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !"
	$String42:.asciiz "test global variable and constance"
	$String43:.asciiz "before change para="
	$String44:.asciiz "after change para="
	$String45:.asciiz "test of comp symbol"
	$String46:.asciiz "a==b"
	$String47:.asciiz "a<b"
	$String48:.asciiz "c>a"
	$String49:.asciiz "d"
	$String50:.asciiz "a<=c"
	$String51:.asciiz "error!"
	$String52:.asciiz "please input an integer"
	$String53:.asciiz "please input 2 integers press enter for each integer"
	$String54:.asciiz "this is a permutation of ABCDE"
.globl main
.text
foo1:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
add:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 20
addiu $sp $sp 36
addchar:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
addone:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
addint:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
foo2:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
test_string_int:
addiu $fp $sp 12
addiu $sp $sp 24
fib:
move $s0 $a0
addiu $fp $sp 24
addiu $sp $sp 36
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
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
subu $t5 $s0 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addu $t7 $t4 $v0
move $v0 $t7
jr $ra
test_lots_paras:
move $s0 $a0
move $s1 $a1
move $s2 $a2
move $s3 $a3
lw $s4 0($k1)
addiu $fp $sp 28
addiu $sp $sp 56
addu $t3 $s0 $s1
addu $t4 $t3 $s2
subu $t5 $t4 $s3
addu $t6 $t5 $s4
move $v0 $t6
jr $ra
test_all_cond:
addiu $fp $sp 24
addiu $sp $sp 48
test_diff_domain:
move $a0 $a0
addiu $fp $sp 16
addiu $sp $sp 32
test_expr:
addiu $fp $sp 16
addiu $sp $sp 108
la $a0 $String28
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s0 60
la $a0 $String29
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 -50
la $a0 $String30
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 2
la $a0 $String31
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 12
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 14
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -92
subu $s0 $t3 $v0
la $a0 $String32
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 111
la $a0 $String33
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 1188
la $a0 $String34
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 -12
la $a0 $String35
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $t1 15
sw $t1 16($fp)
lw $t3 16($fp)
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
mul $t5 $t3 98
addu $s0 $t5 $t4
la $a0 $String36
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $t1 5
sw $t1 0($gp)
li $t1 12
sw $t1 84($fp)
li $s1 104
move $a0 $s1
addiu $t3 $a0 1
move $v0 $t3
$_addone_1:
addiu $t3 $v0 0
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
li $a0 1
move $a1 $t4
sw $t3 8($sp)
addu $t3 $a0 $a1
move $v0 $t3
lw $t3 8($sp)
$_add_1:
addiu $t5 $v0 0
lw $t6 84($fp)
lw $t2 0($gp)
div $t5 $t2
mflo $t7
addu $t8 $t3 $t7
subu $s0 $t8 $t6
la $a0 $String37
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
jr $ra
test_scanf:
addiu $fp $sp 16
addiu $sp $sp 32
echo_char:
move $a0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
really_void:
addiu $fp $sp 8
addiu $sp $sp 16
really_void2:
addiu $fp $sp 8
addiu $sp $sp 16
really_void3:
addiu $fp $sp 8
addiu $sp $sp 16
permutation:
move $s1 $a0
move $s3 $a1
addiu $fp $sp 32
addiu $sp $sp 60
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
sw $s4 28($sp)
sw $ra 32($sp)
jal permutation
addiu $sp $fp -32
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $s4 28($sp)
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
sw $s4 28($sp)
sw $ra 32($sp)
jal permutation
addiu $sp $fp -32
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $s4 28($sp)
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
sw $t3 8($sp)
move $k0 $a0
move $a0 $a0
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $v0 $a0
lw $t3 8($sp)
$_echo_char_1:
addiu $s4 $v0 0
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
beq $s4 $t3 $Label31
la $a0 $String38
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label31:
$Label32:
addiu $s0 $s0 1
blt $s0 5 $Label30
la $a0 $String39
li $v0 4
syscall
li $a0 10
li $v0 11
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
sw $s0 20($sp)
sw $ra 24($sp)
jal fib
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sll $t0 $s0 2
addu $t0 $fp $t0
sw $v0 8($t0)
addiu $s0 $s0 1
blt $s0 10 $Label35
$Label33:
$Label34:
la $a0 $String40
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s1 $v0
li $v0 5
syscall
move $s2 $v0
subu $s0 $s1 1
$Label36:
la $a0 $String39
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $s0 $s0 1
blt $s0 $s2 $Label36
subu $s0 $s2 1
subu $t3 $s1 1
blt $s0 $t3 $Label37
$Label39:
la $a0 $String39
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
subu $s0 $s0 1
subu $t3 $s1 1
bge $s0 $t3 $Label39
$Label37:
$Label38:
li $a0 1
li $a1 98
addu $t3 $a0 $a1
move $v0 $t3
$_foo1_1:
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 1
li $a1 2
sw $t3 8($sp)
addu $t3 $a0 $a1
move $v0 $t3
lw $t3 8($sp)
$_add_1_2:
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 97
li $a1 98
addu $t3 $a0 $a1
move $v0 $t3
$_addchar_1:
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 70
addiu $t3 $a0 1
move $v0 $t3
$_addone_1_2:
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 16
addiu $t3 $a0 1
move $v0 $t3
$_addint_1:
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 99
ble $a0 99 $Label1_1
li $v0 47
j $_foo2_1
j $Label2_1
$Label1_1:
li $v0 42
$Label2_1:
$_foo2_1:
addiu $t3 $v0 0
move $a0 $t3
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
li $a0 1
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a0 0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a0 0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a0 0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a0 12
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a0 -12
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String41
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $_test_string_int_1
$_test_string_int_1:
li $a0 233
move $k0 $a0
li $a0 98
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $a1 222
move $k0 $a0
move $a0 $a1
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String42
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 1
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 102
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 98
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 98
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 2
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 3
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $t1 72
sw $t1 60($gp)
lw $t3 60($gp)
move $k0 $a0
move $a0 $t3
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $t1 155
sw $t1 28($gp)
lw $t3 28($gp)
move $k0 $a0
move $a0 $t3
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String43
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
mul $a0 $a0 2
move $k0 $a0
la $a0 $String44
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $t1 89
sw $t1 48($gp)
move $k0 $a0
lw $a0 48($gp)
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$_test_diff_domain_1:
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal test_expr
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 1
li $a1 2
li $a2 2
li $a3 65
move $k0 $a0
la $a0 $String45
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
bne $a1 $a2 $Label7_1
move $k0 $a0
la $a0 $String46
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label7_1:
$Label8_1:
bge $a0 $a1 $Label9_1
move $k0 $a0
la $a0 $String47
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label9_1:
$Label10_1:
ble $a2 $a0 $Label11_1
move $k0 $a0
la $a0 $String48
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label11_1:
$Label12_1:
beq $a3 0 $Label13_1
move $k0 $a0
la $a0 $String49
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label13_1:
$Label14_1:
bne $a0 1 $Label15_1
move $k0 $a0
la $a0 $String38
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label15_1:
$Label16_1:
beq $a0 1 $Label17_1
move $k0 $a0
la $a0 $String38
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label17_1:
$Label18_1:
bgt $a0 $a2 $Label19_1
move $k0 $a0
la $a0 $String50
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label19_1:
$Label20_1:
blt $a0 $a2 $Label21_1
move $k0 $a0
la $a0 $String51
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label21_1:
$Label22_1:
ble $a3 66 $Label23_1
move $k0 $a0
la $a0 $String51
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label23_1:
$Label24_1:
j $_test_all_cond_1
$_test_all_cond_1:
move $k0 $a0
la $a0 $String52
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $v0 5
syscall
move $a0 $v0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String53
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
li $v0 5
syscall
move $a0 $v0
li $v0 5
syscall
move $a1 $v0
move $k0 $a0
move $a0 $a0
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
move $a0 $a1
li $v0 1
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $_test_scanf_1
$_test_scanf_1:
li $a0 97
sw $t3 8($sp)
move $k0 $a0
move $a0 $a0
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $v0 $a0
lw $t3 8($sp)
$_echo_char_1_2:
li $a0 1
li $a1 2
li $a2 99
li $a3 100
li $v0 5
sw $v0 0($k1)
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $s4 24($sp)
sw $ra 28($sp)
jal test_lots_paras
addiu $sp $fp -28
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $s4 24($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
$_really_void_1:
$_really_void2_1:
$_really_void3_1:
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
li $a0 10
li $v0 11
syscall
li $a0 0
li $a1 5
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $s2 20($sp)
sw $s3 24($sp)
sw $s4 28($sp)
sw $ra 32($sp)
jal permutation
addiu $sp $fp -32
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s2 20($sp)
lw $s3 24($sp)
lw $s4 28($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $v0 10
syscall
# End Of MIPS Assembly Code.
