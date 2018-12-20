.data
	$String85:.asciiz "Error in Array & Loop Check!"
	$String86:.asciiz "Array & Loop Check Succeed!"
	$String87:.asciiz "Arithmetic Check Succeed!"
	$String88:.asciiz "Arithmetic Check Failed!"
	$String89:.asciiz "Division Check Passed!"
	$String90:.asciiz "Error in Division Unit!"
	$String91:.asciiz "Value Assignment Succeed!"
	$String92:.asciiz "Negative Assignment Failed!"
	$String93:.asciiz "Positive Assignment Failed!"
	$String94:.asciiz "Basic Assignment Failed!"
	$String95:.asciiz "Error in testing Case Insensitive!"
	$String96:.asciiz "Case Sensitive Detected!"
	$String97:.asciiz "Case Insensitive Passed!"
	$String98:.asciiz "Switch Logic Error!"
	$String99:.asciiz "Switch Parse Check Succeed!"
	$String100:.asciiz "If Statement Error!"
	$String101:.asciiz "Passed If Statement Testing!"
	$String102:.asciiz ""
	$String103:.asciiz "INPUT 0: Basic Test        [Arithmetic, Case Inseneitive, Control Flow Logics]"
	$String104:.asciiz "INPUT 1: Value Type Test   [Char Return, Char Operation, Char Conversion, Escape Char]"
	$String105:.asciiz "INPUT 2: Structure Test    [Loop, Array, Structures]"
	$String106:.asciiz "INPUT 3: Recursive Test    [Permutation, Sequential Sum]"
	$String107:.asciiz "INPUT 4: Exit Program"
	$String108:.asciiz " "
	$String109:.asciiz "Structure Check Succeed!"
	$String110:.asciiz "Error In Register Name!"
	$String111:.asciiz "Illigal Input Detected!"
	$String112:.asciiz "The Following Test Should Output 'Hi, 2018'"
	$String113:.asciiz "This Test Should Output '\\n\\t\\r~!@#$%^&*`' Rather Than Escape Them"
	$String114:.asciiz "#t1"
	$String115:.asciiz "$t1"
	$String116:.asciiz "INPUT P: Permutation Output"
	$String117:.asciiz "INPUT S: Sequential Sum"
	$String118:.asciiz "INPUT INT0 INT1: Select INT1 From INT0 To Do Permutation"
	$String119:.asciiz "ERROR!"
	$String120:.asciiz "INPUT N: Calculate Sum From 1 To N"
	$String121:.asciiz "Sequential Sum Result is: "
	$String122:.asciiz "Recursive Check Succeed!"
	$String123:.asciiz "Error in Recursive Check!"
	$String124:.asciiz "Critical Error Occurred During Testing..."
	$String125:.asciiz "Test Passed!"
	$String126:.asciiz "Test End"
