.text 0x0000
main:
    addi $sp, $zero, 0xf00
    lui $s2, 0x000C #VGACursor
    ori $s2, $s2, 4880
    addi $s4, $zero, 0x074f
    addi $t0, $zero, 0
    jal update_Ob
    j game
    # Border drawn

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

    add $t0, $zero, $zero # VGA cursor
    add $t1, $zero, $zero # vga_column count
    add $t2, $zero ,$zero # vga_row count
    add $t3, $zero, $zero # grid_column counter
    add $t4, $zero, $zero # grid_row counter
    lui $t5, 0xc000

    move_cursor_col:
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    bne $t1, $s3, move_cursor_col
    add $t1, $t1, $zero
    addi $t3, $t3, 1
    bne $t3, $s0, move_cursor_col
    
    move_cursor_row:
    addi $t0, $t0, 512
    addi $t2, $t2, 1
    bne $t2, $s3, move_cursor_row
    addi $t2, $t2, 0
    addi $t4, $t4, 1
    bne $t4, $s5, move_cursor_row

    add $t1, $zero, $zero # vga_column count
    add $t2, $zero ,$zero # vga_row count

    addi $t6, $zero, 0xdf2
    bne $s2, $t6, draw_start
    lw $t7, 0($t0)
    beq $t7, $t6, game_over
    
    draw_start:
    sw $s2, 0($t0)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    bne $t1, $s3, draw_start
    addi $t1, $t1, 0
    addi $t0, $t0, -16
    addi $t0, $t0, 512
    addi $t2, $t2, 1
    bne $t2, $t2, draw_start

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
    lui $s1, 0
    ori $s1, $zero, 0x052c # time count
    lw $s0, 0($s1)
    lui $s2, 0x0009 # loop gap
    bne $s0, $s2, no_update_Ob
        jal update_Ob
        ori $s0, $zero, 0
    no_update_Ob:
    addi $s0, $s0, 1
    sw $s0, 0($s1) # increment time count
    #read PS and process
    lui $s0, 0xffff
    ori $s0, $s0, 0xd000 # PS2 Addr
    ori $s1, $zero, 0x0528 # duck position Addr
    lw $t7, 0($s0) # Read PS2
    lui $t6, 0x8000
    ori $t6, $t6, 0x001D # if W
    
    lw $t3, 0($s1) # Read Duck Position

    bne $t7, $t6, no_w
        addi $t4, $zero, 1
        beq $t3, $t4, top
            addi $t3, $t3, -1
        top:
        j draw
    no_w:
    lui $t6, 0x8000
    ori $t6, $t6, 0x00F0 # if 
    bne $t7, $t6, no_duan_ma
        lw $t7, 0($s0) # Process DuanMa
        ori $t7, $zero, 0
        j draw

    no_duan_ma:
    lui $t6, 0x8000
    ori $t6, $t6, 0x001B
    bne $t7, $t6, draw # If S
        addi $t2, $zero, 30
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
j game

game_over:
    j game_over

update_Ob:
    addi $sp, $sp, -16
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)

    lui $t0, 0
    ori $t0, $t0, 0x0500 # ob position
    lui $t3, 0
    ori $t3, $t3, 0x0524 # duck position
    process_loop: # process 0x0500 - 0x0524
        lw $t1, 4($t0)
        sw $t1, 0($t0)
        addi $t0, $t0, 4
        ori $s4, $zero, 0x0524
        bne $t0, $s4, process_loop
    lui $t0, 0
    ori $t0, $zero, 0x0530 # address of random address
    lw $t1, 0($t0) # t1 got the random address
    lw $t4, 0($t1) # t4 got the random
    sw $t4, -12($t0) # save to 0x0524
    lui $s3, 0
    ori $t3, $zero, 0x05c4
    addi $t1, $t1, 4
    bne $t3, $t1, set_new_addr
        ori $t1, $zero, 0x0534
    set_new_addr:
    sw $t1, 0($t0)

    jal draw_ob

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    addi $sp, $sp, 16
jr $ra
    # draw ob

