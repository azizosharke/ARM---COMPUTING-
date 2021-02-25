  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

    MOV R4, #0            @modeCount = 0;
    MOV R3, #0            @mode = 0
    MOV R5, #0            @i1 = 0;

    WhileA :
    CMP R5, R2            @ while (i1 < N)
    BGE EndWhileA          @{
    LDR R6, [R1]          @ value1 = word[address1]
    MOV R8, #0            @ count = 0;
    ADD R7, R1,#4         @ address2 = address1 + 4;
    ADD R9, R5, #1        @ i2 = i1 + 1

    WhileB :
    CMP R9, R2             @ While ( i2 < N)
    BGE EndIfA              @{
    LDR R10,[R7]           @value2 = word[address2]
    CMP R6, R10            @ if (value1 == value2)
    BNE EndIfB             @ {
    ADD R8,R8,#1           @ count = count + 1;
    EndIfB : 
    ADD R9,R9,#1           @i2 = i2 + 1;
    ADD R7,R7,#4           @ address2 = address2 + 4;
    B   WhileB
    EndIfA :

    CMP R8,R4              @if (count > modeCount)
    BLE EndIfC
    MOV R3,R6              @mode = value1;
    MOV R4,R8              @modeCount = count;
    MOV R0,R3              @  }
    EndIfC :    
    ADD R5,R5,#1           @ i1 = i1 +1
    ADD R1,R1,#4           @ address1 = address1 + 4 ;
    B   WhileA


   EndWhileA :
  @ End of program ... check your result

End_Main:
  BX    lr