.globl main
.text
pause:
addiu $sp $sp 0
move $k0 $sp
jr $ra
testdo:
addiu $sp $sp 4
move $k0 $sp
li $s0 0
$Label1:
addiu $t0 $gp 4024
sll $t1 $s0 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $s0 $s0 1
ble $s0 15 $Label1
li $s0 0
$Label2:
mul $t3 $s0 2
subu $t4 $t3 $s0
addiu $t1 $gp 4024
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
li $t0 15
subu $t6 $t0 $s0
addiu $t1 $gp 4024
sll $t2 $t6 2
addu $t1 $t1 $t2
lw $t7 0($t1)
addiu $t0 $gp 4024
sll $t1 $s0 2
addu $t0 $t0 $t1
addu $t1 $t5 $t7
sw $t1 0($t0)
addiu $t1 $gp 4024
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
ble $s0 15 $Label2
addiu $t1 $gp 4024
addiu $t1 $t1 4
lw $t3 0($t1)
addiu $t1 $gp 4024
addiu $t1 $t1 20
lw $t4 0($t1)
bne $t3 $t4 $Label3
j $Label4
$Label3:
la $a0 $String85
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label4:
addiu $t1 $gp 4024
addiu $t1 $t1 60
lw $t3 0($t1)
bne $t3 30 $Label5
la $a0 $String86
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label6
$Label5:
la $a0 $String85
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label6:
jr $ra
testarithmetic:
addiu $sp $sp 4
move $k0 $sp
li $s0 -4
beq $s0 0 $Label7
la $a0 $String87
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label8
$Label7:
la $a0 $String88
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label8:
li $s0 11
bne $s0 11 $Label9
la $a0 $String89
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label10
$Label9:
la $a0 $String90
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label10:
jr $ra
testvalue:
addiu $sp $sp 0
move $k0 $sp
li $s5 0
bne $s5 0 $Label11
bge $s5 1 $Label13
ble $s5 -3 $Label15
la $a0 $String91
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label16
$Label15:
la $a0 $String92
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label16:
j $Label14
$Label13:
la $a0 $String93
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label14:
j $Label12
$Label11:
la $a0 $String94
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
$Label12:
jr $ra
testcaseinsensitive:
addiu $sp $sp 4
move $k0 $sp
li $s0 0
li $s0 1
beq $s0 0 $Label18
beq $s0 1 $Label19
la $a0 $String95
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
j $Label17
$Label18:
la $a0 $String96
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
j $Label17
$Label19:
la $a0 $String97
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label17
$Label17:
jr $ra
testswitch:
move $s0 $a0
addiu $sp $sp 8
move $k0 $sp
addiu $s1 $s0 0
li $s6 1
addiu $t3 $s1 -3
mul $t4 $s6 1
addu $t5 $t3 $t4
beq $t5 1 $Label22
la $a0 $String98
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
j $Label21
$Label22:
la $a0 $String99
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
la $a0 $String100
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
j $Label25
$Label24:
la $a0 $String101
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label25:
jr $ra
calrecursive:
move $s1 $a0
sw $a1 4($sp)
addiu $sp $sp 12
move $k0 $sp
bne $s1 $s4 $Label26
addiu $t1 $gp 12
addiu $t1 $t1 0
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $s0 1
bge $s0 $s4 $Label28
$Label30:
addiu $t1 $gp 12
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
blt $s0 $s4 $Label30
$Label28:
$Label29:
la $a0 $String102
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
$Label26:
$Label27:
lw $t1 12($fp)
addiu $s0 $t1 0
addu $t3 $s1 $s3
subu $t4 $t3 $s4
addiu $t5 $t4 1
bgt $s0 $t5 $Label31
$Label33:
addiu $t0 $gp 12
sll $t1 $s1 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t3 $s1 1
addiu $t4 $s0 1
move $a0 $t3
move $a1 $t4
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
jal calrecursive
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
addiu $s0 $s0 1
addu $t3 $s1 $s3
subu $t4 $t3 $s4
addiu $t5 $t4 1
ble $s0 $t5 $Label33
$Label31:
$Label32:
jr $ra
initpermutation:
sw $a0 0($sp)
move $s1 $a1
addiu $sp $sp 12
move $k0 $sp
li $s0 0
$Label34:
addiu $t0 $gp 12
sll $t1 $s0 2
addu $t0 $t0 $t1
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $s0 $s0 1
ble $s0 $s1 $Label34
jr $ra
seqsum:
move $s0 $a0
addiu $sp $sp 4
move $k0 $sp
bne $s0 1 $Label35
li $v0 1
jr $ra
j $Label36
$Label35:
subu $t3 $s0 1
move $a0 $t3
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal seqsum
move $sp $fp
addiu $sp $sp -24
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
addu $t5 $s0 $t4
move $v0 $t5
jr $ra
$Label36:
printtable:
addiu $sp $sp 0
move $k0 $sp
la $a0 $String103
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String104
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String105
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String106
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String107
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
jr $ra
and:
move $s1 $a0
move $s0 $a1
addiu $sp $sp 8
move $k0 $sp
bne $s0 4 $Label37
li $v0 0
jr $ra
j $Label38
$Label37:
bne $s1 0 $Label39
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
li $s0 44
move $v0 $s0
jr $ra
typecorrosion:
addiu $sp $sp 8
move $k0 $sp
li $s1 105
li $s0 8
li $a0 72
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
move $a0 $s1
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
sw $k0 0($sp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal helpchar
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
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
la $a0 $String108
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
move $a0 $s0
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
move $s1 $a1
move $s0 $a2
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
move $a0 $s1
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
move $a0 $s0
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
lw $t2 24($fp)
subu $t3 $s0 $t2
lw $t1 8($fp)
addu $t4 $t1 $s1
lw $t2 20($fp)
addu $t5 $t4 $t2
subu $t6 $t5 $s0
subu $t7 $t6 $t3
beq $t7 66666 $Label42
beq $t7 0 $Label43
li $s2 1
j $Label41
$Label42:
la $a0 $String109
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
la $a0 $String110
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $s2 1
j $Label41
$Label41:
jr $ra
main:
li $k1 268502228
addiu $fp $gp 4168
addiu $sp $fp 8
addiu $sp $sp 8
move $k0 $sp
li $s2 0
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
move $s1 $v0
beq $s1 0 $Label47
beq $s1 1 $Label48
beq $s1 2 $Label49
beq $s1 3 $Label50
beq $s1 4 $Label59
la $a0 $String111
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
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal testarithmetic
move $sp $fp
addiu $sp $sp -12
lw $k0 0($sp)
lw $s0 8($sp)
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
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal testswitch
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
j $Label46
$Label48:
la $a0 $String112
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
sw $k0 0($sp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal typecorrosion
move $sp $fp
addiu $sp $sp -20
lw $k0 0($sp)
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String113
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String114
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String115
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label46
$Label49:
li $s7 49
addiu $t0 $gp 4096
li $t1 50
sw $t1 0($t0)
li $s5 12345
li $s6 54321
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
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
lw $s0 28($sp)
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
move $a0 $s5
move $a1 $s6
move $a2 $s7
lw $a3 4096($gp)
lw $v0 4164($gp)
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $s0 28($sp)
sw $s1 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
addiu $sp $sp 44
addiu $fp $sp -8
jal teststructure
move $sp $fp
addiu $sp $sp -36
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $s0 28($sp)
lw $s1 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
j $Label46
$Label50:
la $a0 $String116
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String117
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
move $s0 $v0
beq $s0 80 $Label52
beq $s0 83 $Label55
la $a0 $String111
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label51
$Label52:
la $a0 $String118
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s3 $v0
li $v0 5
syscall
move $s4 $v0
la $a0 $String102
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
addiu $t3 $s4 1
ble $t3 1000 $Label53
la $a0 $String119
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 10
syscall
$Label53:
$Label54:
addiu $t3 $s4 1
li $a0 0
move $a1 $t3
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal initpermutation
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 0
li $a1 1
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
jal calrecursive
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
j $Label51
$Label55:
la $a0 $String120
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s1 $v0
la $a0 $String121
li $v0 4
syscall
move $a0 $s1
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal seqsum
move $sp $fp
addiu $sp $sp -24
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
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
sw $s0 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal seqsum
move $sp $fp
addiu $sp $sp -24
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
bne $t4 55 $Label56
la $a0 $String122
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label57
$Label56:
li $s2 1
la $a0 $String123
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label57:
li $s1 3
j $Label51
$Label51:
$Label59:
j $Label46
$Label46:
move $a0 $s2
move $a1 $s1
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal and
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
bne $t3 0 $Label45
blt $s2 1 $Label61
la $a0 $String124
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label62
$Label61:
la $a0 $String125
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
$Label62:
la $a0 $String126
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
