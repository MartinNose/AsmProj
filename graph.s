main:
	lui $sp, 0x000f
    ori $sp, $zero, 0xf000
	add $a0, $zero, $zero #first pixel

 	jal pointad
 	addi $a0, $zero, 0xA0F0 #in the middle xx: 160, tt: 240
 	jal pointad
	addi $a0, $zero, 0xffff #in the max xx: 255 yy: 25l pointad
	jal pointad

    lui $a0, 0x7f7f
	ori $a0, $a0, 0xffff
	jal drawline

	lui $a0, 0xfe01
	ori $a0, $a0, 0x00fe
	jal drawline

	lui $a0, 0xfe7f
	ori $a0, $a0, 0x007f
	jal drawline

	lui $a0, 0xfe9f
	ori $a0, $a0, 0x009f
	jal drawline

    lui $a0,0x0000
    ori $a0,$a0,0x00f1
    lui $a1,0x3f3f
    ori $a0,$a0,0x3f7f
	jal drawbox
    
    add $a0,$zero,$zero
    ori $a0,$a0,0xf090
    addi $a1,$zero,0x20

    j drawCircle

drawbox:
	addiu $sp, $sp, -56	# Decrement the stack pointer
	sw $ra, 48($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 44($sp)		# Save the original value of $s0 to the stack
	sw $s1, 40($sp)		# Save the original value of $s1 to the stack
	sw $s2, 36($sp)		# Save the original value of $s2 to the stack
	sw $s3, 32($sp)		# Save the original value of $s3 to the stack
	sw $s4, 28($sp)		# Save the original value of $s4 to the stack
	sw $s5, 24($sp)		# Save the original value of $s5 to the stack
	sw $s6, 20($sp)		# Save the original value of $s6 to the stack
	sw $s7, 16($sp)		# Save the original value of $s7 to the stack
	sw $t0, 12($sp)		# Save the original value of $t0 to the stack
	sw $t1, 8($sp)		# Save the original value of $t1 to the stack
	sw $t2, 4($sp)		# Save the original value of $t2 to the stack
	sw $t3, ($sp)		# Save the original value of $t3 to the stack

    ori $t1, $zero, 0xffff
	srl $s0, $a0, 16		# Store the x co-ordinate of point 1 in $s0
    and $s1, $s0, $t1		# Store the y co-ordinate of point 1 in $s1
    srl $s0, $a1, 16		# Store the x co-ordinate of point 2 in $s2
    and $s1, $s1, $t1		# Store the y co-ordinate of point 2 in $s3

    lui $a0, 0x3f01
	ori $a0, $a0, 0x7e3f
	jal drawline

	lui $a0, 0x0000
	ori $a0, $a0, 0x3f3f
	jal drawline

	lui $a0, 0x3f3f
	ori $a0, $a0, 0x7f3f
	jal drawline

	lw $t3, ($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 4($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 8($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 12($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 16($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 20($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 24($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 28($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 32($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 36($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 40($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 44($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 48($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 56	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	jr $ra 		# Jump to the return address to exit the subroutine
	nop

drawline:
 addiu $sp, $sp, -56	# Decrement the stack pointer
	sw $ra, 48($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 44($sp)		# Save the original value of $s0 to the stack
	sw $s1, 40($sp)		# Save the original value of $s1 to the stack
	sw $s2, 36($sp)		# Save the original value of $s2 to the stack
	sw $s3, 32($sp)		# Save the original value of $s3 to the stack
	sw $s4, 28($sp)		# Save the original value of $s4 to the stack
	sw $s5, 24($sp)		# Save the original value of $s5 to the stack
	sw $s6, 20($sp)		# Save the original value of $s6 to the stack
	sw $s7, 16($sp)		# Save the original value of $s7 to the stack
	sw $t0, 12($sp)		# Save the original value of $t0 to the stack
	sw $t1, 8($sp)		# Save the original value of $t1 to the stack
	sw $t2, 4($sp)		# Save the original value of $t2 to the stack
	sw $t3, ($sp)		# Save the original value of $t3 to the stack 

	# Copies the values of the parameters passed in into the now free s registers
	srl $s0, $a0, 24
	srl $s1, $a0, 16
	srl $s2, $a0, 8
	move $s3, $a0

	andi $a0, $s0, 0xff
	andi $a1, $s1, 0xff
	andi $a2, $s2, 0xff
	andi $a3, $s3, 0xff

	move $s0, $a0		# Store the x co-ordinate of point 1 in $s0
	move $s1, $a1		# Store the y co-ordinate of point 1 in $s1
	move $s2, $a2		# Store the x co-ordinate of point 2 in $s2
	move $s3, $a3		# Store the y co-ordinate of point 2 in $s3
	lw $s4, 52($sp)		# Store the colour (takes form the stack) in $s4


	# Main code for drawing the line on the bitmap

	subu $t3, $s2, $s0 		# Calculates x1 - x0 and store it in $t3
	#abs $s5, $t3 			# Sets dx ($s5) to the absolute value of x1 - x0
    move $s5, $s3
    sra $t7,$s5,31
    xor $s5,$s5,$t7
    sub $s5,$s5,$t7

	subu $t3, $s3, $s1		# Calculates y1 - y0 and stores it in $t3
	#abs $s6, $t3			# Sets dy ($s6) to the absolute value of y1 - y0
    move $s6, $t3
    sra $t7,$s6,31
    xor $s6,$s6,$t7
    sub $s6,$s6,$t7

	sub $s6, $zero, $s6 	# Sets dy to -dy as dy is needed as a minus value later in calculations
							# it is turned minus via two's complement method

	#bgt $s0, $s2, sxelse	# If x0 is greater than x1 then branch to sxelse
    slt $t7, $s2, $s0
    bne $t7, $zero, sxelse
	nop
	addi $s7, $zero, 1				# Set the value of sx ($s7) to 1
	b sxcomplete			# Branch around the sxelse section
	nop

sxelse:				# Branches to here if x0 is greater than x1
	addi $s7, $zero, -1		# Sets the value of sx ($s7) to -1

sxcomplete:					# Branches to here if x1 was greater than x0
	#bgt $s1, $s3, syelse	# If y0 is greater than y1 then branch to syelse
	slt $t7, $s3, $s1
    bne $t7, $zero, syelse
	nop
	addi $t0, $zero, 1				# Sets the value of sy ($t0) to 1
	b sycomplete			# Branch around the syelse section
	nop

syelse:				# Branche shere is y0 is greater than y1
	addi $t0, $zero, -1		# Sets the value sy ($t0) to -1

sycomplete:				# Branches to here if y1 was greater than y0
	addu $t1, $s5, $s6	# err is set to the value of dx - dy

drawpixelloop:
	slti $t7, $s0, 0xff
	beq $t7, $zero, exit
	slti $t7, $s1, 0xff
	beq $t7, $zero, exit
	move $a0, $s0		# Store the x co-ordinate in $a0
	move $a1, $s1		# Store the y co-ordinate in $a1
	move $a2, $s4		# Store the colour in $a2

	jal setpixel		# Enter the subroutine "setpixel"

	nop

	add $t2, $t1, $t1			# Sets e2 ($t2) to err ($t1) * 2 by calculating err + err
	#bgt $s6, $t2, e2notgreaterthandy	# Branch if -dy is greater than e2
	slt $t7, $t2, $s6
    bne $t7, $zero, e2notgreaterthandy
	nop
	add $t1, $t1, $s6			# Calculate err = err - dy: err = $t1 , -dy = $s6
	add $s0, $s0, $s7			# Calculate x0 = x0 + sx: x0 = $s0 , sx = $s7

e2notgreaterthandy:
	#bgt $t2, $s5, e2greaterthandx		# Branch if e2 ($t2) is greater than dx ($s5)
    slt $t7, $s5, $t2
    bne $t7, $zero, e2greaterthandx
	nop
	add $t1, $t1, $s5			# Calculate err = derr + dx: err = $t1 , dx = $s5
	add $s1, $s1, $t0  			# Caluclate y0 = y0 + sy: y0 = $s1 , sy = $t0
e2greaterthandx:

	# To exit the loop x0 must now be equal to x1 and y0 much now be equal to y1
	# The two statements must be true to pass both branches and thus exits the loop

	bne $s0, $s2, drawpixelloop	# If x0 ($s0) and x1 ($s2) are not
	nop				# equal branch to drawpixelloop
	bne $s1, $s3, drawpixelloop	# If y0 ($s1) and y1 ($s3) are not
	nop				# equal branch to drawpixelloop

	# Restores the original values of the s registers from the stack
exit:
	lw $t3, ($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 4($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 8($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 12($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 16($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 20($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 24($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 28($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 32($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 36($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 40($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 44($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 48($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 56	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack

	jr $ra 		# Jump to the return address to exit the subroutine
	nop

drawCircle:
    addi $sp, $zero, 16384
    addi $s3, $zero, 53248
    lui $s4, 12  
    lui $s5,13
    lui $s1,240
    srl $s1,$s1,8 
    addi $s2,$s1,0xF00 
    addi $t0,$zero,255
    and $t2,$a0,$t0 
    srl $a0,$a0,8
    and $t1,$a0,$t0 
    srl $a0,$a0,8
    sub $t3,$t1,$a1 
    add $t4,$t1,$a1
    sub $t5,$t2,$a1
    add $t6,$t2,$a1
    mult $a1,$a1
    mflo $a1
    OuterLoop:

    add $t7,$zero,$t5
    InnerLoop:
    sub $s6,$t3,$t1
    slt $t0,$s6,$zero
    beq $t0,$zero,S6_big0
    sub $s6,$zero,$s6
    S6_big0:
    sub $s7,$t7,$t2
    slt $t0,$s7,$zero
    beq $t0,$zero,S7_big0
    sub $s7,$zero,$s7
    S7_big0:
    mult $s6,$s6
    mflo $s6
    mult $s7,$s7
    mflo $s7
    add $t8,$s7,$s6
    slt $t0,$t8,$a1
    beq $t0,$zero,circle_skip
    add $a0,$zero,$zero
    add $a0,$zero,$t3
    sll $a0,$a0,8
    add $a0,$a0,$t7
    jal drawCirclePoint
    circle_skip:
    addi $t7,$t7,1
    slt $t0,$t7,$t6
    bne $t0,$zero,InnerLoop

    addi $t3,$t3,1
    slt $t0,$t3,$t4
    bne $t0,$zero,OuterLoop
    j end

setpixel:
	addiu $sp, $sp, -56	# Decrement the stack pointer
	sw $ra, 48($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 44($sp)		# Save the original value of $s0 to the stack
	sw $s1, 40($sp)		# Save the original value of $s1 to the stack
	sw $s2, 36($sp)		# Save the original value of $s2 to the stack
	sw $s3, 32($sp)		# Save the original value of $s3 to the stack
	sw $s4, 28($sp)		# Save the original value of $s4 to the stack
	sw $s5, 24($sp)		# Save the original value of $s5 to the stack
	sw $s6, 20($sp)		# Save the original value of $s6 to the stack
	sw $s7, 16($sp)		# Save the original value of $s7 to the stack
	sw $t0, 12($sp)		# Save the original value of $t0 to the stack
	sw $t1, 8($sp)		# Save the original value of $t1 to the stack
	sw $t2, 4($sp)		# Save the original value of $t2 to the stack
	sw $t3, ($sp)		# Save the original value of $t3 to the stack

	slti $t7, $a0, 0xff
	beq $t7, $zero, exit2
	slti $t7, $a1, 0xff
	beq $t7, $zero, exit2
	# Store the x co-ordinate in $a0
	# Store the y co-ordinate in $a1
	# Store the colour in $a2
	lui $s7, 0xfafa
 	ori $s7, $s7, 0xffff #white
 	lui $s0, 12
 	ori $s0, $s0, 0x2000 #s0 <- first row

	#pointad($a0) draw at xxyy
    move $t0, $a1 #get line
 	move $t2, $a0 #get column
 	addi $t9, $zero, 0x140
 	mult $t0, $t9
 	mflo $t0 #line * 320
 	add $t0, $t0, $t2 #line * 320 + column
 	sll $t0, $t0, 2 # pixel * 4
	add $t1, $s0, $t0
 	sw $s7, 0($t1)
exit2:
	lw $t3, ($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 4($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 8($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 12($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 16($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 20($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 24($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 28($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 32($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 36($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 40($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 44($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 48($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 56	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	jr $ra 		# Jump to the return address to exit the subroutine
	nop



pointad: #pointad($a0) draw at xxyy
 lui $s1, 0xfafa
 ori $s1, $s1, 0x0 #white
 lui $s0, 12
 ori $s0, $s0, 0x2000 #s0 <- first row
 andi $t0, $a0, 0xff #get line
 srl $a0, $a0, 8
 andi $a0, $a0, 0xff #get column
 addi $t9, $zero, 0x140
 mult $t0, $t9
 mflo $t0 #line * 320
 add $t0, $t0, $a0 #line * 320 + column
 sll $t0, $t0, 2 # pixel * 4
 add $a0, $zero, $t0
 j point
point: #point(#a0) draw at $a0
 add $t1, $s0, $a0
 sw $s1, 0($t1)
 jr $ra

drawCirclePoint:
    addi $sp,$sp,65500
    sw $t0,($sp)
    sw $t1,4($sp)
    sw $t2,8($sp)
    sw $t3,12($sp)
    sw $t4,16($sp)
    sw $t5,20($sp)
    sw $t6,24($sp)
    sw $t7,28($sp)
    sw $t8,32($sp)
    add $v0,$zero,$zero
    add $t1,$zero,$zero
    add $t2,$zero,$zero
    addi $t0,$zero,255
    and $t0,$a0,$t0 //t0 = y
    srl $a0,$a0,8 //a0 = x
    addi $t3,$zero,640
    mult $t0,$t3
    mflo $t3
    add $t2,$t3,$a0
    sll $t2,$t2,1
    add $t2,$s5,$t2
    lui $t5,0xFAFA
    sw $t5,($t2)
    lw $t0,($sp)
    lw $t1,4($sp)
    lw $t2,8($sp)
    lw $t3,12($sp)
    lw $t4,16($sp)
    lw $t5,20($sp)
    lw $t6,24($sp)
    lw $t7,28($sp)
    lw $t8,32($sp)
    addi $sp,$sp,36
    jr $ra

end:
.word 0