.data
	$String3:.asciiz "Error"
.globl main
.text
rec:
move $s0 $a0
move $s4 $a1
move $s6 $a2
move $s3 $a3
lw $s2 0($k1)
lw $s5 4($k1)
addiu $fp $sp 36
addiu $sp $sp 72
blt $s0 50 $Label1
move $v0 $s2
jr $ra
j $Label2
$Label1:
addiu $t3 $s0 1
move $a0 $t3
move $a1 $s4
move $a2 $s6
move $a3 $s3
sw $s2 0($k1)
sw $s5 4($k1)
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $s4 24($sp)
sw $s5 28($sp)
sw $s6 32($sp)
sw $ra 36($sp)
jal rec
addiu $sp $fp -36
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $s4 24($sp)
lw $s5 28($sp)
lw $s6 32($sp)
lw $ra 0($fp)
addiu $fp $sp -36
addiu $s1 $v0 0
$Label2:
move $v0 $s1
jr $ra
main:
li $k1 268501000
addiu $fp $gp 0
addiu $sp $fp 32
li $s1 10
li $s0 2
beq $0 0 $Label3
la $a0 $String3
li $v0 4
syscall
$Label3:
$Label4:
beq $0 1 $Label5
$Label7:
li $t1 4
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
li $t1 4
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
li $t1 4
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
li $t1 4
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
lw $t3 16($fp)
sw $t3 16($fp)
li $t1 5
sw $t1 16($fp)
lw $t3 16($fp)
addiu $t1 $t3 1
sw $t1 16($fp)
lw $t3 16($fp)
li $t1 2
subu $t1 $t1 $t3
sw $t1 16($fp)
lw $t3 16($fp)
mul $t1 $t3 2
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
lw $t3 16($fp)
mul $t1 $t3 0
sw $t1 16($fp)
lw $t3 16($fp)
move $a0 $t3
li $v0 1
syscall
addiu $s1 $s1 1
addiu $t1 $s1 99
sw $t1 12($fp)
lw $t3 12($fp)
mul $t4 $t3 5
subu $t1 $t4 23
sw $t1 16($fp)
lw $t3 16($fp)
addiu $t1 $t3 5
sw $t1 16($fp)
lw $t3 16($fp)
mul $t1 $t3 2
sw $t1 12($fp)
lw $t3 12($fp)
li $t1 4096
div $t1 $t1 $t3
sw $t1 16($fp)
lw $t3 12($fp)
div $t1 $t3 4
sw $t1 16($fp)
lw $t3 16($fp)
subu $t1 $t3 3
sw $t1 16($fp)
lw $t3 12($fp)
li $t1 10024
subu $t1 $t1 $t3
sw $t1 16($fp)
lw $t3 16($fp)
addu $s0 $s0 $t3
li $a0 10
li $a1 5
li $a2 2
li $a3 1
sw $s0 0($k1)
sw $s1 4($k1)
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $s4 24($sp)
sw $s5 28($sp)
sw $s6 32($sp)
sw $ra 36($sp)
jal rec
addiu $sp $fp -36
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $s4 24($sp)
lw $s5 28($sp)
lw $s6 32($sp)
lw $ra 0($fp)
addiu $fp $sp -32
addiu $s0 $v0 0
li $a0 10
li $a1 5
li $a2 2
li $a3 1
sw $s0 0($k1)
sw $s1 4($k1)
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $s4 24($sp)
sw $s5 28($sp)
sw $s6 32($sp)
sw $ra 36($sp)
jal rec
addiu $sp $fp -36
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $s4 24($sp)
lw $s5 28($sp)
lw $s6 32($sp)
lw $ra 0($fp)
addiu $fp $sp -32
addiu $s0 $v0 0
blt $s0 100000 $Label7
$Label5:
$Label6:
move $a0 $s0
li $v0 1
syscall
# End Of MIPS Assembly Code.
