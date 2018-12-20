.data
	$String1:.asciiz "Error in Array & Loop Check!"
	$String2:.asciiz "Array & Loop Check Succeed!"
	$String3:.asciiz "Arithmetic Check Succeed!"
	$String4:.asciiz "Arithmetic Check Failed!"
	$String5:.asciiz "Division Check Passed!"
	$String6:.asciiz "Error in Division Unit!"
	$String7:.asciiz "Value Assignment Succeed!"
	$String8:.asciiz "Negative Assignment Failed!"
	$String9:.asciiz "Positive Assignment Failed!"
	$String10:.asciiz "Basic Assignment Failed!"
	$String11:.asciiz "Error in testing Case Insensitive!"
	$String12:.asciiz "Case Sensitive Detected!"
	$String13:.asciiz "Case Insensitive Passed!"
	$String14:.asciiz "Switch Logic Error!"
	$String15:.asciiz "Switch Parse Check Succeed!"
	$String16:.asciiz "If Statement Error!"
	$String17:.asciiz "Passed If Statement Testing!"
	$String18:.asciiz ""
	$String19:.asciiz "INPUT 0: Basic Test        [Arithmetic, Case Inseneitive, Control Flow Logics]"
	$String20:.asciiz "INPUT 1: Value Type Test   [Char Return, Char Operation, Char Conversion, Escape Char]"
	$String21:.asciiz "INPUT 2: Structure Test    [Loop, Array, Structures]"
	$String22:.asciiz "INPUT 3: Recursive Test    [Permutation, Sequential Sum]"
	$String23:.asciiz "INPUT 4: Exit Program"
	$String24:.asciiz " "
	$String25:.asciiz "Structure Check Succeed!"
	$String26:.asciiz "Error In Register Name!"
	$String27:.asciiz "Illigal Input Detected!"
	$String28:.asciiz "The Following Test Should Output 'Hi, 2018'"
	$String29:.asciiz "This Test Should Output '\\n\\t\\r~!@#$%^&*`' Rather Than Escape Them"
	$String30:.asciiz "#t1"
	$String31:.asciiz "$t1"
	$String32:.asciiz "INPUT P: Permutation Output"
	$String33:.asciiz "INPUT S: Sequential Sum"
	$String34:.asciiz "INPUT INT0 INT1: Select INT1 From INT0 To Do Permutation"
	$String35:.asciiz "ERROR!"
	$String36:.asciiz "INPUT N: Calculate Sum From 1 To N"
	$String37:.asciiz "Sequential Sum Result is: "
	$String38:.asciiz "Recursive Check Succeed!"
	$String39:.asciiz "Error in Recursive Check!"
	$String40:.asciiz "Critical Error Occurred During Testing..."
	$String41:.asciiz "Test Passed!"
	$String42:.asciiz "Test End"
