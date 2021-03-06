// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

@value // 0 is white, -1 is black
M = 0

(START)
  @KBD
  D = M // save keypress in D

  @COLOR
  D; JEQ // if D is 0, then color as 0

  (KEY_PRESS)
    D = -1 // change value to -1 (black)

  (COLOR) // Set D to color value before entering COLOR function
    @value
    M = D

    @SCREEN
    D = A
    @i // set @i variable to SCREEN
    M = D

    @SCREEN
    D = A
    @8192
    D = D + A
    @loop_limit
    M = D // set loop_limit to 8192 + SCREEN

    (START_COLOR_LOOP)
      @i
      D = M

      @loop_limit
      D = M - D
      @STOP_COLOR_LOOP
      D; JLE // exit loop if i > loop_limit

      @value
      D = M

      @colored
      M = D // set colored flag to value

      @i
      A = M
      M = D // RAM[addr] = value

      @i
      M = M + 1 // i++

      @START_COLOR_LOOP
      0; JMP

    (STOP_COLOR_LOOP)
      @START
      0; JMP