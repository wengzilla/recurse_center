// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

@R2
M = 0

@R0
D = M
@temp
M = D

(START)
@temp
D = M

@STOP
D; JLE

@R2
D = M

@R1
D = D + M

@R2
M = D

@temp
M = M - 1

@START
0; JMP

(STOP)
@STOP
0; JMP