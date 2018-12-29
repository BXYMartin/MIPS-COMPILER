.data
	$String1:.asciiz " x = "
	$String2:.asciiz " y = "
	$String3:.asciiz " SWAP x = "
	$String4:.asciiz " SWAP y = "
	$String5:.asciiz " OVERFLOW!          "
	$String6:.asciiz " complete number: "
	$String7:.asciiz "  "
	$String8:.asciiz "          "
	$String9:.asciiz " ---------------------------------------------------------------          "
	$String10:.asciiz " b = "
	$String11:.asciiz " "
	$String12:.asciiz "          The total is "
	$String13:.asciiz " 10! = "
.globl main
.text
factorial:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $a1 8($fp)
bgt $a1 1 $Label1
li $v0 1
jr $ra
j $Label2
$Label1:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $ra 8($sp)
jal factorial
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
lw $t1 8($fp)
mul $t5 $t1 $t4
move $v0 $t5
jr $ra
$Label2:
mod:
sw $a0 16($sp)
sw $a1 20($sp)
addiu $fp $sp 8
addiu $sp $sp 24
lw $t1 8($fp)
lw $t2 12($fp)
div $t3 $t1 $t2
lw $t2 12($fp)
mul $t4 $t3 $t2
lw $t1 8($fp)
subu $t5 $t1 $t4
sw $t5 8($fp)
lw $v0 8($fp)
jr $ra
swap:
sw $a0 16($sp)
sw $a1 20($sp)
addiu $fp $sp 8
addiu $sp $sp 28
la $a0 $String1
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
la $a0 $String2
li $v0 4
syscall
lw $a0 12($fp)
li $v0 1
syscall
lw $t1 8($fp)
sw $t1 16($fp)
lw $t1 12($fp)
sw $t1 8($fp)
lw $t1 16($fp)
sw $t1 12($fp)
la $a0 $String3
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
la $a0 $String4
li $v0 4
syscall
lw $a0 12($fp)
li $v0 1
syscall
jr $ra
complete_num:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 584
lw $t1 8($fp)
sw $t1 528($fp)
$Label3:
li $t1 -1
sw $t1 532($fp)
lw $t1 528($fp)
sw $t1 536($fp)
li $t1 1
sw $t1 524($fp)
$Label4:
lw $t1 528($fp)
lw $t2 524($fp)
div $t3 $t1 $t2
lw $t2 524($fp)
mul $t4 $t3 $t2
sw $t4 540($fp)
lw $a0 528($fp)
lw $a1 524($fp)
sw $ra 8($sp)
jal mod
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -576
addiu $t3 $v0 0
bne $t3 0 $Label5
lw $t1 532($fp)
addiu $t3 $t1 1
sw $t3 532($fp)
lw $t1 536($fp)
lw $t2 524($fp)
subu $t3 $t1 $t2
sw $t3 536($fp)
lw $a1 532($fp)
blt $a1 128 $Label7
la $a0 $String5
li $v0 4
syscall
j $Label8
$Label7:
lw $t1 524($fp)
lw $t0 532($fp)
sll $t0 $t0 2
addu $t0 $fp $t0
sw $t1 12($t0)
$Label8:
j $Label6
$Label5:
$Label6:
lw $t1 524($fp)
addiu $t3 $t1 1
sw $t3 524($fp)
lw $a1 524($fp)
lw $a2 528($fp)
blt $a1 $a2 $Label4
lw $a1 536($fp)
bne $a1 0 $Label9
la $a0 $String6
li $v0 4
syscall
lw $a0 528($fp)
li $v0 1
syscall
li $t1 0
sw $t1 524($fp)
$Label11:
la $a0 $String7
li $v0 4
syscall
addiu $t1 $fp 12
lw $t2 524($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
lw $t1 524($fp)
addiu $t3 $t1 1
sw $t3 524($fp)
lw $a1 524($fp)
lw $a2 532($fp)
ble $a1 $a2 $Label11
la $a0 $String8
li $v0 4
syscall
j $Label10
$Label9:
$Label10:
lw $t1 528($fp)
addiu $t3 $t1 1
sw $t3 528($fp)
lw $a1 528($fp)
blt $a1 1024 $Label3
la $a0 $String9
li $v0 4
syscall
li $t1 0
sw $t1 564($fp)
li $t1 0
sw $t1 524($fp)
$Label12:
lw $t1 564($fp)
lw $t2 524($fp)
mul $t3 $t1 $t2
sw $t3 568($fp)
lw $t1 528($fp)
lw $t2 532($fp)
mul $t3 $t1 $t2
sw $t3 572($fp)
lw $t1 564($fp)
lw $t2 524($fp)
mul $t3 $t1 $t2
sw $t3 564($fp)
lw $t1 564($fp)
lw $t2 568($fp)
addu $t3 $t1 $t2
lw $t2 572($fp)
addu $t4 $t3 $t2
sw $t4 564($fp)
lw $t1 524($fp)
addiu $t3 $t1 1
sw $t3 524($fp)
lw $a1 524($fp)
blt $a1 1024 $Label12
lw $t1 564($fp)
sw $t1 568($fp)
li $t1 0
sw $t1 524($fp)
$Label13:
lw $t1 568($fp)
lw $t2 524($fp)
addu $t3 $t1 $t2
sw $t3 568($fp)
lw $t1 524($fp)
addiu $t3 $t1 1
sw $t3 524($fp)
lw $a1 524($fp)
blt $a1 1024 $Label13
la $a0 $String10
li $v0 4
syscall
lw $a0 568($fp)
li $v0 1
syscall
la $a0 $String9
li $v0 4
syscall
li $t1 0
sw $t1 552($fp)
li $t1 1
sw $t1 556($fp)
li $t1 2
sw $t1 544($fp)
$Label14:
lw $t1 544($fp)
div $t3 $t1 2
sw $t3 548($fp)
li $t1 2
sw $t1 524($fp)
$Label15:
lw $t1 544($fp)
lw $t2 524($fp)
div $t3 $t1 $t2
lw $t2 524($fp)
mul $t4 $t3 $t2
sw $t4 560($fp)
lw $a0 544($fp)
lw $a1 524($fp)
sw $ra 8($sp)
jal mod
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -576
addiu $t3 $v0 0
bne $t3 0 $Label16
li $t1 0
sw $t1 556($fp)
j $Label17
$Label16:
$Label17:
lw $t1 524($fp)
addiu $t3 $t1 1
sw $t3 524($fp)
lw $a1 524($fp)
lw $a2 548($fp)
ble $a1 $a2 $Label15
lw $a1 556($fp)
bne $a1 1 $Label18
la $a0 $String11
li $v0 4
syscall
lw $a0 544($fp)
li $v0 1
syscall
lw $t1 552($fp)
addiu $t3 $t1 1
sw $t3 552($fp)
lw $t1 552($fp)
div $t3 $t1 10
mul $t4 $t3 10
sw $t4 560($fp)
lw $a1 560($fp)
lw $a2 552($fp)
bne $a1 $a2 $Label20
la $a0 $String8
li $v0 4
syscall
j $Label21
$Label20:
$Label21:
j $Label19
$Label18:
$Label19:
li $t1 1
sw $t1 556($fp)
lw $t1 544($fp)
addiu $t3 $t1 1
sw $t3 544($fp)
lw $a1 544($fp)
ble $a1 1024 $Label14
la $a0 $String12
li $v0 4
syscall
lw $a0 552($fp)
li $v0 1
syscall
jr $ra
main:
li $k1 268501200
addiu $fp $gp 0
addiu $sp $fp 12
li $a0 10
sw $ra 8($sp)
jal factorial
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t3 $v0 0
sw $t3 8($fp)
la $a0 $String13
li $v0 4
syscall
lw $a0 8($fp)
li $v0 1
syscall
li $a0 5
li $a1 10
sw $ra 8($sp)
jal swap
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -12
li $a0 2
sw $ra 8($sp)
jal complete_num
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -12
# End Of MIPS Assembly Code.
