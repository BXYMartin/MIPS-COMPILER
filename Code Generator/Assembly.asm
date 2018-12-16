.data
.globl main
.text
main:
li $k1 268501000
addiu $fp $gp 0
addiu $sp $fp 8
addiu $sp $sp 24
move $k0 $sp
addiu $t0 $fp 20
li $t1 10
sw $t1 0($t0)
addiu $t0 $fp 28
li $t1 2
sw $t1 0($t0)
$Label1:
lw $t1 20($fp)
addiu $t3 $t1 1
addiu $t0 $fp 20
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 20($fp)
addiu $t3 $t1 99
addiu $t0 $fp 12
addiu $t0 $t0 0
addiu $t1 $t3 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
mul $t4 $t3 5
subu $t5 $t4 23
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t5 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t4 $t3 5
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
mul $t4 $t3 2
addiu $t0 $fp 12
addiu $t0 $t0 0
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
li $t0 4096
div $t4 $t0 $t3
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
div $t4 $t3 4
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
subu $t4 $t3 3
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 0
lw $t3 0($t1)
li $t0 10024
subu $t4 $t0 $t3
addiu $t0 $fp 12
addiu $t0 $t0 4
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 12
addiu $t1 $t1 4
lw $t3 0($t1)
lw $t1 28($fp)
addu $t4 $t1 $t3
addiu $t0 $fp 28
addiu $t1 $t4 0
sw $t1 0($t0)
lw $a0 28($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a1 28($fp)
blt $a1 2050 $Label1
# End Of MIPS Assembly Code.
