.data
	$String1:.asciiz "Error Type Not Define."
	$String2:.asciiz "Invalid Input."
	$String3:.asciiz "Max value limit."
	$String4:.asciiz "Min value limit."
	$String5:.asciiz "Letter is "
	$String6:.asciiz ""
	$String7:.asciiz "Complex Expression = "
	$String8:.asciiz "Please Input Lower Bound and Upper Bound:"
	$String9:.asciiz "Please Input A Char:"
	$String10:.asciiz "X sum to Y = "
	$String11:.asciiz "It's already "
	$String12:.asciiz "It is Lower c."
	$String13:.asciiz "It is not Lower c"
	$String14:.asciiz "\\tReturnC is Upper C.\\n"
	$String15:.asciiz "ReturnC is not Upper C"
	$String16:.asciiz "Final i = "
	$String17:.asciiz "Register_Disater = "
.globl main
.text
returnyear:
addiu $sp $sp 0
move $k0 $sp
li $v0 2018
jr $ra
add:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 8
move $k0 $sp
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
error:
sw $a0 0($sp)
addiu $sp $sp 4
move $k0 $sp
lw $a1 8($fp)
beq $a1 1 $Label2
lw $a1 8($fp)
beq $a1 2 $Label3
lw $a1 8($fp)
beq $a1 3 $Label6
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label5
$Label6:
la $a0 $String2
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label5
$Label5:
j $Label1
$Label2:
la $a0 $String3
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label1
$Label3:
la $a0 $String4
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label1
$Label1:
lw $t1 0($gp)
addiu $t3 $t1 1
addiu $t0 $gp 0
addiu $t1 $t3 0
sw $t1 0($t0)
jr $ra
jr $ra
cumulative_sum:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 8
move $k0 $sp
lw $a1 8($fp)
lw $a2 12($fp)
ble $a1 $a2 $Label8
li $a0 3
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label9
$Label8:
lw $a1 12($fp)
ble $a1 100 $Label10
li $a0 1
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label11
$Label10:
lw $a1 8($fp)
bge $a1 -100 $Label12
li $a0 2
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label13
$Label12:
lw $t1 8($fp)
lw $t2 12($fp)
subu $t3 $t1 $t2
beq $t3 0 $Label14
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal cumulative_sum
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
lw $a0 8($fp)
move $a1 $t4
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal add
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t5 $t1 0
move $v0 $t5
jr $ra
j $Label15
$Label14:
lw $v0 8($fp)
jr $ra
$Label15:
$Label13:
$Label11:
$Label9:
returnc:
addiu $sp $sp 0
move $k0 $sp
lw $a1 4($gp)
bge $a1 5 $Label16
lw $t1 4($gp)
addiu $t3 $t1 1
addiu $t0 $gp 4
addiu $t1 $t3 0
sw $t1 0($t0)
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
sw $a0 0($sp)
addiu $sp $sp 4
move $k0 $sp
$Label18:
la $a0 $String5
li $v0 4
syscall
lw $a0 8($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $v0 8($fp)
jr $ra
li $t3 1
bne $t3 0 $Label18
register_disaster:
sw $a0 0($sp)
sw $a1 4($sp)
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
addiu $t0 $fp 8
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 12
li $t1 1
sw $t1 0($t0)
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
addiu $t0 $fp 44
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 1
sw $t1 0($t0)
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
addu $t5 $t4 $t2
lw $t2 24($fp)
addu $t6 $t5 $t2
lw $t2 28($fp)
addu $t7 $t6 $t2
lw $t2 32($fp)
addu $t8 $t7 $t2
lw $t2 36($fp)
addu $t9 $t8 $t2
addiu $t0 $k0 0
lw $t2 40($fp)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t1 0($k0)
lw $t2 44($fp)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 4($k0)
lw $t2 48($fp)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 12
lw $t1 8($k0)
lw $t2 52($fp)
addu $t1 $t1 $t2
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
addiu $t0 $fp 12
li $t1 65
sw $t1 0($t0)
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
addiu $t0 $fp 32
li $t1 10
sw $t1 0($t0)
lw $a1 12($fp)
beq $a1 65 $Label20
lw $a1 12($fp)
beq $a1 97 $Label22
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
lw $t1 12($fp)
addiu $t6 $t1 131
addu $t7 $t6 $t3
subu $t8 $t7 $t4
subu $t9 $t8 $t5
addiu $t0 $k0 0
lw $t1 32($fp)
mul $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 4($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $fp 8
lw $t1 8($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 32($fp)
subu $t3 $t1 1
addiu $t0 $fp 32
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 32($fp)
bge $a1 0 $Label21
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
lw $t1 12($fp)
addiu $t6 $t1 221
addu $t7 $t6 $t3
subu $t8 $t7 $t4
subu $t9 $t8 $t5
addiu $t0 $k0 0
lw $t1 32($fp)
mul $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $fp 8
lw $t1 4($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
j $Label19
$Label19:
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String7
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $fp 32
li $t1 10
sw $t1 0($t0)
$Label24:
lw $a1 32($fp)
blt $a1 5 $Label25
lw $a1 32($fp)
beq $a1 10 $Label28
lw $a1 32($fp)
beq $a1 57 $Label29
lw $a1 32($fp)
beq $a1 8 $Label30
lw $a1 32($fp)
beq $a1 55 $Label31
lw $a1 32($fp)
beq $a1 6 $Label32
addiu $t0 $fp 12
li $t1 70
sw $t1 0($t0)
j $Label27
$Label28:
addiu $t0 $fp 12
li $t1 65
sw $t1 0($t0)
j $Label27
$Label29:
addiu $t0 $fp 12
li $t1 66
sw $t1 0($t0)
j $Label27
$Label30:
addiu $t0 $fp 12
li $t1 67
sw $t1 0($t0)
j $Label27
$Label31:
addiu $t0 $fp 12
li $t1 68
sw $t1 0($t0)
j $Label27
$Label32:
addiu $t0 $fp 12
li $t1 69
sw $t1 0($t0)
j $Label27
$Label27:
j $Label26
$Label25:
lw $t1 32($fp)
mul $t3 $t1 2
div $t4 $t3 2
addiu $t5 $t4 48
subu $t6 $t5 0
beq $t6 0 $Label35
beq $t6 48 $Label36
addiu $t0 $fp 12
li $t1 71
sw $t1 0($t0)
j $Label34
$Label35:
addiu $t0 $fp 12
li $t1 65
sw $t1 0($t0)
j $Label34
$Label36:
addiu $t0 $fp 12
li $t1 48
sw $t1 0($t0)
j $Label34
$Label34:
$Label26:
lw $t1 32($fp)
subu $t3 $t1 1
addiu $t0 $fp 32
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 32($fp)
bge $a1 0 $Label24
lw $a0 12($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal output
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 4
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal error
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
main:
li $k1 268501308
addiu $fp $gp 36
addiu $sp $fp 8
addiu $sp $sp 816
move $k0 $sp
addiu $t0 $gp 12
li $t1 1
sw $t1 0($t0)
addiu $t0 $gp 16
li $t1 2
sw $t1 0($t0)
addiu $t0 $gp 24
li $t1 48
sw $t1 0($t0)
addiu $t0 $gp 28
li $t1 49
sw $t1 0($t0)
addiu $t0 $gp 32
li $t1 50
sw $t1 0($t0)
la $a0 $String8
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
la $a0 $String9
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
addiu $a3 $fp 16
sw $v0 0($a3)
addiu $t0 $gp 8
li $t1 0
sw $t1 0($t0)
$Label38:
lw $t1 8($gp)
mul $t3 $t1 1
subu $t4 $t3 1
addiu $t5 $t4 1
lw $a0 8($fp)
lw $a1 12($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal cumulative_sum
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t6 $t1 0
addiu $t0 $fp 24
sll $t1 $t5 2
addu $t0 $t0 $t1
addiu $t1 $t6 0
sw $t1 0($t0)
li $t3 0
bne $t3 0 $Label38
addiu $t0 $gp 8
li $t1 1
sw $t1 0($t0)
$Label39:
addiu $t0 $fp 24
lw $t1 8($gp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 8($gp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 8($gp)
addiu $t3 $t1 1
addiu $t0 $gp 8
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 12($fp)
lw $t2 8($fp)
subu $t3 $t1 $t2
lw $a1 8($gp)
blt $a1 $t3 $Label39
addiu $t0 $gp 8
li $t1 1
sw $t1 0($t0)
lw $a1 8($fp)
blt $a1 -100 $Label40
lw $a1 12($fp)
bgt $a1 100 $Label42
lw $a1 8($fp)
lw $a2 12($fp)
bgt $a1 $a2 $Label44
la $a0 $String10
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
j $Label45
$Label44:
$Label45:
j $Label43
$Label42:
$Label43:
j $Label41
$Label40:
$Label41:
la $a0 $String11
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
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal output
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
addiu $t0 $fp 20
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 20($fp)
bne $a1 99 $Label46
la $a0 $String12
li $v0 4
syscall
lw $a0 12($gp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label47
$Label46:
la $a0 $String13
li $v0 4
syscall
lw $a0 16($gp)
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
move $t1 $v0
addiu $t3 $t1 0
addiu $t0 $fp 20
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 20($fp)
addiu $t3 $t1 0
bne $t3 67 $Label48
la $a0 $String14
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label49
$Label48:
la $a0 $String15
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
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal test
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
la $a0 $String16
li $v0 4
syscall
lw $a0 8($gp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String17
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
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal register_disaster
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
# End Of MIPS Assembly Code.
