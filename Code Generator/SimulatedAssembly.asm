.data
	$String37:.asciiz "wrongwhile1"
	$String38:.asciiz "wrongwhile2"
	$String39:.asciiz "wrongwhile3"
	$String40:.asciiz "wrong1"
	$String41:.asciiz "wrong2"
	$String42:.asciiz "wrong3"
	$String43:.asciiz "wrong4"
	$String44:.asciiz "wrong5"
	$String45:.asciiz "wrong6"
	$String46:.asciiz "wrong7"
	$String47:.asciiz "wrong8"
	$String48:.asciiz "wrong9"
	$String49:.asciiz "wrong10"
	$String50:.asciiz "wrong11"
	$String51:.asciiz "wrong12"
	$String52:.asciiz "wrongt7t8neq\\n\\t\\r"
	$String53:.asciiz "wrong\\n"
	$String54:.asciiz "right\\n"
.globl main
.text
init:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
add:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 20
addiu $sp $sp 36
addx:
addiu $fp $sp 8
addiu $sp $sp 16
addx1:
addiu $fp $sp 8
addiu $sp $sp 16
tolow:
move $a0 $a0
addiu $fp $sp 16
addiu $sp $sp 32
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
j $Label6
$Label5:
bne $s0 -100 $Label7
li $v0 -100
jr $ra
$Label7:
$Label8:
$Label6:
$Label4:
bne $s0 2 $Label9
li $v0 1
jr $ra
$Label9:
$Label10:
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
testif:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 0($gp)
bne $t1 1 $Label11
li $t1 1
sw $t1 4($gp)
j $Label12
$Label11:
li $t1 2
sw $t1 4($gp)
$Label12:
lw $t1 4($gp)
beq $t1 1 $Label13
li $t1 0
sw $t1 16($gp)
$Label13:
$Label14:
lw $t1 0($gp)
blt $t1 1 $Label15
li $t1 3
sw $t1 4($gp)
j $Label16
$Label15:
li $t1 4
sw $t1 4($gp)
$Label16:
lw $t1 4($gp)
beq $t1 3 $Label17
li $t1 0
sw $t1 16($gp)
$Label17:
$Label18:
lw $t1 0($gp)
addiu $t1 $t1 1
sw $t1 0($gp)
lw $t1 0($gp)
bgt $t1 1 $Label19
li $t1 5
sw $t1 4($gp)
j $Label20
$Label19:
li $t1 6
sw $t1 4($gp)
$Label20:
lw $t1 4($gp)
beq $t1 6 $Label21
li $t1 0
sw $t1 16($gp)
$Label21:
$Label22:
lw $t1 0($gp)
ble $t1 1 $Label23
li $t1 7
sw $t1 4($gp)
j $Label24
$Label23:
li $t1 8
sw $t1 4($gp)
$Label24:
lw $t1 4($gp)
beq $t1 7 $Label25
li $t1 0
sw $t1 16($gp)
$Label25:
$Label26:
lw $t1 0($gp)
bge $t1 0 $Label27
li $t1 9
sw $t1 4($gp)
j $Label28
$Label27:
li $t1 10
sw $t1 4($gp)
$Label28:
lw $t1 4($gp)
beq $t1 10 $Label29
li $t1 0
sw $t1 16($gp)
$Label29:
$Label30:
li $a0 8
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
addiu $fp $sp -8
subu $t1 $v0 1
sw $t1 0($gp)
lw $t1 0($gp)
beq $t1 20 $Label31
li $t1 11
sw $t1 4($gp)
j $Label32
$Label31:
li $t1 12
sw $t1 4($gp)
$Label32:
lw $t1 4($gp)
beq $t1 12 $Label33
li $t1 0
sw $t1 16($gp)
$Label33:
$Label34:
li $t1 2
sw $t1 0($gp)
jr $ra
testcase1:
move $a0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
testcase2:
move $a0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
test_do_while:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
$Label42:
lw $t1 0($gp)
addiu $t1 $t1 1
sw $t1 0($gp)
li $v0 0
$_addx1_1:
lw $t1 0($gp)
blt $t1 5 $Label42
lw $t1 0($gp)
beq $t1 5 $Label43
la $a0 $String37
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label43:
$Label44:
li $t1 3
sw $t1 4($gp)
$Label45:
lw $t1 0($gp)
addiu $t1 $t1 1
sw $t1 0($gp)
lw $t1 0($gp)
blt $t1 8 $Label45
lw $t1 0($gp)
beq $t1 8 $Label46
li $t1 0
sw $t1 16($gp)
$Label46:
$Label47:
$Label48:
$Label49:
lw $t1 0($gp)
subu $t1 $t1 1
sw $t1 0($gp)
lw $t1 0($gp)
bge $t1 0 $Label49
lw $t1 4($gp)
subu $t1 $t1 1
sw $t1 4($gp)
lw $t1 4($gp)
bge $t1 1 $Label48
lw $t1 0($gp)
beq $t1 -3 $Label50
la $a0 $String38
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label50:
$Label51:
lw $t1 4($gp)
beq $t1 0 $Label52
la $a0 $String39
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label52:
$Label53:
jr $ra
main:
li $k1 268501156
addiu $fp $gp 20
addiu $sp $fp 832
li $t1 1
sw $t1 16($gp)
li $s1 97
move $a0 $s1
addiu $a1 $a0 0
move $v0 $a1
$_tolow_1:
sw $v0 468($fp)
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
addiu $fp $sp -832
sw $v0 56($fp)
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
addiu $fp $sp -832
addiu $s4 $v0 0
lw $t3 468($fp)
lw $t4 56($fp)
mul $t5 $t4 -1
mul $t6 $t5 $s4
addu $t7 $t3 $t6
div $t8 $t7 2
subu $t9 $t8 48
addiu $t1 $t9 123
sw $t1 -4($sp)
lw $t1 -4($sp)
beq $t1 118 $Label54
la $a0 $String40
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
j $Label55
$Label54:
li $a0 48
addiu $a1 $a0 0
move $v0 $a1
$_tolow_1_2:
addiu $t4 $v0 -909
beq $t4 -861 $Label56
la $a0 $String41
li $v0 4
syscall
li $a0 48
addiu $a1 $a0 0
move $v0 $a1
$_tolow_1_2_3:
addiu $t4 $v0 -909
move $a0 $t4
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label56:
$Label57:
$Label55:
li $a0 2
sw $a0 0($gp)
j $_init_1
$_init_1:
lw $t1 0($gp)
beq $t1 2 $Label58
la $a0 $String42
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label58:
$Label59:
lw $t3 56($fp)
li $a0 3
move $a1 $t3
sw $t3 8($sp)
addu $t3 $a0 $a1
move $v0 $t3
lw $t3 8($sp)
$_add_1:
beq $v0 8 $Label60
la $a0 $String43
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
j $Label61
$Label60:
li $a0 10
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
addiu $fp $sp -832
beq $v0 55 $Label62
la $a0 $String44
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label62:
$Label63:
$Label61:
move $a0 $s1
addiu $a1 $a0 0
move $v0 $a1
$_tolow_1_2_3_4:
addiu $t3 $v0 0
li $a0 -2
li $a1 4
sw $t3 8($sp)
addu $t3 $a0 $a1
move $v0 $t3
lw $t3 8($sp)
$_add_1_2:
addiu $t4 $v0 0
move $a0 $t4
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
addiu $fp $sp -832
addu $t1 $t3 $v0
sw $t1 0($gp)
lw $t1 0($gp)
addiu $t1 $t1 1
sw $t1 0($gp)
lw $t1 0($gp)
beq $t1 99 $Label1_1
li $v0 -100
j $_addx_1
j $Label2_1
$Label1_1:
li $v0 100
$Label2_1:
$_addx_1:
beq $v0 100 $Label64
la $a0 $String45
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label64:
$Label65:
li $t1 1
sw $t1 0($gp)
sw $ra 8($sp)
jal testif
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -832
lw $a0 0($gp)
sw $t3 8($sp)
beq $a0 1 $Label36_1
beq $a0 2 $Label37_1
li $v0 3
lw $t3 8($sp)
j $_testcase1_1
j $Label35_1
$Label36_1:
li $v0 1
lw $t3 8($sp)
j $_testcase1_1
j $Label35_1
$Label37_1:
li $v0 2
lw $t3 8($sp)
j $_testcase1_1
$Label35_1:
$_testcase1_1:
beq $v0 2 $Label66
la $a0 $String46
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label66:
$Label67:
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
addiu $fp $sp -832
addiu $t3 $v0 0
li $a0 1
sw $t3 8($sp)
beq $a0 1 $Label36_1_2
beq $a0 2 $Label37_1_2
li $v0 3
lw $t3 8($sp)
j $_testcase1_1_2
j $Label35_1_2
$Label36_1_2:
li $v0 1
lw $t3 8($sp)
j $_testcase1_1_2
j $Label35_1_2
$Label37_1_2:
li $v0 2
lw $t3 8($sp)
j $_testcase1_1_2
$Label35_1_2:
$_testcase1_1_2:
subu $t5 $t3 $v0
move $a0 $t5
li $a1 1
sw $t3 8($sp)
addu $t3 $a0 $a1
move $v0 $t3
lw $t3 8($sp)
$_add_1_2_3:
sw $v0 0($gp)
lw $t1 0($gp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
beq $a0 1 $Label36_1_2_3
beq $a0 2 $Label37_1_2_3
li $v0 3
lw $t3 8($sp)
j $_testcase1_1_2_3
j $Label35_1_2_3
$Label36_1_2_3:
li $v0 1
lw $t3 8($sp)
j $_testcase1_1_2_3
j $Label35_1_2_3
$Label37_1_2_3:
li $v0 2
lw $t3 8($sp)
j $_testcase1_1_2_3
$Label35_1_2_3:
$_testcase1_1_2_3:
beq $v0 1 $Label68
la $a0 $String47
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label68:
$Label69:
li $t1 -1
sw $t1 0($gp)
lw $a0 0($gp)
sw $t3 8($sp)
beq $a0 1 $Label36_1_2_3_4
beq $a0 2 $Label37_1_2_3_4
li $v0 3
lw $t3 8($sp)
j $_testcase1_1_2_3_4
j $Label35_1_2_3_4
$Label36_1_2_3_4:
li $v0 1
lw $t3 8($sp)
j $_testcase1_1_2_3_4
j $Label35_1_2_3_4
$Label37_1_2_3_4:
li $v0 2
lw $t3 8($sp)
j $_testcase1_1_2_3_4
$Label35_1_2_3_4:
$_testcase1_1_2_3_4:
addiu $t3 $v0 0
lw $t4 56($fp)
li $a0 6
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
addiu $fp $sp -832
addiu $t5 $v0 0
li $t0 0
subu $t6 $t0 $t4
addu $t7 $t6 $t5
beq $t3 $t7 $Label70
la $a0 $String48
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label70:
$Label71:
li $t1 0
sw $t1 0($gp)
lw $a0 0($gp)
sw $ra 8($sp)
jal test_do_while
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -832
li $v0 5
syscall
move $s3 $v0
li $v0 5
syscall
move $s2 $v0
subu $t3 $s3 1
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
addiu $fp $sp -832
addu $t5 $v0 $s2
beq $t5 5 $Label72
la $a0 $String49
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label72:
$Label73:
li $s0 97
move $a0 $s0
beq $a0 97 $Label40_1
li $v0 2
j $_testcase2_1
j $Label39_1
$Label40_1:
li $v0 1
j $_testcase2_1
$Label39_1:
$_testcase2_1:
li $t0 0
subu $t4 $t0 $v0
move $a0 $s2
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
addiu $fp $sp -832
li $t0 0
subu $t6 $t0 $v0
beq $t4 $t6 $Label74
la $a0 $String50
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label74:
$Label75:
li $s0 98
move $a0 $s0
beq $a0 97 $Label40_1_2
li $v0 2
j $_testcase2_1_2
j $Label39_1_2
$Label40_1_2:
li $v0 1
j $_testcase2_1_2
$Label39_1_2:
$_testcase2_1_2:
beq $v0 $s2 $Label76
la $a0 $String51
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 16($gp)
$Label76:
$Label77:
li $v0 12
syscall
move $s0 $v0
li $v0 12
syscall
move $s1 $v0
subu $t3 $s0 0
addiu $t4 $s1 97
subu $t5 $t4 97
beq $t3 $t5 $Label78
la $a0 $String52
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label78:
$Label79:
lw $t1 16($gp)
bne $t1 0 $Label80
la $a0 $String53
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label81
$Label80:
la $a0 $String54
li $v0 4
syscall
lw $a0 0($gp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
$Label81:
# End Of MIPS Assembly Code.
