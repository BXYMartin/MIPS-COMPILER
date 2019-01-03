.data
	$String1:.asciiz " | "
	$String2:.asciiz " | v1: "
	$String3:.asciiz " | b: "
.globl main
.text
limit2char:
sw $a0 28($sp)
addiu $fp $sp 20
addiu $sp $sp 32
lw $t1 8($fp)
div $t3 $t1 256
mul $t4 $t3 256
lw $t1 8($fp)
subu $t5 $t1 $t4
move $v0 $t5
jr $ra
m:
sw $a0 28($sp)
sw $a1 32($sp)
addiu $fp $sp 20
addiu $sp $sp 36
lw $t1 8($fp)
bge $t1 0 $Label1
$Label3:
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
sw $t3 8($fp)
lw $t1 8($fp)
blt $t1 0 $Label3
j $Label2
$Label1:
$Label2:
lw $t1 8($fp)
lw $t2 12($fp)
bge $t1 $t2 $Label4
lw $v0 8($fp)
jr $ra
j $Label5
$Label4:
lw $t1 8($fp)
lw $t2 12($fp)
div $t1 $t2
mflo $t3
lw $t2 12($fp)
mul $t4 $t3 $t2
lw $t1 8($fp)
subu $t5 $t1 $t4
sw $t5 8($fp)
$Label5:
lw $v0 8($fp)
jr $ra
randomset:
addiu $fp $sp 24
addiu $sp $sp 32
lw $t1 32($gp)
addiu $t3 $t1 0
lw $t1 0($gp)
addiu $t4 $t1 0
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -8
addiu $t5 $v0 0
addiu $t1 $gp 56
sll $t2 $t5 2
addu $t1 $t1 $t2
lw $t6 0($t1)
sw $t6 52($gp)
jr $ra
normal:
sw $a0 32($sp)
addiu $fp $sp 24
addiu $sp $sp 36
lw $a0 8($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal limit2char
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
sw $t3 8($fp)
lw $t1 8($fp)
beq $t1 0 $Label6
j $Label7
$Label6:
lw $t1 8($fp)
bne $t1 0 $Label8
li $a0 36
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal limit2char
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
move $v0 $t4
jr $ra
j $Label9
$Label8:
$Label9:
$Label7:
lw $t1 8($fp)
beq $t1 43 $Label10
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal randomset
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -12
j $Label11
$Label10:
$Label11:
lw $t1 8($fp)
ble $t1 47 $Label12
lw $t1 8($fp)
bgt $t1 57 $Label14
lw $a0 8($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal limit2char
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
move $v0 $t3
jr $ra
j $Label15
$Label14:
$Label15:
j $Label13
$Label12:
$Label13:
lw $t1 8($fp)
subu $t3 $t1 32
move $a0 $t3
li $a1 95
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
addiu $t5 $t4 32
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal limit2char
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t6 $v0 0
move $v0 $t6
jr $ra
acc:
sw $a0 32($sp)
addiu $fp $sp 24
addiu $sp $sp 36
lw $a0 8($fp)
li $a1 4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
lw $a0 8($fp)
li $a1 4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
addiu $t1 $gp 36
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
lw $t2 8($fp)
addu $t6 $t5 $t2
sll $t0 $t3 2
addu $t0 $gp $t0
sw $t6 36($t0)
jr $ra
f:
sw $a0 28($sp)
sw $a1 32($sp)
addiu $fp $sp 20
addiu $sp $sp 40
lw $a0 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 16($fp)
lw $a0 16($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal acc
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
lw $t1 8($fp)
mul $t3 $t1 13
lw $t2 16($fp)
addu $t4 $t3 $t2
move $a0 $t4
li $a1 100007
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t5 $v0 0
move $v0 $t5
jr $ra
hash:
sw $a0 28($sp)
addiu $fp $sp 20
addiu $sp $sp 36
lw $t1 0($gp)
addiu $t3 $t1 0
bgt $t3 0 $Label16
jr $ra
j $Label17
$Label16:
$Label17:
lw $t1 8($fp)
sw $t1 32($gp)
li $t1 0
sw $t1 12($fp)
lw $t1 0($gp)
addiu $t3 $t1 0
lw $t1 12($fp)
bge $t1 $t3 $Label18
$Label20:
lw $t1 32($gp)
addiu $t3 $t1 0
addiu $t1 $gp 56
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t4 0($t1)
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal f
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -16
addiu $t5 $v0 0
sw $t5 32($gp)
lw $t1 12($fp)
addiu $t3 $t1 1
sw $t3 12($fp)
lw $t1 0($gp)
addiu $t3 $t1 0
lw $t1 12($fp)
blt $t1 $t3 $Label20
j $Label19
$Label18:
$Label19:
jr $ra
main:
addiu $fp $gp 40056
addiu $sp $fp 20
li $t1 0
sw $t1 0($gp)
li $a0 391
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal hash
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
li $v0 5
syscall
sw $v0 0($gp)
li $t1 0
sw $t1 8($fp)
lw $t1 0($gp)
addiu $t3 $t1 0
lw $t1 8($fp)
bge $t1 $t3 $Label21
$Label23:
li $v0 12
syscall
sw $v0 16($fp)
lw $t1 16($fp)
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 56($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
sw $t3 8($fp)
lw $t1 0($gp)
addiu $t3 $t1 0
lw $t1 8($fp)
blt $t1 $t3 $Label23
j $Label22
$Label21:
$Label22:
li $a0 -20
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 8($fp)
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 8($fp)
li $a0 3
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal m
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 8($fp)
li $a0 0
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 12($fp)
li $a0 43
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 12($fp)
li $a0 47
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 12($fp)
li $a0 49
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t3 $v0 0
sw $t3 12($fp)
lw $t1 0($gp)
addiu $t3 $t1 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
lw $t1 0($gp)
addiu $t3 $t1 0
subu $t4 $t3 1
sw $t4 8($fp)
lw $t1 8($fp)
blt $t1 0 $Label24
$Label26:
addiu $t1 $gp 56
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
sw $t3 12($fp)
addiu $t1 $gp 56
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $t1 8($fp)
subu $t3 $t1 1
sw $t3 8($fp)
lw $t1 8($fp)
bge $t1 0 $Label26
j $Label25
$Label24:
$Label25:
li $a0 391
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal hash
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -20
la $a0 $String2
li $v0 4
syscall
lw $t1 32($gp)
addiu $t3 $t1 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $t1 52($gp)
addiu $t3 $t1 0
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal normal
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $t4 $v0 0
sw $t4 12($fp)
la $a0 $String3
li $v0 4
syscall
lw $a0 12($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $t1 0
sw $t1 8($fp)
lw $t1 8($fp)
bge $t1 4 $Label27
$Label29:
la $a0 $String1
li $v0 4
syscall
addiu $t1 $gp 36
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $t1 8($fp)
addiu $t3 $t1 1
sw $t3 8($fp)
lw $t1 8($fp)
blt $t1 4 $Label29
j $Label28
$Label27:
$Label28:
# End Of MIPS Assembly Code.
