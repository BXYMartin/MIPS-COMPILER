.data
.globl main
.text
main:
li $k1 268501000
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
addiu $t1 $fp 8
lw $t2 24($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t0 $fp 20
addiu $t1 $t3 0
sw $t1 0($t0)
addiu $t0 $fp 32
li $t1 0
sw $t1 0($t0)
lw $t1 24($fp)
subu $t3 $t1 1
addiu $t0 $fp 36
addiu $t1 $t3 0
sw $t1 0($t0)
addiu $t0 $fp 40
li $t1 0
sw $t1 0($t0)
lw $a1 32($fp)
lw $a2 36($fp)
bgt $a1 $a2 $Label4
$Label6:
lw $t1 32($fp)
lw $t2 36($fp)
addu $t3 $t1 $t2
div $t4 $t3 2
addiu $t0 $fp 40
addiu $t1 $t4 0
sw $t1 0($t0)
addiu $t1 $fp 8
lw $t2 40($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a1 20($fp)
bge $a1 $t3 $Label7
lw $t1 40($fp)
subu $t3 $t1 1
addiu $t0 $fp 36
addiu $t1 $t3 0
sw $t1 0($t0)
j $Label8
$Label7:
lw $t1 40($fp)
addiu $t3 $t1 1
addiu $t0 $fp 32
addiu $t1 $t3 0
sw $t1 0($t0)
$Label8:
lw $a1 32($fp)
lw $a2 36($fp)
ble $a1 $a2 $Label6
j $Label5
$Label4:
$Label5:
lw $t1 24($fp)
subu $t3 $t1 1
addiu $t0 $fp 28
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 28($fp)
lw $a2 32($fp)
blt $a1 $a2 $Label9
$Label11:
lw $t1 28($fp)
addiu $t3 $t1 1
addiu $t1 $fp 8
lw $t2 28($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t4 0($t1)
addiu $t0 $fp 8
sll $t1 $t3 2
addu $t0 $t0 $t1
addiu $t1 $t4 0
sw $t1 0($t0)
lw $t1 28($fp)
subu $t3 $t1 1
addiu $t0 $fp 28
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 28($fp)
lw $a2 32($fp)
bge $a1 $a2 $Label11
j $Label10
$Label9:
$Label10:
lw $a1 32($fp)
lw $a2 24($fp)
beq $a1 $a2 $Label12
addiu $t0 $fp 8
lw $t1 32($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 20($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
j $Label13
$Label12:
$Label13:
lw $t1 24($fp)
addiu $t3 $t1 1
addiu $t0 $fp 24
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 24($fp)
blt $a1 3 $Label3
j $Label2
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
lw $t1 24($fp)
addiu $t3 $t1 1
addiu $t0 $fp 24
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 24($fp)
blt $a1 3 $Label16
j $Label15
$Label14:
$Label15:
li $v0 10
syscall
# End Of MIPS Assembly Code.
