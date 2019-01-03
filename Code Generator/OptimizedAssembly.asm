.data
.globl main
.text
t:
addiu $fp $sp 32
addiu $sp $sp 64
li $s0 0
addiu $t3 $s0 99
move $v0 $t3
jr $ra
main:
addiu $fp $gp 0
addiu $sp $fp 12
li $s0 0
# End Of MIPS Assembly Code.