draw_ob:
    addi $sp, $sp, -16
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)

    ori $s0, $zero, 0x0500 # ob info

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
            addi $a0, $a0, 1
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
        bne $t2, $s4, draw_Ob_Inner_loop2

        ori $s4, $zero, 30
        draw_Ob_Inner_loop3: # draw lower ob
            addi $a0, $t3, 0
            addi $a1, $t2, 0
            addi $a2, $s5, 0
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
            addi $a0, $a0, 1
            jal drawBlock
        bne $t2, $s4, draw_Ob_Inner_loop3

        addi $s0, $s0, 4 # update ob address
        addi $t0, $t0, 1 # update ob counter
        addi $t3, $t3, 3 # update col counter
    bne $t0, $t1, draw_Ob_Outter_loop

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    addi $sp, $sp, 16
jr $ra

.data 0x0500
    .word 0  # 0x0500 obstacle positon 0
    .word 0  # 0x0504 obstacle positon 1
    .word 0  # 0x0508 obstacle positon 2
    .word 0  # 0x050c obstacle positon 3
    .word 0  # 0x0510 obstacle positon 4
    .word 0  # 0x0514 obstacle positon 5
    .word 0  # 0x0518 obstacle positon 6
    .word 0  # 0x051c obstacle positon 7
    .word 0  # 0x0520 obstacle positon 8
    .word 10 # 0x0524 obstacle position 9
    
    .word 15 # 0x0528 duck position

    .word 0  # 0x052c time count
# rand count
    .word 0x0534 #0x0530
# random number
    .word  0 #0x0534
    .word  0 #0x0538
    .word 20 #0x053c
    .word  0 #0x0540
    .word  0 #0x0544
    .word 15 #0x0548
    .word  0 #0x054c
    .word  0 #0x0550
    .word 15 #0x0554
    .word  0 #0x0558
    .word  0 #0x055c
    .word 20 #0x0560
    .word  0 #0x0564
    .word  0 #0x0568
    .word  5 #0x056c
    .word  0 #0x0570
    .word  0 #0x0574
    .word 10 #0x0578
    .word  0 #0x057c
    .word  0 #0x0580
    .word 10 #0x0584
    .word  0 #0x0588
    .word  0 #0x058c
    .word 15 #0x0590
    .word  0 #0x0594
    .word  0 #0x0598
    .word 15 #0x059c
    .word  0 #0x05a0
    .word  0 #0x05a4
    .word 10 #0x05a8
    .word  0 #0x05ac
    .word  0 #0x05b0
    .word 15 #0x05b4
    .word  0 #0x05b8
    .word  0 #0x05bc
    .word  5 #0x05c0
    .word  0 #0x05c4
    .word  0 #0x05c8
    .word 15 #0x05cc
    .word  0 #0x05d0
    .word  0 #0x40d4
    .word  5 #0x40d8
    .word  0 #0x40dc
    .word  0 #0x40e0
    .word 15 #0x04e4
    .word  0 #0x04e8
    .word  0 #0x04ec
    .word 10 #0x04f0
    .word  0 #0x04f4
    .word  0 #0x04f8
    .word 10 #0x04fc
    .word  0 #0x0500
    .word  0 #0x0504
    .word 15 #0x0508
    .word  0 #0x050c
    .word  0 #0x0510
    .word 10 #0x0514
    .word  0 #0x0518
    .word  0 #0x051c
    .word 20 #0x0520
    .word  0 #0x0524
    .word  0 #0x0528
    .word 15 #0x052c
    .word  0 #0x0530
    .word  0 #0x0534
    .word 10 #0x0538
    .word  0 #0x053c
    .word  0 #0x0540
    .word 10 #0x0544
    .word  0 #0x0548
    .word  0 #0x054c
    .word 10 #0x0550
    .word  0 #0x0554
    .word  0 #0x0558
    .word 15 #0x055c
    .word  0 #0x0560
    .word  0 #0x0564
    .word 20 #0x0568
    .word  0 #0x056c
    .word  0 #0x0570
    .word 10 #0x0574
    .word  0 #0x0578
    .word  0 #0x057c
    .word 15 #0x0580
    .word  0 #0x0584
    .word  0 #0x0588
    .word  5 #0x058c
    .word  0 #0x0590
    .word  0 #0x0594
    .word 15 #0x0598
    .word  0 #0x059c
    .word  0 #0x05a0
    .word 10 #0x05a4
    .word  0 #0x05a8
    .word  0 #0x05ac
    .word 15 #0x05b0
    .word  0 #0x05b4
    .word  0 #0x05b8
    .word 15 #0x05bc
 
