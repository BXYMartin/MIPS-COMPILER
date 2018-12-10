.data
	$String5:.asciiz "Full permutation, please input a number(<100)"
	$String6:.asciiz "Finished!"
	$String7:.asciiz "Three integers"
	$String8:.asciiz "Please input e/r/n/v instead of "
.globl main
.text
sqrt:
move $s0 $a0
addiu $sp $sp 4
move $k0 $sp
mul $t3 $s0 $s0
move $v0 $t3
jr $ra
arrange:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
sw $a3 12($sp)
lw $s1 0($k1)
addiu $sp $sp 24
move $k0 $sp
li $s0 0
bne $s1 $s7 $Label1
jr $ra
$Label1:
$Label2:
$Label3:
addiu $t1 $gp 0
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
bne $t3 0 $Label4
addiu $t0 $gp 0
sll $t1 $s0 2
addu $t0 $t0 $t1
li $t1 1
sw $t1 0($t0)
addiu $t0 $gp 400
sll $t1 $s1 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t3 $s1 1
li $a0 0
li $a1 0
li $a2 0
li $a3 0
sw $t3 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal arrange
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $gp 0
sll $t1 $s0 2
addu $t0 $t0 $t1
li $t1 0
sw $t1 0($t0)
$Label4:
$Label5:
addiu $s0 $s0 1
blt $s0 $s7 $Label3
jr $ra
foo_recursion:
addiu $sp $sp 4
move $k0 $sp
li $s0 0
la $a0 $String5
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s7 $v0
$Label6:
addiu $t0 $gp 0
sll $t1 $s0 2
addu $t0 $t0 $t1
li $t1 0
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 $s7 $Label6
li $a0 1
li $a1 2
li $a2 3
li $a3 4
li $v0 0
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal arrange
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
foo_expr:
addiu $sp $sp 16
move $k0 $sp
li $s0 0
la $a0 $String7
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $fp 8
sw $v0 0($a3)
li $v0 5
syscall
move $s1 $v0
li $v0 5
syscall
addiu $a3 $fp 16
sw $v0 0($a3)
$Label7:
addiu $t0 $gp 400
sll $t1 $s0 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 100 $Label7
addiu $t1 $gp 400
sll $t2 $s1 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a0 16($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal sqrt
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
lw $t1 8($fp)
mul $t5 $t1 $t3
li $t0 0
subu $t6 $t0 $t5
addiu $t7 $t6 -198
addu $t8 $t7 $t4
subu $t9 $t8 2
move $v0 $t9
jr $ra
do_nothing:
addiu $sp $sp 0
move $k0 $sp
jr $ra
value:
addiu $sp $sp 4
move $k0 $sp
li $v0 5
syscall
move $s0 $v0
beq $s0 1 $Label9
beq $s0 2 $Label10
li $a0 98
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label8
$Label9:
li $a0 110
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label8
$Label10:
li $a0 98
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
j $Label8
$Label8:
jr $ra
main:
li $k1 268501100
addiu $fp $gp 824
addiu $sp $fp 8
addiu $sp $sp 4
move $k0 $sp
li $v0 12
syscall
move $s0 $v0
$Label12:
li $t3 -1
beq $t3 0 $Label13
beq $s0 101 $Label16
beq $s0 114 $Label17
beq $s0 110 $Label18
beq $s0 118 $Label19
la $a0 $String8
li $v0 4
syscall
move $a0 $s0
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
j $Label15
$Label16:
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $s0 36($sp)
sw $s1 40($sp)
sw $ra 44($sp)
sw $fp 48($sp)
addiu $sp $sp 52
addiu $fp $sp -8
jal foo_expr
move $sp $fp
addiu $sp $sp -44
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
lw $s1 40($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label15
$Label17:
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal foo_recursion
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label15
$Label18:
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal do_nothing
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label15
$Label19:
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal value
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label15
$Label15:
$Label13:
$Label14:
li $t3 0
bne $t3 0 $Label12
li $v0 10
syscall
# End Of MIPS Assembly Code.
