  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
   MOV R11, #0x20                               @placeHolder2 = 0x20 
   MOV R9, #0                                   @ number  1 = 0 ; 
   MOV R7, #0                                   @ number 2 = 0 ;
   MOV R5, #0                                   @ count = 0 ; 
   MOV R0 , #1                                  @ value = 1 ; 
   LDRB R9 , [R1]                               @ number  1 = [Byteaddress]
   LDR R10 , = 1                                @placeHolder = 1 
   WhileNotZero :                               @ while ( number  1 != 0 )
   CMP R9, #0     
   BEQ  EndWhileNotZero 
   ADD R1, R1, R10                             @ Byteaddress = Byteaddress + 1
   LDRB R9, [R1]                              @ number  1 = [ Byteaddress ]
   ADD R5,R5, R10                              @ count = count + 1
   B  WhileNotZero 
   EndWhileNotZero :
   SUB R1, R1, R5                             @ Byteaddress = Byteaddrss -  1

  WhileNotOne :                               @ while (( value != 0 ) && count > 0 )
  CMP R5, R10            
  BLE EndWhileNotOne
  CMP R0, #0 
  BEQ EndWhileNotOne 
  LDRB R9, [R1]                              @ number 1 = [ Byteaddress]

  WhileNotLetter :                           @ while ( number 1 !=z && number 1 != a )
  CMP R9, #0x61 
  BLT IfNot
  CMP R9, #0x7A
  BLE IfIs 
  IfNot : 
  CMP R9, #0x41                             @ while ( number 1 != Z && number  1!= A)
  BLT IfNot2 
  CMP R9, #0x5A
  BLE IfIs 
  IfNot2 : 
  ADD R1, R1, R10                            @ Byteaddress = Bytaddress +  1
  LDRB R9, [R1]                                @ number  1 = [Byteaddress ]
  SUB  R5,R5, R10                            @ count = count - 1
  B WhileNotLetter
  IfIs  :
  SUB  R5,R5, R10                             @ count = count - 1 
  ADD R1,R1, R5                             @ Byteaddress = Byteaddress + count 
  LDRB R7, [R1]                             @ number 2 = [Byteaddress]
  WhileNotLetter2 : 
  CMP R7, #0x61                             @ while ( number 2 != z && number 2 ! =a)
  BLT IfNot3
  CMP R7, #0x7A
  BLE IfNot4
  IfNot3 :
  CMP R7, #0x41                             @ while ( number 2 != Z && number 2 ! = A)
  BLT IfNot5
  CMP R7, 0x5A
  BLE IfNot4
  IfNot5 : 
  SUB R1,R1 , R10                            @ ByteAddress = ByteAddress - 1 
  LDRB R7, [R1]
  SUB  R5,R5, R10                            @ count = count - 1
  B WhileNotLetter2 
  IfNot4 : 
  BIC R9, R9, R11                         @ number1 ----- > UPPERCASE 
  BIC R7,R7, R11                          @ number 2 ----> UPPERCASE 
  CMP R9, R7
  BEQ IfEqual                               @ ( if number 2 != number 1)
  MOV R0 , #0                               @ value = 0 
  IfEqual : 
  SUB R5,R5, R10                            @ count = count   -1
  SUB R1,R1, R5                             @ Byteaddress = Byteaddress - count 
  B WhileNotOne
  EndWhileNotOne : 

    

  @ End of program ... check your result

End_Main:
  BX    lr

