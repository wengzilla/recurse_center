@SCREEN
D = A
@i // set @i variable to 0
M = D

@8192
D = A
@SCREEN
D = D + A
@loop_limit
M = D // set loop_limit to 8192 + SCREEN

@value
M = -1

(START_LOOP_1)
@i
D = M

@loop_limit
D = M - D 
@STOP_LOOP_1
D; JLT

@value
D = M
@i
A = M
M = D // RAM[addr] = -1

@i
M = M + 1 // i++

@START_LOOP_1
0; JMP

(STOP_LOOP_1)

@STOP_LOOP_1
0; JMP