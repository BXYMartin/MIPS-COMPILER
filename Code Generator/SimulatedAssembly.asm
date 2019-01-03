.data
.globl main
.text
t:
addiu $fp $sp 8
addiu $sp $sp 40
li $t1 0
sw $t1 8($fp)
lw $t2 8($fp)
addiu $t3 $t2 99
move $v0 $t3
jr $ra
main:
addiu $fp $gp 0
addiu $sp $fp 12
li $s0 0
# End Of MIPS Assembly Code.
