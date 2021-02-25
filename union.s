  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @

  LDR R11, =4                     @ a = 4
  LDR R4, [R1]                    @ testA = [WordaddressB]
  ADD R1, R1,R11                  @ WordaddressC = WordaddressC + 4
  LDR R3, [R2]                    @ testB = [addressC]
  ADD R2, R2, R11                 @ WordaddressC = WordaddressC + 4
  MOV R6, #0                      @ AexA = 0 
  MOV R5 , #0                     @ elementA = 0 ; 
  MOV R10, #0                     @ WordaddressAC = 0 ;
  ADD R10, R10 , R0               @ WordaddressAC = WordaddressAC +WordaddressA

  WhileFirstA  :                  @ while ( AexA != size)
  CMP R6, R4         
  BEQ EndWhileFA 
  LDR R5, [R1]                     @ elementA = [WordaddressB]
  STR R5, [R0]                     @ [WordaddressA] = b
  ADD R1, R1, R11                  @ WordaddressB = WordaddressB + a
  ADD R0, R0, R11                  @ WordaddressA =WordaddressA + a
  ADD R6, R6, #1                   @ AexA = AexA + 1
  B WhileFirstA 
  EndWhileFA : 
  
  MOV R12, R11                    @ = a 
  ADD R6, R6, #1                  @ AexA = AexA +1
  MUL R6, R6, R12                 @ AexA = AexA * a
  SUB R1, R1, R6                  @ WordaddressB = WordaddressB - AexA
  MOV R7, #0                      @ AexB = 0
  MOV R8, #0                      @ elementB = 0 ; 
  WhileSecondB :                  @ while (AexB != size)
  CMP R7, R3
  BEQ EndWhileSB
  LDR R8, [R2]                    @ elementB = [WordaddressC]
  MOV R6, #0                      @AexA = 0 
  LDR R5, [R1]                    @ elementA = [ WordaddressB]

  WhileThirdC :                   @ while ( AexA < testA)
  CMP R6, R4     
  BEQ EndWhileTC
  CMP R5, R8 
  BEQ EndWhileTC
  ADD R1, R1, R11                 @ WordaddressB = WordaddressB + a 
  LDR R5 ,[R1]                    @ elementA = [ WordaddressB]
  ADD R6, R6, #1                  @ AexA = AexA + 1
  B WhileThirdC 
  
  EndWhileTC :     
  MUL R6, R6, R12                 @ AexA = AexA * a
  SUB R1, R1, R6                  @ WordaddressB = WordaddressB - AexA

  CMP R5, R8                      @ if ( elementA != elementB)
  BEQ EndIfA 
  STR R8 , [R0]                   @ elementB = [WordaddressA]
  ADD R0 , R0, R11                @ WordaddressA = WordaddressA +a
  EndIfA : 
  ADD R2, R2, R11                 @ WordaddressC = WordaddressC + a
  ADD R7, R7, #1                  @ AexB = AexB +1
  B WhileSecondB
  EndWhileSB :
  
  MOV R3, #0                      @ AexC = 0  
  WhileFourthD :                  @ while ( WordaddressAC!)
  CMP R10, R0 
  BEQ EndWhileFD 
  ADD R10, R10 , R11              @ WordaddressAC = WordaddressAC + a 
  ADD R3, #1                      @ AexC = AexC + 1
  B WhileFourthD 
EndWhileFD :
 MOV R4, #0                       @ testC = 0 
 ADD R4, R4, R3                   @ testC= AexC + testC
 MOV R9, #0                       @ elementC = 0 
 WhileFifthE :
 CMP R3, #0 
 BEQ EndFE 
 SUB R0, R0, R11                  @ WordaddressA = Wordaddress3 + a 
 LDR R9, [R0]                     @ elementC = WordaddressA
 ADD R0, R0 , R11                 @ WordaddressA = WordaddressA + a    
 STR R9, [R0]                     @ [WordaddressA] = elementC
 SUB R0 ,R0  ,R11                 @ AexC = AexC -1
 SUB R3, R3, #1                  
 B WhileFifthE
EndFE :
STR R4, [R0]                      @ [WordaddressA] = testC




  

  @ End of program ... check your result

End_Main:
  BX    lr

