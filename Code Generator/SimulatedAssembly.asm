.data
	$String9:.asciiz "2^"
	$String10:.asciiz "2"
	$String11:.asciiz "*"
	$String12:.asciiz "^"
.globl main
.text
judge:
move $a0 $a0
move $a1 $a1
move $a2 $a2
addiu $fp $sp 24
addiu $sp $sp 44
sieve:
move $s3 $a0
addiu $fp $sp 24
addiu $sp $sp 48
li $s2 2
li $t1 -1
sw $t1 0($gp)
li $t1 -1
sw $t1 4($gp)
mul $t3 $s2 $s2
bge $t3 $s3 $Label5
$Label7:
li $s0 2
mul $s1 $s2 $s0
bgt $s1 $s3 $Label8
$Label10:
li $t1 -1
sll $t0 $s1 2
addu $t0 $gp $t0
sw $t1 0($t0)
mul $s1 $s2 $s0
addiu $s0 $s0 1
ble $s1 $s3 $Label10
$Label8:
$Label9:
addiu $s2 $s2 1
addiu $t1 $gp 0
sll $t2 $s2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
move $a1 $s2
move $a2 $s3
sw $t3 8($sp)
bne $a0 -1 $Label1_1
mul $t3 $a1 $a1
bge $t3 $a2 $Label3_1
li $v0 1
lw $t3 8($sp)
j $_judge_1
$Label3_1:
$Label4_1:
$Label1_1:
$Label2_1:
li $v0 0
lw $t3 8($sp)
$_judge_1:
beq $v0 0 $Label11
$Label13:
addiu $s2 $s2 1
addiu $t1 $gp 0
sll $t2 $s2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
move $a1 $s2
move $a2 $s3
sw $t3 8($sp)
bne $a0 -1 $Label1_1_2
mul $t3 $a1 $a1
bge $t3 $a2 $Label3_1_2
li $v0 1
lw $t3 8($sp)
j $_judge_1_2
$Label3_1_2:
$Label4_1_2:
$Label1_1_2:
$Label2_1_2:
li $v0 0
lw $t3 8($sp)
$_judge_1_2:
bne $v0 0 $Label13
$Label11:
$Label12:
mul $t3 $s2 $s2
blt $t3 $s3 $Label7
$Label5:
$Label6:
jr $ra
mod:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 20
addiu $sp $sp 40
calculate:
move $s1 $a0
addiu $fp $sp 16
addiu $sp $sp 32
li $s0 2
beq $s1 1 $Label14
$Label16:
move $a0 $s1
move $a1 $s0
div $a0 $a1
mflo $a2
mul $t3 $a2 $a1
subu $t4 $a0 $t3
move $v0 $t4
$_mod_1:
beq $v0 0 $Label17
$Label19:
addiu $s0 $s0 1
addiu $t1 $gp 0
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
beq $t3 -1 $Label19
j $Label18
$Label17:
div $s1 $s0
mflo $s1
addiu $t1 $gp 0
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t1 $t3 1
sll $t0 $s0 2
addu $t0 $gp $t0
sw $t1 0($t0)
$Label18:
bne $s1 1 $Label16
$Label14:
$Label15:
jr $ra
print:
move $a0 $a0
addiu $fp $sp 16
addiu $sp $sp 32
main:
addiu $fp $gp 240800
addiu $sp $fp 16
li $v0 5
syscall
move $s1 $v0
bne $s1 1 $Label31
li $v0 10
syscall
$Label31:
$Label32:
move $a0 $s1
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $ra 24($sp)
jal sieve
addiu $sp $fp -24
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $ra 0($fp)
addiu $fp $sp -16
addiu $s0 $s1 0
blt $s0 2 $Label33
$Label35:
move $a0 $s0
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal calculate
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -16
subu $s0 $s0 1
bge $s0 2 $Label35
$Label33:
$Label34:
move $a0 $s1
lw $t3 8($gp)
beq $t3 1 $Label20_1
move $v1 $a0
la $a0 $String9
li $v0 4
syscall
move $a0 $v1
lw $t3 8($gp)
move $v1 $a0
move $a0 $t3
li $v0 1
syscall
move $a0 $v1
j $Label21_1
$Label20_1:
lw $t3 8($gp)
bne $t3 1 $Label22_1
move $v1 $a0
la $a0 $String10
li $v0 4
syscall
move $a0 $v1
$Label22_1:
$Label23_1:
$Label21_1:
li $a1 3
bgt $a1 $a0 $Label24_1
$Label26_1:
addiu $t1 $gp 0
sll $t2 $a1 2
addu $t1 $t1 $t2
lw $t3 0($t1)
ble $t3 1 $Label27_1
move $v1 $a0
la $a0 $String11
li $v0 4
syscall
move $a0 $v1
move $v1 $a0
move $a0 $a1
li $v0 1
syscall
move $a0 $v1
move $v1 $a0
la $a0 $String12
li $v0 4
syscall
move $a0 $v1
addiu $t1 $gp 0
sll $t2 $a1 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $v1 $a0
move $a0 $t3
li $v0 1
syscall
move $a0 $v1
j $Label28_1
$Label27_1:
addiu $t1 $gp 0
sll $t2 $a1 2
addu $t1 $t1 $t2
lw $t3 0($t1)
bne $t3 1 $Label29_1
move $v1 $a0
la $a0 $String11
li $v0 4
syscall
move $a0 $v1
move $v1 $a0
move $a0 $a1
li $v0 1
syscall
move $a0 $v1
$Label29_1:
$Label30_1:
$Label28_1:
addiu $a1 $a1 1
ble $a1 $a0 $Label26_1
$Label24_1:
$Label25_1:
$_print_1:
li $v0 10
syscall
# End Of MIPS Assembly Code.
