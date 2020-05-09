.text 0x0000
main:
lui $s2, 0x000C #VGACursor
lui $s3, 0xFFFF
addi $s3, $zero, 0xD000 #P2SAddr
addi $t0, $t0, 0x075f
sw $t0, 0($s2)
j read

dismore:
lw $t1, 0($s3)
lui $t3, 0x8000
and $t2, $t1, $t3 //if t1 read
beq $t2, $zero, read
addi $t4, $t3, 0xF0
beq $t1, $t4, read_r
j read

read_r:
lw $t1, 0($s3)
lui $t3, 0x8000
and $t2, $t1, $t3
beq $t2, $zero, read_r #check if read
andi $t5, $t1, 0xffff
 addi $t4, $zero, 0x75 #up
 beq $t5, $t4, up
 addi $t4, $zero, 0x6B
 beq $t5, $t4, left
 addi $t4, $zero, 0x72
 beq $t5, $t4, down
 addi $t4, $zero, 0x74
 beq $t5, $t4, right
 add $s7, $zero, $zero
 addi $t4, $zero, 0x1c #a
 beq $t5, $t4, a
 addi $t4, $zero, 0x32 #b
 beq $t5, $t4, b
 addi $t4, $zero, 0x21 #c
 beq $t5, $t4, c
 addi $t4, $zero, 0x23 #d
 beq $t5, $t4, d
 addi $t4, $zero, 0x24 #e
 beq $t5, $t4, e
 addi $t4, $zero, 0x2b #f
 beq $t5, $t4, f
 addi $t4, $zero, 0x34 #g
 beq $t5, $t4, g
 addi $t4, $zero, 0x33 #h
 beq $t5, $t4, h
 addi $t4, $zero, 0x43 #i
 beq $t5, $t4, i
 addi $t4, $zero, 0x3b #j
 beq $t5, $t4, j
 addi $t4, $zero, 0x42 #k
 beq $t5, $t4, k
 addi $t4, $zero, 0x4b #l
 beq $t5, $t4, l
 addi $t4, $zero, 0x3a #m
 beq $t5, $t4, m
 addi $t4, $zero, 0x31 #n
 beq $t5, $t4, n
 addi $t4, $zero, 0x44 #o
 beq $t5, $t4, o
 addi $t4, $zero, 0x4d #p
 beq $t5, $t4, p
 addi $t4, $zero, 0x15 #q
 beq $t5, $t4, q
 addi $t4, $zero, 0x2d #r
 beq $t5, $t4, r
 addi $t4, $zero, 0x1b #s
 beq $t5, $t4, s
 addi $t4, $zero, 0x2c #t
 beq $t5, $t4, t
 addi $t4, $zero, 0x3c #u
 beq $t5, $t4, u
 addi $t4, $zero, 0x2a #v
 beq $t5, $t4, v
 addi $t4, $zero, 0x1d #w
 beq $t5, $t4, w
 addi $t4, $zero, 0x22 #x
 beq $t5, $t4, x
 addi $t4, $zero, 0x35 #y
 beq $t5, $t4, y
 addi $t4, $zero, 0x1a #z
 beq $t5, $t4, z
 addi $t4, $zero, 0x16 #1
 beq $t5, $t4, n1
 addi $t4, $zero, 0x1e #2
 beq $t5, $t4, n2
 addi $t4, $zero, 0x26 #3
 beq $t5, $t4, n3
 addi $t4, $zero, 0x25 #4
 beq $t5, $t4, n4
 addi $t4, $zero, 0x2e #5
 beq $t5, $t4, n5
 addi $t4, $zero, 0x36 #6
 beq $t5, $t4, n6
 addi $t4, $zero, 0x3d #7
 beq $t5, $t4, n7
 addi $t4, $zero, 0x3e #8
 beq $t5, $t4, n8
 addi $t4, $zero, 0x46 #9
 beq $t5, $t4, n9
 addi $t4, $zero, 0x45 #0
 beq $t5, $t4, n0
 addi $t4, $zero, 0x29 #space
 beq $t5, $t4, space
 addi $t4, $zero, 0x5a #enter
 beq $t5, $t4, enter
 addi $t4, $zero, 0x66 #backspace
 beq $t5, $t4, back_space
 addi $t4, $zero, 0x76
 beq $t5, $t4, clr1 #clear screen
 addi $t4, $zero, 0x05
 beq $t5, $t4, f1 #f1
 addi $t4, $zero, 0x06
 beq $t5, $t4, f2 #f2
 addi $t4, $zero, 0x04
 beq $t5, $t4, f3 #f3
 j read

