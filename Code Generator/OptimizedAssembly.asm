.data
	$String4:.asciiz " "
	$String5:.asciiz "\\n"
	$String6:.asciiz "ERROR!"
.globl main
.text
recursive_cal:
move $s1 $a0
move $s2 $a1
addiu $fp $sp 32
addiu $sp $sp 52
lw $a2 4($gp)
bne $s1 $a2 $Label1
lw $t3 8($gp)
move $a0 $t3
li $v0 1
syscall
li $s0 1
lw $a2 4($gp)
bge $s0 $a2 $Label3
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
lw $a2 4($gp)
blt $s0 $a2 $Label5
$Label3:
$Label4:
la $a0 $String5
li $v0 4
syscall
jr $ra
$Label1:
$Label2:
addiu $s0 $s2 0
lw $t2 0($gp)
addu $t3 $s1 $t2
lw $t2 4($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
bgt $s0 $t5 $Label6
$Label8:
sll $t0 $s1 2
addu $t0 $gp $t0
sw $s0 8($t0)
addiu $t3 $s1 1
addiu $t4 $s0 1
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $s2 28($sp)
sw $ra 32($sp)
jal recursive_cal
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $s2 28($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s0 $s0 1
lw $t2 0($gp)
addu $t3 $s1 $t2
lw $t2 4($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
ble $s0 $t5 $Label8
$Label6:
$Label7:
jr $ra
initial:
move $s2 $a0
move $s1 $a1
addiu $fp $sp 20
addiu $sp $sp 40
li $s0 0
$Label9:
sll $t0 $s0 2
addu $t0 $gp $t0
sw $s2 8($t0)
addiu $s0 $s0 1
ble $s0 $s1 $Label9
jr $ra
main:
li $k1 268501008
addiu $fp $gp 4008
addiu $sp $fp 16
li $v0 5
syscall
sw $v0 0($gp)
li $v0 5
syscall
sw $v0 4($gp)
lw $t1 4($gp)
addiu $t3 $t1 1
ble $t3 1000 $Label10
la $a0 $String6
li $v0 4
syscall
li $v0 10
syscall
$Label10:
$Label11:
lw $t1 4($gp)
addiu $t3 $t1 1
li $a0 0
move $a1 $t3
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $ra 20($sp)
jal initial
addiu $sp $fp -20
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $ra 0($fp)
addiu $fp $sp -16
li $a0 0
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $s2 28($sp)
sw $ra 32($sp)
jal recursive_cal
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $s2 28($sp)
lw $ra 0($fp)
addiu $fp $sp -16
# End Of MIPS Assembly Code.
