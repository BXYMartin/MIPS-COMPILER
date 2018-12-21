.data
	$String1:.asciiz " "
	$String2:.asciiz "\\n"
	$String3:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
lw $t1 8($fp)
addiu $t3 $t1 0
lw $t1 4($gp)
addiu $t4 $t1 0
bne $t3 $t4 $Label1
addiu $t1 $gp 8
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $t0 $fp 16
li $t1 1
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 4($gp)
addiu $t4 $t1 0
bge $t3 $t4 $Label3
$Label5:
la $a0 $String1
li $v0 4
syscall
lw $t1 16($fp)
addiu $t3 $t1 0
addiu $t1 $gp 8
sll $t2 $t3 2
addu $t1 $t1 $t2
lw $t4 0($t1)
move $a0 $t4
li $v0 1
syscall
lw $t1 16($fp)
addiu $t3 $t1 0
addiu $t4 $t3 1
addiu $t0 $fp 16
addiu $t1 $t4 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 4($gp)
addiu $t4 $t1 0
blt $t3 $t4 $Label5
j $Label4
$Label3:
$Label4:
la $a0 $String2
li $v0 4
syscall
jr $ra
j $Label2
$Label1:
$Label2:
lw $t1 12($fp)
addiu $t3 $t1 0
addiu $t0 $fp 16
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 8($fp)
addiu $t4 $t1 0
lw $t1 0($gp)
addiu $t5 $t1 0
lw $t1 4($gp)
addiu $t6 $t1 0
addu $t7 $t4 $t5
subu $t8 $t7 $t6
addiu $t9 $t8 1
bgt $t3 $t9 $Label6
$Label8:
lw $t1 8($fp)
addiu $t3 $t1 0
lw $t1 16($fp)
addiu $t4 $t1 0
addiu $t0 $gp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $t4 0
sw $t1 0($t0)
lw $t1 8($fp)
addiu $t3 $t1 0
addiu $t4 $t3 1
lw $t1 16($fp)
addiu $t5 $t1 0
addiu $t6 $t5 1
move $a0 $t4
move $a1 $t6
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal recursive_cal
move $sp $fp
addiu $sp $sp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
lw $t1 16($fp)
addiu $t7 $t1 0
addiu $t8 $t7 1
addiu $t0 $fp 16
addiu $t1 $t8 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 8($fp)
addiu $t4 $t1 0
lw $t1 0($gp)
addiu $t5 $t1 0
lw $t1 4($gp)
addiu $t6 $t1 0
addu $t7 $t4 $t5
subu $t8 $t7 $t6
addiu $t9 $t8 1
ble $t3 $t9 $Label8
j $Label7
$Label6:
$Label7:
jr $ra
initial:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
$Label9:
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 8($fp)
addiu $t4 $t1 0
addiu $t0 $gp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $t4 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
addiu $t4 $t3 1
addiu $t0 $fp 16
addiu $t1 $t4 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 0
lw $t1 12($fp)
addiu $t4 $t1 0
ble $t3 $t4 $Label9
jr $ra
jr $ra
main:
li $k1 268501012
addiu $fp $gp 4008
addiu $sp $fp 8
addiu $sp $sp 8
li $v0 5
syscall
addiu $a3 $gp 0
sw $v0 0($a3)
li $v0 5
syscall
addiu $a3 $gp 4
sw $v0 0($a3)
lw $t1 4($gp)
addiu $t3 $t1 0
addiu $t4 $t3 1
ble $t4 1000 $Label10
la $a0 $String3
li $v0 4
syscall
li $v0 10
syscall
j $Label11
$Label10:
$Label11:
lw $t1 4($gp)
addiu $t3 $t1 0
addiu $t4 $t3 1
li $a0 0
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal initial
move $sp $fp
addiu $sp $sp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 0
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal recursive_cal
move $sp $fp
addiu $sp $sp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
# End Of MIPS Assembly Code.
