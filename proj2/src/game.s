.text 0x0000
main:
    lui $sp, 0x000f
    ori $sp, $sp, 0xf000
    lui $s2, 0x000C #VGACursor
    ori $s2, $s2, 4880
    addi $s4, $zero, 0x074f
    addi $t0, $zero, 0
    main_loop:
        sw $s4, 0($s2)
        addi $s2, $s2, 9920
        sw $s4, 0($s2)
        addi $s2, $s2, -9920
        addi $s2, $s2, 4
        addi $t0, $t0, 1
        slti $t3, $t0, 40
        bne $t3, $zero, main_loop

    lui $s2, 0x000C #VGACursor
    ori $s2, $s2, 4876
    addi $t0, $zero, 0
    main_loop_2:
        sw $s4, 0($s2)
        addi $s2, $s2, 164
        sw $s4, 0($s2)
        addi $s2, $s2, -164
        addi $s2, $s2, 320
        addi $t0, $t0, 1
        slti $t3, $t0, 32
        bne $t3, $zero, main_loop_2
    jal update_Ob
    # Border drawn

game:
    lui $s1, 0
    ori $s1, $zero, 0x042c # time count
    lw $s0, 0($s1)
    lui $s2, 0x0009
    bne $s0, $s2, no_update_Ob
        jal update_Ob
        ori $s0, $zero, 0
    no_update_Ob:
    addi $s0, $s0, 1
    sw $s0, 0($s1)
    #read PS and process 
    lui $s0, 0xffff
    ori $s0, $s0, 0xd000 # PS2 Addr
    ori $s1, $zero, 0x0428 # duck position Addr
    lw $t7, 0($s0) # Read PS2
    lui $t6, 0x8000
    ori $t6, $t6, 0x001D
    lw $t3, 0($s1) # Read Duck Position
    bne $t7, $t6, no_w
        ori $t4, $zero, 1
        beq $t3, $t4, top
            addi $t3, $t3, -1
        top:
        j draw
    no_w:
    lui $t6, 0x8000
    ori $t6, $t6, 0x00F0
    bne $t7, $t6, no_duan_ma
        lw $t7, 0($s0)
        ori $t7, $zero, 0
        j draw
    no_duan_ma:
    lui $t6, 0x8000
    ori $t6, $t6, 0x001B
    bne $t7, $t6, no_s
        ori $t2, $zero, 30
        beq $t3, $t2, bottom
            addi $t3, $t3, 1
        bottom:
        j draw

    no_s:
        sll $zero, $zero, 0
    # draw duck and judge
    draw:
        lw $t0, 0($s1) # Read Positon
        beq $t0, $t3, no_cover
        ori $t1, $zero, 0
        lui $s2, 0x000C
        ori $s2, $s2, 4904 # Bird Cursor
        draw_duck_loop:
            addi $t1, $t1, 1
            addi $s2, $s2, 320
        bne $t1, $t0, draw_duck_loop
        lw $t0, 0($s2)
        ori $t1, $zero, 0x202f
        beq $t0, $t1, game_over
        ori $t1, $zero, 0x3000
        sw $t1, 0($s2) # draw duck

        sw $t3, 0($s1)
    no_cover:
        lw $t0, 0($s1) # Read Positon
        ori $t1, $zero, 0
        lui $s2, 0x000C
        ori $s2, $s2, 4904 # Bird Cursor
        draw_duck_loop1:
            addi $t1, $t1, 1
            addi $s2, $s2, 320
        bne $t1, $t0, draw_duck_loop1
        lw $t0, 0($s2)
        ori $t1, $zero, 0x202f
        beq $t0, $t1, game_over
        ori $t1, $zero, 0x6600
        sw $t1, 0($s2) # draw duck
        
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
    ori $t0, $t0, 0x0400 # ob position
    lui $t3, 0
    ori $t3, $t3, 0x0424 # duck position
    process_loop: # process 0x0400 - 0x0424
        lw $t1, 4($t0)
        sw $t1, 0($t0)
        addi $t0, $t0, 4
        ori $s4, $zero, 0x0424
        bne $t0, $s4, process_loop
    lui $t0, 0
    ori $t0, $zero, 0x0430 # address of random address
    lw $t1, 0($t0) # t1 got the random address
    lw $t4, 0($t1) # t4 got the random
    sw $t4, -12($t0) # save to 0x0424
    lui $s3, 0
    ori $t3, $zero, 0x05c4
    addi $t1, $t1, 4
    bne $t3, $t1, set_new_addr
        ori $t1, $zero, 0x0434
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

    ori $s0, $zero, 0x0400 # ob info
    lui $s1, 0x000C
    ori $s1, $s1, 5200 # vga cursor

    ori $t0, $zero, 0
    ori $t1, $zero, 10
    draw_Ob_Outter_loop: # draw t0 th ob
        addi $t0, $t0, 1
        lw $s4, 0($s0) # load ob info to s4
        ori $s2, $zero, 0x202f # green o
        bne $s4, $zero, green
            ori $s2, $zero, 0x3000 #black O
            ori $s4, $zero, 5
        green:
        ori $t2, $zero, 0
        draw_Ob_Inner_loop1: # draw upper ob
            addi $t2, $t2, 1
            sw $s2, 0($s1)
            sw $s2, 4($s1)
            sw $s2, 8($s1)
            sw $s2, 12($s1)
            addi $s1, $s1, 320
        bne $t2, $s4, draw_Ob_Inner_loop1
        addi $s4, $s4, 5
        ori $s5, $zero, 0x3000 # black o
        draw_Ob_Inner_loop2: # draw upper ob
            addi $t2, $t2, 1
            sw $s5, 0($s1)
            sw $s5, 4($s1)
            sw $s5, 8($s1)
            sw $s5, 12($s1)
            addi $s1, $s1, 320
        bne $t2, $s4, draw_Ob_Inner_loop2
        ori $s4, $zero, 30
        draw_Ob_Inner_loop3: # draw lower ob
            addi $t2, $t2, 1
            sw $s2, 0($s1)
            sw $s2, 4($s1)
            sw $s2, 8($s1)
            sw $s2, 12($s1)
            addi $s1, $s1, 320
        bne $t2, $s4, draw_Ob_Inner_loop3
        addi $s1, $s1, -9600
        addi $s1, $s1, 16
        addi $s0, $s0, 4
    bne $t0, $t1, draw_Ob_Outter_loop

    lw $ra, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    addi $sp, $sp, 16
