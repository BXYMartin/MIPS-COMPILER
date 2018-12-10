.data
	$String1:.asciiz "Full permutation, please input a number(<100)"
	$String2:.asciiz "Finished!"
	$String3:.asciiz "Three integers"
	$String4:.asciiz "Please input e/r/n/v instead of "
.globl main
.text
sqrt:
sw $a0 0($sp)
addiu $sp $sp 4
move $k0 $sp
lw $t1 8($fp)
lw $t2 8($fp)
mul $t3 $t1 $t2
move $v0 $t3
jr $ra
arrange:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
addiu $sp $sp 24
move $k0 $sp
addiu $t0 $fp 28
li $t1 0
sw $t1 0($t0)
lw $a1 24($fp)
lw $a2 820($gp)
bne $a1 $a2 $Label1
jr $ra
j $Label2
$Label1:
$Label2:
$Label3:
addiu $t1 $gp 0
lw $t2 28($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
bne $t3 0 $Label4
addiu $t0 $gp 0
lw $t1 28($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
li $t1 1
sw $t1 0($t0)
addiu $t0 $gp 400
lw $t1 24($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 28($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 24($fp)
addiu $t3 $t1 1
li $a0 0
li $a1 0
li $a2 0
li $a3 0
sw $t3 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal arrange
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $gp 0
lw $t1 28($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
li $t1 0
sw $t1 0($t0)
j $Label5
$Label4:
$Label5:
lw $t1 28($fp)
addiu $t3 $t1 1
addiu $t0 $fp 28
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 28($fp)
lw $a2 820($gp)
blt $a1 $a2 $Label3
jr $ra
foo_recursion:
addiu $sp $sp 4
move $k0 $sp
addiu $t0 $fp 8
li $t1 0
sw $t1 0($t0)
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $gp 820
sw $v0 0($a3)
$Label6:
addiu $t0 $gp 0
lw $t1 8($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
li $t1 0
sw $t1 0($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t0 $fp 8
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 8($fp)
lw $a2 820($gp)
blt $a1 $a2 $Label6
li $a0 1
li $a1 2
li $a2 3
li $a3 4
li $v0 0
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal arrange
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String2
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
foo_expr:
addiu $sp $sp 16
move $k0 $sp
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
la $a0 $String3
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
addiu $a3 $fp 12
sw $v0 0($a3)
li $v0 5
syscall
addiu $a3 $fp 16
sw $v0 0($a3)
$Label7:
addiu $t0 $gp 400
lw $t1 20($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 20($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 20($fp)
addiu $t3 $t1 1
addiu $t0 $fp 20
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 20($fp)
blt $a1 100 $Label7
addiu $t1 $gp 400
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a0 16($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal sqrt
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
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
addiu $a3 $fp 8
sw $v0 0($a3)
lw $a1 8($fp)
beq $a1 1 $Label9
lw $a1 8($fp)
beq $a1 2 $Label10
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
li $k1 268501104
addiu $fp $gp 824
addiu $sp $fp 8
addiu $sp $sp 4
move $k0 $sp
li $v0 12
syscall
addiu $a3 $fp 8
sw $v0 0($a3)
$Label12:
li $t3 -1
beq $t3 0 $Label13
lw $a1 8($fp)
beq $a1 101 $Label16
lw $a1 8($fp)
beq $a1 114 $Label17
lw $a1 8($fp)
beq $a1 110 $Label18
lw $a1 8($fp)
beq $a1 118 $Label19
la $a0 $String4
li $v0 4
syscall
lw $a0 8($fp)
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
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal foo_expr
move $sp $fp
addiu $sp $sp -36
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
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
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal foo_recursion
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
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
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal value
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label15
$Label15:
j $Label14
$Label13:
$Label14:
li $t3 0
bne $t3 0 $Label12
li $v0 10
syscall
# End Of MIPS Assembly Code.
