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
// initialization
@SCREEN
D=A
@nowscreen
M=D
@256
D=A
@rowcount
M=D
@32
D=A
@colcount
M=D

(LOOP)
  @KBD
  D=M
  @WHITE
  D;JEQ
  @BLACK
  D;JMP
  @LOOP
  0;JMP

(WHITE)
  // process all bit in register
  // value in register & 0000000000000000
  @nowscreen
  A=M
  D=M
  @0
  D=D&A
  @nowscreen
  A=M
  M=D

  @nowscreen
  M=M+1

  @colcount
  M=M-1
  D=M
  @CMPCOLMAXWHITE
  0;JMP

(CMPCOLMAXWHITE)
  @colcount
  D=M
  @RESETCOLWHITE
  D;JEQ
  @WHITE
  0;JMP

// reset col count and decrement row count
// if rowcount == 0, jump to reset row count
(RESETCOLWHITE)
  @32
  D=A
  @colcount
  M=D
  @rowcount
  M=M-1
  D=M
  @RESETROW
  D;JEQ
  @WHITE
  0;JMP

(RESETROW)
  @256
  D=A
  @rowcount
  M=D

  @SCREEN
  D=A
  @nowscreen
  M=D

  @LOOP
  0;JMP

(BLACK)
  // process all bit in register
  // value in register | 1111111111111111
  @nowscreen
  A=M
  D=M
  @0
  D=D&A
  D=!D
  @nowscreen
  A=M
  M=D

  @nowscreen
  M=M+1

  @colcount
  M=M-1
  D=M
  @CMPCOLMAXBLACK
  0;JMP

(CMPCOLMAXBLACK)
  @colcount
  D=M
  @RESETCOLBLACK
  D;JEQ
  @BLACK
  0;JMP

// reset col count and decrement row count
// if rowcount == 0, jump to reset row count
(RESETCOLBLACK)
  @32
  D=A
  @colcount
  M=D
  @rowcount
  M=M-1
  D=M
  @RESETROW
  D;JEQ
  @BLACK
  0;JMP

(END)
  @END
  0;JMP
