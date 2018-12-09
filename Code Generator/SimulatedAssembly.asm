.data
.globl main
.text
main:
li $k1 268500996
addiu $fp $gp 0
addiu $sp $fp 8
addiu $sp $sp 80
addiu $k0 $sp -32
li $s0 1
addiu $t0 $fp 20
li $t1 -4
sw $t1 0($t0)
addiu $t0 $fp 32
addiu $t0 $t0 12
li $t1 -100
sw $t1 0($t0)
addiu $t0 $fp 12
li $t1 10
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t1 12($fp)
mul $t1 $t1 -1
sw $t1 0($t0)
lw $t1 20($fp)
subu $t3 $t1 $s0
lw $t1 20($fp)
subu $t4 $t1 $s0
li $t0 12
div $t5 $t0 $t3
subu $t6 $t5 11
lw $t1 20($fp)
mul $t9 $t1 $t6
addiu $t0 $fp 24
li $t1 9
sw $t1 0($t0)
lw $t2 24($fp)
mul $t7 $t3 $t2
lw $t2 24($fp)
addu $t8 $t7 $t2
addiu $t0 $k0 0
subu $t1 $t8 $t9
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 0($k0)
lw $t2 4($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
lw $t1 8($k0)
addiu $s1 $t1 11
addiu $t0 $fp 32
addiu $t0 $t0 8
li $t1 99
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
move $a0 $s1
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 12($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 16($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t1 $fp 32
addiu $t1 $t1 8
lw $t3 0($t1)
addiu $t1 $fp 32
addiu $t1 $t1 8
lw $t8 0($t1)
addiu $t0 $k0 0
addiu $t1 $fp 32
addiu $t1 $t1 8
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t1 $fp 32
addiu $t1 $t1 12
lw $t7 0($t1)
subu $t9 $t7 $t3
addiu $t0 $k0 24
mul $t1 $t9 9
sw $t1 0($t0)
lw $t2 24($fp)
div $t4 $s0 $t2
mul $t5 $t4 $t3
li $s1 10
addu $t6 $s1 $t5
addiu $t0 $k0 12
mul $t1 $t6 -10
sw $t1 0($t0)
addiu $t0 $k0 16
lw $t1 12($k0)
lw $t2 20($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 4
subu $t1 $s1 11
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 4($k0)
lw $t2 24($fp)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 20
lw $t1 8($k0)
lw $t2 16($k0)
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 28
lw $t1 20($k0)
lw $t2 24($k0)
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $fp 12
lw $t1 28($k0)
addu $t1 $t1 $t3
sw $t1 0($t0)
move $a0 $s1
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 12($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
