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
    ori $s1, $zero, 0xf02c # time count
    lw $s0, 0($s1)
    lui $s2, 0x0020
    bne $s0, $s2, no_update_Ob
        jal update_Ob
        ori $s0, $zero, 0
    no_update_Ob:
    addi $s0, $s0, 1
    sw $s0, 0($s1)
    #read PS and process 
    lui $s0, 0xffff
    ori $s0, $s0, 0xd000 # PS2 Addr
    ori $s1, $zero, 0xf028 # duck Addr
    lw $t0, 0($s0) # Read PS2
    lui $t1, 0x8000
    ori $t1, $zero, 0x001D
    bne $t0, $t1, no_w
        lw $t3, 0($s1) # Read Duck Position
        ori $t4, $zero, 1
        beq $t3, $t4, top
            addi $t3, $t3, -1
        top:
        sw $t3, 0($s1)
        j draw_duck
    no_w:
    lui $t1, 0x8000
    ori $t1, $zero, 0x00F0
    bne $t0, $t1, no_duan_ma
        lw $t0, 0($s0)
        j draw_duck
    no_duan_ma:
    lui $t1, 0x8000
    ori $t1, $zero, 0x001B
    bne $t0, $t1, no_s
        lw $t3, 0($s1)
        ori $t2, $zero, 30
        beq $t3, $t2, bottom
            addi $t3, $t3, 1
        bottom:
        sw $t3, 0($s1)
        j draw_duck

    no_s:
        sll $zero, $zero, 0
    # draw duck and judge
    draw_duck:
        lw $t0, 0($s1) # Read Positon
        ori $t1, $zero, 0
        lui $s2, 0x000C
        ori $s2, $zero, 4904 # Bird Cursor
        draw_duck_loop:
            addi $t1, $t1, 1
            addi $s2, $s2, 320
        bne $t1, $t0, draw_duck_loop
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
    ori $t0, $t0, 0xf000 # ob position
    lui $t3, 0
    ori $t3, $t3, 0xf024 # duck position
    process_loop: # process 0xf000 - 0xf024
        lw $t1, 4($t0)
        sw $t1, 0($t0)
        addi $t0, $t0, 4
        ori $s4, $zero, 0xf024
        bne $t0, $s4, process_loop
    lui $t0, 0
    ori $t0, $zero, 0xf030 # address of random address
    lw $t1, 0($t0) # t1 got the random address
    lw $t4, 0($t1) # t4 got the random
    sw $t4, -12($t0) # save to 0xf024
    lui $s3, 0
    ori $t3, $zero, 0xf1c4
    addi $t1, $t1, 4
    bne $t3, $t1, set_new_addr
        ori $t1, $zero, 0xf034
    set_new_addr:
    sw $t1, 0($t0)

    # draw ob
    ori $s0, $zero, 0xf000 # ob info
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

.data 0xf000
    .word 0  # 0xf000 obstacle positon 0
    .word 0  # 0xf004 obstacle positon 1
    .word 0  # 0xf008 obstacle positon 2
    .word 0  # 0xf00c obstacle positon 3
    .word 0  # 0xf010 obstacle positon 4
    .word 0  # 0xf014 obstacle positon 5
    .word 0  # 0xf018 obstacle positon 6
    .word 0  # 0xf01c obstacle positon 7
    .word 0  # 0xf020 obstacle positon 8
    .word 10 # 0xf024 obstacle position 9
    
    .word 15 # 0xf028 duck position

    .word 0  # 0xf02c time count
# rand count
    .word 0xf034 #0xf030
# random number
    .word  0 #0xf034
    .word  0 #0xf038
    .word 20 #0xf03c
    .word  0 #0xf040
    .word  0 #0xf044
    .word 15 #0xf048
    .word  0 #0xf04c
    .word  0 #0xf050
    .word 15 #0xf054
    .word  0 #0xf058
    .word  0 #0xf05c
    .word 20 #0xf060
    .word  0 #0xf064
    .word  0 #0xf068
    .word  5 #0xf06c
    .word  0 #0xf070
    .word  0 #0xf074
    .word 10 #0xf078
    .word  0 #0xf07c
    .word  0 #0xf080
    .word 10 #0xf084
    .word  0 #0xf088
    .word  0 #0xf08c
    .word 15 #0xf090
    .word  0 #0xf094
    .word  0 #0xf098
    .word 15 #0xf09c
    .word  0 #0xf0a0
    .word  0 #0xf0a4
    .word 10 #0xf0a8
    .word  0 #0xf0ac
    .word  0 #0xf0b0
    .word 15 #0xf0b4
    .word  0 #0xf0b8
    .word  0 #0xf0bc
    .word  5 #0xf0c0
    .word  0 #0xf0c4
    .word  0 #0xf0c8
    .word 15 #0xf0cc
    .word  0 #0xf0d0
    .word  0 #0xf0d4
    .word  5 #0xf0d8
    .word  0 #0xf0dc
    .word  0 #0xf0e0
    .word 15 #0xf0e4
    .word  0 #0xf0e8
    .word  0 #0xf0ec
    .word 10 #0xf0f0
    .word  0 #0xf0f4
    .word  0 #0xf0f8
    .word 10 #0xf0fc
    .word  0 #0xf100
    .word  0 #0xf104
    .word 15 #0xf108
    .word  0 #0xf10c
    .word  0 #0xf110
    .word 10 #0xf114
    .word  0 #0xf118
    .word  0 #0xf11c
    .word 20 #0xf120
    .word  0 #0xf124
    .word  0 #0xf128
    .word 15 #0xf12c
    .word  0 #0xf130
    .word  0 #0xf134
    .word 10 #0xf138
    .word  0 #0xf13c
    .word  0 #0xf140
    .word 10 #0xf144
    .word  0 #0xf148
    .word  0 #0xf14c
    .word 10 #0xf150
    .word  0 #0xf154
    .word  0 #0xf158
    .word 15 #0xf15c
    .word  0 #0xf160
    .word  0 #0xf164
    .word 20 #0xf168
    .word  0 #0xf16c
    .word  0 #0xf170
    .word 10 #0xf174
    .word  0 #0xf178
    .word  0 #0xf17c
    .word 15 #0xf180
    .word  0 #0xf184
    .word  0 #0xf188
    .word  5 #0xf18c
    .word  0 #0xf190
    .word  0 #0xf194
    .word 15 #0xf198
    .word  0 #0xf19c
    .word  0 #0xf1a0
    .word 10 #0xf1a4
    .word  0 #0xf1a8
    .word  0 #0xf1ac
    .word 15 #0xf1b0
    .word  0 #0xf1b4
    .word  0 #0xf1b8
    .word 15 #0xf1bc
 