.data
	$String1:.asciiz " "
	$String2:.asciiz "\\n"
	$String3:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
lw $a1 8($fp)
lw $a2 4($gp)
bne $a1 $a2 $Label1
lw $t3 8($gp)
move $a0 $t3
li $v0 1
syscall
li $t1 1
sw $t1 16($fp)
lw $a1 16($fp)
lw $a2 4($gp)
bge $a1 $a2 $Label3
$Label5:
la $a0 $String1
li $v0 4
syscall
addiu $t1 $gp 8
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 16($fp)
lw $a1 16($fp)
lw $a2 4($gp)
blt $a1 $a2 $Label5
j $Label4
$Label3:
$Label4:
la $a0 $String2
li $v0 4
syscall
jr $ra
j $Label2
$Label1:
$Label2:
lw $t1 12($fp)
addiu $t1 $t1 0
sw $t1 16($fp)
lw $t1 8($fp)
lw $t2 0($gp)
addu $t3 $t1 $t2
lw $t2 4($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
lw $a1 16($fp)
bgt $a1 $t5 $Label6
$Label8:
lw $t1 16($fp)
addiu $t1 $t1 0
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 8($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
lw $t1 16($fp)
addiu $t4 $t1 1
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal recursive_cal
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
lw $t1 16($fp)
addiu $t5 $t1 1
addiu $t1 $t5 0
sw $t1 16($fp)
lw $t1 8($fp)
lw $t2 0($gp)
addu $t3 $t1 $t2
lw $t2 4($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
lw $a1 16($fp)
ble $a1 $t5 $Label8
j $Label7
$Label6:
$Label7:
jr $ra
initial:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
li $t1 0
sw $t1 16($fp)
$Label9:
lw $t1 8($fp)
addiu $t1 $t1 0
lw $t0 16($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 8($t0)
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 16($fp)
lw $a1 16($fp)
lw $a2 12($fp)
ble $a1 $a2 $Label9
jr $ra
jr $ra
main:
li $k1 268501012
addiu $fp $gp 4008
addiu $sp $fp 8
addiu $sp $sp 8
li $v0 5
syscall
sw $v0 0($gp)
li $v0 5
syscall
sw $v0 4($gp)
lw $t1 4($gp)
addiu $t3 $t1 1
ble $t3 1000 $Label10
la $a0 $String3
li $v0 4
syscall
li $v0 10
syscall
j $Label11
$Label10:
$Label11:
lw $t1 4($gp)
addiu $t3 $t1 1
li $a0 0
move $a1 $t3
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal initial
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 0
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal recursive_cal
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
# End Of MIPS Assembly Code.
