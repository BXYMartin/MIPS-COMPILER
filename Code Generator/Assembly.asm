.data
.globl main
.text
recursive:
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
addiu $sp $sp 20
move $k0 $sp
lw $a1 8($fp)
ble $a1 10 $Label1
lw $v0 24($fp)
jr $ra
j $Label2
$Label1:
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
lw $a2 16($fp)
lw $a3 20($fp)
lw $v0 24($fp)
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal recursive
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
move $v0 $t4
jr $ra
$Label2:
main:
li $k1 268501000
addiu $fp $gp 0
addiu $sp $fp 8
addiu $sp $sp 224
addiu $k0 $sp -84
addiu $t0 $fp 8
li $t1 1
sw $t1 0($t0)
addiu $t0 $fp 12
li $t1 2
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 3
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 44
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 56
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 44
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 56
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 44
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 56
li $t1 0
sw $t1 0($t0)
lw $t1 16($fp)
lw $t2 8($fp)
mul $t3 $t1 $t2
lw $t1 8($fp)
subu $t4 $t1 $t3
lw $t1 8($fp)
lw $t2 12($fp)
addu $t5 $t1 $t2
lw $t1 16($fp)
lw $t2 8($fp)
mul $t6 $t1 $t2
subu $t7 $t5 $t6
lw $t2 12($fp)
addu $t8 $t7 $t2
lw $t2 16($fp)
subu $t9 $t8 $t2
addiu $t0 $k0 0
lw $t2 16($fp)
mul $t1 $t4 $t2
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 16($fp)
lw $t2 12($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 12
lw $t1 4($k0)
lw $t2 8($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 16
lw $t1 16($fp)
lw $t2 16($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 20
lw $t1 12($k0)
lw $t2 16($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 24
lw $t1 16($fp)
lw $t2 8($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 28
lw $t1 8($fp)
lw $t2 24($k0)
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 32
lw $t1 8($fp)
lw $t2 12($fp)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 36
lw $t1 16($fp)
lw $t2 8($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 40
lw $t1 32($k0)
lw $t2 36($k0)
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 44
lw $t1 40($k0)
lw $t2 12($fp)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 48
lw $t1 44($k0)
lw $t2 16($fp)
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 52
lw $t1 28($k0)
lw $t2 16($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 56
lw $t1 48($k0)
lw $t2 52($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 60
lw $t1 16($fp)
lw $t2 12($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 64
lw $t1 56($k0)
lw $t2 60($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 68
lw $t1 16($fp)
lw $t2 16($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 72
lw $t1 64($k0)
lw $t2 68($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
li $a0 0
li $a1 0
li $a2 0
li $a3 0
lw $v0 72($k0)
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal recursive
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $k0 76
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $k0 80
lw $t2 76($k0)
addiu $t1 $t2 1
sw $t1 0($t0)
addiu $t0 $fp 60
lw $t1 20($k0)
sll $t1 $t1 2
addu $t0 $t0 $t1
lw $t1 80($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 36
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 44
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 48
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 52
li $t1 2
sw $t1 0($t0)
addiu $t0 $fp 56
li $t1 5
sw $t1 0($t0)
lw $t1 16($fp)
lw $t2 12($fp)
mul $t3 $t1 $t2
addiu $t0 $fp 60
addiu $t0 $t0 4
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 12($fp)
lw $t2 16($fp)
subu $t3 $t1 $t2
addiu $t0 $fp 60
addiu $t0 $t0 8
addiu $t1 $t3 0
sw $t1 0($t0)
lw $t1 16($fp)
lw $t2 8($fp)
mul $t3 $t1 $t2
lw $t1 8($fp)
subu $t4 $t1 $t3
lw $t1 8($fp)
lw $t2 12($fp)
addu $t5 $t1 $t2
lw $t1 16($fp)
lw $t2 8($fp)
mul $t6 $t1 $t2
subu $t7 $t5 $t6
lw $t2 12($fp)
addu $t8 $t7 $t2
lw $t2 16($fp)
subu $t9 $t8 $t2
addiu $t0 $k0 0
lw $t2 16($fp)
mul $t1 $t4 $t2
sw $t1 0($t0)
addiu $t0 $k0 4
lw $t2 0($k0)
addu $t1 $t9 $t2
sw $t1 0($t0)
addiu $t0 $k0 8
lw $t1 16($fp)
lw $t2 12($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 12
lw $t1 4($k0)
lw $t2 8($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 16
lw $t1 16($fp)
lw $t2 16($fp)
mul $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $k0 20
lw $t1 12($k0)
lw $t2 16($k0)
addu $t1 $t1 $t2
sw $t1 0($t0)
li $a0 0
li $a1 0
li $a2 0
li $a3 0
lw $v0 20($k0)
sw $v0 0($k1)
sw $k0 0($sp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal recursive
move $sp $fp
addiu $sp $sp -16
lw $k0 0($sp)
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $k0 24
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $k0 28
lw $t1 24($k0)
subu $t1 $t1 3
sw $t1 0($t0)
addiu $t0 $fp 48
lw $t1 28($k0)
addiu $t1 $t1 0
sw $t1 0($t0)
move $t3 $0
addiu $t0 $fp 56
addiu $t1 $t3 0
sw $t1 0($t0)
lw $a0 56($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
lw $a0 48($fp)
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t1 $fp 60
addiu $t1 $t1 4
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t1 $fp 60
addiu $t1 $t1 8
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
addiu $t1 $fp 60
addiu $t1 $t1 32
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
li $a0 10
li $v0 11
syscall
li $v0 10
syscall
# End Of MIPS Assembly Code.