a:
 addi $s4, $zero, 0x41
 jal display
 j read
b:
 addi $s4, $zero, 0x42
 jal display
 j read
c:
 addi $s4, $zero, 0x43
 jal display
 j read
d:
 addi $s4, $zero, 0x44
 jal display
 j read
e:
 addi $s4, $zero, 0x45
 jal display
 j read
f:
 addi $s4, $zero, 0x46
 jal display
 j read
g:
 addi $s4, $zero, 0x47
 jal display
 j read
h:
 addi $s4, $zero, 0x48
 jal display
 j read
i:
 addi $s4, $zero, 0x49
 jal display
 j read
j:
 addi $s4, $zero, 0x4a
 jal display
 j read
k:
 addi $s4, $zero, 0x4b
 jal display
 j read
l:
 addi $s4, $zero, 0x4c
 jal display
 j read
m:
 addi $s4, $zero, 0x4d
 jal display
 j read
n:
 addi $s4, $zero, 0x4e
 jal display
 j read
o:
 addi $s4, $zero, 0x4f
 jal display
 j read
p:
 addi $s4, $zero, 0x50
 jal display
 j read
q:
 addi $s4, $zero, 0x51
 jal display
 j read
r:
 addi $s4, $zero, 0x52
 jal display
 j read
s:
 addi $s4, $zero, 0x53
 jal display
 j read
t:
 addi $s4, $zero, 0x54
 jal display
 j read
u:
 addi $s4, $zero, 0x55
 jal display
 j read
v:
 addi $s4, $zero, 0x56
 jal display
 j read
w:
 addi $s4, $zero, 0x57
 jal display
 j read
x:
 addi $s4, $zero, 0x58
 jal display
 j read
y:
 addi $s4, $zero, 0x59
 jal display
 j read
z:
 addi $s4, $zero, 0x5a
 jal display
 j read
n0:
 addi $s4, $zero, 0x30
 jal display
 j read
n1:
 addi $s4, $zero, 0x31
 jal display
 j read
n2:
 addi $s4, $zero, 0x32
 jal display
 j read
n3:
 addi $s4, $zero, 0x33
 jal display
 j read
n4:
 addi $s4, $zero, 0x34
 jal display
 j read
n5:
 addi $s4, $zero, 0x35
 jal display
 j read
n6:
 addi $s4, $zero, 0x36
 jal display
 j read
n7:
 addi $s4, $zero, 0x37
 jal display
 j read
n8:
 addi $s4, $zero, 0x38
 jal display
 j read
n9:
 addi $s4, $zero, 0x39
 jal display
 j read
space:
 add $s4, $zero, $zero
 jal display
 j read
enter:
 lui $t0, 12
 addi $t0, $t0, 0x2300
 slt $t1, $s2, $t0
 beq $t1, $zero, read
 add $s4, $zero, $zero
 jal display
 lui $t6, 12
 sub $t6, $s2, $t6
 addi $t7, $zero, 320
 Loop2:
 sub $t6, $t6, $t7
 beq $t6, $zero, read
 slt $t8, $t6, $zero # $t8 = $t6<0?1:0
 bne $t8, $zero, enter
 j Loop2
back_space:
 lui $t5, 12
 beq $s2, $t5, read
 sw $zero, 0($s2) #clear this cur
 addi $s2, $s2, -4
 addi $s4, $zero, 0x075f
 sw $s4, 0($s2)
 j read

