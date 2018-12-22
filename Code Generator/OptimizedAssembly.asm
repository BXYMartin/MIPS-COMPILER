.data
	$String4:.asciiz " "
	$String5:.asciiz "\\n"
	$String6:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
move $s1 $a0
sw $a1 40($sp)
addiu $fp $sp 28
addiu $sp $sp 48
bne $s1 $s3 $Label1
addiu $t1 $gp 8
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $s0 1
bge $s0 $s3 $Label3
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
blt $s0 $s3 $Label5
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
addu $t3 $s1 $s2
subu $t4 $t3 $s3
addiu $t5 $t4 1
bgt $s0 $t5 $Label6
$Label8:
addiu $t0 $gp 8
sll $t1 $s1 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t3 $s1 1
addiu $t4 $s0 1
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
jal recursive_cal
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s0 $s0 1
addu $t3 $s1 $s2
subu $t4 $t3 $s3
addiu $t5 $t4 1
ble $s0 $t5 $Label8
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
addiu $t0 $gp 8
sll $t1 $s0 2
addu $t0 $t0 $t1
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
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
addiu $t3 $s3 1
ble $t3 1000 $Label10
la $a0 $String6
li $v0 4
syscall
li $v0 10
syscall
$Label10:
$Label11:
addiu $t3 $s3 1
li $a0 0
move $a1 $t3
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
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
jal recursive_cal
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $ra 0($fp)
addiu $fp $sp -16
# End Of MIPS Assembly Code.
