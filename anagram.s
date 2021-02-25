  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
 
 LDR R12 , = 0                         @ a = 0  
 LDR R11 , = 1                         @ b = 1
 MOV R0, R12                           @answer = 0 ;
 MOV R9, #' '                          @ space 
 MOV R10, R12                          @ sChar = 0 
 LDRB R5, [R1]                         @ charA= [byteddressA]
 LDRB R6, [R2]                         @ charB = [byteaddressB]
WhileNotB :                           @ while ( charA !=0)
 CMP R5,R12                            @ && ( charB !=0)
 BEQ EndWhileNotB 
 CMP R6, R12 
 BEQ EndWhileNotB

 CMP R5, #0x61                          @ if (char <= 'z')
 BLO NotLowerCaseA                        @ && ( char >= 'a')
 CMP R5, #0x7A
 BHI NotLowerCaseA
 SUB R5, R5,0x20                       @ charA = charA- 0x20
 STRB R5, [R1]                         @ [address1] = ch1

 NotLowerCaseA :                          @ if ( char <= 'z')
 CMP R6, #0x61                          @ && ( char >= 'a' )
 BLO NotLowerCaseB
 CMP R6, #0x7A
 BHI NotLowerCaseB
 SUB R6, R6,0x20                       @ charB= charB -0x20
 STRB R6, [R2]                         @ byteaddressB = ch2 

 NotLowerCaseB :
 ADD R4, R4, R11                       @characterB = characterB + 1
 ADD R3, R3, R11                       @characterA = characterA + 1
 ADD R2, R2, R11                       @byteaddressB = byteaddressB + 1
 ADD R1, R1, R11                       @byteaddressA = byteaddressA +  1
 LDRB R5, [R1]
 LDRB R6, [R2]
 B WhileNotB 

 EndWhileNotB :                        @if ( charB != 0 )
 CMP R5, R12                           @ || ( charA != 0 )
 BNE Endit 
 CMP R6, R12
 BNE Endit 
 SUB R2, R2, R4                        @ byteaddressB = byteaddressB - characterB 
 SUB R1, R1, R3                        @ byteaddressA = byteaddressA - characterA     
 LDRB R5, [R1]                         @ charA = [ byteaddressA]
 LDRB R6, [R2]                         @ charB = [ byteaddressB]

WhileNotA :                           @ while ( char!= 0)
CMP R5, R12
BEQ EndWhileA
MOV R8, R12                           @ sChar =0 
MOV R7, R12                           @ charC= 0 

ForCh :                               @ for ( charC 0 )
CMP R6, R12                           @ sChar != 1 
BEQ EndForC                           @ && charB!= 0 
CMP R8, R11
BEQ EndForC 
CMP R5, R6                            @if ( charA = charB)
BNE EndIfNot 
MOV R8, R11                           @sChar = 1
STRB R9, [R2]                         
ADD R10, R10 , R11                    @sChar = sChar + 1 

EndIfNot :   
ADD R2, R11                            @ byteaddressB = byteaddressB + 1 
LDRB R6, [R2]                          @ charB = [byteaddressB]
ADD R7 , R11                           @ charC = charC + 1 
B ForCh 
EndForC :  
SUB R2, R2, R7                         @ byteaddressB = byteaddressB - charC 
LDRB R6, [R2]                          @ charB = [byteaddressB]
ADD R1, R1, R11                        @ byteddressA= byteaddressA + 1 
LDRB R5, [R1]                          @ charA = [byteaddressA]
B WhileNotA


EndWhileA:                             @ if ( sChar = charC )                   
CMP R10, R3  
BNE Endit 
ADD R0, R0 , R11                      @ answer  = 1 

Endit : 



 




  @ End of program ... check your result

End_Main:
  BX    lr

