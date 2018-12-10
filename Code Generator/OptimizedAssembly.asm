.data
	$String18:.asciiz "Error Type Not Define."
	$String19:.asciiz "Invalid Input."
	$String20:.asciiz "Max value limit."
	$String21:.asciiz "Min value limit."
	$String22:.asciiz "Letter is "
	$String23:.asciiz ""
	$String24:.asciiz "Complex Expression = "
	$String25:.asciiz "Please Input Lower Bound and Upper Bound:"
	$String26:.asciiz "Please Input A Char:"
	$String27:.asciiz "X sum to Y = "
	$String28:.asciiz "It's already "
	$String29:.asciiz "It is Lower c."
	$String30:.asciiz "It is not Lower c"
	$String31:.asciiz "\\tReturnC is Upper C.\\n"
	$String32:.asciiz "ReturnC is not Upper C"
	$String33:.asciiz "Final i = "
	$String34:.asciiz "Register_Disater = "
.globl main
.text
returnyear:
addiu $sp $sp 0
move $k0 $sp
li $v0 2018
jr $ra
add:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
move $k0 $sp
addu $t3 $s0 $s1
move $v0 $t3
jr $ra
error:
move $s0 $a0
addiu $sp $sp 4
move $k0 $sp
beq $s0 1 $Label2
beq $s0 2 $Label3
beq $s0 3 $Label6
la $a0 $String18
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label5
$Label6:
la $a0 $String19
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label5
$Label5:
j $Label1
$Label2:
la $a0 $String20
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label1
$Label3:
la $a0 $String21
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label1
$Label1:
addiu $s2 $s2 1
jr $ra
cumulative_sum:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
move $k0 $sp
ble $s0 $s1 $Label8
li $a0 3
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label9
$Label8:
ble $s1 100 $Label10
li $a0 1
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label11
$Label10:
bge $s0 -100 $Label12
li $a0 2
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label13
$Label12:
subu $t3 $s0 $s1
beq $t3 0 $Label14
addiu $t3 $s0 1
move $a0 $t3
move $a1 $s1
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal cumulative_sum
move $sp $fp
addiu $sp $sp -28
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
move $a0 $s0
move $a1 $t4
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal add
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t5 $t1 0
move $v0 $t5
jr $ra
j $Label15
$Label14:
move $v0 $s0
jr $ra
$Label15:
$Label13:
$Label11:
$Label9:
returnc:
addiu $sp $sp 0
move $k0 $sp
bge $s3 5 $Label16
addiu $s3 $s3 1
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal returnc
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
move $v0 $t3
jr $ra
j $Label17
$Label16:
li $v0 67
jr $ra
$Label17:
output:
move $s0 $a0
addiu $sp $sp 4
move $k0 $sp
$Label18:
la $a0 $String22
li $v0 4
syscall
move $a0 $s0
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
move $v0 $s0
jr $ra
li $t3 1
bne $t3 0 $Label18
register_disaster:
move $s0 $a0
move $s1 $a1
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
lw $v1 4($k1)
sw $v1 20($sp)
lw $v1 8($k1)
sw $v1 24($sp)
lw $v1 12($k1)
sw $v1 28($sp)
lw $v1 16($k1)
sw $v1 32($sp)
lw $v1 20($k1)
sw $v1 36($sp)
lw $v1 24($k1)
sw $v1 40($sp)
lw $v1 28($k1)
sw $v1 44($sp)
addiu $sp $sp 64
addiu $k0 $sp -16
li $s0 1
addiu $t0 $fp 44
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 1
sw $t1 0($t0)
li $s1 1
addiu $t0 $fp 16
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 28
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 32
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 36
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 40
li $t1 1
sw $t1 0($t0)
addu $t3 $s0 $s0
addu $t4 $t3 $s0
addu $t5 $t4 $s0
addu $t6 $t5 $s0
addu $t7 $t6 $s0
addu $t8 $t7 $s0
addu $t9 $t8 $s0
addiu $t0 $k0 0
addu $t1 $t9 $s0
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t1 0($k0)
addu $t1 $t1 $s0
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 4($k0)
addu $t1 $t1 $s0
sw $t1 0($t0)
addiu $t0 $k0 12
lw $t1 8($k0)
addu $t1 $t1 $s0
sw $t1 0($t0)
lw $v0 12($k0)
jr $ra
warning:
addiu $sp $sp 0
move $k0 $sp
jr $ra
test:
addiu $sp $sp 40
addiu $k0 $sp -12
li $s0 65
addiu $t0 $fp 20
addiu $t0 $t0 0
li $t1 49
sw $t1 0($t0)
addiu $t0 $fp 20
addiu $t0 $t0 4
li $t1 50
sw $t1 0($t0)
addiu $t0 $fp 20
addiu $t0 $t0 8
li $t1 97
sw $t1 0($t0)
li $s1 10
beq $s0 65 $Label20
beq $s0 97 $Label22
addiu $t0 $fp 8
li $t1 -1
sw $t1 0($t0)
j $Label19
$Label20:
$Label21:
addiu $t1 $fp 20
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t1 $fp 20
addiu $t1 $t1 0
lw $t4 0($t1)
addiu $t1 $fp 20
addiu $t1 $t1 8
lw $t5 0($t1)
addiu $t6 $s0 131
addu $t7 $t6 $t3
subu $t8 $t7 $t4
subu $t9 $t8 $t5
addiu $t0 $k0 0
mul $t1 $s1 1
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $fp 8
lw $t1 8($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
subu $s1 $s1 1
bge $s1 0 $Label21
j $Label19
$Label22:
addiu $t1 $fp 20
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t1 $fp 20
addiu $t1 $t1 0
lw $t4 0($t1)
addiu $t1 $fp 20
addiu $t1 $t1 8
lw $t5 0($t1)
addiu $t6 $s0 221
addu $t7 $t6 $t3
subu $t8 $t7 $t4
subu $t9 $t8 $t5
addiu $t0 $k0 0
mul $t1 $s1 1
sw $t1 0($t0)
addiu $t0 $fp 8
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
j $Label19
$Label19:
la $a0 $String23
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String24
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s1 10
$Label24:
blt $s1 5 $Label25
beq $s1 10 $Label28
beq $s1 57 $Label29
beq $s1 8 $Label30
beq $s1 55 $Label31
beq $s1 6 $Label32
li $s0 70
j $Label27
$Label28:
li $s0 65
j $Label27
$Label29:
li $s0 66
j $Label27
$Label30:
li $s0 67
j $Label27
$Label31:
li $s0 68
j $Label27
$Label32:
li $s0 69
j $Label27
$Label27:
j $Label26
$Label25:
mul $t3 $s1 2
div $t4 $t3 2
addiu $t5 $t4 48
subu $t6 $t5 0
beq $t6 0 $Label35
beq $t6 48 $Label36
li $s0 71
j $Label34
$Label35:
li $s0 65
j $Label34
$Label36:
li $s0 48
j $Label34
$Label34:
$Label26:
subu $s1 $s1 1
bge $s1 0 $Label24
move $a0 $s0
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal output
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 4
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
main:
li $k1 268501304
addiu $fp $gp 36
addiu $sp $fp 8
addiu $sp $sp 816
move $k0 $sp
li $s5 1
li $s6 2
addiu $t0 $gp 24
li $t1 48
sw $t1 0($t0)
addiu $t0 $gp 28
li $t1 49
sw $t1 0($t0)
addiu $t0 $gp 32
li $t1 50
sw $t1 0($t0)
la $a0 $String25
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s0 $v0
li $v0 5
syscall
move $s1 $v0
la $a0 $String26
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
addiu $a3 $fp 16
sw $v0 0($a3)
li $s4 0
$Label38:
mul $t3 $s4 1
subu $t4 $t3 1
addiu $t5 $t4 1
move $a0 $s0
move $a1 $s1
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal cumulative_sum
move $sp $fp
addiu $sp $sp -28
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 24
sll $t1 $t5 2
addu $t0 $t0 $t1
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
li $t3 0
bne $t3 0 $Label38
li $s4 1
$Label39:
addiu $t0 $fp 24
sll $t1 $s4 2
addu $t0 $t0 $t1
addiu $t1 $s4 0
sw $t1 0($t0)
addiu $s4 $s4 1
subu $t3 $s1 $s0
blt $s4 $t3 $Label39
li $s4 1
blt $s0 -100 $Label40
bgt $s1 100 $Label42
bgt $s0 $s1 $Label44
la $a0 $String27
li $v0 4
syscall
addiu $t1 $fp 24
addiu $t1 $t1 0
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
$Label44:
$Label45:
$Label42:
$Label43:
$Label40:
$Label41:
la $a0 $String28
li $v0 4
syscall
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal returnyear
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
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
lw $a0 16($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal output
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 20
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
lw $a1 20($fp)
bne $a1 99 $Label46
la $a0 $String29
li $v0 4
syscall
move $a0 $s5
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label47
$Label46:
la $a0 $String30
li $v0 4
syscall
move $a0 $s6
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
$Label47:
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal returnc
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 20
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 20($fp)
addiu $t3 $t1 0
bne $t3 67 $Label48
la $a0 $String31
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label49
$Label48:
la $a0 $String32
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label49:
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal warning
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
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
jal test
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
la $a0 $String33
li $v0 4
syscall
move $a0 $s4
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String34
li $v0 4
syscall
li $a0 0
li $a1 0
li $a2 0
li $a3 0
li $v0 0
sw $v0 0($k1)
li $v0 0
sw $v0 4($k1)
li $v0 0
sw $v0 8($k1)
li $v0 0
sw $v0 12($k1)
li $v0 0
sw $v0 16($k1)
li $v0 0
sw $v0 20($k1)
li $v0 0
sw $v0 24($k1)
li $v0 0
sw $v0 28($k1)
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
jal register_disaster
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
# End Of MIPS Assembly Code.
