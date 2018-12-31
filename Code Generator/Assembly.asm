.data
	$String1:.asciiz "cat"
	$String2:.asciiz "apple"
	$String3:.asciiz "ali"
	$String4:.asciiz "boy"
	$String5:.asciiz "<"
	$String6:.asciiz "<="
	$String7:.asciiz ">"
	$String8:.asciiz ">="
	$String9:.asciiz "!="
	$String10:.asciiz "=="
	$String11:.asciiz "The result is "
	$String12:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String13:.asciiz "Please input 1~6"
	$String14:.asciiz "test_if"
	$String15:.asciiz "test_factorial"
	$String16:.asciiz "test_while"
	$String17:.asciiz "test_switch_char"
	$String18:.asciiz "test_relation"
	$String19:.asciiz "test_expression"
.globl main
.text
test_if:
sw $a0 16($sp)
sw $a1 20($sp)
addiu $fp $sp 8
addiu $sp $sp 24
lw $t1 8($fp)
lw $t2 12($fp)
blt $t1 $t2 $Label1
li $v0 97
jr $ra
j $Label2
$Label1:
li $v0 98
jr $ra
$Label2:
test_factorial:
sw $a0 24($sp)
addiu $fp $sp 16
addiu $sp $sp 28
lw $t1 8($fp)
bne $t1 0 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
move $v0 $t4
jr $ra
$Label4:
test_while:
addiu $fp $sp 12
addiu $sp $sp 24
li $t1 3
sw $t1 8($fp)
$Label5:
lw $t1 8($fp)
subu $t3 $t1 1
sw $t3 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $t1 8($fp)
bne $t1 0 $Label5
li $v0 666
jr $ra
test_switch_char:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $t1 8($fp)
beq $t1 97 $Label7
lw $t1 8($fp)
beq $t1 98 $Label8
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label6
$Label7:
la $a0 $String2
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String3
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label6
$Label8:
la $a0 $String4
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label6
$Label6:
jr $ra
test_relation:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $t1 8($fp)
bge $t1 3 $Label10
la $a0 $String5
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label11
$Label10:
$Label11:
lw $t1 8($fp)
bgt $t1 4 $Label12
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label13
$Label12:
$Label13:
lw $t1 8($fp)
ble $t1 5 $Label14
la $a0 $String7
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label15
$Label14:
$Label15:
lw $t1 8($fp)
blt $t1 6 $Label16
la $a0 $String8
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label17
$Label16:
$Label17:
lw $t1 8($fp)
beq $t1 7 $Label18
la $a0 $String9
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label19
$Label18:
$Label19:
lw $t1 8($fp)
bne $t1 8 $Label20
la $a0 $String10
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label21
$Label20:
$Label21:
jr $ra
test_expression:
addiu $fp $sp 36
addiu $sp $sp 48
li $t1 3
sw $t1 8($gp)
lw $t3 8($gp)
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
li $t0 -1
subu $t5 $t0 $t3
addiu $t6 $t5 5
addiu $t7 $t6 97
addu $t8 $t7 $t4
addiu $t9 $t8 -3
sw $t9 8($fp)
la $a0 $String11
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String12
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
main:
li $k1 268501240
addiu $fp $gp 1232
addiu $sp $fp 28
li $v0 5
syscall
sw $v0 24($fp)
lw $t1 24($fp)
beq $t1 1 $Label23
lw $t1 24($fp)
beq $t1 2 $Label24
lw $t1 24($fp)
beq $t1 3 $Label25
lw $t1 24($fp)
beq $t1 4 $Label26
lw $t1 24($fp)
beq $t1 5 $Label27
lw $t1 24($fp)
beq $t1 6 $Label28
la $a0 $String13
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label23:
la $a0 $String14
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
sw $v0 0($gp)
li $v0 5
syscall
sw $v0 4($gp)
lw $a0 0($gp)
lw $a1 4($gp)
sw $ra 8($sp)
jal test_if
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t3 $v0 0
sw $t3 12($fp)
lw $a0 12($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $a0 4($gp)
lw $a1 0($gp)
sw $ra 8($sp)
jal test_if
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t3 $v0 0
sw $t3 12($fp)
lw $a0 12($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label24:
la $a0 $String15
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
sw $v0 0($gp)
lw $a0 0($gp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t3 $v0 0
sw $t3 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label25:
la $a0 $String16
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
sw $t3 8($sp)
sw $ra 12($sp)
jal test_while
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t3 $v0 0
sw $t3 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label26:
la $a0 $String17
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
sw $ra 8($sp)
jal test_switch_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
sw $ra 8($sp)
jal test_switch_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
sw $ra 8($sp)
jal test_switch_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
j $Label22
$Label27:
la $a0 $String18
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
sw $v0 0($gp)
lw $a0 0($gp)
sw $ra 8($sp)
jal test_relation
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
li $v0 5
syscall
sw $v0 0($gp)
lw $a0 0($gp)
sw $ra 8($sp)
jal test_relation
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
j $Label22
$Label28:
la $a0 $String19
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
jal test_expression
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
addiu $fp $sp -28
j $Label22
$Label22:
li $v0 10
syscall
# End Of MIPS Assembly Code.