clr1:
 lui $s2, 12
 addi $s2,$s2,0x243c
 j clr
clr:
 sw $zero, 0($s2)
 beq $s2, $zero, main
 addi $s2, $s2, -4
 lui $t4, 12
 slt $t5, $s2, $t4
 bne $t5, $zero, main
 j clr

up:
 lui $t6, 12
 addi $t6, $t6, 320 #end of first line
 slt $t0, $s2, $t6
 bne $t0, $zero, read
 sw $s7, 0($s2)
 addi $t3, $zero, 320
 sub $s2, $s2, $t3
 addi $t3, $zero, 0x075f
 lw $s7, 0($s2)
 sw $t3, 0($s2)
 j read

left:
 sw $s7, 0($s2)
 addi $s2, $s2, -4
 addi $t0, $zero, 0x075f
 lw $s7, 0($s2)
 sw $t0, 0($s2)
 j read

right:
 sw $s7, 0($s2)
 addi $s2, $s2, 4
 addi $t0, $zero, 0x075f
 lw $s7, 0($s2)
 sw $t0, 0($s2)
 j read

down:
 lui $t6, 12
 addi $t6, $t6, 0x22fc #end of first line
 slt $t0, $t6, $s2
 bne $t0, $zero, read
 sw $s7, 0($s2)
 addi $s2, $s2, 320
 addi $t3, $zero, 0x075f
 lw $s7, 0($s2)
 sw $t3, 0($s2)
 j read

f1:
 lui $t0, 12
 beq $t0, $s2, read
 addi $t0, $s2, -4
 lw $t0, ($t0)
 andi $s4, $t0, 0x00f0
 srl $s4, $s4, 4
 addi $s4, $s4, 0x30
 jal display
 andi $s4, $t0, 0x000f
 slti $t0, $s4, 0xa
 beq $t0, $zero, char
 addi $s4, $s4, 0x30
 jal display
 j color

f2: #scroll up
 lui $s5, 12
 lui $s6, 12
 addi $s6, $s6, 0x2300
 loop3:
 beq $s5, $s6, lastline
 lw $t0, 0x140($s5)
 sw $t0, 0($s5)
 addi $s5, $s5, 4
 j loop3
 lastline:
 lui $s6, 12
 addi $s6, $s6, 0x2440
 loop4:
 beq $s5, $s6, read
 sw $zero, 0($s5)
 addi $s5, $s5, 4
 j loop4


f3:
 lui $s5, 12
 addi $s5, $s5, 0x243c
 lui $s6, 12
 addi $s6, $s6, 0x13c
 loop5:
 beq $s5, $s6, firstline
 lw $t0, -0x140($s5)
 sw $t0, 0($s5)
 addi $s5, $s5, -4
 j loop5
 firstline:
 lui $s6, 12
 addi $s6, $s6, -4
 loop6:
 beq $s5, $s6, read
 sw $zero, 0($s5)
 addi $s5, $s5, -4
 j loop6

char:
 addi $t0, $zero, 0xa
 beq $s4, $t0, a
 addi $t0, $zero, 0xb
 beq $s4, $t0, b
 addi $t0, $zero, 0xc
 beq $s4, $t0, c
 addi $t0, $zero, 0xd
 beq $s4, $t0, d
 addi $t0, $zero, 0xe
 beq $s4, $t0, e
 addi $t0, $zero, 0xf
 beq $s4, $t0, f
 j color

color:
 addi $t0, $s2, -8
 lw $t1, 0($t0)
 addi $t1, $t1, 0x1000
 addi $t1, $t1, -0x0500
 sw $t1, 0($t0)
 lw $t1, 4($t0)
 addi $t1, $t1, 0x1000
 addi $t1, $t1, -0x0500
 sw $t1, 4($t0)
 j read

