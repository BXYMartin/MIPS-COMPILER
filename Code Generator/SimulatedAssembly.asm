.data
	$String55:.asciiz "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !"
	$String56:.asciiz "test of comp symbol"
	$String57:.asciiz "a==b"
	$String58:.asciiz "a<b"
	$String59:.asciiz "c>a"
	$String60:.asciiz "d"
	$String61:.asciiz "error"
	$String62:.asciiz "a<=c"
	$String63:.asciiz "error!"
	$String64:.asciiz "test global variable and constance"
	$String65:.asciiz "before change para="
	$String66:.asciiz "after change para="
	$String67:.asciiz "test for expression"
	$String68:.asciiz "--12--12--12-+12+-12--12--12--12--12="
	$String69:.asciiz "10*-5="
	$String70:.asciiz "10/+4="
	$String71:.asciiz "fib(12)-fib(14)="
	$String72:.asciiz "c + 12 = "
	$String73:.asciiz "c*12/1="
	$String74:.asciiz "1-(((12+1)))="
	$String75:.asciiz "arr[1]*'b'+fib(3)="
	$String76:.asciiz "addone(g_v_char_h)+add(1, fib(5))/G_v_int_a1 - tag[6]="
	$String77:.asciiz "please input an integer"
	$String78:.asciiz "please input 2 integers press enter for each integer"
	$String79:.asciiz " "
	$String80:.asciiz "input the number of fib you want(1~10)"
	$String81:.asciiz "this is a permutation of ABCDE"
