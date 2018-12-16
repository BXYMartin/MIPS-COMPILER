.data
.globl main
.text
main:
li $k1 268500996
addiu $fp $gp 0
addiu $sp $fp 8
addiu $sp $sp 24
move $k0 $sp
li $s0 10
li $s1 2
$Label1:
addiu $s0 $s0 1
addiu $t0 $fp 12
addiu $t0 $t0 0
addiu $t1 $s0 99
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
mul $t4 $t3 5
addiu $t0 $fp 12
addiu $t0 $t0 4
subu $t1 $t4 23
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t3 5
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 0
mul $t1 $t3 2
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 4
li $t1 4096
div $t1 $t1 $t3
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 4
div $t1 $t3 4
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 4
subu $t1 $t3 3
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
addiu $t0 $fp 12
addiu $t0 $t0 4
li $t1 10024
subu $t1 $t1 $t3
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
addu $s1 $s1 $t3
move $a0 $s1
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
blt $s1 2050 $Label1
# End Of MIPS Assembly Code.
