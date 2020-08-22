.text 0x0000
main:
    addi $sp, $zero, 0xf00
	lui $t0, 0xe000
	sw $zero, 0($t0)
	addi $t0, $zero, 0x07c0
	sw $zero, 0($t0)
    jal update_Ob
    j game

drawBlock:
    addi $sp, $sp, -64
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)
    sw $s3, 20($sp)
    sw $s4, 24($sp)
    sw $s5, 28($sp)
    sw $s6, 32($sp)
    sw $t0, 36($sp)
    sw $t1, 40($sp)
    sw $t2, 44($sp)
    sw $t3, 48($sp)
    sw $t4, 52($sp)
    sw $t5, 56($sp)
    sw $t6, 60($sp)
    sw $t7, 64($sp)

    addi $s0, $a0, 0 # col 0-30
    addi $s1, $a1, 0 # row 0-30
    addi $s2, $a2, 0 # RGB color
    
    addi $s3, $zero, 16 # block size
    addi $s4, $zero, 512 # column
    addi $s5, $zero, 480 # row

    add $t1, $zero, $zero # vga_column count
    add $t2, $zero ,$zero # vga_row count
    add $t3, $zero, $zero # grid_column counter
    add $t4, $zero, $zero # grid_row counter
    lui $t0, 0xc000

    beq $s0, $zero, move_cursor_row
    move_cursor_col:
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    bne $t1, $s3, move_cursor_col
    add $t1, $zero, $zero
    addi $t3, $t3, 1
    bne $t3, $s0, move_cursor_col

    move_cursor_row:
	beq $s1, $zero, draw_start
    addi $t0, $t0, 512
    addi $t2, $t2, 1
    bne $t2, $s3, move_cursor_row
    addi $t2, $zero, 0
    addi $t4, $t4, 1
    bne $t4, $s1, move_cursor_row

    add $t1, $zero, $zero # vga_column count
    add $t2, $zero ,$zero # vga_row count
    
    draw_start:
    sw $s2, 0($t0)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    bne $t1, $s3, draw_start
    addi $t1, $zero, 0
    addi $t0, $t0, -16
    addi $t0, $t0, 512
    addi $t2, $t2, 1
    bne $t2, $s3, draw_start

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    lw $s3, 20($sp)
    lw $s4, 24($sp)
    lw $s5, 28($sp)
    lw $s6, 32($sp)
    lw $t0, 36($sp)
    lw $t1, 40($sp)
    lw $t2, 44($sp)
    lw $t3, 48($sp)
    lw $t4, 52($sp)
    lw $t5, 56($sp)
    lw $t6, 60($sp)
    lw $t7, 64($sp)
    addi $sp, $sp, 64
    jr $ra

game:
    ori $s1, $zero, 0x062c # time count
    lw $s0, 0($s1)
    lui $s2, 0x0006 # loop gap
    #addi $s2, $zero, 0x1000
    bne $s0, $s2, no_update_Ob
        jal update_Ob
        ori $s0, $zero, 0
        sw $s0, 0($s1) # increment time count
	    j update_duck
    no_update_Ob:
    addi $s0, $s0, 1
    sw $s0, 0($s1) # increment time count
	ori $k0, $k0, 0x7fff
    and $k0, $s0, $k0

    ori $k1, $zero, 0x4000

    bne $k0, $k1, game
	
	update_duck:
    ori $s1, $zero, 0x0628 # duck position Addr
    lw $t3, 0($s1) # Read Duck Position
    #read PS and process
    
    lui $s0, 0xd000 # PS2 Addr
    lw $t7, 0($s0) # Read PS2
    addi $t6, $zero, 629 # if up

    bne $t7, $t6, no_up
        addi $t4, $zero, 0
        beq $t3, $t4, top
            addi $t3, $t3, -1
        top:
        j draw
    no_up:
    ori $t6, $zero, 626
    bne $t7, $t6, draw # If S
        addi $t2, $zero, 29
        beq $t3, $t2, draw
            addi $t3, $t3, 1
    # draw duck and judge
    draw:
        lw $t0, 0($s1) # Read Positon
        beq $t0, $t3, no_cover # If Position is unaltered.

        addi $a0, $zero, 6 # 6th col
        addi $a1, $t0, 0 # older row
        addi $a2, $zero, 0xcc4 # draw blue
        jal drawBlock

        sw $t3, 0($s1) # save the duck position

    no_cover:
        addi $a0, $zero, 6
        addi $a1, $t3, 0
        addi $a2, $zero, 0xdf2 # draw yellow
        jal drawBlock

	addi $s4, $zero, 0x0608
    lw $s4, 0($s4)
    beq $s4, $zero, game

    slt $s5, $s4, $t3
    beq $s5, $zero, game_over
    addi $s4, $s4, 6
    slt $s5, $t3, $s4
    beq $s5, $zero, game_over

