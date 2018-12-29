.data
	$String6:.asciiz "test expr"
	$String7:.asciiz "test switch result:"
	$String8:.asciiz "test string\\n"
	$String9:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String10:.asciiz "print string and expr, got char: "
.globl main
.text
add:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
get:
addiu $fp $sp 8
addiu $sp $sp 16
fib:
move $s0 $a0
addiu $fp $sp 28
addiu $sp $sp 40
bge $s0 0 $Label1
li $v0 0
jr $ra
j $Label2
$Label1:
ble $s0 0 $Label3
subu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $s0 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $s0 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
subu $t5 $s0 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $s0 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $s0 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addu $t7 $t4 $v0
move $v0 $t7
jr $ra
j $Label4
$Label3:
li $v0 1
jr $ra
$Label4:
$Label2:
testexpr:
addiu $fp $sp 8
addiu $sp $sp 16
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $a1 20
addu $t3 $a0 $a1
move $v0 $t3
sw $v0 12($gp)
li $t1 -10
sw $t1 16($gp)
li $a0 200
li $a1 20
addu $t3 $a0 $a1
move $v0 $t3
sw $v0 20($gp)
li $a0 85
li $a1 20
addu $t3 $a0 $a1
move $v0 $t3
sw $v0 24($gp)
lw $t3 12($gp)
addiu $t4 $t3 18
mul $t5 $t4 2
addiu $t1 $t5 3
sw $t1 32($gp)
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $s0 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $s0 24($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t3 $v0 0
li $a0 -1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $s0 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $s0 24($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addu $t1 $t3 $v0
sw $t1 36($gp)
li $t1 0
sw $t1 4($gp)
$Label5:
addiu $t1 $gp 12
lw $t2 4($gp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 4($gp)
addiu $t1 $t1 1
sw $t1 4($gp)
lw $a1 4($gp)
ble $a1 6 $Label5
jr $ra
testempty:
addiu $fp $sp 8
addiu $sp $sp 16
main:
li $k1 268501168
addiu $fp $gp 76
addiu $sp $fp 24
li $t1 0
sw $t1 0($gp)
li $t1 0
sw $t1 8($gp)
li $s0 10
li $t1 104
sw $t1 56($gp)
li $t1 101
sw $t1 60($gp)
li $t1 108
sw $t1 64($gp)
li $t1 108
sw $t1 68($gp)
li $t1 111
sw $t1 72($gp)
li $v0 5
syscall
move $s2 $v0
li $v0 5
syscall
move $s1 $v0
li $v0 12
syscall
sw $v0 52($gp)
$Label6:
addiu $t1 $gp 56
lw $t2 0($gp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 11
syscall
lw $t1 0($gp)
addiu $t1 $t1 1
sw $t1 0($gp)
lw $a1 0($gp)
blt $a1 5 $Label6
lw $a1 52($gp)
beq $a1 43 $Label8
lw $a1 52($gp)
beq $a1 45 $Label9
mul $s0 $s2 $s1
j $Label7
$Label8:
addu $s0 $s2 $s1
j $Label7
$Label9:
subu $s0 $s2 $s1
j $Label7
$Label7:
la $a0 $String7
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
blt $s0 0 $Label11
lw $t1 8($gp)
addiu $t1 $t1 1
sw $t1 8($gp)
j $Label12
$Label11:
lw $t1 8($gp)
addiu $t1 $t1 3
sw $t1 8($gp)
$Label12:
lw $t1 8($gp)
addiu $t1 $t1 1
sw $t1 8($gp)
addiu $t1 $gp 56
lw $t2 8($gp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $v0 $t3
addiu $s3 $v0 0
beq $s3 108 $Label13
la $a0 $String8
li $v0 4
syscall
la $a0 $String9
li $v0 4
syscall
j $Label14
$Label13:
la $a0 $String10
li $v0 4
syscall
move $a0 $s3
li $v0 11
syscall
$Label14:
sw $ra 8($sp)
jal testexpr
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -24
li $v0 10
syscall
# End Of MIPS Assembly Code.
