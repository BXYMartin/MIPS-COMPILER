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
	$String28:.asciiz "The Following Test Should Output 'Hi+ 2018'"
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
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
testdo:
addiu $fp $sp 32
addiu $sp $sp 44
li $t1 0
sw $t1 8($fp)
$Label1:
lw $t1 8($fp)
addiu $t1 $t1 0
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 4024($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 15 $Label1
li $t1 0
sw $t1 8($fp)
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
addiu $t1 $t8 0
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 4024($t0)
addiu $t1 $gp 4024
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 15 $Label2
lw $t3 4028($gp)
lw $t4 4044($gp)
bne $t3 $t4 $Label3
j $Label4
$Label3:
la $a0 $String1
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label4:
lw $t3 4084($gp)
bne $t3 30 $Label5
la $a0 $String2
li $v0 4
syscall
j $Label6
$Label5:
la $a0 $String1
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label6:
jr $ra
testarithmetic:
addiu $fp $sp 8
addiu $sp $sp 20
li $t1 -4
sw $t1 8($fp)
lw $a1 8($fp)
beq $a1 0 $Label7
la $a0 $String3
li $v0 4
syscall
j $Label8
$Label7:
la $a0 $String4
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label8:
li $t1 11
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 11 $Label9
la $a0 $String5
li $v0 4
syscall
j $Label10
$Label9:
la $a0 $String6
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label10:
jr $ra
testvalue:
addiu $fp $sp 12
addiu $sp $sp 20
li $t1 0
sw $t1 4012($gp)
lw $t1 4012($gp)
addiu $t3 $t1 0
bne $t3 0 $Label11
lw $t1 4012($gp)
addiu $t3 $t1 0
bge $t3 1 $Label13
lw $t1 4012($gp)
addiu $t3 $t1 0
ble $t3 -3 $Label15
la $a0 $String7
li $v0 4
syscall
j $Label16
$Label15:
la $a0 $String8
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label16:
j $Label14
$Label13:
la $a0 $String9
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label14:
j $Label12
$Label11:
la $a0 $String10
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
$Label12:
jr $ra
testcaseinsensitive:
addiu $fp $sp 8
addiu $sp $sp 20
li $t1 0
sw $t1 8($fp)
li $t1 1
sw $t1 8($fp)
lw $a1 8($fp)
beq $a1 0 $Label18
lw $a1 8($fp)
beq $a1 1 $Label19
la $a0 $String11
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
j $Label17
$Label18:
la $a0 $String12
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
j $Label17
$Label19:
la $a0 $String13
li $v0 4
syscall
j $Label17
$Label17:
jr $ra
testswitch:
sw $a0 32($sp)
addiu $fp $sp 24
addiu $sp $sp 40
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 12($fp)
li $t1 1
sw $t1 4020($gp)
lw $t1 4020($gp)
addiu $t3 $t1 0
lw $t1 12($fp)
addiu $t4 $t1 -3
mul $t5 $t3 1
addu $t6 $t4 $t5
beq $t6 1 $Label22
la $a0 $String14
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
j $Label21
$Label22:
la $a0 $String15
li $v0 4
syscall
j $Label21
$Label21:
jr $ra
testif:
addiu $fp $sp 12
addiu $sp $sp 20
li $t3 0
beq $t3 0 $Label24
la $a0 $String16
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
j $Label25
$Label24:
la $a0 $String17
li $v0 4
syscall
$Label25:
jr $ra
calrecursive:
sw $a0 36($sp)
sw $a1 40($sp)
addiu $fp $sp 28
addiu $sp $sp 48
lw $t1 8($gp)
addiu $t3 $t1 0
lw $a1 8($fp)
bne $a1 $t3 $Label26
lw $t3 12($gp)
move $a0 $t3
li $v0 1
syscall
li $t1 1
sw $t1 16($fp)
lw $t1 8($gp)
addiu $t3 $t1 0
lw $a1 16($fp)
bge $a1 $t3 $Label28
$Label30:
addiu $t1 $gp 12
lw $t2 16($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 16($fp)
lw $t1 8($gp)
addiu $t3 $t1 0
lw $a1 16($fp)
blt $a1 $t3 $Label30
j $Label29
$Label28:
$Label29:
la $a0 $String18
li $v0 4
syscall
jr $ra
j $Label27
$Label26:
$Label27:
lw $t1 12($fp)
addiu $t1 $t1 0
sw $t1 16($fp)
lw $t1 4($gp)
addiu $t3 $t1 0
lw $t1 8($gp)
addiu $t4 $t1 0
lw $t1 8($fp)
addu $t5 $t1 $t3
subu $t6 $t5 $t4
addiu $t7 $t6 1
lw $a1 16($fp)
bgt $a1 $t7 $Label31
$Label33:
lw $t1 16($fp)
addiu $t1 $t1 0
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 12($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
lw $t1 16($fp)
addiu $t4 $t1 1
move $a0 $t3
move $a1 $t4
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal calrecursive
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -20
lw $t1 16($fp)
addiu $t5 $t1 1
addiu $t1 $t5 0
sw $t1 16($fp)
lw $t1 4($gp)
addiu $t3 $t1 0
lw $t1 8($gp)
addiu $t4 $t1 0
lw $t1 8($fp)
addu $t5 $t1 $t3
subu $t6 $t5 $t4
addiu $t7 $t6 1
lw $a1 16($fp)
ble $a1 $t7 $Label33
j $Label32
$Label31:
$Label32:
jr $ra
initpermutation:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 32
li $t1 0
sw $t1 16($fp)
$Label34:
lw $t1 8($fp)
addiu $t1 $t1 0
lw $t0 16($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 12($t0)
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 16($fp)
lw $a1 16($fp)
lw $a2 12($fp)
ble $a1 $a2 $Label34
jr $ra
jr $ra
seqsum:
sw $a0 28($sp)
addiu $fp $sp 20
addiu $sp $sp 32
lw $a1 8($fp)
bne $a1 1 $Label35
li $v0 1
jr $ra
j $Label36
$Label35:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal seqsum
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -12
move $t1 $v0
addiu $t4 $t1 0
lw $t1 8($fp)
addu $t5 $t1 $t4
move $v0 $t5
jr $ra
$Label36:
printtable:
addiu $fp $sp 8
addiu $sp $sp 16
la $a0 $String19
li $v0 4
syscall
la $a0 $String20
li $v0 4
syscall
la $a0 $String21
li $v0 4
syscall
la $a0 $String22
li $v0 4
syscall
la $a0 $String23
li $v0 4
syscall
jr $ra
and:
sw $a0 16($sp)
sw $a1 20($sp)
addiu $fp $sp 8
addiu $sp $sp 24
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
addiu $fp $sp 8
addiu $sp $sp 20
li $t1 43
sw $t1 8($fp)
lw $v0 8($fp)
jr $ra
typecorrosion:
addiu $fp $sp 12
addiu $sp $sp 28
li $t1 105
sw $t1 12($fp)
li $t1 8
sw $t1 8($fp)
li $a0 72
li $v0 11
syscall
lw $a0 12($fp)
li $v0 11
syscall
sw $ra 8($sp)
jal helpchar
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -16
move $t1 $v0
addiu $t3 $t1 0
move $a0 $t3
li $v0 11
syscall
la $a0 $String24
li $v0 4
syscall
li $a0 2
li $v0 1
syscall
li $a0 0
li $v0 1
syscall
li $a0 1
li $v0 1
syscall
lw $a0 8($fp)
li $v0 1
syscall
jr $ra
testemptyfunction:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
teststructure:
sw $a0 36($sp)
sw $a1 40($sp)
sw $a2 44($sp)
sw $a3 48($sp)
lw $v1 0($k1)
sw $v1 52($sp)
addiu $fp $sp 28
addiu $sp $sp 64
lw $a0 8($fp)
li $v0 1
syscall
lw $a0 12($fp)
li $v0 1
syscall
lw $a0 16($fp)
li $v0 11
syscall
lw $a0 20($fp)
li $v0 11
syscall
lw $a0 24($fp)
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
li $t1 1
sw $t1 0($gp)
j $Label41
$Label42:
la $a0 $String25
li $v0 4
syscall
li $t1 0
sw $t1 28($fp)
li $t1 0
sw $t1 32($fp)
j $Label41
$Label43:
la $a0 $String26
li $v0 4
syscall
li $t1 1
sw $t1 0($gp)
j $Label41
$Label41:
jr $ra
main:
li $k1 268502232
addiu $fp $gp 4168
addiu $sp $fp 16
li $t1 0
sw $t1 0($gp)
li $t1 48
sw $t1 4164($gp)
$Label45:
sw $ra 8($sp)
jal printtable
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -16
li $v0 5
syscall
sw $v0 12($fp)
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
j $Label46
$Label47:
sw $t3 8($sp)
sw $ra 12($sp)
jal testvalue
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -16
sw $ra 8($sp)
jal testarithmetic
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -16
sw $t3 8($sp)
sw $ra 12($sp)
jal testif
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -16
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal testswitch
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -16
j $Label46
$Label48:
la $a0 $String28
li $v0 4
syscall
sw $t3 8($sp)
sw $ra 12($sp)
jal typecorrosion
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -16
la $a0 $String29
li $v0 4
syscall
la $a0 $String30
li $v0 4
syscall
la $a0 $String31
li $v0 4
syscall
j $Label46
$Label49:
li $t1 49
sw $t1 4088($gp)
li $t1 50
sw $t1 4096($gp)
li $t1 12345
sw $t1 4012($gp)
li $t1 54321
sw $t1 4020($gp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $ra 32($sp)
jal testdo
addiu $sp $fp -32
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $ra 0($fp)
addiu $fp $sp -16
sw $ra 8($sp)
jal testemptyfunction
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -16
lw $t1 4012($gp)
addiu $t3 $t1 0
lw $t1 4020($gp)
addiu $t4 $t1 0
lw $t1 4088($gp)
addiu $t5 $t1 0
lw $t1 4096($gp)
addiu $t6 $t1 0
lw $t1 4164($gp)
addiu $t7 $t1 0
move $a0 $t3
move $a1 $t4
move $a2 $t5
move $a3 $t6
sw $t7 0($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal teststructure
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -16
j $Label46
$Label50:
la $a0 $String32
li $v0 4
syscall
la $a0 $String33
li $v0 4
syscall
li $v0 12
syscall
sw $v0 8($fp)
lw $a1 8($fp)
beq $a1 80 $Label52
lw $a1 8($fp)
beq $a1 83 $Label55
la $a0 $String27
li $v0 4
syscall
j $Label51
$Label52:
la $a0 $String34
li $v0 4
syscall
li $v0 5
syscall
sw $v0 4($gp)
li $v0 5
syscall
sw $v0 8($gp)
la $a0 $String18
li $v0 4
syscall
lw $t1 8($gp)
addiu $t8 $t1 0
addiu $t9 $t8 1
ble $t9 1000 $Label53
la $a0 $String35
li $v0 4
syscall
li $v0 10
syscall
j $Label54
$Label53:
$Label54:
lw $t1 8($gp)
addiu $t3 $t1 0
addiu $t4 $t3 1
li $a0 0
move $a1 $t4
sw $t3 8($sp)
sw $ra 12($sp)
jal initpermutation
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -16
li $a0 0
li $a1 1
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal calrecursive
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -16
j $Label51
$Label55:
la $a0 $String36
li $v0 4
syscall
li $v0 5
syscall
sw $v0 12($fp)
la $a0 $String37
li $v0 4
syscall
lw $a0 12($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal seqsum
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -16
move $t1 $v0
addiu $t5 $t1 0
move $a0 $t5
li $v0 1
syscall
li $a0 10
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
jal seqsum
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
addiu $fp $sp -16
move $t1 $v0
addiu $t5 $t1 0
bne $t5 55 $Label56
la $a0 $String38
li $v0 4
syscall
j $Label57
$Label56:
li $t1 1
sw $t1 0($gp)
la $a0 $String39
li $v0 4
syscall
$Label57:
li $t1 3
sw $t1 12($fp)
j $Label51
$Label51:
j $Label46
$Label59:
j $Label46
$Label46:
lw $t1 0($gp)
addiu $t3 $t1 0
move $a0 $t3
lw $a1 12($fp)
sw $ra 8($sp)
jal and
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -16
move $t1 $v0
addiu $t4 $t1 0
bne $t4 0 $Label45
lw $t1 0($gp)
addiu $t3 $t1 0
blt $t3 1 $Label61
la $a0 $String40
li $v0 4
syscall
j $Label62
$Label61:
la $a0 $String41
li $v0 4
syscall
$Label62:
la $a0 $String42
li $v0 4
syscall
# End Of MIPS Assembly Code.
