.data
	$String7:.asciiz " | "
	$String8:.asciiz " | v1: "
	$String9:.asciiz " | b: "
.globl main
.text
limit2char:
move $a0 $a0
addiu $fp $sp 24
addiu $sp $sp 36
m:
move $a0 $a0
move $a1 $a1
addiu $fp $sp 24
addiu $sp $sp 40
randomset:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 32($gp)
addiu $t3 $t1 0
lw $t1 0($gp)
addiu $t4 $t1 0
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1
$Label3_1:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1
$Label1_1:
$Label2_1:
bge $a0 $a1 $Label4_1
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1
j $Label5_1
$Label4_1:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1:
addiu $t5 $v0 0
addiu $t1 $gp 56
sll $t2 $t5 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 52($gp)
jr $ra
normal:
move $s0 $a0
addiu $fp $sp 16
addiu $sp $sp 28
move $a0 $s0
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
div $t3 $a0 256
mul $t4 $t3 256
subu $t5 $a0 $t4
move $v0 $t5
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
$_limit2char_1:
addiu $s0 $v0 0
beq $s0 0 $Label6
j $Label7
$Label6:
bne $s0 0 $Label8
li $a0 36
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
div $t3 $a0 256
mul $t4 $t3 256
subu $t5 $a0 $t4
move $v0 $t5
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
$_limit2char_1_2:
jr $ra
$Label8:
$Label9:
$Label7:
beq $s0 43 $Label10
sw $ra 8($sp)
jal randomset
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -12
$Label10:
$Label11:
ble $s0 47 $Label12
bgt $s0 57 $Label14
move $a0 $s0
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
div $t3 $a0 256
mul $t4 $t3 256
subu $t5 $a0 $t4
move $v0 $t5
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
$_limit2char_1_2_3:
jr $ra
$Label14:
$Label15:
$Label12:
$Label13:
subu $t3 $s0 32
move $a0 $t3
li $a1 95
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2
$Label3_1_2:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2
$Label1_1_2:
$Label2_1_2:
bge $a0 $a1 $Label4_1_2
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2
j $Label5_1_2
$Label4_1_2:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2:
addiu $t5 $v0 32
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
div $t3 $a0 256
mul $t4 $t3 256
subu $t5 $a0 $t4
move $v0 $t5
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
$_limit2char_1_2_3_4:
jr $ra
acc:
move $s0 $a0
addiu $fp $sp 12
addiu $sp $sp 24
move $a0 $s0
li $a1 4
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3
$Label3_1_2_3:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3
$Label1_1_2_3:
$Label2_1_2_3:
bge $a0 $a1 $Label4_1_2_3
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3
j $Label5_1_2_3
$Label4_1_2_3:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3:
addiu $t3 $v0 0
move $a0 $s0
li $a1 4
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3_4
$Label3_1_2_3_4:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3_4
$Label1_1_2_3_4:
$Label2_1_2_3_4:
bge $a0 $a1 $Label4_1_2_3_4
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3_4
j $Label5_1_2_3_4
$Label4_1_2_3_4:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3_4:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3_4:
addiu $t4 $v0 0
addiu $t1 $gp 36
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addu $t1 $t5 $s0
sll $t0 $t3 2
addu $t0 $gp $t0
sw $t1 36($t0)
jr $ra
f:
move $s2 $a0
move $s1 $a1
addiu $fp $sp 28
addiu $sp $sp 48
move $a0 $s1
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s0 $v0 0
move $a0 $s0
sw $s0 8($sp)
sw $ra 12($sp)
jal acc
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -20
mul $t3 $s2 13
addu $t4 $t3 $s0
move $a0 $t4
li $a1 100007
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3_4_5
$Label3_1_2_3_4_5:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3_4_5
$Label1_1_2_3_4_5:
$Label2_1_2_3_4_5:
bge $a0 $a1 $Label4_1_2_3_4_5
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3_4_5
j $Label5_1_2_3_4_5
$Label4_1_2_3_4_5:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3_4_5:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3_4_5:
jr $ra
hash:
move $s1 $a0
addiu $fp $sp 16
addiu $sp $sp 32
lw $t1 0($gp)
bgt $t1 0 $Label16
jr $ra
$Label16:
$Label17:
sw $s1 32($gp)
li $s0 0
lw $t2 0($gp)
bge $s0 $t2 $Label18
$Label20:
lw $t1 32($gp)
addiu $t3 $t1 0
addiu $t1 $gp 56
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t4 0($t1)
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $s2 24($sp)
sw $ra 28($sp)
jal f
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $s2 24($sp)
lw $ra 0($fp)
addiu $fp $sp -16
sw $v0 32($gp)
addiu $s0 $s0 1
lw $t2 0($gp)
blt $s0 $t2 $Label20
$Label18:
$Label19:
jr $ra
main:
li $k1 268501012
addiu $fp $gp 40056
addiu $sp $fp 20
li $t1 0
sw $t1 0($gp)
li $a0 391
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal hash
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
li $v0 5
syscall
sw $v0 0($gp)
li $s0 0
lw $t2 0($gp)
bge $s0 $t2 $Label21
$Label23:
li $v0 12
syscall
move $s1 $v0
sll $t0 $s0 2
addu $t0 $gp $t0
sw $s1 56($t0)
addiu $s0 $s0 1
lw $t2 0($gp)
blt $s0 $t2 $Label23
$Label21:
$Label22:
li $a0 -20
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3_4_5_6
$Label3_1_2_3_4_5_6:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3_4_5_6
$Label1_1_2_3_4_5_6:
$Label2_1_2_3_4_5_6:
bge $a0 $a1 $Label4_1_2_3_4_5_6
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3_4_5_6
j $Label5_1_2_3_4_5_6
$Label4_1_2_3_4_5_6:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3_4_5_6:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3_4_5_6:
addiu $s0 $v0 0
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3_4_5_6_7
$Label3_1_2_3_4_5_6_7:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3_4_5_6_7
$Label1_1_2_3_4_5_6_7:
$Label2_1_2_3_4_5_6_7:
bge $a0 $a1 $Label4_1_2_3_4_5_6_7
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3_4_5_6_7
j $Label5_1_2_3_4_5_6_7
$Label4_1_2_3_4_5_6_7:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3_4_5_6_7:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3_4_5_6_7:
addiu $s0 $v0 0
li $a0 3
li $a1 2
sw $t3 8($sp)
sw $t4 12($sp)
bge $a0 0 $Label1_1_2_3_4_5_6_7_8
$Label3_1_2_3_4_5_6_7_8:
addu $a0 $a0 $a1
blt $a0 0 $Label3_1_2_3_4_5_6_7_8
$Label1_1_2_3_4_5_6_7_8:
$Label2_1_2_3_4_5_6_7_8:
bge $a0 $a1 $Label4_1_2_3_4_5_6_7_8
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
j $_m_1_2_3_4_5_6_7_8
j $Label5_1_2_3_4_5_6_7_8
$Label4_1_2_3_4_5_6_7_8:
div $a0 $a1
mflo $t3
mul $t4 $t3 $a1
subu $a0 $a0 $t4
$Label5_1_2_3_4_5_6_7_8:
move $v0 $a0
lw $t3 8($sp)
lw $t4 12($sp)
$_m_1_2_3_4_5_6_7_8:
addiu $s0 $v0 0
li $a0 0
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s2 $v0 0
li $a0 43
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s2 $v0 0
li $a0 47
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s2 $v0 0
li $a0 49
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s2 $v0 0
lw $t1 0($gp)
addiu $t3 $t1 0
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String7
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
lw $t1 0($gp)
subu $s0 $t1 1
blt $s0 0 $Label24
$Label26:
addiu $t1 $gp 56
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $s2 0($t1)
move $a0 $s2
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
subu $s0 $s0 1
bge $s0 0 $Label26
$Label24:
$Label25:
li $a0 391
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
jal hash
addiu $sp $fp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
la $a0 $String8
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
sw $s0 12($sp)
sw $ra 16($sp)
jal normal
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -20
addiu $s2 $v0 0
la $a0 $String9
li $v0 4
syscall
move $a0 $s2
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 0
bge $s0 4 $Label27
$Label29:
la $a0 $String7
li $v0 4
syscall
addiu $t1 $gp 36
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $s0 $s0 1
blt $s0 4 $Label29
$Label27:
$Label28:
# End Of MIPS Assembly Code.
