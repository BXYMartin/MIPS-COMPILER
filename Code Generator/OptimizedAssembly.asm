.data
	$String4:.asciiz " "
	$String5:.asciiz "\\n"
	$String6:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
move $s1 $a0
move $s2 $a1
addiu $sp $sp 12
addiu $t3 $s1 0
addiu $t4 $s4 0
bne $t3 $t4 $Label1
addiu $t1 $gp 8
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $s0 1
addiu $t3 $s0 0
addiu $t4 $s4 0
bge $t3 $t4 $Label3
$Label5:
la $a0 $String4
li $v0 4
syscall
addiu $t3 $s0 0
addiu $t1 $gp 8
sll $t2 $t3 2
addu $t1 $t1 $t2
lw $t4 0($t1)
move $a0 $t4
li $v0 1
syscall
addiu $t3 $s0 0
addiu $s0 $t3 1
addiu $t3 $s0 0
addiu $t4 $s4 0
blt $t3 $t4 $Label5
$Label3:
$Label4:
la $a0 $String5
li $v0 4
syscall
jr $ra
$Label1:
$Label2:
addiu $s0 $s2 0
addiu $t3 $s0 0
addiu $t4 $s1 0
addiu $t5 $s3 0
addiu $t6 $s4 0
addu $t7 $t4 $t5
subu $t8 $t7 $t6
addiu $t9 $t8 1
bgt $t3 $t9 $Label6
$Label8:
addiu $t3 $s1 0
addiu $t0 $gp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t3 $s1 0
addiu $t4 $t3 1
addiu $t5 $s0 0
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
sw $s0 36($sp)
sw $s1 40($sp)
sw $s2 44($sp)
sw $ra 48($sp)
sw $fp 52($sp)
addiu $sp $sp 56
addiu $fp $sp -8
jal recursive_cal
move $sp $fp
addiu $sp $sp -48
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
lw $s1 40($sp)
lw $s2 44($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t7 $s0 0
addiu $s0 $t7 1
addiu $t3 $s0 0
addiu $t4 $s1 0
addiu $t5 $s3 0
addiu $t6 $s4 0
addu $t7 $t4 $t5
subu $t8 $t7 $t6
addiu $t9 $t8 1
ble $t3 $t9 $Label8
$Label6:
$Label7:
jr $ra
initial:
move $s2 $a0
move $s1 $a1
addiu $sp $sp 12
li $s0 0
$Label9:
addiu $t3 $s0 0
addiu $t0 $gp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $s2 0
sw $t1 0($t0)
addiu $t3 $s0 0
addiu $s0 $t3 1
addiu $t3 $s0 0
addiu $t4 $s1 0
ble $t3 $t4 $Label9
jr $ra
main:
li $k1 268501008
addiu $fp $gp 4008
addiu $sp $fp 8
addiu $sp $sp 8
li $v0 5
syscall
move $s3 $v0
li $v0 5
syscall
move $s4 $v0
addiu $t3 $s4 0
addiu $t4 $t3 1
ble $t4 1000 $Label10
la $a0 $String6
li $v0 4
syscall
li $v0 10
syscall
$Label10:
$Label11:
addiu $t3 $s4 0
addiu $t4 $t3 1
li $a0 0
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $s2 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal initial
move $sp $fp
addiu $sp $sp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $s2 24($sp)
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
sw $s0 36($sp)
sw $s1 40($sp)
sw $s2 44($sp)
sw $ra 48($sp)
sw $fp 52($sp)
addiu $sp $sp 56
addiu $fp $sp -8
jal recursive_cal
move $sp $fp
addiu $sp $sp -48
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
lw $s1 40($sp)
lw $s2 44($sp)
lw $ra 0($fp)
lw $fp 4($fp)
# End Of MIPS Assembly Code.