.globl main
.text
foo1:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
add:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
addchar:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
addone:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 8($fp)
addiu $t3 $t1 1
move $v0 $t3
jr $ra
addint:
sw $a0 20($sp)
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 8($fp)
addiu $t3 $t1 1
move $v0 $t3
jr $ra
foo2:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $a1 8($fp)
ble $a1 99 $Label1
li $v0 47
jr $ra
j $Label2
$Label1:
li $v0 42
jr $ra
$Label2:
test_string_int:
addiu $fp $sp 12
addiu $sp $sp 24
li $s0 1
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 0
move $a0 $s0
li $v0 1
syscall
li $s0 12
move $a0 $s0
li $v0 1
syscall
li $s0 -12
move $a0 $s0
li $v0 1
syscall
la $a0 $String55
li $v0 4
syscall
jr $ra
fib:
sw $a0 36($sp)
addiu $fp $sp 28
addiu $sp $sp 40
lw $a1 8($fp)
bne $a1 1 $Label3
li $v0 1
jr $ra
j $Label4
$Label3:
lw $a1 8($fp)
bne $a1 2 $Label5
li $v0 1
jr $ra
$Label5:
$Label6:
$Label4:
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t4 $v0 0
lw $t1 8($fp)
subu $t5 $t1 2
move $a0 $t5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -12
addiu $t6 $v0 0
addu $t7 $t4 $t6
move $v0 $t7
jr $ra
test_lots_paras:
sw $a0 32($sp)
sw $a1 36($sp)
sw $a2 40($sp)
sw $a3 44($sp)
lw $v1 0($k1)
sw $v1 48($sp)
addiu $fp $sp 24
addiu $sp $sp 52
lw $t1 8($fp)
lw $t2 12($fp)
addu $t3 $t1 $t2
lw $t2 16($fp)
addu $t4 $t3 $t2
lw $t2 20($fp)
subu $t5 $t4 $t2
lw $t2 24($fp)
addu $t6 $t5 $t2
move $v0 $t6
jr $ra
test_all_cond:
addiu $fp $sp 24
addiu $sp $sp 48
li $s0 1
li $s2 2
li $s1 2
li $s3 65
la $a0 $String56
li $v0 4
syscall
bne $s2 $s1 $Label7
la $a0 $String57
li $v0 4
syscall
$Label7:
$Label8:
bge $s0 $s2 $Label9
la $a0 $String58
li $v0 4
syscall
$Label9:
$Label10:
ble $s1 $s0 $Label11
la $a0 $String59
li $v0 4
syscall
$Label11:
$Label12:
beq $s3 0 $Label13
la $a0 $String60
li $v0 4
syscall
$Label13:
$Label14:
bne $s0 1 $Label15
la $a0 $String61
li $v0 4
syscall
$Label15:
$Label16:
beq $s0 1 $Label17
la $a0 $String61
li $v0 4
syscall
$Label17:
$Label18:
bgt $s0 $s1 $Label19
la $a0 $String62
li $v0 4
syscall
$Label19:
$Label20:
blt $s0 $s1 $Label21
la $a0 $String63
li $v0 4
syscall
$Label21:
$Label22:
ble $s3 66 $Label23
la $a0 $String63
li $v0 4
syscall
$Label23:
$Label24:
jr $ra
test_diff_domain:
move $s0 $a0
addiu $fp $sp 16
addiu $sp $sp 32
li $a0 98
li $v0 11
syscall
li $t1 222
sw $t1 12($fp)
lw $a0 12($fp)
li $v0 1
syscall
la $a0 $String64
li $v0 4
syscall
li $a0 1
li $v0 1
syscall
li $a0 102
li $v0 11
syscall
li $a0 98
li $v0 11
syscall
li $a0 98
li $v0 11
syscall
li $a0 2
li $v0 1
syscall
li $a0 3
li $v0 1
syscall
li $t1 72
sw $t1 60($gp)
lw $t3 60($gp)
move $a0 $t3
li $v0 11
syscall
li $t1 155
sw $t1 28($gp)
lw $t3 28($gp)
move $a0 $t3
li $v0 1
syscall
la $a0 $String65
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
mul $s0 $s0 2
la $a0 $String66
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s6 89
addiu $t3 $s6 0
move $a0 $t3
li $v0 11
syscall
jr $ra
test_expr:
addiu $fp $sp 40
addiu $sp $sp 132
la $a0 $String67
li $v0 4
syscall
li $s0 60
la $a0 $String68
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 -50
la $a0 $String69
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 2
la $a0 $String70
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $a0 12
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 14
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
subu $s0 $t3 $t4
la $a0 $String71
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 111
la $a0 $String72
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 1188
la $a0 $String73
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s0 -12
la $a0 $String74
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $t1 15
sw $t1 16($fp)
lw $t3 16($fp)
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
mul $t5 $t3 98
addu $s0 $t5 $t4
la $a0 $String75
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
li $s4 5
li $t1 12
sw $t1 84($fp)
li $t1 104
sw $t1 88($fp)
lw $a0 88($fp)
sw $t3 8($sp)
sw $ra 12($sp)
jal addone
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t3 $v0 0
li $a0 5
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t4 $v0 0
li $a0 1
move $a1 $t4
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -92
addiu $t5 $v0 0
addiu $t6 $s4 0
lw $t7 84($fp)
div $t8 $t5 $t6
addu $t9 $t3 $t8
subu $s0 $t9 $t7
la $a0 $String76
li $v0 4
syscall
move $a0 $s0
li $v0 1
syscall
jr $ra
test_scanf:
addiu $fp $sp 12
addiu $sp $sp 28
la $a0 $String77
li $v0 4
syscall
li $v0 5
syscall
move $s0 $v0
move $a0 $s0
li $v0 1
syscall
la $a0 $String78
li $v0 4
syscall
li $v0 5
syscall
move $s0 $v0
li $v0 5
syscall
sw $v0 12($fp)
move $a0 $s0
li $v0 1
syscall
lw $a0 12($fp)
li $v0 1
syscall
jr $ra
echo_char:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
lw $a0 8($fp)
li $v0 11
syscall
lw $v0 8($fp)
jr $ra
really_void:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
really_void2:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
really_void3:
addiu $fp $sp 8
addiu $sp $sp 16
jr $ra
permutation:
sw $a0 24($sp)
sw $a1 28($sp)
addiu $fp $sp 16
addiu $sp $sp 44
lw $t1 12($fp)
subu $t3 $t1 1
lw $a1 8($fp)
bge $a1 $t3 $Label25
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
lw $t1 8($fp)
addiu $s0 $t1 1
lw $a2 12($fp)
bge $s0 $a2 $Label27
$Label29:
addiu $t1 $gp 252
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 20($fp)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t3 252($t0)
lw $t1 20($fp)
sll $t0 $s0 2
addu $t0 $gp $t0
sw $t1 252($t0)
lw $t1 8($fp)
addiu $t3 $t1 1
move $a0 $t3
lw $a1 12($fp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -28
addiu $t1 $gp 252
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t1 0($t1)
sw $t1 20($fp)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t0 8($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t3 252($t0)
lw $t1 20($fp)
sll $t0 $s0 2
addu $t0 $gp $t0
sw $t1 252($t0)
addiu $s0 $s0 1
lw $a2 12($fp)
blt $s0 $a2 $Label29
$Label27:
$Label28:
j $Label26
$Label25:
li $s0 0
$Label30:
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
sw $ra 8($sp)
jal echo_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -28
sw $v0 24($fp)
addiu $t1 $gp 252
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $a1 24($fp)
beq $a1 $t3 $Label31
la $a0 $String61
li $v0 4
syscall
$Label31:
$Label32:
addiu $s0 $s0 1
blt $s0 5 $Label30
la $a0 $String79
li $v0 4
syscall
$Label26:
jr $ra
main:
li $k1 268501560
addiu $fp $gp 272
addiu $sp $fp 64
li $s0 0
bge $s0 10 $Label33
$Label35:
addiu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $ra 28($sp)
jal fib
addiu $sp $fp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sll $t0 $s0 2
addu $t0 $fp $t0
sw $v0 8($t0)
addiu $s0 $s0 1
blt $s0 10 $Label35
$Label33:
$Label34:
la $a0 $String80
li $v0 4
syscall
li $v0 5
syscall
sw $v0 52($fp)
li $v0 5
syscall
sw $v0 56($fp)
lw $t1 52($fp)
subu $s0 $t1 1
$Label36:
la $a0 $String79
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
addiu $s0 $s0 1
lw $a2 56($fp)
blt $s0 $a2 $Label36
lw $t1 56($fp)
subu $s0 $t1 1
lw $t1 52($fp)
subu $t3 $t1 1
blt $s0 $t3 $Label37
$Label39:
la $a0 $String79
li $v0 4
syscall
addiu $t1 $fp 8
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
subu $s0 $s0 1
lw $t1 52($fp)
subu $t3 $t1 1
bge $s0 $t3 $Label39
$Label37:
$Label38:
li $a0 1
li $a1 98
sw $t3 8($sp)
sw $ra 12($sp)
jal foo1
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $ra 12($sp)
jal add
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 97
li $a1 98
sw $t3 8($sp)
sw $ra 12($sp)
jal addchar
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 70
sw $t3 8($sp)
sw $ra 12($sp)
jal addone
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 16
sw $t3 8($sp)
sw $ra 12($sp)
jal addint
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
li $a0 99
sw $ra 8($sp)
jal foo2
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 11
syscall
sw $s0 8($sp)
sw $ra 12($sp)
jal test_string_int
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 233
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal test_diff_domain
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $s0 36($sp)
sw $ra 40($sp)
jal test_expr
addiu $sp $fp -40
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $s0 36($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $s0 8($sp)
sw $s1 12($sp)
sw $s2 16($sp)
sw $s3 20($sp)
sw $ra 24($sp)
jal test_all_cond
addiu $sp $fp -24
lw $s0 8($sp)
lw $s1 12($sp)
lw $s2 16($sp)
lw $s3 20($sp)
lw $ra 0($fp)
addiu $fp $sp -64
sw $s0 8($sp)
sw $ra 12($sp)
jal test_scanf
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 97
sw $ra 8($sp)
jal echo_char
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $a0 1
li $a1 2
li $a2 99
li $a3 100
li $v0 5
sw $v0 0($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $ra 24($sp)
jal test_lots_paras
addiu $sp $fp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $ra 0($fp)
addiu $fp $sp -64
addiu $t3 $v0 0
move $a0 $t3
li $v0 1
syscall
sw $ra 8($sp)
jal really_void
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal really_void2
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
sw $ra 8($sp)
jal really_void3
addiu $sp $fp -8
lw $ra 0($fp)
addiu $fp $sp -64
li $t1 65
sw $t1 252($gp)
li $t1 66
sw $t1 256($gp)
li $t1 67
sw $t1 260($gp)
li $t1 68
sw $t1 264($gp)
li $t1 69
sw $t1 268($gp)
la $a0 $String81
li $v0 4
syscall
li $a0 0
li $a1 5
sw $t3 8($sp)
sw $s0 12($sp)
sw $ra 16($sp)
jal permutation
addiu $sp $fp -16
lw $t3 8($sp)
lw $s0 12($sp)
lw $ra 0($fp)
addiu $fp $sp -64
li $v0 10
syscall
# End Of MIPS Assembly Code.
