.data
	$String3:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String4:.asciiz "all test:"
.globl main
.text
get_sum:
move $s0 $a0
addiu $sp $sp 8
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $s2 $s2 1
li $s1 0
beq $s0 1 $Label1
subu $t3 $s0 1
move $a0 $t3
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal get_sum
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $s1 $t1 0
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label1:
$Label2:
addu $t3 $s1 $s0
move $v0 $t3
jr $ra
count_to_10:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $a0 10
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal get_sum
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
move $v0 $t3
jr $ra
higher:
move $s0 $a0
addiu $sp $sp 4
li $v0 65
jr $ra
prt_message:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
la $a0 $String3
li $v0 4
syscall
li $v0 97
jr $ra
test_global_variable:
addiu $sp $sp 8
lw $t1 88($gp)
addiu $t4 $t1 0
addiu $t0 $gp 88
addiu $t1 $t4 1
sw $t1 0($t0)
li $s1 0
li $s0 0
li $s2 2
addiu $t0 $gp 44
li $t1 97
sw $t1 0($t0)
addiu $t0 $gp 44
addiu $t0 $t0 4
li $t1 49
sw $t1 0($t0)
addiu $t0 $gp 44
addiu $t0 $t0 8
li $t1 95
sw $t1 0($t0)
addiu $t0 $gp 44
addiu $t0 $t0 12
li $t1 43
sw $t1 0($t0)
addiu $t0 $gp 44
addiu $t0 $t0 16
li $t1 65
sw $t1 0($t0)
move $a0 $s2
li $v0 1
syscall
addiu $t1 $gp 44
lw $t3 0($t1)
move $a0 $t3
li $v0 1
syscall
bne $s2 2 $Label3
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label3:
$Label4:
bne $s2 1 $Label5
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 1
$Label5:
$Label6:
bne $s0 0 $Label7
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label7:
$Label8:
li $s4 1
li $s5 2
li $s6 3
li $s7 4
addiu $t0 $gp 84
li $t1 5
sw $t1 0($t0)
li $s0 0
bne $s4 1 $Label9
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label9:
$Label10:
bne $s4 0 $Label11
li $s0 1
$Label11:
$Label12:
bne $s0 0 $Label13
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label13:
$Label14:
li $s0 0
bne $s5 2 $Label15
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label15:
$Label16:
bne $s5 0 $Label17
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 1
$Label17:
$Label18:
bne $s0 0 $Label19
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label19:
$Label20:
li $s0 0
bne $s6 3 $Label21
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label21:
$Label22:
bne $s6 0 $Label23
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 1
$Label23:
$Label24:
bne $s0 0 $Label25
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label25:
$Label26:
li $s0 0
bne $s7 4 $Label27
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label27:
$Label28:
bne $s7 0 $Label29
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 1
$Label29:
$Label30:
bne $s0 0 $Label31
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label31:
$Label32:
li $s0 0
lw $a1 84($gp)
bne $a1 5 $Label33
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label33:
$Label34:
lw $a1 84($gp)
bne $a1 0 $Label35
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 1
$Label35:
$Label36:
bne $s0 0 $Label37
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label37:
$Label38:
jr $ra
test_global_const:
addiu $sp $sp 20
addiu $t0 $fp 24
li $t1 100
sw $t1 0($t0)
lw $a1 24($fp)
bne $a1 100 $Label39
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label39:
$Label40:
addiu $t0 $fp 16
li $t1 100
sw $t1 0($t0)
addiu $t0 $fp 16
addiu $t0 $t0 4
li $t1 101
sw $t1 0($t0)
addiu $t1 $fp 16
lw $t3 0($t1)
bne $t3 100 $Label41
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label41:
$Label42:
addiu $t1 $fp 16
addiu $t1 $t1 4
lw $t3 0($t1)
bne $t3 101 $Label43
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label43:
$Label44:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $t3 0
bne $t3 0 $Label45
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label45:
$Label46:
li $t3 0
bne $t3 0 $Label47
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label47:
$Label48:
li $t3 0
bne $t3 0 $Label49
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label49:
$Label50:
li $s1 97
addiu $s0 $s1 97
bne $s0 194 $Label51
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label51:
$Label52:
li $t3 0
bne $t3 0 $Label53
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label53:
$Label54:
li $t3 1
bne $t3 0 $Label55
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label55:
$Label56:
li $s0 0
bge $s0 2 $Label57
$Label59:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 2 $Label59
$Label57:
$Label58:
jr $ra
test_brackets:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
jr $ra
test_compare_operator:
addiu $sp $sp 12
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
li $s0 0
li $s1 1
bge $s0 $s1 $Label60
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label60:
$Label61:
ble $s1 $s0 $Label62
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label62:
$Label63:
bne $s0 $s1 $Label64
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 1
sw $t1 0($t0)
$Label64:
$Label65:
lw $a1 16($fp)
bne $a1 0 $Label66
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label66:
$Label67:
beq $s0 $s1 $Label68
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label68:
$Label69:
li $s0 0
bgt $s0 1 $Label70
$Label72:
bgt $s0 $s1 $Label73
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label73:
$Label74:
addiu $s0 $s0 1
ble $s0 1 $Label72
$Label70:
$Label71:
li $s0 0
bgt $s0 1 $Label75
$Label77:
blt $s1 $s0 $Label78
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label78:
$Label79:
addiu $s0 $s0 1
ble $s0 1 $Label77
$Label75:
$Label76:
jr $ra
test_expression:
addiu $sp $sp 60
addiu $t0 $sp -4
lw $t1 88($gp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 97
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 98
sw $t1 0($t0)
addiu $t0 $fp 24
li $t1 99
sw $t1 0($t0)
addiu $t0 $gp 88
lw $t1 -4($sp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s1 0
addiu $s0 $s1 0
bne $s0 0 $Label80
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label80:
$Label81:
li $t0 0
subu $s0 $t0 $s0
bne $s0 0 $Label82
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label82:
$Label83:
lw $t1 16($fp)
addiu $s0 $t1 0
bne $s0 97 $Label84
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label84:
$Label85:
lw $t2 16($fp)
li $t0 0
subu $s0 $t0 $t2
bne $s0 -97 $Label86
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label86:
$Label87:
li $s0 3
bne $s0 3 $Label88
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label88:
$Label89:
li $s0 -1
bne $s0 -1 $Label90
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label90:
$Label91:
li $s0 1
bne $s0 1 $Label92
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label92:
$Label93:
li $s0 1
bne $s0 1 $Label94
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label94:
$Label95:
li $s0 -1
bne $s0 -1 $Label96
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label96:
$Label97:
li $s0 1
bne $s0 1 $Label98
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label98:
$Label99:
li $s0 -9
bne $s0 -9 $Label100
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label100:
$Label101:
li $s1 5
addiu $t1 $gp 4
sll $t2 $s1 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t4 $s1 1
addiu $t1 $gp 4
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addu $t6 $t3 $t5
addiu $t7 $t6 3
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal count_to_10
move $sp $fp
addiu $sp $sp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t8 $t1 0
addiu $t1 $gp 44
lw $t9 0($t1)
addiu $t0 $sp -32
mul $t1 $t7 $t8
sw $t1 0($t0)
addiu $t0 $sp -28
lw $t1 -32($sp)
div $t1 $t1 3
sw $t1 0($t0)
addiu $t0 $sp -24
lw $t2 -28($sp)
li $t1 0
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $sp -20
lw $t1 -24($sp)
addiu $t1 $t1 97
sw $t1 0($t0)
addiu $t0 $sp -16
lw $t1 -20($sp)
addiu $t1 $t1 97
sw $t1 0($t0)
addiu $t0 $sp -12
lw $t1 -16($sp)
subu $t1 $t1 2
sw $t1 0($t0)
lw $t1 -12($sp)
addu $s0 $t1 $t9
bne $s0 33 $Label102
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label102:
$Label103:
addiu $t0 $sp -4
lw $t1 88($gp)
addiu $t1 $t1 0
sw $t1 0($t0)
addiu $t0 $fp 32
li $t1 113
sw $t1 0($t0)
addiu $t0 $fp 28
li $t1 97
sw $t1 0($t0)
lw $t1 28($fp)
lw $t2 32($fp)
mul $t3 $t1 $t2
lw $t1 24($fp)
addu $t4 $t1 $t3
lw $t1 20($fp)
addu $t5 $t1 $t4
lw $t1 16($fp)
mul $t6 $t1 $t5
li $s1 1
addu $t7 $s1 $t6
mul $s0 $s1 $t7
div $t3 $s0 1024
addiu $t0 $gp 88
lw $t1 -4($sp)
addu $t1 $t1 $t3
sw $t1 0($t0)
jr $ra
test_while:
addiu $sp $sp 8
li $s0 9
blt $s0 0 $Label104
$Label106:
blt $s0 5 $Label107
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label107:
$Label108:
subu $s0 $s0 1
bge $s0 0 $Label106
$Label104:
$Label105:
li $s0 0
bgt $s0 2 $Label109
$Label111:
bne $s0 0 $Label112
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
j $Label113
$Label112:
bne $s0 1 $Label114
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
j $Label115
$Label114:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label115:
$Label113:
addiu $s0 $s0 1
ble $s0 2 $Label111
$Label109:
$Label110:
li $s1 0
li $s0 0
bgt $s1 2 $Label116
$Label118:
li $s0 0
bgt $s0 2 $Label119
$Label121:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $s0 $s0 1
ble $s0 2 $Label121
$Label119:
$Label120:
addiu $s1 $s1 1
ble $s1 2 $Label118
$Label116:
$Label117:
li $s0 0
li $s1 11
bge $s0 10 $Label122
$Label124:
addiu $t0 $gp 4
sll $t1 $s0 2
addu $t0 $t0 $t1
mul $t1 $s0 $s1
sw $t1 0($t0)
addiu $t1 $gp 4
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t0 $gp 88
lw $t1 88($gp)
addu $t1 $t1 $t3
sw $t1 0($t0)
addiu $s0 $s0 1
addiu $s1 $s1 2
blt $s0 10 $Label124
$Label122:
$Label123:
jr $ra
test_if:
addiu $sp $sp 12
lw $t1 88($gp)
addiu $t4 $t1 0
li $s0 0
li $s1 0
addiu $t0 $gp 88
addiu $t1 $t4 1
sw $t1 0($t0)
li $t3 0
bne $t3 0 $Label125
$Label125:
$Label126:
li $t3 0
bne $t3 0 $Label127
$Label127:
$Label128:
li $t3 0
bne $t3 0 $Label129
$Label129:
$Label130:
li $s0 0
bgt $s0 1 $Label131
$Label133:
li $t3 0
bne $t3 0 $Label134
bne $s0 0 $Label136
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s1 1
$Label136:
$Label137:
bne $s1 0 $Label138
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label138:
$Label139:
$Label134:
$Label135:
li $s1 0
addiu $s0 $s0 1
ble $s0 1 $Label133
$Label131:
$Label132:
li $s0 0
li $t3 0
bne $t3 0 $Label140
bge $s0 2 $Label142
$Label144:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $s0 $s0 1
blt $s0 2 $Label144
$Label142:
$Label143:
$Label140:
$Label141:
li $s0 0
bgt $s0 1 $Label145
$Label147:
li $t3 0
bne $t3 0 $Label148
bne $s0 0 $Label150
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
j $Label151
$Label150:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label151:
$Label148:
$Label149:
addiu $s0 $s0 1
ble $s0 1 $Label147
$Label145:
$Label146:
li $s1 0
addiu $t0 $fp 16
li $t1 97
sw $t1 0($t0)
lw $a1 16($fp)
bne $a1 97 $Label152
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label152:
$Label153:
lw $a1 16($fp)
bne $a1 98 $Label154
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s1 1
$Label154:
$Label155:
bne $s1 0 $Label156
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label156:
$Label157:
jr $ra
test_switch:
addiu $sp $sp 20
li $s1 0
li $s0 0
addiu $t0 $fp 16
li $t1 0
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
bgt $s1 6 $Label158
$Label160:
bne $s1 0 $Label161
li $t3 0
bne $t3 0 $Label163
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $gp 4
li $t1 3
sw $t1 0($t0)
li $a0 3
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal get_sum
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
addiu $t0 $gp 4
addiu $t0 $t0 12
move $t1 $v0
addiu $t1 $t1 0
sw $t1 0($t0)
$Label163:
$Label164:
li $t3 1
bne $t3 0 $Label165
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $fp 16
li $t1 1
sw $t1 0($t0)
$Label165:
$Label166:
lw $a1 16($fp)
bne $a1 0 $Label167
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label167:
$Label168:
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
j $Label162
$Label161:
bne $s1 1 $Label169
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 0
bgt $s0 2 $Label171
$Label173:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $s0 $s0 1
ble $s0 2 $Label173
$Label171:
$Label172:
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
j $Label170
$Label169:
bne $s1 2 $Label174
j $Label175
$Label174:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
div $t3 $s1 3
bne $t3 1 $Label176
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
$Label176:
$Label177:
lw $a1 20($fp)
bne $a1 0 $Label178
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label178:
$Label179:
addiu $t0 $fp 20
li $t1 1
sw $t1 0($t0)
$Label175:
$Label170:
$Label162:
lw $a1 20($fp)
bne $a1 0 $Label180
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label180:
$Label181:
addiu $t0 $fp 20
li $t1 0
sw $t1 0($t0)
addiu $s1 $s1 1
ble $s1 6 $Label160
$Label158:
$Label159:
li $s1 0
bge $s1 3 $Label182
$Label184:
bne $s1 0 $Label185
addiu $t0 $fp 24
li $t1 97
sw $t1 0($t0)
$Label185:
$Label186:
bne $s1 1 $Label187
addiu $t0 $fp 24
li $t1 98
sw $t1 0($t0)
$Label187:
$Label188:
bne $s1 2 $Label189
addiu $t0 $fp 24
li $t1 99
sw $t1 0($t0)
$Label189:
$Label190:
lw $a1 24($fp)
bne $a1 97 $Label191
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
j $Label192
$Label191:
lw $a1 24($fp)
bne $a1 98 $Label193
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
j $Label194
$Label193:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label194:
$Label192:
addiu $s1 $s1 1
blt $s1 3 $Label184
$Label182:
$Label183:
li $s1 1
bne $s1 1 $Label195
$Label195:
$Label196:
jr $ra
test_function:
addiu $sp $sp 8
li $s1 11
li $s0 97
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
move $a0 $s0
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal higher
move $sp $fp
addiu $sp $sp -12
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t3 $t1 0
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal count_to_10
move $sp $fp
addiu $sp $sp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t4 $t1 0
addu $t5 $t3 $t4
move $a0 $t5
li $v0 1
syscall
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal prt_message
move $sp $fp
addiu $sp $sp -8
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
test_printf:
addiu $sp $sp 24
li $s0 1
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
move $a0 $s0
li $v0 1
syscall
li $s0 5
addiu $t1 $gp 4
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
addiu $t4 $s0 1
addiu $t1 $gp 4
sll $t2 $t4 2
addu $t1 $t1 $t2
lw $t5 0($t1)
addu $t6 $t3 $t5
addiu $t7 $t6 3
sw $t3 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal count_to_10
move $sp $fp
addiu $sp $sp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t8 $t1 0
mul $t9 $t7 $t8
addiu $t0 $sp -20
div $t1 $t9 3
sw $t1 0($t0)
addiu $t0 $sp -16
lw $t2 -20($sp)
li $t1 0
subu $t1 $t1 $t2
sw $t1 0($t0)
addiu $t0 $sp -12
lw $t1 -16($sp)
addiu $t1 $t1 97
sw $t1 0($t0)
addiu $t0 $sp -8
lw $t1 -12($sp)
addiu $t1 $t1 97
sw $t1 0($t0)
addiu $t0 $sp -4
lw $t1 -8($sp)
subu $t1 $t1 2
sw $t1 0($t0)
lw $a0 -4($sp)
li $v0 1
syscall
jr $ra
test_scanf:
addiu $sp $sp 24
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $v0 5
syscall
move $s1 $v0
li $v0 12
syscall
move $s0 $v0
lw $t1 88($gp)
addu $t3 $t1 $s1
addiu $t0 $gp 88
addu $t1 $t3 $s0
sw $t1 0($t0)
li $v0 12
syscall
move $s0 $v0
addiu $t0 $gp 44
addiu $t0 $t0 12
addiu $t1 $s0 0
sw $t1 0($t0)
addiu $t0 $gp 88
lw $t1 88($gp)
addu $t1 $t1 $s0
sw $t1 0($t0)
li $v0 5
syscall
move $s1 $v0
addiu $t0 $gp 88
lw $t1 88($gp)
addu $t1 $t1 $s1
sw $t1 0($t0)
jr $ra
test_varib2:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
bne $s4 1 $Label197
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label197:
$Label198:
jr $ra
test_varib:
addiu $sp $sp 4
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $s0 100
bne $s0 100 $Label199
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
$Label199:
$Label200:
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_varib2
move $sp $fp
addiu $sp $sp -8
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
test_para4:
move $s0 $a0
move $s1 $a1
sw $a2 8($sp)
sw $a3 12($sp)
lw $v1 0($k1)
sw $v1 16($sp)
lw $v1 4($k1)
sw $v1 20($sp)
lw $v1 8($k1)
sw $v1 24($sp)
addiu $sp $sp 28
lw $t1 88($gp)
addu $t3 $t1 $s0
addu $t4 $t3 $s1
lw $t2 16($fp)
addu $t5 $t4 $t2
lw $t2 20($fp)
addu $t6 $t5 $t2
lw $t2 24($fp)
addu $t7 $t6 $t2
lw $t2 28($fp)
addu $t8 $t7 $t2
addiu $t0 $gp 88
lw $t2 32($fp)
addu $t1 $t8 $t2
sw $t1 0($t0)
jr $ra
test_para1:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $v0 1
jr $ra
test_para2:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $v0 97
jr $ra
test_para3:
move $s0 $a0
move $s1 $a1
addiu $sp $sp 8
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
jr $ra
test_para:
addiu $t0 $gp 88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 0($t0)
li $a0 1
li $a1 2
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_para1
move $sp $fp
addiu $sp $sp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 97
li $a1 98
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_para2
move $sp $fp
addiu $sp $sp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
li $a0 97
li $a1 1
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_para3
move $sp $fp
addiu $sp $sp -16
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
sw $s0 32($sp)
sw $s1 36($sp)
sw $ra 40($sp)
sw $fp 44($sp)
addiu $sp $sp 48
addiu $fp $sp -8
jal test_para4
move $sp $fp
addiu $sp $sp -40
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $t6 20($sp)
lw $t7 24($sp)
lw $t8 28($sp)
lw $s0 32($sp)
lw $s1 36($sp)
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
main:
li $k1 268501100
addiu $fp $gp 92
addiu $sp $fp 8
addiu $sp $sp 4
li $s0 0
addiu $t0 $gp 88
addiu $t1 $s0 1
sw $t1 0($t0)
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal test_global_variable
move $sp $fp
addiu $sp $sp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal test_global_const
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_brackets
move $sp $fp
addiu $sp $sp -8
lw $ra 0($fp)
lw $fp 4($fp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
addiu $sp $sp 24
addiu $fp $sp -8
jal test_compare_operator
move $sp $fp
addiu $sp $sp -16
lw $s0 8($sp)
lw $s1 12($sp)
lw $ra 0($fp)
lw $fp 4($fp)
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
jal test_expression
move $sp $fp
addiu $sp $sp -44
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
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal test_while
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
addiu $sp $sp 32
addiu $fp $sp -8
jal test_if
move $sp $fp
addiu $sp $sp -24
lw $t3 8($sp)
lw $t4 12($sp)
lw $s0 16($sp)
lw $s1 20($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal test_switch
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $t5 16($sp)
sw $s0 20($sp)
sw $s1 24($sp)
sw $ra 28($sp)
sw $fp 32($sp)
addiu $sp $sp 36
addiu $fp $sp -8
jal test_function
move $sp $fp
addiu $sp $sp -28
lw $t3 8($sp)
lw $t4 12($sp)
lw $t5 16($sp)
lw $s0 20($sp)
lw $s1 24($sp)
lw $ra 0($fp)
lw $fp 4($fp)
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
jal test_printf
move $sp $fp
addiu $sp $sp -40
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
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
addiu $sp $sp 28
addiu $fp $sp -8
jal test_scanf
move $sp $fp
addiu $sp $sp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
addiu $sp $sp 20
addiu $fp $sp -8
jal test_varib
move $sp $fp
addiu $sp $sp -12
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $ra 8($sp)
sw $fp 12($sp)
addiu $sp $sp 16
addiu $fp $sp -8
jal test_para
move $sp $fp
addiu $sp $sp -8
lw $ra 0($fp)
lw $fp 4($fp)
la $a0 $String4
li $v0 4
syscall
lw $a0 88($gp)
li $v0 1
syscall
li $v0 10
syscall
# End Of MIPS Assembly Code.
