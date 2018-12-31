.data
	$String20:.asciiz "The result is "
	$String21:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String22:.asciiz "Please input 1~6"
	$String23:.asciiz "test_if"
	$String24:.asciiz "test_factorial"
	$String25:.asciiz "test_while"
	$String26:.asciiz "test_switch_char"
	$String27:.asciiz "cat"
	$String28:.asciiz "apple"
	$String29:.asciiz "ali"
	$String30:.asciiz "boy"
	$String31:.asciiz "test_relation"
	$String32:.asciiz "<"
	$String33:.asciiz "<="
	$String34:.asciiz ">"
	$String35:.asciiz ">="
	$String36:.asciiz "!="
	$String37:.asciiz "=="
	$String38:.asciiz "test_expression"
.globl main
.text
test_if:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
test_factorial:
move $s0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
bne $s0 0 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
subu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
move $v0 $t4
jr $ra
$Label4:
test_while:
addiu $fp $sp 12
addiu $sp $sp 24
test_switch_char:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
test_relation:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
test_expression:
addiu $fp $sp 12
addiu $sp $sp 24
li $t1 3
sw $t1 8($gp)
lw $t3 8($gp)
li $a0 3
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
li $t0 -1
subu $t5 $t0 $t3
addiu $t6 $t5 5
addiu $t7 $t6 97
addu $t8 $t7 $t4
addiu $s0 $t8 -3
la $a0 $String20
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String21
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
main:
li $k1 268501236
addiu $fp $gp 1232
addiu $sp $fp 28
li $v0 5
syscall
move $s2 $v0
beq $s2 1 $Label23
beq $s2 2 $Label24
beq $s2 3 $Label25
beq $s2 4 $Label26
beq $s2 5 $Label27
beq $s2 6 $Label28
la $a0 $String22
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label23:
la $a0 $String23
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
blt $a0 $a1 $Label1_1
li $v0 97
j $_test_if_1
j $Label2_1
$Label1_1:
li $v0 98
$Label2_1:
$_test_if_1:
addiu $s1 $v0 0
move $a0 $s1
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $a0 4($gp)
lw $a1 0($gp)
blt $a0 $a1 $Label1_1_2
li $v0 97
j $_test_if_1_2
j $Label2_1_2
$Label1_1_2:
li $v0 98
$Label2_1_2:
$_test_if_1_2:
addiu $s1 $v0 0
move $a0 $s1
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label24:
la $a0 $String24
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
sw $s0 12($sp)
sw $ra 16($sp)
jal test_factorial
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $s0 $v0 0
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label25:
la $a0 $String25
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $a0 3
$Label5_1:
subu $a0 $a0 1
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
bne $a0 0 $Label5_1
li $v0 666
$_test_while_1:
addiu $s0 $v0 0
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label22
$Label26:
la $a0 $String26
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
beq $a0 97 $Label7_1
beq $a0 98 $Label8_1
move $k0 $a0
la $a0 $String27
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1
$Label7_1:
move $k0 $a0
la $a0 $String28
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String29
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1
$Label8_1:
move $k0 $a0
la $a0 $String30
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label6_1:
$_test_switch_char_1:
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
beq $a0 97 $Label7_1_2
beq $a0 98 $Label8_1_2
move $k0 $a0
la $a0 $String27
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1_2
$Label7_1_2:
move $k0 $a0
la $a0 $String28
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String29
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1_2
$Label8_1_2:
move $k0 $a0
la $a0 $String30
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label6_1_2:
$_test_switch_char_1_2:
li $v0 12
syscall
sw $v0 816($gp)
lw $a0 816($gp)
beq $a0 97 $Label7_1_2_3
beq $a0 98 $Label8_1_2_3
move $k0 $a0
la $a0 $String27
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1_2_3
$Label7_1_2_3:
move $k0 $a0
la $a0 $String28
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
move $k0 $a0
la $a0 $String29
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
j $Label6_1_2_3
$Label8_1_2_3:
move $k0 $a0
la $a0 $String30
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label6_1_2_3:
$_test_switch_char_1_2_3:
j $Label22
$Label27:
la $a0 $String31
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
sw $v0 0($gp)
lw $a0 0($gp)
bge $a0 3 $Label10_1
move $k0 $a0
la $a0 $String32
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label10_1:
$Label11_1:
bgt $a0 4 $Label12_1
move $k0 $a0
la $a0 $String33
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label12_1:
$Label13_1:
ble $a0 5 $Label14_1
move $k0 $a0
la $a0 $String34
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label14_1:
$Label15_1:
blt $a0 6 $Label16_1
move $k0 $a0
la $a0 $String35
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label16_1:
$Label17_1:
beq $a0 7 $Label18_1
move $k0 $a0
la $a0 $String36
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label18_1:
$Label19_1:
bne $a0 8 $Label20_1
move $k0 $a0
la $a0 $String37
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label20_1:
$Label21_1:
$_test_relation_1:
li $v0 5
syscall
sw $v0 0($gp)
lw $a0 0($gp)
bge $a0 3 $Label10_1_2
move $k0 $a0
la $a0 $String32
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label10_1_2:
$Label11_1_2:
bgt $a0 4 $Label12_1_2
move $k0 $a0
la $a0 $String33
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label12_1_2:
$Label13_1_2:
ble $a0 5 $Label14_1_2
move $k0 $a0
la $a0 $String34
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label14_1_2:
$Label15_1_2:
blt $a0 6 $Label16_1_2
move $k0 $a0
la $a0 $String35
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label16_1_2:
$Label17_1_2:
beq $a0 7 $Label18_1_2
move $k0 $a0
la $a0 $String36
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label18_1_2:
$Label19_1_2:
bne $a0 8 $Label20_1_2
move $k0 $a0
la $a0 $String37
li $v0 4
syscall
move $a0 $k0
move $k0 $a0
li $a0 10
li $v0 11
syscall
move $a0 $k0
$Label20_1_2:
$Label21_1_2:
$_test_relation_1_2:
j $Label22
$Label28:
la $a0 $String38
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
sw $s0 8($sp)
sw $ra 12($sp)
jal test_expression
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -28
$Label22:
li $v0 10
syscall
# End Of MIPS Assembly Code.
