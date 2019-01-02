.data
.globl main
.text
par2:
sw $a0 24($sp)
sw $a1 28($sp)
addiu $fp $sp 16
addiu $sp $sp 32
lw $t2 8($fp)
mul $t3 $t2 2
lw $t2 12($fp)
addu $t4 $t3 $t2
move $v0 $t4
jr $ra
par3:
sw $a0 28($sp)
sw $a1 32($sp)
sw $a2 36($sp)
addiu $fp $sp 20
addiu $sp $sp 40
lw $t2 8($fp)
mul $t3 $t2 3
lw $t2 12($fp)
addu $t4 $t3 $t2
lw $t2 16($fp)
addu $t5 $t4 $t2
move $v0 $t5
jr $ra
par4:
sw $a0 32($sp)
sw $a1 36($sp)
sw $a2 40($sp)
sw $a3 44($sp)
addiu $fp $sp 24
addiu $sp $sp 48
lw $t2 8($fp)
mul $t3 $t2 4
lw $t2 12($fp)
addu $t4 $t3 $t2
lw $t2 16($fp)
addu $t5 $t4 $t2
lw $t2 20($fp)
addu $t6 $t5 $t2
move $v0 $t6
jr $ra
par5:
sw $a0 36($sp)
sw $a1 40($sp)
sw $a2 44($sp)
sw $a3 48($sp)
lw $v1 0($k1)
sw $v1 52($sp)
addiu $fp $sp 28
addiu $sp $sp 56
lw $t2 8($fp)
mul $t3 $t2 5
lw $t2 12($fp)
addu $t4 $t3 $t2
lw $t2 16($fp)
addu $t5 $t4 $t2
lw $t2 20($fp)
addu $t6 $t5 $t2
lw $t2 24($fp)
subu $t7 $t6 $t2
move $v0 $t7
jr $ra
par10:
sw $a0 44($sp)
sw $a1 48($sp)
sw $a2 52($sp)
sw $a3 56($sp)
lw $v1 0($k1)
sw $v1 60($sp)
lw $v1 4($k1)
sw $v1 64($sp)
lw $v1 8($k1)
sw $v1 68($sp)
lw $v1 12($k1)
sw $v1 72($sp)
lw $v1 16($k1)
sw $v1 76($sp)
lw $v1 20($k1)
sw $v1 80($sp)
addiu $fp $sp 36
addiu $sp $sp 96
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
addu $t5 $t4 $t2
lw $t2 24($fp)
addu $t6 $t5 $t2
lw $t2 28($fp)
addu $t7 $t6 $t2
lw $t2 32($fp)
addu $t8 $t7 $t2
lw $t2 36($fp)
addu $t9 $t8 $t2
lw $t1 40($fp)
lw $t2 44($fp)
mul $t1 $t1 $t2
sw $t1 -12($sp)
lw $t2 -12($sp)
addu $t1 $t9 $t2
sw $t1 -8($sp)
lw $t1 -8($sp)
lw $t2 44($fp)
subu $t1 $t1 $t2
sw $t1 -4($sp)
lw $v0 -4($sp)
jr $ra
main:
li $k1 268501000
addiu $fp $gp 0
addiu $sp $fp 20
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal par2
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal par2
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t4 $v0 0
addiu $t5 $t4 1
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
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
jal par10
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t6 $v0 0
li $a0 1
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal par2
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t7 $v0 0
li $a0 1
li $a1 1
li $a2 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal par3
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t8 $v0 0
li $a0 1
li $a1 1
li $a2 1
move $a3 $t8
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal par4
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t9 $v0 0
mul $t1 $t9 -1
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
sw $ra 28($sp)
jal par5
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -20
sw $v0 -4($sp)
lw $t1 -4($sp)
sw $t1 8($fp)
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
