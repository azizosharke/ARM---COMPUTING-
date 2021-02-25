  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will convert
  @   a signed value (integer) in R3 into three ASCII characters that
  @   represent the integer as a decimal value in ASCII form, prefixed
  @   by the sign (+/-).
  @ The first character in R0 should represent the sign
  @ The second character in R1 should represent the most significaint digit
  @ The third character in R2 should represent the least significant digit
  @ Store 'N', '/', 'A' if the integer is outside the range -99 ... 0 ... +99

  
  @ *** your solution goes here ***

  MOV R0, #0                                             @ t=0 
  MOV R1, #0                                             @ m = 0 
  MOV R2, #0                                             @ n = 0          
  MOV R5, #10                                            @number = 10 
  CMP R3, #100                                           @if ( z<100 && z>0)
  BGE EndIfBigger3    
  CMP R3, #0                       
  BLE ElseIfBigger       
  MOV R0, 0x2B                                           @t = '+'
  UDIV R7, R3, R5                                       
  ADD R1,R1,R7                                                 
  ADD R1,R1, 0x30                                       @ convert it to ASCII 
  MUL R7, R7, R5                                        @ i =i*number
  SUB R3, R3, R7                                        @ p= p-i
  MOV R2, R3                                            @ n=p
  ADD R2,R2,0x30                                        @convert it to ASCII 
  B EndIfBigger 
 
  ElseIfBigger :
  
  CMP R3, #0                                             @Elseif (n=0)
  BNE ElseIfBigger2
  MOV R1, #'0'                                           @m = '0'
  MOV R2, #'0'                                           @n = '0'
  MOV R0 , #0X20                                          @t = ''
  B EndIfBigger 

  ElseIfBigger2 : 
  LDR R6 ,= -100                                         @ElseIf ( z> "-100 " && z <0)
  CMP R3, R6
  BLE EndIfBigger3
  MOV R6, #-1                                             @ random = -1
  MUL R3, R3,R6                                           @ b*random 
  MOV R0, 0x2D                                            @ t = '-'
  UDIV R7, R3, R5                                         @ r/number
  ADD R1,R1,R7                                            @ m = m+1
  ADD R1,R1, 0x30                                         @ convert it to ASCII 
  MUL R7, R7, R5                                          @ i = i*number   
  SUB R3, R3, R7                                          @ p= p-i
  MOV R2, R3                                              @ n=p
  ADD R2,R2,0x30                                          @convert it to ASCII 

 B EndIfBigger
 EndIfBigger3 :                                             @Else
  MOV R1, 0x2F                                              @m = '/'
  MOV R2, 0x41                                              @n = 'A'
  MOV R0, 0x4E                                              @t = 'N'
 EndIfBigger : 


  @ End of program ... check your result

End_Main:
  BX    lr

.end
