.data
	$String1:.asciiz "default"
	$String2:.asciiz "This is A String ! #$%&'()*+,-./0123456789:<^_~|`"
.globl main
.text
fib:
sw $a0 0($sp)
addiu $sp $sp 4
move $k0 $sp
lw $a1 8($fp)
bne $a1 1 $Label1
li $v0 1
jr $ra
j $Label2
$Label1:
lw $a1 8($fp)
bne $a1 0 $Label3
li $v0 0
jr $ra
j $Label4
$Label3:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
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
jal fib
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
move $t1 $v0
addiu $t4 $t1 0
lw $t1 8($fp)
subu $t5 $t1 2
move $a0 $t5
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
jal fib
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
move $t1 $v0
addiu $t6 $t1 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
$Label4:
$Label2:
test_array:
addiu $sp $sp 836
addiu $k0 $sp -32
addiu $t0 $fp 808
li $t1 0
sw $t1 0($t0)
$Label5:
addiu $t0 $fp 8
lw $t1 808($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 808($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $fp 408
lw $t1 808($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 808($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 808($fp)
addiu $t3 $t1 1
addiu $t0 $fp 808
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 808($fp)
blt $a1 100 $Label5
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
addiu $t0 $k0 28
lw $t2 24($k0)
mul $t1 $t8 $t2
sw $t1 0($t0)
addiu $t0 $fp 808
lw $t1 28($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $a0 808($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
jr $ra
jr $ra
cal:
addiu $sp $sp 60
addiu $k0 $sp -12
addiu $t0 $fp 12
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
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
lw $t1 16($fp)
lw $t2 20($fp)
mul $t3 $t1 $t2
addiu $t0 $fp 12
addiu $t1 $t3 0
sw $t1 0($t0)
addiu $t1 $fp 36
addiu $t1 $t1 16
lw $t3 0($t1)
addiu $t1 $fp 36
addiu $t1 $t1 8
lw $t4 0($t1)
div $t5 $t3 $t4
addiu $t0 $fp 12
addiu $t1 $t5 0
sw $t1 0($t0)
addiu $t1 $fp 36
addiu $t1 $t1 16
lw $t3 0($t1)
addiu $t1 $fp 36
addiu $t1 $t1 8
lw $t4 0($t1)
addu $t5 $t3 $t4
li $a0 10
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
jal fib
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
move $t1 $v0
addiu $t6 $t1 0
lw $t1 12($fp)
lw $t2 20($fp)
mul $t7 $t1 $t2
li $t0 0
subu $t8 $t0 $t7
lw $t2 12($fp)
addu $t9 $t8 $t2
addiu $t0 $k0 0
subu $t1 $t9 $t5
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t1 0($k0)
addu $t1 $t1 $t6
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 4($k0)
subu $t1 $t1 -4
sw $t1 0($t0)
addiu $t0 $fp 16
lw $t1 8($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $v0 16($fp)
jr $ra
test_case:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
addiu $sp $sp 16
move $k0 $sp
addiu $t0 $fp 20
li $t1 -1
sw $t1 0($t0)
lw $a1 8($fp)
beq $a1 1 $Label7
lw $a1 8($fp)
beq $a1 15 $Label8
lw $a1 12($fp)
beq $a1 97 $Label13
lw $a1 12($fp)
beq $a1 98 $Label14
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
j $Label12
$Label13:
addiu $t0 $fp 20
li $t1 97
sw $t1 0($t0)
j $Label12
$Label14:
addiu $t0 $fp 20
li $t1 98
sw $t1 0($t0)
j $Label12
$Label12:
j $Label6
$Label7:
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
j $Label6
$Label8:
lw $a1 16($fp)
bne $a1 1 $Label9
addiu $t0 $fp 20
li $t1 -15
sw $t1 0($t0)
j $Label10
$Label9:
addiu $t0 $fp 20
li $t1 15
sw $t1 0($t0)
$Label10:
j $Label6
$Label6:
lw $v0 20($fp)
jr $ra
ret_char:
sw $a0 0($sp)
addiu $sp $sp 8
move $k0 $sp
addiu $t0 $fp 12
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $v0 12($fp)
jr $ra
test_if:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
addiu $sp $sp 12
move $k0 $sp
lw $a1 16($fp)
bne $a1 1 $Label16
lw $a1 8($fp)
lw $a2 12($fp)
bge $a1 $a2 $Label18
li $v0 1
jr $ra
j $Label19
$Label18:
$Label19:
lw $a1 8($fp)
lw $a2 12($fp)
bgt $a1 $a2 $Label20
li $v0 2
jr $ra
j $Label21
$Label20:
$Label21:
lw $a1 8($fp)
lw $a2 12($fp)
bne $a1 $a2 $Label22
li $v0 3
jr $ra
j $Label23
$Label22:
$Label23:
lw $a1 8($fp)
lw $a2 12($fp)
ble $a1 $a2 $Label24
li $v0 4
jr $ra
j $Label25
$Label24:
$Label25:
lw $a1 8($fp)
lw $a2 12($fp)
blt $a1 $a2 $Label26
li $v0 5
jr $ra
j $Label27
$Label26:
li $v0 0
jr $ra
$Label27:
j $Label17
$Label16:
lw $a1 8($fp)
lw $a2 12($fp)
beq $a1 $a2 $Label28
li $v0 6
jr $ra
j $Label29
$Label28:
li $v0 0
jr $ra
$Label29:
$Label17:
test_can:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
addiu $sp $sp 24
move $k0 $sp
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
addu $t5 $t4 $t2
lw $t2 24($fp)
addu $t6 $t5 $t2
addiu $t0 $fp 28
addiu $t1 $t6 0
sw $t1 0($t0)
lw $v0 28($fp)
jr $ra
test_tao:
sw $a0 0($sp)
sw $a1 4($sp)
addiu $sp $sp 8
move $k0 $sp
lw $a1 8($fp)
beq $a1 0 $Label30
lw $a1 12($fp)
beq $a1 120 $Label33
lw $a1 12($fp)
beq $a1 121 $Label34
la $a0 $String1
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
li $k1 268501056
addiu $fp $gp 496
addiu $sp $fp 8
addiu $sp $sp 832
move $k0 $sp
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 420
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 20
addiu $t0 $t0 4
li $t1 2
sw $t1 0($t0)
$Label36:
addiu $t0 $gp 44
lw $t1 16($fp)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 16($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
lw $t1 16($fp)
addiu $t3 $t1 1
addiu $t0 $fp 16
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a1 16($fp)
blt $a1 10 $Label36
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
jal test_array
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
jal cal
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
addiu $t0 $fp 16
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a0 16($fp)
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
addiu $a3 $fp 420
sw $v0 0($a3)
lw $a0 420($fp)
lw $a1 436($fp)
li $a2 1
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_case
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
addiu $t0 $fp 440
addiu $t0 $t0 4
lw $t1 436($fp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t1 $fp 440
addiu $t1 $t1 4
lw $t3 0($t1)
move $a0 $t3
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal ret_char
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
addiu $t0 $fp 8
addiu $t1 $t4 0
sw $t1 0($t0)
lw $a0 8($fp)
li $v0 11
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $fp 420
sw $v0 0($a3)
li $a0 1
lw $a1 420($fp)
li $a2 1
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_if
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
addiu $t0 $fp 428
addiu $t1 $t3 0
sw $t1 0($t0)
li $a0 1
lw $a1 420($fp)
li $a2 0
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_if
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
addiu $t0 $fp 432
addiu $t1 $t3 0
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
la $a0 $String2
li $v0 4
syscall
li $a0 10
li $v0 11
syscall
li $v0 5
syscall
addiu $a3 $fp 420
sw $v0 0($a3)
li $v0 12
syscall
addiu $a3 $fp 436
sw $v0 0($a3)
lw $a0 420($fp)
lw $a1 436($fp)
sw $k0 0($sp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_tao
move $sp $fp
addiu $sp $sp -8
lw $k0 0($sp)
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
sw $t6 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal test_can
move $sp $fp
addiu $sp $sp -24
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
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
sw $t6 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal test_can
move $sp $fp
addiu $sp $sp -24
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
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
