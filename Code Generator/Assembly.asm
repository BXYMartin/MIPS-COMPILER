.data
	$String1:.asciiz "2^"
	$String2:.asciiz "2"
	$String3:.asciiz "*"
	$String4:.asciiz "^"
.globl main
.text
judge:
sw $a0 20($sp)
sw $a1 24($sp)
sw $a2 28($sp)
addiu $fp $sp 12
addiu $sp $sp 32
lw $t1 8($fp)
bne $t1 -1 $Label1
lw $t1 12($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
lw $t2 16($fp)
bge $t3 $t2 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
$Label4:
j $Label2
$Label1:
$Label2:
li $v0 0
jr $ra
sieve:
sw $a0 24($sp)
addiu $fp $sp 16
addiu $sp $sp 40
li $t1 2
sw $t1 12($fp)
li $t1 -1
sw $t1 0($gp)
li $t1 -1
sw $t1 4($gp)
lw $t1 12($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
lw $t2 8($fp)
bge $t3 $t2 $Label5
$Label7:
li $t1 2
sw $t1 16($fp)
lw $t1 12($fp)
lw $t2 16($fp)
mul $t3 $t1 $t2
sw $t3 20($fp)
lw $t1 20($fp)
lw $t2 8($fp)
bgt $t1 $t2 $Label8
$Label10:
li $t1 -1
lw $t0 20($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 0($t0)
lw $t1 12($fp)
lw $t2 16($fp)
mul $t3 $t1 $t2
sw $t3 20($fp)
lw $t1 16($fp)
addiu $t3 $t1 1
sw $t3 16($fp)
lw $t1 20($fp)
lw $t2 8($fp)
ble $t1 $t2 $Label10
j $Label9
$Label8:
$Label9:
lw $t1 12($fp)
addiu $t3 $t1 1
sw $t3 12($fp)
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
lw $a1 12($fp)
lw $a2 8($fp)
sw $t3 8($sp)
sw $ra 12($sp)
jal judge
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -24
addiu $t4 $v0 0
beq $t4 0 $Label11
$Label13:
lw $t1 12($fp)
addiu $t3 $t1 1
sw $t3 12($fp)
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
lw $a1 12($fp)
lw $a2 8($fp)
sw $t3 8($sp)
sw $ra 12($sp)
jal judge
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -24
addiu $t4 $v0 0
bne $t4 0 $Label13
j $Label12
$Label11:
$Label12:
lw $t1 12($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
lw $t2 8($fp)
blt $t3 $t2 $Label7
j $Label6
$Label5:
$Label6:
jr $ra
mod:
sw $a0 24($sp)
sw $a1 28($sp)
addiu $fp $sp 16
addiu $sp $sp 36
lw $t1 8($fp)
lw $t2 12($fp)
div $t1 $t2
mflo $t3
sw $t3 16($fp)
lw $t1 16($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
lw $t1 8($fp)
subu $t4 $t1 $t3
move $v0 $t4
jr $ra
calculate:
sw $a0 24($sp)
addiu $fp $sp 16
addiu $sp $sp 32
li $t1 2
sw $t1 12($fp)
lw $t1 8($fp)
beq $t1 1 $Label14
$Label16:
lw $a0 8($fp)
lw $a1 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal mod
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -16
addiu $t3 $v0 0
beq $t3 0 $Label17
$Label19:
lw $t1 12($fp)
addiu $t3 $t1 1
sw $t3 12($fp)
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
beq $t3 -1 $Label19
j $Label18
$Label17:
lw $t1 8($fp)
lw $t2 12($fp)
div $t1 $t2
mflo $t3
sw $t3 8($fp)
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t4 $t3 1
lw $t0 12($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t4 0($t0)
$Label18:
lw $t1 8($fp)
bne $t1 1 $Label16
j $Label15
$Label14:
$Label15:
jr $ra
print:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t3 8($gp)
beq $t3 1 $Label20
la $a0 $String1
li $v0 4
syscall
lw $t3 8($gp)
move $a0 $t3
li $v0 1
syscall
j $Label21
$Label20:
lw $t3 8($gp)
bne $t3 1 $Label22
la $a0 $String2
li $v0 4
syscall
j $Label23
$Label22:
$Label23:
$Label21:
li $t1 3
sw $t1 12($fp)
lw $t1 12($fp)
lw $t2 8($fp)
bgt $t1 $t2 $Label24
$Label26:
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
ble $t3 1 $Label27
la $a0 $String3
li $v0 4
syscall
lw $a0 12($fp)
li $v0 1
syscall
la $a0 $String4
li $v0 4
syscall
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
j $Label28
$Label27:
addiu $t1 $gp 0
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
bne $t3 1 $Label29
la $a0 $String3
li $v0 4
syscall
lw $a0 12($fp)
li $v0 1
syscall
j $Label30
$Label29:
$Label30:
$Label28:
lw $t1 12($fp)
addiu $t3 $t1 1
sw $t3 12($fp)
lw $t1 12($fp)
lw $t2 8($fp)
ble $t1 $t2 $Label26
j $Label25
$Label24:
$Label25:
jr $ra
main:
addiu $fp $gp 240800
addiu $sp $fp 16
li $v0 5
syscall
sw $v0 8($fp)
lw $t1 8($fp)
bne $t1 1 $Label31
li $v0 10
syscall
j $Label32
$Label31:
$Label32:
lw $a0 8($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal sieve
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -16
lw $t1 8($fp)
sw $t1 12($fp)
lw $t1 12($fp)
blt $t1 2 $Label33
$Label35:
lw $a0 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
jal calculate
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
addiu $fp $sp -16
lw $t1 12($fp)
subu $t3 $t1 1
sw $t3 12($fp)
lw $t1 12($fp)
bge $t1 2 $Label35
j $Label34
$Label33:
$Label34:
lw $a0 8($fp)
sw $t3 8($sp)
sw $ra 12($sp)
jal print
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -16
li $v0 10
syscall
# End Of MIPS Assembly Code.
