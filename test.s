add $t1, $zero, $zero	//用于遍历屏幕的x
add $t2, $zero, $zero	//用于遍历屏幕的y
addi $t3, $zero, 512	//屏幕长度
addi $t4, $zero, 180	//屏幕宽度 上
lui $t5, 0xc000
addi $t7, $zero, 0xcc4

estart1:
sw $t7, 0($t5)
addi $t5, $t5, 1
addi $t1, $t1, 1
bne $t1, $t3, estart1
add $t1, $zero, $zero
addi $t2, $t2, 1
bne $t2, $t4, estart1

addi $s7, $zero, 0xdf2
addi $t7, $zero, 0xcc4
estart2:
sw $t7, 0($t5)
addi $t5, $t5, 1
addi $t1, $t1, 1
bne $t1, $t3, estart2
add $t1, $zero, $zero
addi $t2, $t2, 1
bne $t2, $t4, estart2

addi $t7, $zero, 0x000
estart3:
sw $t7, 0($t5)
addi $t5, $t5, 1
addi $t1, $t1, 1
bne $t1, $t3, estart3
add $t1, $zero, $zero
addi $t2, $t2, 1
bne $t2, $t4, estart3