.globl main
.text
pause:
addiu $sp $sp 0
move $k0 $sp
jr $ra
testdo:
addiu $sp $sp 4
move $k0 $sp
addiu $t0 $fp 8
li $t1 0
sw $t1 0($t0)
$Label1:
addiu $t0 $gp 4024
lw $t1 8($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t0 $fp 8
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 8($fp)
ble $a1 15 $Label1
addiu $t0 $fp 8
li $t1 0
sw $t1 0($t0)
$Label2:
lw $t2 8($fp)
mul $t3 $t2 2
lw $t2 8($fp)
subu $t4 $t3 $t2
addiu $t1 $gp 4024
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
lw $t2 8($fp)
li $t0 15
subu $t6 $t0 $t2
addiu $t1 $gp 4024
sll $t2 $t6 2
addu $t1 $t1 $t2
lw $t7 0($t1)
addu $t8 $t5 $t7
addiu $t0 $gp 4024
lw $t1 8($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
addiu $t1 $t8 0
sw $t1 0($t0)
addiu $t1 $gp 4024
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
addiu $t0 $fp 8
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 8($fp)
ble $a1 15 $Label2
addiu $t1 $gp 4024
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t1 $gp 4024
addiu $t1 $t1 20
lw $t4 0($t1)
bne $t3 $t4 $Label3
j $Label4
$Label3:
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label4:
addiu $t1 $gp 4024
addiu $t1 $t1 60
lw $t3 0($t1)
bne $t3 30 $Label5
la $a0 $String2
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label6
$Label5:
la $a0 $String1
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label6:
jr $ra
testarithmetic:
addiu $sp $sp 4
move $k0 $sp
addiu $t0 $fp 8
li $t1 -4
sw $t1 0($t0)
lw $a1 8($fp)
beq $a1 0 $Label7
la $a0 $String3
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label8
$Label7:
la $a0 $String4
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label8:
addiu $t0 $fp 8
li $t1 11
sw $t1 0($t0)
lw $a1 8($fp)
bne $a1 11 $Label9
la $a0 $String5
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label10
$Label9:
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label10:
jr $ra
testvalue:
addiu $sp $sp 0
move $k0 $sp
addiu $t0 $gp 4012
li $t1 0
sw $t1 0($t0)
lw $a1 4012($gp)
bne $a1 0 $Label11
lw $a1 4012($gp)
bge $a1 1 $Label13
lw $a1 4012($gp)
ble $a1 -3 $Label15
la $a0 $String7
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label16
$Label15:
la $a0 $String8
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label16:
j $Label14
$Label13:
la $a0 $String9
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label14:
j $Label12
$Label11:
la $a0 $String10
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
$Label12:
jr $ra
testcaseinsensitive:
addiu $sp $sp 4
move $k0 $sp
addiu $t0 $fp 8
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 8
li $t1 1
sw $t1 0($t0)
lw $a1 8($fp)
beq $a1 0 $Label18
lw $a1 8($fp)
beq $a1 1 $Label19
la $a0 $String11
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label17
$Label18:
la $a0 $String12
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label17
$Label19:
la $a0 $String13
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label17
$Label17:
jr $ra
testswitch:
sw $a0 0($sp)
addiu $sp $sp 8
move $k0 $sp
addiu $t0 $fp 12
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $gp 4020
li $t1 1
sw $t1 0($t0)
lw $t1 12($fp)
addiu $t3 $t1 -3
lw $t1 4020($gp)
mul $t4 $t1 1
addu $t5 $t3 $t4
beq $t5 1 $Label22
la $a0 $String14
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label21
$Label22:
la $a0 $String15
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label21
$Label21:
jr $ra
testif:
addiu $sp $sp 0
move $k0 $sp
li $t3 0
beq $t3 0 $Label24
la $a0 $String16
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label25
$Label24:
la $a0 $String17
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label25:
jr $ra
calrecursive:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
move $k0 $sp
lw $a1 8($fp)
lw $a2 8($gp)
bne $a1 $a2 $Label26
addiu $t1 $gp 12
addiu $t1 $t1 0
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $fp 16
li $t1 1
sw $t1 0($t0)
lw $a1 16($fp)
lw $a2 8($gp)
bge $a1 $a2 $Label28
$Label30:
addiu $t1 $gp 12
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t0 $fp 16
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 16($fp)
lw $a2 8($gp)
blt $a1 $a2 $Label30
j $Label29
$Label28:
$Label29:
la $a0 $String18
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
j $Label27
$Label26:
$Label27:
addiu $t0 $fp 16
lw $t1 12($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 8($fp)
lw $t2 4($gp)
addu $t3 $t1 $t2
lw $t2 8($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
lw $a1 16($fp)
bgt $a1 $t5 $Label31
$Label33:
addiu $t0 $gp 12
lw $t1 8($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 16($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
lw $t1 16($fp)
addiu $t4 $t1 1
move $a0 $t3
move $a1 $t4
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal calrecursive
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
lw $t1 16($fp)
addiu $t5 $t1 1
addiu $t0 $fp 16
addiu $t1 $t5 0
sw $t1 0($t0)
lw $t1 8($fp)
lw $t2 4($gp)
addu $t3 $t1 $t2
lw $t2 8($gp)
subu $t4 $t3 $t2
addiu $t5 $t4 1
lw $a1 16($fp)
ble $a1 $t5 $Label33
j $Label32
$Label31:
$Label32:
jr $ra
initpermutation:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 12
move $k0 $sp
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
$Label34:
addiu $t0 $gp 12
lw $t1 16($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t0 $fp 16
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 16($fp)
lw $a2 12($fp)
ble $a1 $a2 $Label34
jr $ra
jr $ra
seqsum:
sw $a0 0($sp)
addiu $sp $sp 4
move $k0 $sp
lw $a1 8($fp)
bne $a1 1 $Label35
li $v0 1
jr $ra
j $Label36
$Label35:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal seqsum
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
lw $t1 8($fp)
addu $t5 $t1 $t4
move $v0 $t5
jr $ra
$Label36:
printtable:
addiu $sp $sp 0
move $k0 $sp
la $a0 $String19
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String20
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String21
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String22
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String23
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
and:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 8
move $k0 $sp
lw $a1 12($fp)
bne $a1 4 $Label37
li $v0 0
jr $ra
j $Label38
$Label37:
lw $a1 8($fp)
bne $a1 0 $Label39
li $v0 1
jr $ra
j $Label40
$Label39:
li $v0 0
jr $ra
$Label40:
$Label38:
helpchar:
addiu $sp $sp 4
move $k0 $sp
addiu $t0 $fp 8
li $t1 44
sw $t1 0($t0)
lw $v0 8($fp)
jr $ra
typecorrosion:
addiu $sp $sp 8
move $k0 $sp
addiu $t0 $fp 12
li $t1 105
sw $t1 0($t0)
addiu $t0 $fp 8
li $t1 8
sw $t1 0($t0)
li $a0 72
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $a0 12($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal helpchar
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
move $a0 $t3
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String24
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $a0 2
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 1
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
jr $ra
testemptyfunction:
addiu $sp $sp 0
move $k0 $sp
jr $ra
teststructure:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
addiu $sp $sp 28
move $k0 $sp
lw $a0 8($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 12($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 16($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $a0 20($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $a0 24($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
lw $t1 16($fp)
lw $t2 24($fp)
subu $t3 $t1 $t2
lw $t1 8($fp)
lw $t2 12($fp)
addu $t4 $t1 $t2
lw $t2 20($fp)
addu $t5 $t4 $t2
lw $t2 16($fp)
subu $t6 $t5 $t2
subu $t7 $t6 $t3
beq $t7 66666 $Label42
beq $t7 0 $Label43
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label41
$Label42:
la $a0 $String25
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $fp 28
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 32
li $t1 0
sw $t1 0($t0)
j $Label41
$Label43:
la $a0 $String26
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
j $Label41
$Label41:
jr $ra
main:
li $k1 268502232
addiu $fp $gp 4168
addiu $sp $fp 8
addiu $sp $sp 8
move $k0 $sp
addiu $t0 $gp 0
li $t1 0
sw $t1 0($t0)
addiu $t0 $gp 4164
li $t1 48
sw $t1 0($t0)
$Label45:
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal printtable
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $v0 5
syscall
addiu $a3 $fp 12
sw $v0 0($a3)
lw $a1 12($fp)
beq $a1 0 $Label47
lw $a1 12($fp)
beq $a1 1 $Label48
lw $a1 12($fp)
beq $a1 2 $Label49
lw $a1 12($fp)
beq $a1 3 $Label50
lw $a1 12($fp)
beq $a1 4 $Label59
la $a0 $String27
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label46
$Label47:
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal testvalue
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal testarithmetic
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal testif
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 3
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal testswitch
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label46
$Label48:
la $a0 $String28
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal typecorrosion
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String29
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String30
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String31
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label46
$Label49:
addiu $t0 $gp 4088
li $t1 49
sw $t1 0($t0)
addiu $t0 $gp 4096
li $t1 50
sw $t1 0($t0)
addiu $t0 $gp 4012
li $t1 12345
sw $t1 0($t0)
addiu $t0 $gp 4020
li $t1 54321
sw $t1 0($t0)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $ra 32($sp)
sw $fp 36($sp)
addiu $sp $sp 40
addiu $fp $sp -8
jal testdo
move $sp $fp
addiu $sp $sp -32
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal testemptyfunction
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
lw $a0 4012($gp)
lw $a1 4020($gp)
lw $a2 4088($gp)
lw $a3 4096($gp)
lw $v0 4164($gp)
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal teststructure
move $sp $fp
addiu $sp $sp -28
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label46
$Label50:
la $a0 $String32
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String33
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
addiu $a3 $fp 8
sw $v0 0($a3)
lw $a1 8($fp)
beq $a1 80 $Label52
lw $a1 8($fp)
beq $a1 83 $Label55
la $a0 $String27
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label51
$Label52:
la $a0 $String34
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $gp 4
sw $v0 0($a3)
li $v0 5
syscall
addiu $a3 $gp 8
sw $v0 0($a3)
la $a0 $String18
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
lw $t1 8($gp)
addiu $t3 $t1 1
ble $t3 1000 $Label53
la $a0 $String35
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 10
syscall
j $Label54
$Label53:
$Label54:
lw $t1 8($gp)
addiu $t3 $t1 1
li $a0 0
move $a1 $t3
sw $k0 0($sp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal initpermutation
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 0
li $a1 1
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal calrecursive
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label51
$Label55:
la $a0 $String36
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $fp 12
sw $v0 0($a3)
la $a0 $String37
li $v0 4
syscall
lw $a0 12($fp)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal seqsum
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
move $a0 $t4
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $a0 10
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal seqsum
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
bne $t4 55 $Label56
la $a0 $String38
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label57
$Label56:
addiu $t0 $gp 0
li $t1 1
sw $t1 0($t0)
la $a0 $String39
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label57:
addiu $t0 $fp 12
li $t1 3
sw $t1 0($t0)
j $Label51
$Label51:
j $Label46
$Label59:
j $Label46
$Label46:
lw $a0 0($gp)
lw $a1 12($fp)
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal and
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
bne $t3 0 $Label45
lw $a1 0($gp)
blt $a1 1 $Label61
la $a0 $String40
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label62
$Label61:
la $a0 $String41
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label62:
la $a0 $String42
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
