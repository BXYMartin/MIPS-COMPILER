.data
	$String1:.asciiz "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !"
	$String2:.asciiz "test of comp symbol"
	$String3:.asciiz "a==b"
	$String4:.asciiz "a<b"
	$String5:.asciiz "c>a"
	$String6:.asciiz "d"
	$String7:.asciiz "error"
	$String8:.asciiz "a<=c"
	$String9:.asciiz "error!"
	$String10:.asciiz "test global variable and constance"
	$String11:.asciiz "before change para="
	$String12:.asciiz "after change para="
	$String13:.asciiz "test for expression"
	$String14:.asciiz "--12--12--12-+12+-12--12--12--12--12="
	$String15:.asciiz "10*-5="
	$String16:.asciiz "10/+4="
	$String17:.asciiz "fib(12)-fib(14)="
	$String18:.asciiz "c + 12 = "
	$String19:.asciiz "c*12/1="
	$String20:.asciiz "1-(((12+1)))="
	$String21:.asciiz "arr[1]*'b'+fib(3)="
	$String22:.asciiz "addone(g_v_char_h)+add(1, fib(5))/G_v_int_a1 - tag[6]="
	$String23:.asciiz "please input an integer"
	$String24:.asciiz "please input 2 integers press enter for each integer"
	$String25:.asciiz " "
	$String26:.asciiz "input the number of fib you want(1~10)"
	$String27:.asciiz "this is a permutation of ABCDE"
