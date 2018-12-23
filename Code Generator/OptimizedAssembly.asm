.data
	$String4:.asciiz " "
	$String5:.asciiz "\\n"
	$String6:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
move $s1 $a0
sw $a1 48($sp)
addiu $fp $sp 36
addiu $sp $sp 56
addiu $t3 $s3 0
bne $s1 $t3 $Label1
lw $t3 8($gp)
move $a0 $t3
li $v0 1
syscall
li $s0 1
addiu $t3 $s3 0
bge $s0 $t3 $Label3
$Label5:
la $a0 $String4
li $v0 4
syscall
addiu $t1 $gp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $s0 $s0 1
addiu $t3 $s3 0
blt $s0 $t3 $Label5
$Label3:
$Label4:
la $a0 $String5
li $v0 4
syscall
jr $ra
$Label1:
$Label2:
lw $t1 12($fp)
addiu $s0 $t1 0
addiu $t3 $s2 0
addiu $t4 $s3 0
addu $t5 $s1 $t3
subu $t6 $t5 $t4
addiu $t7 $t6 1
bgt $s0 $t7 $Label6
$Label8:
addiu $t1 $s0 0
sll $t0 $s1 2
addu $t0 $gp $t0
sw $t1 8($t0)
addiu $t3 $s1 1
addiu $t4 $s0 1
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $s1 32($sp)
sw $ra 36($sp)
jal recursive_cal
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $s1 32($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s0 $s0 1
addiu $t3 $s2 0
addiu $t4 $s3 0
addu $t5 $s1 $t3
subu $t6 $t5 $t4
addiu $t7 $t6 1
ble $s0 $t7 $Label8
$Label6:
$Label7:
jr $ra
initial:
sw $a0 24($sp)
move $s1 $a1
addiu $fp $sp 16
addiu $sp $sp 36
li $s0 0
$Label9:
lw $t1 8($fp)
addiu $t1 $t1 0
sll $t0 $s0 2
addu $t0 $gp $t0
sw $t1 8($t0)
addiu $s0 $s0 1
ble $s0 $s1 $Label9
jr $ra
main:
li $k1 268501008
addiu $fp $gp 4008
addiu $sp $fp 16
li $v0 5
syscall
move $s2 $v0
li $v0 5
syscall
move $s3 $v0
addiu $t3 $s3 0
addiu $t4 $t3 1
ble $t4 1000 $Label10
la $a0 $String6
li $v0 4
syscall
li $v0 10
syscall
$Label10:
$Label11:
addiu $t3 $s3 0
addiu $t4 $t3 1
li $a0 0
move $a1 $t4
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal initial
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -16
li $a0 0
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $s1 32($sp)
sw $ra 36($sp)
jal recursive_cal
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $s1 32($sp)
lw $ra 0($fp)
addiu $fp $sp -16
# End Of MIPS Assembly Code.
