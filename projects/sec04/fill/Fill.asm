// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(LOOP)
  // Determine color
  @KBD
  D=M
  @WHITE
  D;JEQ

  // key pressed, blacken the screen
  @color
  M=-1
  @START_FILL
  0;JMP

(WHITE)
  @color
  M=0

(START_FILL)
  // ptr = SCREEN
  @SCREEN
  D=A
  @ptr
  M=D

(FILL)
  // RAM[ptr] = color
  @color
  D=M
  @ptr
  A=M
  M=D

  // ptr = ptr + 1
  @ptr
  M=M+1

  // if ptr < KBD, continue filling
  // KBD address is located immediately after the screen memory
  @KBD
  D=A
  @ptr
  D=M-D
  @FILL
  D;JLT

  // Check keyboard again
  @LOOP
  0;JMP
