.data
	$String27:.asciiz " x = "
	$String28:.asciiz " y = "
	$String29:.asciiz " SWAP x = "
	$String30:.asciiz " SWAP y = "
	$String31:.asciiz " OVERFLOW!          "
	$String32:.asciiz " complete number: "
	$String33:.asciiz "  "
	$String34:.asciiz "          "
	$String35:.asciiz " ---------------------------------------------------------------          "
	$String36:.asciiz " b = "
	$String37:.asciiz " "
	$String38:.asciiz "          The total is "
	$String39:.asciiz " 10! = "
.globl main
.text
factorial:
move $s0 $a0
addiu $fp $sp 20
addiu $sp $sp 32
bgt $s0 1 $Label1
li $v0 1
jr $ra
j $Label2
$Label1:
subu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $ra 20($sp)
jal factorial
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
mul $t4 $s0 $v0
move $v0 $t4
jr $ra
$Label2:
mod:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 24
addiu $sp $sp 40
div $t3 $s0 $s1
mul $t4 $t3 $s1
subu $s0 $s0 $t4
move $v0 $s0
lw $t3 8($sp)
lw $t4 12($sp)
swap:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 20
addiu $sp $sp 40
la $a0 $String27
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
la $a0 $String28
li $v0 4
syscall
move $a0 $s1
li $v0 1
syscall
addiu $s2 $s0 0
addiu $s0 $s1 0
addiu $s1 $s2 0
la $a0 $String29
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
la $a0 $String30
li $v0 4
syscall
move $a0 $s1
li $v0 1
syscall
jr $ra
complete_num:
sw $a0 56($sp)
addiu $fp $sp 48
addiu $sp $sp 624
lw $t1 8($fp)
addiu $s1 $t1 0
$Label3:
li $s6 -1
addiu $s7 $s1 0
li $s0 1
$Label4:
div $t3 $s1 $s0
mul $s3 $t3 $s0
move $a0 $s1
move $a1 $s0
sw $t3 8($sp)
sw $t4 12($sp)
div $t3 $s0 $s1
mul $t4 $t3 $s1
subu $s0 $s0 $t4
move $v0 $s0
lw $t3 8($sp)
lw $t4 12($sp)
bne $v0 0 $Label5
addiu $s6 $s6 1
subu $s7 $s7 $s0
blt $s6 128 $Label7
la $a0 $String31
li $v0 4
syscall
j $Label8
$Label7:
sll $t0 $s6 2
addu $t0 $fp $t0
sw $s0 12($t0)
$Label8:
$Label5:
$Label6:
addiu $s0 $s0 1
blt $s0 $s1 $Label4
bne $s7 0 $Label9
la $a0 $String32
li $v0 4
syscall
move $a0 $s1
li $v0 1
syscall
li $s0 0
$Label11:
la $a0 $String33
li $v0 4
syscall
addiu $t1 $fp 12
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $s0 $s0 1
ble $s0 $s6 $Label11
la $a0 $String34
li $v0 4
syscall
$Label9:
$Label10:
addiu $s1 $s1 1
blt $s1 1024 $Label3
la $a0 $String35
li $v0 4
syscall
li $t1 0
sw $t1 564($fp)
li $s0 0
$Label12:
mul $t1 $s1 $s6
sw $t1 572($fp)
lw $t1 564($fp)
mul $t1 $t1 $s0
sw $t1 568($fp)
lw $t1 568($fp)
lw $t2 568($fp)
addu $t3 $t1 $t2
lw $t2 572($fp)
addu $t1 $t3 $t2
sw $t1 564($fp)
addiu $s0 $s0 1
blt $s0 1024 $Label12
lw $t1 564($fp)
sw $t1 568($fp)
li $s0 0
$Label13:
lw $t1 568($fp)
addu $t1 $t1 $s0
sw $t1 568($fp)
addiu $s0 $s0 1
blt $s0 1024 $Label13
la $a0 $String36
li $v0 4
syscall
lw $a0 568($fp)
li $v0 1
syscall
la $a0 $String35
li $v0 4
syscall
li $t1 0
sw $t1 552($fp)
li $t1 1
sw $t1 556($fp)
li $s2 2
$Label14:
div $s4 $s2 2
li $s0 2
$Label15:
div $t3 $s2 $s0
mul $s5 $t3 $s0
move $a0 $s2
move $a1 $s0
sw $t3 8($sp)
sw $t4 12($sp)
div $t3 $s0 $s1
mul $t4 $t3 $s1
subu $s0 $s0 $t4
move $v0 $s0
lw $t3 8($sp)
lw $t4 12($sp)
bne $v0 0 $Label16
li $t1 0
sw $t1 556($fp)
$Label16:
$Label17:
addiu $s0 $s0 1
ble $s0 $s4 $Label15
lw $a1 556($fp)
bne $a1 1 $Label18
la $a0 $String37
li $v0 4
syscall
move $a0 $s2
li $v0 1
syscall
lw $t1 552($fp)
addiu $t1 $t1 1
sw $t1 552($fp)
lw $t1 552($fp)
div $t3 $t1 10
mul $s5 $t3 10
lw $a2 552($fp)
bne $s5 $a2 $Label20
la $a0 $String34
li $v0 4
syscall
$Label20:
$Label21:
$Label18:
$Label19:
li $t1 1
sw $t1 556($fp)
addiu $s2 $s2 1
ble $s2 1024 $Label14
la $a0 $String38
li $v0 4
syscall
lw $a0 552($fp)
li $v0 1
syscall
jr $ra
main:
li $k1 268501196
addiu $fp $gp 0
addiu $sp $fp 12
li $a0 10
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $ra 20($sp)
jal factorial
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $s0 $v0 0
la $a0 $String39
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 5
li $a1 10
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $ra 20($sp)
jal swap
addiu $sp $fp -20
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
li $a0 2
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $s2 24($sp)
sw $s3 28($sp)
sw $s4 32($sp)
sw $s5 36($sp)
sw $s6 40($sp)
sw $s7 44($sp)
sw $ra 48($sp)
jal complete_num
addiu $sp $fp -48
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $s2 24($sp)
lw $s3 28($sp)
lw $s4 32($sp)
lw $s5 36($sp)
lw $s6 40($sp)
lw $s7 44($sp)
lw $ra 0($fp)
addiu $fp $sp -12
# End Of MIPS Assembly Code.
