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
jr $ra
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
sw $a0 28($sp)
addiu $fp $sp 20
addiu $sp $sp 596
lw $t1 8($fp)
addiu $s1 $t1 0
$Label3:
li $t1 -1
sw $t1 532($fp)
sw $s1 536($fp)
li $s0 1
$Label4:
div $t3 $s1 $s0
mul $t1 $t3 $s0
sw $t1 540($fp)
move $a0 $s1
move $a1 $s0
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $ra 24($sp)
jal mod
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $ra 0($fp)
addiu $fp $sp -576
bne $v0 0 $Label5
lw $t1 532($fp)
addiu $t1 $t1 1
sw $t1 532($fp)
lw $t1 536($fp)
subu $t1 $t1 $s0
sw $t1 536($fp)
lw $a1 532($fp)
blt $a1 128 $Label7
la $a0 $String31
li $v0 4
syscall
j $Label8
$Label7:
lw $t0 532($fp)
sll $t0 $t0 2
addu $t0 $fp $t0
sw $s0 12($t0)
$Label8:
$Label5:
$Label6:
addiu $s0 $s0 1
blt $s0 $s1 $Label4
lw $a1 536($fp)
bne $a1 0 $Label9
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
lw $a2 532($fp)
ble $s0 $a2 $Label11
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
lw $t2 532($fp)
mul $t1 $s1 $t2
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
li $t1 2
sw $t1 544($fp)
$Label14:
lw $t1 544($fp)
div $t1 $t1 2
sw $t1 548($fp)
li $s0 2
$Label15:
lw $t1 544($fp)
div $t3 $t1 $s0
mul $t1 $t3 $s0
sw $t1 560($fp)
lw $a0 544($fp)
move $a1 $s0
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $ra 24($sp)
jal mod
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $ra 0($fp)
addiu $fp $sp -576
bne $v0 0 $Label16
li $t1 0
sw $t1 556($fp)
$Label16:
$Label17:
addiu $s0 $s0 1
lw $a2 548($fp)
ble $s0 $a2 $Label15
lw $a1 556($fp)
bne $a1 1 $Label18
la $a0 $String37
li $v0 4
syscall
lw $a0 544($fp)
li $v0 1
syscall
lw $t1 552($fp)
addiu $t1 $t1 1
sw $t1 552($fp)
lw $t1 552($fp)
div $t3 $t1 10
mul $t1 $t3 10
sw $t1 560($fp)
lw $a1 560($fp)
lw $a2 552($fp)
bne $a1 $a2 $Label20
la $a0 $String34
li $v0 4
syscall
$Label20:
$Label21:
$Label18:
$Label19:
li $t1 1
sw $t1 556($fp)
lw $t1 544($fp)
addiu $t1 $t1 1
sw $t1 544($fp)
lw $a1 544($fp)
ble $a1 1024 $Label14
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
sw $v0 8($fp)
la $a0 $String39
li $v0 4
syscall
lw $a0 8($fp)
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
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
jal complete_num
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
# End Of MIPS Assembly Code.