jr $ra

.data 0x0400
    .word 0  # 0x0400 obstacle positon 0
    .word 0  # 0x0404 obstacle positon 1
    .word 0  # 0x0408 obstacle positon 2
    .word 0  # 0x040c obstacle positon 3
    .word 0  # 0x0410 obstacle positon 4
    .word 0  # 0x0414 obstacle positon 5
    .word 0  # 0x0418 obstacle positon 6
    .word 0  # 0x041c obstacle positon 7
    .word 0  # 0x0420 obstacle positon 8
    .word 10 # 0x0424 obstacle position 9
    
    .word 15 # 0x0428 duck position

    .word 0  # 0x042c time count
# rand count
    .word 0x0434 #0x0430
# random number
    .word  0 #0x0434
    .word  0 #0x0438
    .word 20 #0x043c
    .word  0 #0x0440
    .word  0 #0x0444
    .word 15 #0x0448
    .word  0 #0x044c
    .word  0 #0x0450
    .word 15 #0x0454
    .word  0 #0x0458
    .word  0 #0x045c
    .word 20 #0x0460
    .word  0 #0x0464
    .word  0 #0x0468
    .word  5 #0x046c
    .word  0 #0x0470
    .word  0 #0x0474
    .word 10 #0x0478
    .word  0 #0x047c
    .word  0 #0x0480
    .word 10 #0x0484
    .word  0 #0x0488
    .word  0 #0x048c
    .word 15 #0x0490
    .word  0 #0x0494
    .word  0 #0x0498
    .word 15 #0x049c
    .word  0 #0x04a0
    .word  0 #0x04a4
    .word 10 #0x04a8
    .word  0 #0x04ac
    .word  0 #0x04b0
    .word 15 #0x04b4
    .word  0 #0x04b8
    .word  0 #0x04bc
    .word  5 #0x04c0
    .word  0 #0x04c4
    .word  0 #0x04c8
    .word 15 #0x04cc
    .word  0 #0x04d0
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
 