display:
 lui $t0, 12
 addi $t0,$t0,0x243c
 slt $t0, $s2, $t0
 beq $t0, $zero, back
 addi $t0, $s4, 0x0700
 sw $t0, 0($s2) # to display
 addi $s2, $s2, 4
 addi $s4, $zero, 0x075f #cur
 sw $s4, 0($s2) #display cur
 jr $ra
 back:
 jr $ra

read:
 lui $s5, 12
 addi $s5, $s5, 0x2440
 addi $s6, $zero, 0x4724 #$
 jal dispc
 addi $s6, $zero, 0x4773 #s
 jal dispc
 addi $s6, $zero, 0x4732 #2
 jal dispc
 addi $s6, $zero, 0x473A #:
 jal dispc
 srl $s6, $s2, 28  #s2 8
 jal process
 jal dispc
 srl $s6, $s2, 24
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s2, 20
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s2, 16
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s2, 12
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s2, 8
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s2, 4
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 addi $s6, $s2, 0
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 add $s6, $zero, $zero
 jal dispc
 add $a0, $zero, $s2
 jal showdata
 add $s6, $zero, $zero
 jal dispc
 addi $a0, $zero, 0x00fa
 jal showbin
 add $s6, $zero, $zero
 jal dispc
 jal showbutton
 j dismore

showbin:
 addi $t9, $ra, 0
 add $t1, $zero, $zero
 loopd3:
 slti $t2, $a0, 1000
 bne $t2, $zero, loopd2
 addi $a0, $a0, -1000
 addi $t1, $t1, 0x1000
 j loopd3
 loopd2:
 slti $t2, $a0, 100
 bne $t2, $zero, loopd1
 addi $a0, $a0, -100
 addi $t1, $t1, 0x100
 j loopd2
 loopd1:
 slti $t2, $a0, 10
 bne $t2, $zero, loopd0
 addi $a0, $a0, -10
 addi $t1, $t1, 0x10
 j loopd1
 loopd0:
 slti $t2, $a0, 1
 bne $t2, $zero, showbin2
 addi $a0, $a0, -1
 addi $t1, $t1, 0x1
 j loopd0
 showbin2:
 srl $s6, $t1, 12
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4730
 jal dispc
 srl $s6, $t1, 8
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4730
 jal dispc
 srl $s6, $t1, 4
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4730
 jal dispc
 addi $s6, $t1, 0
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4730
 jal dispc
 jr $t9

showbutton:
 lui $t1, 0xffff
 addi $t1, $zero, 0xfc00
 lw $t0, 0($t1)
 andi $s6, $t0, 0x000f
 slti $t0, $s6, 0xa
 bne $t0, $zero, sb1
 addi $s6, $s6, -0xa
 addi $s6, $s6, 0x4741
 sw  $s6, 0($s5) # to display
 addi $s5, $s5, 4
 jr $ra
sb1:
 addi $s6, $s6, 0x4730
 sw  $s6, 0($s5) # to display
 addi $s5, $s5, 4
 jr $ra

showdata:
 lw $s1, -4($a0)
 add $s0, $zero, $ra
 addi $s6, $zero, 0x4724 #$
 jal dispc
 addi $s6, $zero, 0x4761 #a
 jal dispc
 addi $s6, $zero, 0x4730 #0
 jal dispc
 addi $s6, $zero, 0x473A #:
 jal dispc
 srl $s6, $s1, 28  #s2 8
 jal process
 jal dispc
 srl $s6, $s1, 24
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s1, 20
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s1, 16
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s1, 12
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s1, 8
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 srl $s6, $s1, 4
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 addi $s6, $s1, 0
 andi $s6, $s6, 0xf
 addi $s6, $s6, 0x4700
 jal process
 jal dispc
 jr $s0

process:
 andi $s6, $s6, 0xf
 slti $t1, $s6, 0xa
 bne $t1, $zero, num
 addi $s6, $s6, -0xa
 addi $s6, $s6, 0x4741
 jr $ra
num:
 addi $s6, $s6, 0x4730
 jr $ra

dispc:
 sw $s6, 0($s5) # to display
 addi $s5, $s5, 4
 jr $ra
