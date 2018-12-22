.data
	$String3:.asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	$String4:.asciiz "all test:"
.globl main
.text
get_sum:
move $s0 $a0
addiu $fp $sp 20
addiu $sp $sp 36
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
jal get_sum
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $s1 $t1 0
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label1:
$Label2:
addu $t3 $s1 $s0
move $v0 $t3
jr $ra
count_to_10:
addiu $fp $sp 12
addiu $sp $sp 20
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $a0 10
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
jal get_sum
addiu $sp $fp -20
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
addiu $fp $sp 12
addiu $sp $sp 24
li $v0 65
jr $ra
prt_message:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
la $a0 $String3
li $v0 4
syscall
li $v0 97
jr $ra
test_global_variable:
addiu $fp $sp 24
addiu $sp $sp 40
lw $t1 88($gp)
addiu $t4 $t1 0
addiu $t1 $t4 1
sw $t1 88($gp)
li $s1 0
li $s0 0
li $s2 2
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
move $a0 $s2
li $v0 1
syscall
lw $t3 44($gp)
move $a0 $t3
li $v0 1
syscall
bne $s2 2 $Label3
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label3:
$Label4:
bne $s2 1 $Label5
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 1
$Label5:
$Label6:
bne $s0 0 $Label7
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label7:
$Label8:
li $s4 1
li $s5 2
li $s6 3
li $s7 4
li $t1 5
sw $t1 84($gp)
li $s0 0
bne $s4 1 $Label9
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label9:
$Label10:
bne $s4 0 $Label11
li $s0 1
$Label11:
$Label12:
bne $s0 0 $Label13
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label13:
$Label14:
li $s0 0
bne $s5 2 $Label15
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label15:
$Label16:
bne $s5 0 $Label17
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 1
$Label17:
$Label18:
bne $s0 0 $Label19
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label19:
$Label20:
li $s0 0
bne $s6 3 $Label21
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label21:
$Label22:
bne $s6 0 $Label23
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 1
$Label23:
$Label24:
bne $s0 0 $Label25
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label25:
$Label26:
li $s0 0
bne $s7 4 $Label27
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label27:
$Label28:
bne $s7 0 $Label29
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 1
$Label29:
$Label30:
bne $s0 0 $Label31
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label31:
$Label32:
li $s0 0
lw $a1 84($gp)
bne $a1 5 $Label33
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label33:
$Label34:
lw $a1 84($gp)
bne $a1 0 $Label35
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 1
$Label35:
$Label36:
bne $s0 0 $Label37
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label37:
$Label38:
jr $ra
test_global_const:
addiu $fp $sp 20
addiu $sp $sp 48
li $t1 100
sw $t1 24($fp)
lw $a1 24($fp)
bne $a1 100 $Label39
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label39:
$Label40:
li $t1 100
sw $t1 16($fp)
li $t1 101
sw $t1 20($fp)
lw $t3 16($fp)
bne $t3 100 $Label41
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label41:
$Label42:
lw $t3 20($fp)
bne $t3 101 $Label43
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label43:
$Label44:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $t3 0
bne $t3 0 $Label45
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label45:
$Label46:
li $t3 0
bne $t3 0 $Label47
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label47:
$Label48:
li $t3 0
bne $t3 0 $Label49
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label49:
$Label50:
li $s1 97
addiu $s0 $s1 97
bne $s0 194 $Label51
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label51:
$Label52:
li $t3 0
bne $t3 0 $Label53
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label53:
$Label54:
li $t3 1
bne $t3 0 $Label55
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label55:
$Label56:
li $s0 0
bge $s0 2 $Label57
$Label59:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
addiu $s0 $s0 1
blt $s0 2 $Label59
$Label57:
$Label58:
jr $ra
test_brackets:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
jr $ra
test_compare_operator:
addiu $fp $sp 16
addiu $sp $sp 36
li $t1 0
sw $t1 16($fp)
li $s0 0
li $s1 1
bge $s0 $s1 $Label60
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label60:
$Label61:
ble $s1 $s0 $Label62
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label62:
$Label63:
bne $s0 $s1 $Label64
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $t1 1
sw $t1 16($fp)
$Label64:
$Label65:
lw $a1 16($fp)
bne $a1 0 $Label66
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label66:
$Label67:
beq $s0 $s1 $Label68
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label68:
$Label69:
li $s0 0
bgt $s0 1 $Label70
$Label72:
bgt $s0 $s1 $Label73
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label78:
$Label79:
addiu $s0 $s0 1
ble $s0 1 $Label77
$Label75:
$Label76:
jr $ra
test_expression:
addiu $fp $sp 44
addiu $sp $sp 112
lw $t1 88($gp)
addiu $t1 $t1 0
sw $t1 -4($sp)
li $t1 97
sw $t1 16($fp)
li $t1 98
sw $t1 20($fp)
li $t1 99
sw $t1 24($fp)
lw $t1 -4($sp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s1 0
addiu $s0 $s1 0
bne $s0 0 $Label80
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label80:
$Label81:
li $t0 0
subu $s0 $t0 $s0
bne $s0 0 $Label82
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label82:
$Label83:
lw $t1 16($fp)
addiu $s0 $t1 0
bne $s0 97 $Label84
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label84:
$Label85:
lw $t2 16($fp)
li $t0 0
subu $s0 $t0 $t2
bne $s0 -97 $Label86
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label86:
$Label87:
li $s0 3
bne $s0 3 $Label88
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label88:
$Label89:
li $s0 -1
bne $s0 -1 $Label90
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label90:
$Label91:
li $s0 1
bne $s0 1 $Label92
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label92:
$Label93:
li $s0 1
bne $s0 1 $Label94
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label94:
$Label95:
li $s0 -1
bne $s0 -1 $Label96
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label96:
$Label97:
li $s0 1
bne $s0 1 $Label98
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label98:
$Label99:
li $s0 -9
bne $s0 -9 $Label100
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
jal count_to_10
addiu $sp $fp -12
lw $t3 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t8 $t1 0
lw $t9 44($gp)
mul $t1 $t7 $t8
sw $t1 -32($sp)
lw $t1 -32($sp)
div $t1 $t1 3
sw $t1 -28($sp)
lw $t2 -28($sp)
li $t1 0
subu $t1 $t1 $t2
sw $t1 -24($sp)
lw $t1 -24($sp)
addiu $t1 $t1 97
sw $t1 -20($sp)
lw $t1 -20($sp)
addiu $t1 $t1 97
sw $t1 -16($sp)
lw $t1 -16($sp)
subu $t1 $t1 2
sw $t1 -12($sp)
lw $t1 -12($sp)
addu $s0 $t1 $t9
bne $s0 33 $Label102
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label102:
$Label103:
lw $t1 88($gp)
addiu $t1 $t1 0
sw $t1 -4($sp)
li $t1 113
sw $t1 32($fp)
li $t1 97
sw $t1 28($fp)
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
lw $t1 -4($sp)
addu $t1 $t1 $t3
sw $t1 88($gp)
jr $ra
test_while:
addiu $fp $sp 20
addiu $sp $sp 36
li $s0 9
blt $s0 0 $Label104
$Label106:
blt $s0 5 $Label107
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
j $Label113
$Label112:
bne $s0 1 $Label114
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
j $Label115
$Label114:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
mul $t1 $s0 $s1
sll $t0 $s0 2
addu $t0 $gp $t0
sw $t1 4($t0)
addiu $t1 $gp 4
sll $t2 $s0 2
addu $t1 $t1 $t2
lw $t3 0($t1)
lw $t1 88($gp)
addu $t1 $t1 $t3
sw $t1 88($gp)
addiu $s0 $s0 1
addiu $s1 $s1 2
blt $s0 10 $Label124
$Label122:
$Label123:
jr $ra
test_if:
addiu $fp $sp 24
addiu $sp $sp 44
lw $t1 88($gp)
addiu $t4 $t1 0
li $s0 0
li $s1 0
addiu $t1 $t4 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s1 1
$Label136:
$Label137:
bne $s1 0 $Label138
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
j $Label151
$Label150:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label151:
$Label148:
$Label149:
addiu $s0 $s0 1
ble $s0 1 $Label147
$Label145:
$Label146:
li $s1 0
li $t1 97
sw $t1 16($fp)
lw $a1 16($fp)
bne $a1 97 $Label152
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label152:
$Label153:
lw $a1 16($fp)
bne $a1 98 $Label154
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s1 1
$Label154:
$Label155:
bne $s1 0 $Label156
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label156:
$Label157:
jr $ra
test_switch:
addiu $fp $sp 20
addiu $sp $sp 48
li $s1 0
li $s0 0
li $t1 0
sw $t1 16($fp)
li $t1 0
sw $t1 20($fp)
bgt $s1 6 $Label158
$Label160:
bne $s1 0 $Label161
li $t3 0
bne $t3 0 $Label163
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $t1 3
sw $t1 4($gp)
li $a0 3
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
jal get_sum
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
move $t1 $v0
addiu $t1 $t1 0
sw $t1 16($gp)
$Label163:
$Label164:
li $t3 1
bne $t3 0 $Label165
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $t1 1
sw $t1 16($fp)
$Label165:
$Label166:
lw $a1 16($fp)
bne $a1 0 $Label167
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label167:
$Label168:
li $t1 1
sw $t1 20($fp)
j $Label162
$Label161:
bne $s1 1 $Label169
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 0
bgt $s0 2 $Label171
$Label173:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
addiu $s0 $s0 1
ble $s0 2 $Label173
$Label171:
$Label172:
li $t1 1
sw $t1 20($fp)
j $Label170
$Label169:
bne $s1 2 $Label174
j $Label175
$Label174:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
div $t3 $s1 3
bne $t3 1 $Label176
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $t1 1
sw $t1 20($fp)
$Label176:
$Label177:
lw $a1 20($fp)
bne $a1 0 $Label178
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
addiu $t1 $t1 1
sw $t1 88($gp)
$Label180:
$Label181:
li $t1 0
sw $t1 20($fp)
addiu $s1 $s1 1
ble $s1 6 $Label160
$Label158:
$Label159:
li $s1 0
bge $s1 3 $Label182
$Label184:
bne $s1 0 $Label185
li $t1 97
sw $t1 24($fp)
$Label185:
$Label186:
bne $s1 1 $Label187
li $t1 98
sw $t1 24($fp)
$Label187:
$Label188:
bne $s1 2 $Label189
li $t1 99
sw $t1 24($fp)
$Label189:
$Label190:
lw $a1 24($fp)
bne $a1 97 $Label191
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
j $Label192
$Label191:
lw $a1 24($fp)
bne $a1 98 $Label193
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
j $Label194
$Label193:
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
addiu $fp $sp 28
addiu $sp $sp 44
li $s1 11
li $s0 97
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
move $a0 $s0
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal higher
addiu $sp $fp -12
lw $s0 8($sp)
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
sw $ra 8($sp)
sw $fp 12($sp)
jal prt_message
addiu $sp $fp -8
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
test_printf:
addiu $fp $sp 40
addiu $sp $sp 72
li $s0 1
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
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
test_scanf:
addiu $fp $sp 20
addiu $sp $sp 52
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $v0 5
syscall
move $s1 $v0
li $v0 12
syscall
move $s0 $v0
lw $t1 88($gp)
addu $t3 $t1 $s1
addu $t1 $t3 $s0
sw $t1 88($gp)
li $v0 12
syscall
move $s0 $v0
addiu $t1 $s0 0
sw $t1 56($gp)
lw $t1 88($gp)
addu $t1 $t1 $s0
sw $t1 88($gp)
li $v0 5
syscall
move $s1 $v0
lw $t1 88($gp)
addu $t1 $t1 $s1
sw $t1 88($gp)
jr $ra
test_varib2:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
bne $s4 1 $Label197
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label197:
$Label198:
jr $ra
test_varib:
addiu $fp $sp 12
addiu $sp $sp 24
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $s0 100
bne $s0 100 $Label199
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
$Label199:
$Label200:
sw $ra 8($sp)
sw $fp 12($sp)
jal test_varib2
addiu $sp $fp -8
lw $ra 0($fp)
lw $fp 4($fp)
jr $ra
test_para4:
move $s0 $a0
move $s1 $a1
sw $a2 56($sp)
sw $a3 60($sp)
lw $v1 0($k1)
sw $v1 64($sp)
lw $v1 4($k1)
sw $v1 68($sp)
lw $v1 8($k1)
sw $v1 72($sp)
addiu $fp $sp 40
addiu $sp $sp 76
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
lw $t2 32($fp)
addu $t1 $t8 $t2
sw $t1 88($gp)
jr $ra
test_para1:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $v0 1
jr $ra
test_para2:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $v0 97
jr $ra
test_para3:
move $s0 $a0
move $s1 $a1
addiu $fp $sp 16
addiu $sp $sp 32
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
jr $ra
test_para:
addiu $fp $sp 8
addiu $sp $sp 16
lw $t1 88($gp)
addiu $t1 $t1 1
sw $t1 88($gp)
li $a0 1
li $a1 2
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal test_para1
addiu $sp $fp -16
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
jal test_para2
addiu $sp $fp -16
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
jal test_para3
addiu $sp $fp -16
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
jal test_para4
addiu $sp $fp -40
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
addiu $sp $fp 12
li $s0 0
addiu $t1 $s0 1
sw $t1 88($gp)
sw $t3 8($sp)
sw $t4 12($sp)
sw $s0 16($sp)
sw $s1 20($sp)
sw $ra 24($sp)
sw $fp 28($sp)
jal test_global_variable
addiu $sp $fp -24
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
jal test_global_const
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $ra 8($sp)
sw $fp 12($sp)
jal test_brackets
addiu $sp $fp -8
lw $ra 0($fp)
lw $fp 4($fp)
sw $s0 8($sp)
sw $s1 12($sp)
sw $ra 16($sp)
sw $fp 20($sp)
jal test_compare_operator
addiu $sp $fp -16
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
jal test_expression
addiu $sp $fp -44
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
jal test_while
addiu $sp $fp -20
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
jal test_if
addiu $sp $fp -24
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
jal test_switch
addiu $sp $fp -20
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
jal test_function
addiu $sp $fp -28
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
jal test_printf
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
lw $fp 4($fp)
sw $t3 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $ra 20($sp)
sw $fp 24($sp)
jal test_scanf
addiu $sp $fp -20
lw $t3 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $s0 8($sp)
sw $ra 12($sp)
sw $fp 16($sp)
jal test_varib
addiu $sp $fp -12
lw $s0 8($sp)
lw $ra 0($fp)
lw $fp 4($fp)
sw $ra 8($sp)
sw $fp 12($sp)
jal test_para
addiu $sp $fp -8
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