j game

game_over:

	lui $t0, 0xe000
	sw $zero, 0($t0)

	addi $t0, $zero, 0x07c0
	sw $zero, 0($t0)

	addi $s0, $zero, 512
	addi $s1, $zero, 480
	addi $s2, $zero, 0xcc4
	lui $t2, 0xc000
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	
	end_start:
	sw $s2, 0($t2)
	addi $t2, $t2, 1
	addi $t0, $t0, 1
	bne $t0, $s0, end_start
	add $t0, $zero, $zero
	addi $t1, $t1, 1
	bne $t1, $s1, end_start
    
	addi $t1, $zero, 10
	addi $t2, $zero, 0x0600
	addi $t3, $zero, 0
	mem_clr:
	sw $zero, 0($t2)
	addi $t2, $t2, 4
	addi $t3, $t3, 1
	bne $t3, $t1, mem_clr

    addi $k0, $zero, 0x1000
	wait:
	addi $k0, $k0, -1
	bne $k0, $zero, wait
	addi $k0, $zero, 0x1000
	lui $t1, 0xd000
	lw $t1, 0($t1)
	addi $t2, $zero, 90
	beq $t1, $t2, main
	j wait


update_Ob:
    addi $sp, $sp, -16
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)

    lui $t0, 0
    ori $t0, $t0, 0x0600 # ob position
    process_loop: # process 0x0600 - 0x0624
        lw $t1, 4($t0)
        sw $t1, 0($t0)
        addi $t0, $t0, 4
        ori $s4, $zero, 0x0624
        bne $t0, $s4, process_loop
    lui $t0, 0
    ori $t0, $zero, 0x0630 # address of random address
    lw $t1, 0($t0) # t1 got the random address
    lw $t4, 0($t1) # t4 got the random
    sw $t4, -12($t0) # save to 0x0624
    lui $s3, 0
    ori $t3, $zero, 0x06c4
    addi $t1, $t1, 4
    bne $t3, $t1, set_new_addr
        ori $t1, $zero, 0x0634
    set_new_addr:
    sw $t1, 0($t0)

    jal draw_ob

    ori $t0, $zero, 0x0600 # ob position
    lw $t1, 8($t0) # ob
    addi $t0, $t0, 0x28
    lw $t2, 0($t0) # duck
    beq $t1, $zero, nojudge
	
	addi $t1, $t1, -1
    slt $t3, $t1, $t2
    beq $t3, $zero, game_over
    addi $t1, $t1, 6
    slt $t3, $t2, $t1
    beq $t3, $zero, game_over

    nojudge:

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    addi $sp, $sp, 16
jr $ra

draw_ob:
    addi $sp, $sp, -64
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)
    sw $s3, 20($sp)
    sw $s4, 24($sp)
    sw $s5, 28($sp)
    sw $s6, 32($sp)
    sw $t0, 36($sp)
    sw $t1, 40($sp)
    sw $t2, 44($sp)
    sw $t3, 48($sp)
    sw $t4, 52($sp)
    sw $t5, 56($sp)
    sw $t6, 60($sp)
    sw $t7, 64($sp)

    ori $s0, $zero, 0x0600 # ob info

    #lui $s1, 0x000C
    #ori $s1, $s1, 5200 # vga cursor

    addi $t0, $zero, 0 # slots counter
    addi $t1, $zero, 10 # Totally 10 slots
    addi $t3, $zero, 0 # col counter

    draw_Ob_Outter_loop: # draw t0 th ob
        lw $s4, 0($s0) # load openning start point

        ori $s2, $zero, 0x3b7 # green

        bne $s4, $zero, green # If there exists an pipe
            ori $s2, $zero, 0xcc4 # blue
            ori $s4, $zero, 5

        green:
        addi $t2, $zero, 0 # Set row counter
        draw_Ob_Inner_loop1: # draw upper ob
            addi $a0, $t3, 0
            addi $a1, $t2, 0
            addi $a2, $s2, 0
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $t2, $t2, 1
        bne $t2, $s4, draw_Ob_Inner_loop1

        addi $s4, $s4, 5
        ori $s5, $zero, 0xcc4 # blue
        draw_Ob_Inner_loop2: # draw upper ob
            addi $a0, $t3, 0
            addi $a1, $t2, 0
            addi $a2, $s5, 0
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $t2, $t2, 1
        bne $t2, $s4, draw_Ob_Inner_loop2

        ori $s4, $zero, 30
        draw_Ob_Inner_loop3: # draw lower ob
            addi $a0, $t3, 0
            addi $a1, $t2, 0
            addi $a2, $s2, 0
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $t2, $t2, 1
        bne $t2, $s4, draw_Ob_Inner_loop3

        addi $s0, $s0, 4 # update ob address
        addi $t0, $t0, 1 # update ob counter
        addi $t3, $t3, 3 # update col counter

        addi $s6, $zero, 3
        bne $s6, $t0, tag1

        addi $s6, $zero, 0x0628
        lw $s6, 0($s6)

        addi $a0, $zero, 6
        addi $a1, $s6, 0
        addi $a2, $zero, 0xdf2
        jal drawBlock

        tag1:
    bne $t0, $t1, draw_Ob_Outter_loop

	addi $s0, $zero, 0x07c0
	lw $s1, 0($s0)
	addi $s1, $s1, 1
	sw $s1, 0($s0)
	lui $s0, 0xe000
	sw $s1, 0($s0)

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    lw $s3, 20($sp)
    lw $s4, 24($sp)
    lw $s5, 28($sp)
    lw $s6, 32($sp)
    lw $t0, 36($sp)
    lw $t1, 40($sp)
    lw $t2, 44($sp)
    lw $t3, 48($sp)
    lw $t4, 52($sp)
    lw $t5, 56($sp)
    lw $t6, 60($sp)
    lw $t7, 64($sp)
    addi $sp, $sp, 64
