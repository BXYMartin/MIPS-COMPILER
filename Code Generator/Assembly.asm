.data
	$String1:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String2:.asciiz "all test:"
.globl main
.text
get_sum:
sw $a0 24($sp)
addiu $fp $sp 16
addiu $sp $sp 32
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 0($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 0($gp)
li $t1 0
sw $t1 12($fp)
lw $a1 8($fp)
beq $a1 1 $Label1
lw $t1 8($fp)
subu $t3 $t1 1
move $a0 $t3
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal get_sum
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
addiu $t1 $t4 0
sw $t1 12($fp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label2
$Label1:
$Label2:
lw $t1 12($fp)
lw $t2 8($fp)
addu $t3 $t1 $t2
move $v0 $t3
jr $ra
count_to_10:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $a0 10
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal get_sum
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
move $v0 $t3
jr $ra
higher:
sw $a0 16($sp)
addiu $fp $sp 8
addiu $sp $sp 20
li $v0 65
jr $ra
prt_message:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
la $a0 $String1
li $v0 4
syscall
li $v0 97
jr $ra
test_global_variable:
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 0
sw $t1 8($fp)
li $t1 0
sw $t1 12($fp)
li $t1 2
sw $t1 0($gp)
li $t1 97
sw $t1 44($gp)
li $t1 49
sw $t1 48($gp)
li $t1 95
sw $t1 52($gp)
li $t1 43
sw $t1 56($gp)
li $t1 65
sw $t1 60($gp)
lw $a0 0($gp)
li $v0 1
syscall
lw $t3 44($gp)
move $a0 $t3
li $v0 1
syscall
lw $a1 0($gp)
bne $a1 2 $Label3
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label4
$Label3:
$Label4:
lw $a1 0($gp)
bne $a1 1 $Label5
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label6
$Label5:
$Label6:
lw $a1 12($fp)
bne $a1 0 $Label7
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label8
$Label7:
$Label8:
li $t1 1
sw $t1 68($gp)
li $t1 2
sw $t1 72($gp)
li $t1 3
sw $t1 76($gp)
li $t1 4
sw $t1 80($gp)
li $t1 5
sw $t1 84($gp)
li $t1 0
sw $t1 12($fp)
lw $a1 68($gp)
bne $a1 1 $Label9
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label10
$Label9:
$Label10:
lw $a1 68($gp)
bne $a1 0 $Label11
li $t1 1
sw $t1 12($fp)
j $Label12
$Label11:
$Label12:
lw $a1 12($fp)
bne $a1 0 $Label13
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label14
$Label13:
$Label14:
li $t1 0
sw $t1 12($fp)
lw $a1 72($gp)
bne $a1 2 $Label15
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label16
$Label15:
$Label16:
lw $a1 72($gp)
bne $a1 0 $Label17
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label18
$Label17:
$Label18:
lw $a1 12($fp)
bne $a1 0 $Label19
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label20
$Label19:
$Label20:
li $t1 0
sw $t1 12($fp)
lw $a1 76($gp)
bne $a1 3 $Label21
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label22
$Label21:
$Label22:
lw $a1 76($gp)
bne $a1 0 $Label23
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label24
$Label23:
$Label24:
lw $a1 12($fp)
bne $a1 0 $Label25
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label26
$Label25:
$Label26:
li $t1 0
sw $t1 12($fp)
lw $a1 80($gp)
bne $a1 4 $Label27
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label28
$Label27:
$Label28:
lw $a1 80($gp)
bne $a1 0 $Label29
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label30
$Label29:
$Label30:
lw $a1 12($fp)
bne $a1 0 $Label31
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label32
$Label31:
$Label32:
li $t1 0
sw $t1 12($fp)
lw $a1 84($gp)
bne $a1 5 $Label33
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label34
$Label33:
$Label34:
lw $a1 84($gp)
bne $a1 0 $Label35
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label36
$Label35:
$Label36:
lw $a1 12($fp)
bne $a1 0 $Label37
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label38
$Label37:
$Label38:
jr $ra
jr $ra
test_global_const:
addiu $fp $sp 12
addiu $sp $sp 40
li $t1 100
sw $t1 24($fp)
lw $a1 24($fp)
bne $a1 100 $Label39
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label40
$Label39:
$Label40:
li $t1 100
sw $t1 16($fp)
li $t1 101
sw $t1 20($fp)
lw $t3 16($fp)
bne $t3 100 $Label41
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label42
$Label41:
$Label42:
lw $t3 20($fp)
bne $t3 101 $Label43
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label44
$Label43:
$Label44:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t3 0
bne $t3 0 $Label45
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label46
$Label45:
$Label46:
li $t3 0
bne $t3 0 $Label47
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label48
$Label47:
$Label48:
li $t3 0
bne $t3 0 $Label49
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label50
$Label49:
$Label50:
li $t1 97
sw $t1 12($fp)
lw $t1 12($fp)
addiu $t3 $t1 97
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 194 $Label51
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label52
$Label51:
$Label52:
li $t3 0
bne $t3 0 $Label53
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label54
$Label53:
$Label54:
li $t3 1
bne $t3 0 $Label55
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label56
$Label55:
$Label56:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bge $a1 2 $Label57
$Label59:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
blt $a1 2 $Label59
j $Label58
$Label57:
$Label58:
jr $ra
test_brackets:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
jr $ra
jr $ra
test_compare_operator:
addiu $fp $sp 12
addiu $sp $sp 32
li $t1 0
sw $t1 8($fp)
li $t1 1
sw $t1 12($fp)
li $t1 0
sw $t1 16($fp)
lw $a1 8($fp)
lw $a2 12($fp)
bge $a1 $a2 $Label60
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label61
$Label60:
$Label61:
lw $a1 12($fp)
lw $a2 8($fp)
ble $a1 $a2 $Label62
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label63
$Label62:
$Label63:
lw $a1 8($fp)
lw $a2 12($fp)
bne $a1 $a2 $Label64
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 16($fp)
j $Label65
$Label64:
$Label65:
lw $a1 16($fp)
bne $a1 0 $Label66
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label67
$Label66:
$Label67:
lw $a1 8($fp)
lw $a2 12($fp)
beq $a1 $a2 $Label68
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label69
$Label68:
$Label69:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bgt $a1 1 $Label70
$Label72:
lw $a1 8($fp)
lw $a2 12($fp)
bgt $a1 $a2 $Label73
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label74
$Label73:
$Label74:
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 1 $Label72
j $Label71
$Label70:
$Label71:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bgt $a1 1 $Label75
$Label77:
lw $a1 12($fp)
lw $a2 8($fp)
blt $a1 $a2 $Label78
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label79
$Label78:
$Label79:
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 1 $Label77
j $Label76
$Label75:
$Label76:
jr $ra
test_expression:
addiu $fp $sp 36
addiu $sp $sp 100
li $t1 0
sw $t1 8($fp)
li $t1 0
sw $t1 12($fp)
li $t1 97
sw $t1 16($fp)
li $t1 98
sw $t1 20($fp)
li $t1 99
sw $t1 24($fp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 8($fp)
addiu $t1 $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 0 $Label80
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label81
$Label80:
$Label81:
lw $t2 8($fp)
li $t0 0
subu $t3 $t0 $t2
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 0 $Label82
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label83
$Label82:
$Label83:
lw $t1 16($fp)
addiu $t1 $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 97 $Label84
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label85
$Label84:
$Label85:
lw $t2 16($fp)
li $t0 0
subu $t3 $t0 $t2
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 -97 $Label86
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label87
$Label86:
$Label87:
li $t1 3
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 3 $Label88
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label89
$Label88:
$Label89:
li $t1 -1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 -1 $Label90
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label91
$Label90:
$Label91:
li $t1 1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 1 $Label92
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label93
$Label92:
$Label93:
li $t1 1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 1 $Label94
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label95
$Label94:
$Label95:
li $t1 -1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 -1 $Label96
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label97
$Label96:
$Label97:
li $t1 1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 1 $Label98
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label99
$Label98:
$Label99:
li $t1 -9
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 -9 $Label100
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label101
$Label100:
$Label101:
li $t1 5
sw $t1 12($fp)
addiu $t1 $gp 4
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t1 12($fp)
addiu $t4 $t1 1
addiu $t1 $gp 4
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addu $t6 $t3 $t5
addiu $t7 $t6 3
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal count_to_10
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t8 $t1 0
lw $t9 44($gp)
mul $t1 $t7 $t8
sw $t1 -28($sp)
lw $t1 -28($sp)
div $t1 $t1 3
sw $t1 -24($sp)
lw $t2 -24($sp)
li $t1 0
subu $t1 $t1 $t2
sw $t1 -20($sp)
lw $t1 -20($sp)
addiu $t1 $t1 97
sw $t1 -16($sp)
lw $t1 -16($sp)
addiu $t1 $t1 97
sw $t1 -12($sp)
lw $t1 -12($sp)
subu $t1 $t1 2
sw $t1 -8($sp)
lw $t1 -8($sp)
addu $t1 $t1 $t9
sw $t1 -4($sp)
lw $t1 -4($sp)
addiu $t1 $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 33 $Label102
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label103
$Label102:
$Label103:
li $t1 1
sw $t1 8($fp)
li $t1 1
sw $t1 12($fp)
li $t1 97
sw $t1 28($fp)
li $t1 113
sw $t1 32($fp)
lw $t1 28($fp)
lw $t2 32($fp)
mul $t3 $t1 $t2
lw $t1 24($fp)
addu $t4 $t1 $t3
lw $t1 20($fp)
addu $t5 $t1 $t4
lw $t1 16($fp)
mul $t6 $t1 $t5
lw $t1 12($fp)
addu $t7 $t1 $t6
lw $t1 8($fp)
mul $t8 $t1 $t7
addiu $t1 $t8 0
sw $t1 8($fp)
lw $t1 8($fp)
div $t3 $t1 1024
lw $t1 88($gp)
addu $t4 $t1 $t3
addiu $t1 $t4 0
sw $t1 88($gp)
jr $ra
jr $ra
test_while:
addiu $fp $sp 16
addiu $sp $sp 32
li $t1 9
sw $t1 12($fp)
lw $a1 12($fp)
blt $a1 0 $Label104
$Label106:
lw $a1 12($fp)
blt $a1 5 $Label107
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label108
$Label107:
$Label108:
lw $t1 12($fp)
subu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 12($fp)
lw $a1 12($fp)
bge $a1 0 $Label106
j $Label105
$Label104:
$Label105:
li $t1 0
sw $t1 12($fp)
lw $a1 12($fp)
bgt $a1 2 $Label109
$Label111:
lw $a1 12($fp)
bne $a1 0 $Label112
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label113
$Label112:
lw $a1 12($fp)
bne $a1 1 $Label114
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label115
$Label114:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
$Label115:
$Label113:
lw $t1 12($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 12($fp)
lw $a1 12($fp)
ble $a1 2 $Label111
j $Label110
$Label109:
$Label110:
li $t1 0
sw $t1 12($fp)
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bgt $a1 2 $Label116
$Label118:
li $t1 0
sw $t1 12($fp)
lw $a1 12($fp)
bgt $a1 2 $Label119
$Label121:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 12($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 12($fp)
lw $a1 12($fp)
ble $a1 2 $Label121
j $Label120
$Label119:
$Label120:
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 2 $Label118
j $Label117
$Label116:
$Label117:
li $t1 0
sw $t1 12($fp)
li $t1 11
sw $t1 8($fp)
lw $a1 12($fp)
bge $a1 10 $Label122
$Label124:
lw $t1 12($fp)
lw $t2 8($fp)
mul $t3 $t1 $t2
addiu $t1 $t3 0
lw $t0 12($fp)
sll $t0 $t0 2
addu $t0 $gp $t0
sw $t1 4($t0)
addiu $t1 $gp 4
lw $t2 12($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t1 88($gp)
addu $t4 $t1 $t3
addiu $t1 $t4 0
sw $t1 88($gp)
lw $t1 12($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 12($fp)
lw $t1 8($fp)
addiu $t3 $t1 2
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 12($fp)
blt $a1 10 $Label124
j $Label123
$Label122:
$Label123:
jr $ra
jr $ra
test_if:
addiu $fp $sp 12
addiu $sp $sp 32
li $t1 0
sw $t1 8($fp)
li $t1 0
sw $t1 12($fp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t3 0
bne $t3 0 $Label125
j $Label126
$Label125:
$Label126:
li $t3 0
bne $t3 0 $Label127
j $Label128
$Label127:
$Label128:
li $t3 0
bne $t3 0 $Label129
j $Label130
$Label129:
$Label130:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bgt $a1 1 $Label131
$Label133:
li $t3 0
bne $t3 0 $Label134
lw $a1 8($fp)
bne $a1 0 $Label136
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label137
$Label136:
$Label137:
lw $a1 12($fp)
bne $a1 0 $Label138
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label139
$Label138:
$Label139:
j $Label135
$Label134:
$Label135:
li $t1 0
sw $t1 12($fp)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 1 $Label133
j $Label132
$Label131:
$Label132:
li $t1 0
sw $t1 8($fp)
li $t3 0
bne $t3 0 $Label140
lw $a1 8($fp)
bge $a1 2 $Label142
$Label144:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
blt $a1 2 $Label144
j $Label143
$Label142:
$Label143:
j $Label141
$Label140:
$Label141:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bgt $a1 1 $Label145
$Label147:
li $t3 0
bne $t3 0 $Label148
lw $a1 8($fp)
bne $a1 0 $Label150
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label151
$Label150:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
$Label151:
j $Label149
$Label148:
$Label149:
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 1 $Label147
j $Label146
$Label145:
$Label146:
li $t1 0
sw $t1 12($fp)
li $t1 97
sw $t1 16($fp)
lw $a1 16($fp)
bne $a1 97 $Label152
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label153
$Label152:
$Label153:
lw $a1 16($fp)
bne $a1 98 $Label154
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 12($fp)
j $Label155
$Label154:
$Label155:
lw $a1 12($fp)
bne $a1 0 $Label156
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label157
$Label156:
$Label157:
jr $ra
jr $ra
test_switch:
addiu $fp $sp 12
addiu $sp $sp 40
li $t1 0
sw $t1 16($fp)
li $t1 0
sw $t1 20($fp)
li $t1 0
sw $t1 8($fp)
li $t1 0
sw $t1 12($fp)
lw $a1 8($fp)
bgt $a1 6 $Label158
$Label160:
lw $a1 8($fp)
bne $a1 0 $Label161
li $t3 0
bne $t3 0 $Label163
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 3
sw $t1 4($gp)
li $a0 3
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal get_sum
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
addiu $t1 $t3 0
sw $t1 16($gp)
j $Label164
$Label163:
$Label164:
li $t3 1
bne $t3 0 $Label165
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 16($fp)
j $Label166
$Label165:
$Label166:
lw $a1 16($fp)
bne $a1 0 $Label167
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label168
$Label167:
$Label168:
li $t1 1
sw $t1 20($fp)
j $Label162
$Label161:
lw $a1 8($fp)
bne $a1 1 $Label169
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 0
sw $t1 12($fp)
lw $a1 12($fp)
bgt $a1 2 $Label171
$Label173:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 12($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 12($fp)
lw $a1 12($fp)
ble $a1 2 $Label173
j $Label172
$Label171:
$Label172:
li $t1 1
sw $t1 20($fp)
j $Label170
$Label169:
lw $a1 8($fp)
bne $a1 2 $Label174
j $Label175
$Label174:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $t1 8($fp)
div $t3 $t1 3
bne $t3 1 $Label176
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 1
sw $t1 20($fp)
j $Label177
$Label176:
$Label177:
lw $a1 20($fp)
bne $a1 0 $Label178
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label179
$Label178:
$Label179:
li $t1 1
sw $t1 20($fp)
$Label175:
$Label170:
$Label162:
lw $a1 20($fp)
bne $a1 0 $Label180
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label181
$Label180:
$Label181:
li $t1 0
sw $t1 20($fp)
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
ble $a1 6 $Label160
j $Label159
$Label158:
$Label159:
li $t1 0
sw $t1 8($fp)
lw $a1 8($fp)
bge $a1 3 $Label182
$Label184:
lw $a1 8($fp)
bne $a1 0 $Label185
li $t1 97
sw $t1 24($fp)
j $Label186
$Label185:
$Label186:
lw $a1 8($fp)
bne $a1 1 $Label187
li $t1 98
sw $t1 24($fp)
j $Label188
$Label187:
$Label188:
lw $a1 8($fp)
bne $a1 2 $Label189
li $t1 99
sw $t1 24($fp)
j $Label190
$Label189:
$Label190:
lw $a1 24($fp)
bne $a1 97 $Label191
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label192
$Label191:
lw $a1 24($fp)
bne $a1 98 $Label193
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label194
$Label193:
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
$Label194:
$Label192:
lw $t1 8($fp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 8($fp)
lw $a1 8($fp)
blt $a1 3 $Label184
j $Label183
$Label182:
$Label183:
li $t1 1
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 1 $Label195
j $Label196
$Label195:
$Label196:
jr $ra
jr $ra
test_function:
addiu $fp $sp 20
addiu $sp $sp 36
li $t1 11
sw $t1 8($fp)
li $t1 97
sw $t1 12($fp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $a0 12($fp)
sw $ra 8($sp)
sw $fp 12($sp)
jal higher
addiu $sp $fp -8
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal count_to_10
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
addu $t5 $t3 $t4
move $a0 $t5
li $v0 1
syscall
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal prt_message
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
jr $ra
test_printf:
addiu $fp $sp 36
addiu $sp $sp 68
li $t1 1
sw $t1 8($fp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $a0 8($fp)
li $v0 1
syscall
li $t1 5
sw $t1 8($fp)
addiu $t1 $gp 4
lw $t2 8($fp)
sll $t2 $t2 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t1 8($fp)
addiu $t4 $t1 1
addiu $t1 $gp 4
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addu $t6 $t3 $t5
addiu $t7 $t6 3
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal count_to_10
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t8 $t1 0
mul $t9 $t7 $t8
div $t1 $t9 3
sw $t1 -20($sp)
lw $t2 -20($sp)
li $t1 0
subu $t1 $t1 $t2
sw $t1 -16($sp)
lw $t1 -16($sp)
addiu $t1 $t1 97
sw $t1 -12($sp)
lw $t1 -12($sp)
addiu $t1 $t1 97
sw $t1 -8($sp)
lw $t1 -8($sp)
subu $t1 $t1 2
sw $t1 -4($sp)
lw $a0 -4($sp)
li $v0 1
syscall
jr $ra
jr $ra
test_scanf:
addiu $fp $sp 16
addiu $sp $sp 48
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $v0 5
syscall
sw $v0 8($fp)
li $v0 12
syscall
sw $v0 20($fp)
lw $t1 88($gp)
lw $t2 8($fp)
addu $t3 $t1 $t2
lw $t2 20($fp)
addu $t4 $t3 $t2
addiu $t1 $t4 0
sw $t1 88($gp)
li $v0 12
syscall
sw $v0 20($fp)
lw $t1 20($fp)
addiu $t1 $t1 0
sw $t1 56($gp)
lw $t1 88($gp)
lw $t2 20($fp)
addu $t3 $t1 $t2
addiu $t1 $t3 0
sw $t1 88($gp)
li $v0 5
syscall
sw $v0 8($fp)
lw $t1 88($gp)
lw $t2 8($fp)
addu $t3 $t1 $t2
addiu $t1 $t3 0
sw $t1 88($gp)
jr $ra
jr $ra
test_varib2:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
lw $a1 68($gp)
bne $a1 1 $Label197
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label198
$Label197:
$Label198:
jr $ra
jr $ra
test_varib:
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 100
sw $t1 8($fp)
lw $a1 8($fp)
bne $a1 100 $Label199
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
j $Label200
$Label199:
$Label200:
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_varib2
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
jr $ra
test_para4:
sw $a0 44($sp)
sw $a1 48($sp)
sw $a2 52($sp)
sw $a3 56($sp)
lw $v1 0($k1)
sw $v1 60($sp)
lw $v1 4($k1)
sw $v1 64($sp)
lw $v1 8($k1)
sw $v1 68($sp)
addiu $fp $sp 36
addiu $sp $sp 72
lw $t1 88($gp)
lw $t2 8($fp)
addu $t3 $t1 $t2
lw $t2 12($fp)
addu $t4 $t3 $t2
lw $t2 16($fp)
addu $t5 $t4 $t2
lw $t2 20($fp)
addu $t6 $t5 $t2
lw $t2 24($fp)
addu $t7 $t6 $t2
lw $t2 28($fp)
addu $t8 $t7 $t2
lw $t2 32($fp)
addu $t9 $t8 $t2
addiu $t1 $t9 0
sw $t1 88($gp)
jr $ra
test_para1:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $v0 1
jr $ra
test_para2:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $v0 97
jr $ra
test_para3:
sw $a0 20($sp)
sw $a1 24($sp)
addiu $fp $sp 12
addiu $sp $sp 28
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
jr $ra
jr $ra
test_para:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $a0 1
li $a1 2
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_para1
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 97
li $a1 98
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_para2
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 97
li $a1 1
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_para3
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 1
li $a1 2
li $a2 3
li $a3 4
li $v0 5
sw $v0 0($k1)
li $v0 6
sw $v0 4($k1)
li $v0 7
sw $v0 8($k1)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
jal test_para4
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
jr $ra
main:
li $k1 268501104
addiu $fp $gp 92
addiu $sp $fp 12
li $t1 0
sw $t1 88($gp)
lw $t1 88($gp)
addiu $t3 $t1 1
addiu $t1 $t3 0
sw $t1 88($gp)
li $t1 0
sw $t1 8($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_global_variable
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_global_const
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_brackets
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_compare_operator
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
jal test_expression
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal test_while
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_if
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_switch
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
jal test_function
addiu $sp $fp -20
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $t6 20($sp)
sw $t7 24($sp)
sw $t8 28($sp)
sw $t9 32($sp)
sw $ra 36($sp)
sw $fp 40($sp)
jal test_printf
addiu $sp $fp -36
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $t9 32($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal test_scanf
addiu $sp $fp -16
lw $t3 8($sp)
lw $t4 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_varib
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_para
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String2
li $v0 4
syscall
lw $a0 88($gp)
li $v0 1
syscall
li $v0 10
syscall
# End Of MIPS Assembly Code.
