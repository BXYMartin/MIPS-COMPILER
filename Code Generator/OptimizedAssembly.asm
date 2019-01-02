.data
.globl main
.text
par2:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 24
addiu $sp $sp 40
par3:
move $a0 $a0
move $a1 $a1
move $a2 $a2
addiu $fp $sp 32
addiu $sp $sp 52
par4:
move $a0 $a0
move $a1 $a1
move $a2 $a2
move $a3 $a3
addiu $fp $sp 40
addiu $sp $sp 64
par5:
move $s0 $a0
move $s1 $a1
move $s2 $a2
move $s3 $a3
lw $s4 0($k1)
addiu $fp $sp 48
addiu $sp $sp 76
mul $t3 $s0 5
addu $t4 $t3 $s1
addu $t5 $t4 $s2
addu $t6 $t5 $s3
subu $t7 $t6 $s4
move $v0 $t7
jr $ra
par10:
sw $a0 60($sp)
move $s1 $a1
move $s2 $a2
move $s3 $a3
lw $s4 0($k1)
lw $s5 4($k1)
lw $s6 8($k1)
lw $s7 12($k1)
lw $v1 16($k1)
sw $v1 92($sp)
lw $s0 20($k1)
addiu $fp $sp 52
addiu $sp $sp 112
lw $t1 8($fp)
addu $t3 $t1 $s1
addu $t4 $t3 $s2
addu $t5 $t4 $s3
addu $t6 $t5 $s4
addu $t7 $t6 $s5
addu $t8 $t7 $s6
addu $t9 $t8 $s7
lw $t1 40($fp)
mul $t1 $t1 $s0
sw $t1 -12($sp)
lw $t2 -12($sp)
addu $t1 $t9 $t2
sw $t1 -8($sp)
lw $t1 -8($sp)
subu $t1 $t1 $s0
sw $t1 -4($sp)
lw $v0 -4($sp)
jr $ra
main:
li $k1 268500996
addiu $fp $gp 0
addiu $sp $fp 20
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
mul $t3 $a0 2
addu $t4 $t3 $a1
move $v0 $t4
lw $t3 8($sp)
lw $t4 12($sp)
$_par2_1:
addiu $t3 $v0 0
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
mul $t3 $a0 2
addu $t4 $t3 $a1
move $v0 $t4
lw $t3 8($sp)
lw $t4 12($sp)
$_par2_1_2:
addiu $t5 $v0 1
li $a0 1
li $a1 1
li $a2 1
li $a3 1
li $v0 1
sw $v0 0($k1)
li $v0 1
sw $v0 4($k1)
li $v0 1
sw $v0 8($k1)
li $v0 1
sw $v0 12($k1)
li $v0 -1
sw $v0 16($k1)
li $v0 -1
sw $v0 20($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $s2 28($sp)
sw $s3 32($sp)
sw $s4 36($sp)
sw $s5 40($sp)
sw $s6 44($sp)
sw $s7 48($sp)
sw $ra 52($sp)
jal par10
addiu $sp $fp -52
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $s2 28($sp)
lw $s3 32($sp)
lw $s4 36($sp)
lw $s5 40($sp)
lw $s6 44($sp)
lw $s7 48($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t6 $v0 0
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
mul $t3 $a0 2
addu $t4 $t3 $a1
move $v0 $t4
lw $t3 8($sp)
lw $t4 12($sp)
$_par2_1_2_3:
addiu $t7 $v0 0
li $a0 1
li $a1 1
li $a2 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
mul $t3 $a0 3
addu $t4 $t3 $a1
addu $t5 $t4 $a2
move $v0 $t5
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
$_par3_1:
addiu $t8 $v0 0
li $a0 1
li $a1 1
li $a2 1
move $a3 $t8
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
mul $t3 $a0 4
addu $t4 $t3 $a1
addu $t5 $t4 $a2
addu $t6 $t5 $a3
move $v0 $t6
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
$_par4_1:
mul $t1 $v0 -1
sw $t1 -8($sp)
move $a0 $t3
move $a1 $t5
move $a2 $t6
move $a3 $t7
lw $v0 -8($sp)
sw $v0 0($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $s1 32($sp)
sw $s2 36($sp)
sw $s3 40($sp)
sw $s4 44($sp)
sw $ra 48($sp)
jal par5
addiu $sp $fp -48
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $s1 32($sp)
lw $s2 36($sp)
lw $s3 40($sp)
lw $s4 44($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s0 $v0 0
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