.globl main
.text
foo1:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
add:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
addchar:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
addone:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 8($fp)
addiu $t3 $t1 1
move $v0 $t3
jr $ra
addint:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 8($fp)
addiu $t3 $t1 1
move $v0 $t3
jr $ra
foo2:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $t1 8($fp)
ble $t1 99 $Label1
li $v0 47
jr $ra
j $Label2
$Label1:
li $v0 42
jr $ra
$Label2:
test_string_int:
addiu $fp $sp 8
addiu $sp $sp 20
li $t1 1
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 0
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 0
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 0
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 12
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 -12
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
la $a0 $String1
li $v0 4
syscall
jr $ra
jr $ra
fib:
sw $a0 36($sp)
addiu $fp $sp 28
addiu $sp $sp 40
lw $t1 8($fp)
bne $t1 1 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
lw $t1 8($fp)
bne $t1 2 $Label5
li $v0 1
jr $ra
j $Label6
$Label5:
$Label6:
$Label4:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
lw $t1 8($fp)
subu $t5 $t1 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t6 $v0 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
test_lots_paras:
sw $a0 32($sp)
sw $a1 36($sp)
sw $a2 40($sp)
sw $a3 44($sp)
lw $v1 -4($gp)
sw $v1 48($sp)
addiu $fp $sp 24
addiu $sp $sp 52
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
subu $t5 $t4 $t2
lw $t2 24($fp)
addu $t6 $t5 $t2
move $v0 $t6
jr $ra
test_all_cond:
addiu $fp $sp 8
addiu $sp $sp 32
li $t1 1
sw $t1 8($fp)
li $t1 2
sw $t1 12($fp)
li $t1 2
sw $t1 16($fp)
li $t1 65
sw $t1 20($fp)
la $a0 $String2
li $v0 4
syscall
lw $t1 12($fp)
lw $t2 16($fp)
bne $t1 $t2 $Label7
la $a0 $String3
li $v0 4
syscall
j $Label8
$Label7:
$Label8:
lw $t1 8($fp)
lw $t2 12($fp)
bge $t1 $t2 $Label9
la $a0 $String4
li $v0 4
syscall
j $Label10
$Label9:
$Label10:
lw $t1 16($fp)
lw $t2 8($fp)
ble $t1 $t2 $Label11
la $a0 $String5
li $v0 4
syscall
j $Label12
$Label11:
$Label12:
lw $t1 20($fp)
beq $t1 0 $Label13
la $a0 $String6
li $v0 4
syscall
j $Label14
$Label13:
$Label14:
lw $t1 8($fp)
bne $t1 1 $Label15
la $a0 $String7
li $v0 4
syscall
j $Label16
$Label15:
$Label16:
lw $t1 8($fp)
beq $t1 1 $Label17
la $a0 $String7
li $v0 4
syscall
j $Label18
$Label17:
$Label18:
lw $t1 8($fp)
lw $t2 16($fp)
bgt $t1 $t2 $Label19
la $a0 $String8
li $v0 4
syscall
j $Label20
$Label19:
$Label20:
lw $t1 8($fp)
lw $t2 16($fp)
blt $t1 $t2 $Label21
la $a0 $String9
li $v0 4
syscall
j $Label22
$Label21:
$Label22:
lw $t1 20($fp)
ble $t1 66 $Label23
la $a0 $String9
li $v0 4
syscall
j $Label24
$Label23:
$Label24:
jr $ra
jr $ra
test_diff_domain:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 28
li $a0 98
li $v0 11
syscall
li $t1 222
sw $t1 12($fp)
lw $a0 12($fp)
li $v0 1
syscall
la $a0 $String10
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
la $a0 $String11
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
lw $t1 8($fp)
mul $t3 $t1 2
sw $t3 8($fp)
la $a0 $String12
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 89
sw $t1 48($gp)
lw $a0 48($gp)
li $v0 11
syscall
jr $ra
test_expr:
addiu $fp $sp 36
addiu $sp $sp 128
la $a0 $String13
li $v0 4
syscall
li $t1 60
sw $t1 8($fp)
la $a0 $String14
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 -50
sw $t1 8($fp)
la $a0 $String15
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 2
sw $t1 8($fp)
la $a0 $String16
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 12
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 14
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
subu $t5 $t3 $t4
sw $t5 8($fp)
la $a0 $String17
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 111
sw $t1 8($fp)
la $a0 $String18
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 1188
sw $t1 8($fp)
la $a0 $String19
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 -12
sw $t1 8($fp)
la $a0 $String20
li $v0 4
syscall
lw $a0 8($fp)
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
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
mul $t5 $t3 98
addu $t6 $t5 $t4
sw $t6 8($fp)
la $a0 $String21
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $t1 5
sw $t1 0($gp)
li $t1 12
sw $t1 84($fp)
li $t1 104
sw $t1 88($fp)
lw $a0 88($fp)
sw $t3 8($sp)
sw $ra 12($sp)
jal addone
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
li $a0 1
move $a1 $t4
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t5 $v0 0
lw $t6 84($fp)
lw $t2 0($gp)
div $t5 $t2
mflo $t7
addu $t8 $t3 $t7
subu $t9 $t8 $t6
sw $t9 8($fp)
la $a0 $String22
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
jr $ra
jr $ra
test_scanf:
addiu $fp $sp 8
addiu $sp $sp 24
la $a0 $String23
li $v0 4
syscall
li $v0 5
syscall
sw $v0 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
la $a0 $String24
li $v0 4
syscall
li $v0 5
syscall
sw $v0 8($fp)
li $v0 5
syscall
sw $v0 12($fp)
lw $a0 8($fp)
li $v0 1
syscall
lw $a0 12($fp)
li $v0 1
syscall
jr $ra
jr $ra
echo_char:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $a0 8($fp)
li $v0 11
syscall
lw $v0 8($fp)
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
sw $a0 24($sp)
sw $a1 28($sp)
addiu $fp $sp 16
addiu $sp $sp 44
lw $t1 12($fp)
subu $t3 $t1 1
lw $t1 8($fp)
bge $t1 $t3 $Label25
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
lw $t1 8($fp)
addiu $t4 $t1 1
sw $t4 16($fp)
lw $t1 16($fp)
lw $t2 12($fp)
bge $t1 $t2 $Label27
$Label29:
addiu $t1 $gp 252
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
sw $t3 20($fp)
addiu $t1 $gp 252
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t3 252($t0)
lw $t1 20($fp)
lw $t0 16($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 252($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t1 $gp 252
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t4 0($t1)
sw $t4 20($fp)
addiu $t1 $gp 252
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t3 252($t0)
lw $t1 20($fp)
lw $t0 16($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 252($t0)
lw $t1 16($fp)
addiu $t3 $t1 1
sw $t3 16($fp)
lw $t1 16($fp)
lw $t2 12($fp)
blt $t1 $t2 $Label29
j $Label28
$Label27:
$Label28:
j $Label26
$Label25:
li $t1 0
sw $t1 16($fp)
$Label30:
addiu $t1 $gp 252
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
sw $ra 8($sp)
jal echo_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t4 $v0 0
sw $t4 24($fp)
addiu $t1 $gp 252
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t1 24($fp)
beq $t1 $t3 $Label31
la $a0 $String7
li $v0 4
syscall
j $Label32
$Label31:
$Label32:
lw $t1 16($fp)
addiu $t3 $t1 1
sw $t3 16($fp)
lw $t1 16($fp)
blt $t1 5 $Label30
la $a0 $String25
li $v0 4
syscall
$Label26:
jr $ra
main:
addiu $fp $gp 272
addiu $sp $fp 64
li $t1 0
sw $t1 48($fp)
lw $t1 48($fp)
bge $t1 10 $Label33
$Label35:
lw $t1 48($fp)
addiu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t4 $v0 0
lw $t0 48($fp)
sll $t0 $t0 2
addu $t0 $fp $t0
sw $t4 8($t0)
lw $t1 48($fp)
addiu $t3 $t1 1
sw $t3 48($fp)
lw $t1 48($fp)
blt $t1 10 $Label35
j $Label34
$Label33:
$Label34:
la $a0 $String26
li $v0 4
syscall
li $v0 5
syscall
sw $v0 52($fp)
li $v0 5
syscall
sw $v0 56($fp)
lw $t1 52($fp)
subu $t3 $t1 1
sw $t3 48($fp)
$Label36:
la $a0 $String25
li $v0 4
syscall
addiu $t1 $fp 8
lw $t2 48($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 48($fp)
addiu $t3 $t1 1
sw $t3 48($fp)
lw $t1 48($fp)
lw $t2 56($fp)
blt $t1 $t2 $Label36
lw $t1 56($fp)
subu $t3 $t1 1
sw $t3 48($fp)
lw $t1 52($fp)
subu $t3 $t1 1
lw $t1 48($fp)
blt $t1 $t3 $Label37
$Label39:
la $a0 $String25
li $v0 4
syscall
addiu $t1 $fp 8
lw $t2 48($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 48($fp)
subu $t3 $t1 1
sw $t3 48($fp)
lw $t1 52($fp)
subu $t3 $t1 1
lw $t1 48($fp)
bge $t1 $t3 $Label39
j $Label38
$Label37:
$Label38:
li $a0 1
li $a1 98
sw $t3 8($sp)
sw $ra 12($sp)
jal foo1
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 97
li $a1 98
sw $t3 8($sp)
sw $ra 12($sp)
jal addchar
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 70
sw $t3 8($sp)
sw $ra 12($sp)
jal addone
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 16
sw $t3 8($sp)
sw $ra 12($sp)
jal addint
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 99
sw $ra 8($sp)
jal foo2
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 11
syscall
sw $ra 8($sp)
jal test_string_int
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 233
sw $t3 8($sp)
sw $ra 12($sp)
jal test_diff_domain
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
jal test_expr
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal test_all_cond
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal test_scanf
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 97
sw $ra 8($sp)
jal echo_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 1
li $a1 2
li $a2 99
li $a3 100
li $v0 5
sw $v0 -4($gp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal test_lots_paras
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
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
la $a0 $String27
li $v0 4
syscall
li $a0 0
li $a1 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $v0 10
syscall
# End Of MIPS Assembly Code.
