.data
	$String1:.asciiz "test expr"
	$String2:.asciiz "test switch result:"
	$String3:.asciiz "test string\\n"
	$String4:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String5:.asciiz "print string and expr, got char: "
.globl main
.text
add:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
get:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 8($gp)
addiu $t3 $t1 1
sw $t3 8($gp)
addiu $t1 $gp 56
lw $t2 8($gp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $v0 $t3
jr $ra
fib:
sw $a0 36($sp)
addiu $fp $sp 28
addiu $sp $sp 40
lw $a1 8($fp)
bge $a1 0 $Label1
li $v0 0
jr $ra
j $Label2
$Label1:
lw $a1 8($fp)
ble $a1 0 $Label3
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
lw $t1 8($fp)
subu $t5 $t1 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t6 $v0 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
j $Label4
$Label3:
li $v0 1
jr $ra
$Label4:
$Label2:
testexpr:
addiu $fp $sp 24
addiu $sp $sp 32
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $a1 20
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t3 $v0 0
sw $t3 12($gp)
li $t1 -10
sw $t1 16($gp)
li $a0 200
li $a1 20
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t3 $v0 0
sw $t3 20($gp)
li $a0 85
li $a1 20
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t3 $v0 0
sw $t3 24($gp)
lw $t3 12($gp)
addiu $t4 $t3 18
mul $t5 $t4 2
addiu $t6 $t5 3
sw $t6 32($gp)
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t3 $v0 0
li $a0 -1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t4 $v0 0
addu $t5 $t3 $t4
sw $t5 36($gp)
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
addiu $t3 $t1 1
sw $t3 4($gp)
lw $a1 4($gp)
ble $a1 6 $Label5
jr $ra
jr $ra
testempty:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
main:
li $k1 268501172
addiu $fp $gp 76
addiu $sp $fp 24
li $t1 0
sw $t1 0($gp)
li $t1 0
sw $t1 8($gp)
li $t1 10
sw $t1 16($fp)
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
sw $v0 8($fp)
li $v0 5
syscall
sw $v0 12($fp)
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
addiu $t3 $t1 1
sw $t3 0($gp)
lw $a1 0($gp)
blt $a1 5 $Label6
lw $a1 52($gp)
beq $a1 43 $Label8
lw $a1 52($gp)
beq $a1 45 $Label9
lw $t1 8($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
sw $t3 16($fp)
j $Label7
$Label8:
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
sw $t3 16($fp)
j $Label7
$Label9:
lw $t1 8($fp)
lw $t2 12($fp)
subu $t3 $t1 $t2
sw $t3 16($fp)
j $Label7
$Label7:
la $a0 $String2
li $v0 4
syscall
lw $a0 16($fp)
li $v0 1
syscall
lw $a1 16($fp)
blt $a1 0 $Label11
lw $t1 8($gp)
addiu $t3 $t1 1
sw $t3 8($gp)
j $Label12
$Label11:
lw $t1 8($gp)
addiu $t3 $t1 3
sw $t3 8($gp)
$Label12:
sw $t3 8($sp)
sw $ra 12($sp)
jal get
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -24
addiu $t3 $v0 0
sw $t3 20($fp)
lw $a1 20($fp)
beq $a1 108 $Label13
la $a0 $String3
li $v0 4
syscall
la $a0 $String4
li $v0 4
syscall
j $Label14
$Label13:
la $a0 $String5
li $v0 4
syscall
lw $a0 20($fp)
li $v0 11
syscall
$Label14:
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal testexpr
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -24
sw $ra 8($sp)
jal testempty
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -24
li $v0 10
syscall
# End Of MIPS Assembly Code.