jr $ra

.data 0x0600
    .word 0  # 0x0600 obstacle positon 0
    .word 0  # 0x0604 obstacle positon 1
    .word 0  # 0x0608 obstacle positon 2
    .word 0  # 0x060c obstacle positon 3
    .word 0  # 0x0610 obstacle positon 4
    .word 0  # 0x0614 obstacle positon 5
    .word 0  # 0x0618 obstacle positon 6
    .word 0  # 0x061c obstacle positon 7
    .word 0  # 0x0620 obstacle positon 8
    .word 10 # 0x0624 obstacle position 9

    .word 11 # 0x0628 duck position

    .word 0  # 0x062c time count
# rand count
    .word 0x0634 #0x0630
# random number
    .word  0 #0x0634
    .word  0 #0x0638
    .word 20 #0x063c
    .word  0 #0x0640
    .word  0 #0x0644
    .word 15 #0x0648
    .word  0 #0x064c
    .word  0 #0x0650
    .word 15 #0x0654
    .word  0 #0x0658
    .word  0 #0x065c
    .word 20 #0x0660
    .word  0 #0x0664
    .word  0 #0x0668
    .word  5 #0x066c
    .word  0 #0x0670
    .word  0 #0x0674
    .word 10 #0x0678
    .word  0 #0x067c
    .word  0 #0x0680
    .word 10 #0x0684
    .word  0 #0x0688
    .word  0 #0x068c
    .word 15 #0x0690
    .word  0 #0x0694
    .word  0 #0x0698
    .word 15 #0x069c
    .word  0 #0x06a0
    .word  0 #0x06a4
    .word 10 #0x06a8
    .word  0 #0x06ac
    .word  0 #0x06b0
    .word 15 #0x06b4
    .word  0 #0x06b8
    .word  0 #0x06bc
    .word  5 #0x06c0
    .word  0 #0x06c4
    .word  0 #0x06c8
    .word 15 #0x06cc
    .word  0 #0x06d0
    .word  0 #0x06d4
    .word  5 #0x06d8
    .word  0 #0x06dc
    .word  0 #0x06e0
    .word 15 #0x06e4
    .word  0 #0x06e8
    .word  0 #0x06ec
    .word 10 #0x06f0
    .word  0 #0x06f4
    .word  0 #0x06f8
    .word 10 #0x06fc
    .word  0 #0x0700
    .word  0 #0x0704
    .word 15 #0x0708
    .word  0 #0x070c
    .word  0 #0x0710
    .word 10 #0x0714
    .word  0 #0x0718
    .word  0 #0x071c
    .word 20 #0x0720
    .word  0 #0x0724
    .word  0 #0x0728
    .word 15 #0x072c
    .word  0 #0x0730
    .word  0 #0x0734
    .word 10 #0x0738
    .word  0 #0x073c
    .word  0 #0x0740
    .word 10 #0x0744
    .word  0 #0x0748
    .word  0 #0x074c
    .word 10 #0x0750
    .word  0 #0x0754
    .word  0 #0x0758
    .word 15 #0x075c
    .word  0 #0x0760
    .word  0 #0x0764
    .word 20 #0x0768
    .word  0 #0x076c
    .word  0 #0x0770
    .word 10 #0x0774
    .word  0 #0x0778
    .word  0 #0x077c
    .word 15 #0x0780
    .word  0 #0x0784
    .word  0 #0x0788
    .word  5 #0x078c
    .word  0 #0x0790
    .word  0 #0x0794
    .word 15 #0x0798
    .word  0 #0x079c
    .word  0 #0x07a0
    .word 10 #0x07a4
    .word  0 #0x07a8
    .word  0 #0x07ac
    .word 15 #0x07b0
    .word  0 #0x07b4
    .word  0 #0x07b8
    .word 15 #0x07bc
	.word 0 #0x07c0