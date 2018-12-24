.data
.globl main
.text
main:
li $k1 268500996
addiu $fp $gp 0
addiu $sp $fp 44
addiu $t0 $fp 8
li $t1 20
sw $t1 0($t0)
addiu $t0 $fp 8
addiu $t0 $t0 4
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 8
addiu $t0 $t0 8
li $t1 4
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
lw $a1 24($fp)
bge $a1 3 $Label1
$Label3:
addiu $t0 $fp 20
addiu $t1 $fp 8
lw $t2 24($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
li $s1 0
addiu $t0 $fp 40
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
lw $t1 24($fp)
subu $t1 $t1 1
sw $t1 0($t0)
lw $a2 36($fp)
bgt $s1 $a2 $Label4
$Label6:
lw $t2 36($fp)
addu $t3 $s1 $t2
addiu $t0 $fp 40
div $t1 $t3 2
sw $t1 0($t0)
addiu $t1 $fp 8
lw $t2 40($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a1 20($fp)
bge $a1 $t3 $Label7
addiu $t0 $fp 36
lw $t1 40($fp)
subu $t1 $t1 1
sw $t1 0($t0)
j $Label8
$Label7:
lw $t1 40($fp)
addiu $s1 $t1 1
$Label8:
lw $a2 36($fp)
ble $s1 $a2 $Label6
$Label4:
$Label5:
lw $t1 24($fp)
subu $s0 $t1 1
blt $s0 $s1 $Label9
$Label11:
addiu $t3 $s0 1
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t4 0($t1)
addiu $t0 $fp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $t4 0
sw $t1 0($t0)
subu $s0 $s0 1
bge $s0 $s1 $Label11
$Label9:
$Label10:
lw $a2 24($fp)
beq $s1 $a2 $Label12
addiu $t0 $fp 8
sll $t1 $s1 2
addu $t0 $t0 $t1
lw $t1 20($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
$Label12:
$Label13:
addiu $t0 $fp 24
lw $t1 24($fp)
addiu $t1 $t1 1
sw $t1 0($t0)
lw $a1 24($fp)
blt $a1 3 $Label3
$Label1:
$Label2:
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
lw $a1 24($fp)
bge $a1 3 $Label14
$Label16:
addiu $t1 $fp 8
lw $t2 24($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $t0 $fp 24
lw $t1 24($fp)
addiu $t1 $t1 1
sw $t1 0($t0)
lw $a1 24($fp)
blt $a1 3 $Label16
$Label14:
$Label15:
li $v0 10
syscall
# End Of MIPS Assembly Code.
