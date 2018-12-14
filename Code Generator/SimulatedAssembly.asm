.data
	$String5:.asciiz "default"
	$String6:.asciiz "This is A String ! #$%&'()*+,-./0123456789:<^_~|`"
.globl main
.text
fib:
move $s0 $a0
addiu $sp $sp 4
move $k0 $sp
bne $s0 1 $Label1
li $v0 1
jr $ra
j $Label2
$Label1:
bne $s0 0 $Label3
li $v0 0
jr $ra
j $Label4
$Label3:
subu $t3 $s0 1
move $a0 $t3
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
jal fib
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
move $t1 $v0
addiu $t4 $t1 0
subu $t5 $s0 2
move $a0 $t5
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
jal fib
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
move $t1 $v0
addiu $t6 $t1 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
$Label4:
$Label2:
test_array:
addiu $sp $sp 832
addiu $k0 $sp -28
li $s0 0
$Label5:
addiu $t0 $fp 8
sll $t1 $s0 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t0 $fp 408
sll $t1 $s0 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 100 $Label5
addiu $t1 $fp 8
addiu $t1 $t1 64
lw $t3 0($t1)
addiu $t1 $fp 408
sll $t2 $t3 2
addu $t1 $t1 $t2
lw $t4 0($t1)
addiu $t1 $fp 8
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addiu $t1 $fp 8
sll $t2 $t5 2
addu $t1 $t1 $t2
lw $t6 0($t1)
addiu $t1 $fp 408
sll $t2 $t6 2
addu $t1 $t1 $t2
lw $t7 0($t1)
addiu $t1 $fp 8
sll $t2 $t7 2
addu $t1 $t1 $t2
lw $t8 0($t1)
addiu $t1 $fp 8
addiu $t1 $t1 44
lw $t9 0($t1)
addiu $t0 $k0 0
addiu $t1 $fp 8
sll $t2 $t9 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 4
addiu $t1 $fp 408
lw $t2 0($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 8
addiu $t1 $fp 8
lw $t2 4($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 12
addiu $t1 $fp 408
lw $t2 8($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 16
addiu $t1 $fp 8
lw $t2 12($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 20
addiu $t1 $fp 408
lw $t2 16($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
addiu $t0 $k0 24
addiu $t1 $fp 8
lw $t2 20($k0)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 0($t0)
lw $t2 24($k0)
mul $s0 $t8 $t2
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
jr $ra
cal:
addiu $sp $sp 56
addiu $k0 $sp -8
li $s0 0
li $s1 0
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 28
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 32
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 8
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
addiu $t0 $t0 0
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
addiu $t0 $t0 4
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 36
addiu $t0 $t0 8
li $t1 2
sw $t1 0($t0)
addiu $t0 $fp 36
addiu $t0 $t0 12
li $t1 3
sw $t1 0($t0)
addiu $t0 $fp 36
addiu $t0 $t0 16
li $t1 4
sw $t1 0($t0)
lw $t2 20($fp)
mul $s0 $s1 $t2
addiu $t1 $fp 36
addiu $t1 $t1 8
lw $t4 0($t1)
addiu $t1 $fp 36
addiu $t1 $t1 16
lw $t3 0($t1)
div $s0 $t3 $t4
addu $t5 $t3 $t4
li $a0 10
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
jal fib
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
move $t1 $v0
addiu $t6 $t1 0
lw $t2 20($fp)
mul $t7 $s0 $t2
li $t0 0
subu $t8 $t0 $t7
addu $t9 $t8 $s0
addiu $t0 $k0 0
subu $t1 $t9 $t5
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t1 0($k0)
addu $t1 $t1 $t6
sw $t1 0($t0)
lw $t1 4($k0)
subu $s1 $t1 -4
move $v0 $s1
jr $ra
test_case:
move $s0 $a0
sw $a1 4($sp)
sw $a2 8($sp)
addiu $sp $sp 16
move $k0 $sp
li $s1 -1
beq $s0 1 $Label7
beq $s0 15 $Label8
lw $a1 12($fp)
beq $a1 97 $Label13
lw $a1 12($fp)
beq $a1 98 $Label14
li $s1 0
j $Label12
$Label13:
li $s1 97
j $Label12
$Label14:
li $s1 98
j $Label12
$Label12:
j $Label6
$Label7:
li $s1 1
j $Label6
$Label8:
lw $a1 16($fp)
bne $a1 1 $Label9
li $s1 -15
j $Label10
$Label9:
li $s1 15
$Label10:
j $Label6
$Label6:
move $v0 $s1
jr $ra
ret_char:
move $s0 $a0
addiu $sp $sp 8
move $k0 $sp
addiu $s1 $s0 0
move $v0 $s1
jr $ra
test_if:
move $s0 $a0
move $s1 $a1
sw $a2 8($sp)
addiu $sp $sp 12
move $k0 $sp
lw $a1 16($fp)
bne $a1 1 $Label16
bge $s0 $s1 $Label18
li $v0 1
jr $ra
$Label18:
$Label19:
bgt $s0 $s1 $Label20
li $v0 2
jr $ra
$Label20:
$Label21:
bne $s0 $s1 $Label22
li $v0 3
jr $ra
$Label22:
$Label23:
ble $s0 $s1 $Label24
li $v0 4
jr $ra
$Label24:
$Label25:
blt $s0 $s1 $Label26
li $v0 5
jr $ra
j $Label27
$Label26:
li $v0 0
jr $ra
$Label27:
j $Label17
$Label16:
beq $s0 $s1 $Label28
li $v0 6
jr $ra
j $Label29
$Label28:
li $v0 0
jr $ra
$Label29:
$Label17:
test_can:
move $s0 $a0
move $s1 $a1
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
addiu $sp $sp 24
move $k0 $sp
addu $t3 $s0 $s1
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
addu $t5 $t4 $t2
addiu $t0 $fp 28
lw $t2 24($fp)
addu $t1 $t5 $t2
sw $t1 0($t0)
lw $v0 28($fp)
jr $ra
test_tao:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
move $k0 $sp
beq $s0 0 $Label30
beq $s1 120 $Label33
beq $s1 121 $Label34
la $a0 $String5
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
j $Label32
$Label33:
li $a0 120
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
j $Label32
$Label34:
li $a0 121
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
j $Label32
$Label32:
j $Label31
$Label30:
jr $ra
$Label31:
jr $ra
main:
li $k1 268501052
addiu $fp $gp 496
addiu $sp $fp 8
addiu $sp $sp 832
move $k0 $sp
li $s0 0
li $s1 0
addiu $t0 $fp 20
addiu $t0 $t0 4
li $t1 2
sw $t1 0($t0)
$Label36:
addiu $t0 $gp 44
sll $t1 $s0 2
addu $t0 $t0 $t1
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 10 $Label36
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $s0 36($sp)
sw $ra 40($sp)
sw $fp 44($sp)
addiu $sp $sp 48
addiu $fp $sp -8
jal test_array
move $sp $fp
addiu $sp $sp -40
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
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
jal cal
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
addiu $s0 $t1 0
move $a0 $s0
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $v0 12
syscall
addiu $a3 $fp 436
sw $v0 0($a3)
li $v0 5
syscall
move $s1 $v0
move $a0 $s1
lw $a1 436($fp)
li $a2 1
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_case
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
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
lw $t1 436($fp)
addiu $t3 $t1 0
move $a0 $t3
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal ret_char
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 8
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
lw $a0 8($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s1 $v0
li $a0 1
move $a1 $s1
li $a2 1
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_if
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 428
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
li $a0 1
move $a1 $s1
li $a2 0
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_if
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $fp 432
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 428($fp)
lw $t2 432($fp)
addu $t3 $t1 $t2
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
la $a0 $String6
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
move $s1 $v0
li $v0 12
syscall
addiu $a3 $fp 436
sw $v0 0($a3)
move $a0 $s1
lw $a1 436($fp)
sw $k0 0($sp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_tao
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 1
li $a1 2
li $a2 3
li $a3 4
li $v0 5
sw $v0 0($k1)
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
jal test_can
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
addiu $t3 $t1 0
li $a0 1
li $a1 2
li $a2 3
move $a3 $t3
li $v0 4
sw $v0 0($k1)
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
jal test_can
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
move $a0 $t4
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
# End Of MIPS Assembly Code.
