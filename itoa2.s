  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @ 


  @
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the following watch expression: (unsigned char [64]) strA
  @
  @   OR
  @
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @

  @ End of program ... check your result

LDR R12 , = 1                         @c = 1
LDR R11 , = 0                         @b = 0 
LDR R10, = -1                         @a = -1
CMP R1 , R11                          @ if ( no.1 = b )
BNE ElseIfNotZero                     @ {
ADD R1, R1, #0x30                     @ no.1 += '0'  
STRB R1 , [R0]                        @ [Byteaddress ] = no.1 ;
ADD R0 , R0 , R12                     @ byteaddress += c ;
B EndTheProgram                       
 
ElseIfNotZero :                       @ elseif ( no.1 != b ) {
CMP R1, R11                           @ if (no.1 <0)
BGT NumberValidNeg                    @{
MOV R8, #0x2D                         @  '-'
STRB R8, [R0]                         @ [Byteaddress] = '-'; 
ADD R0 , R0 , R12                     @ byteaddress += c; 
MOV R4,R10                            @ b = a  
MUL R1, R1, R4                        @ no.1 *= b);   
B ConvertorASCII                      @ } 

NumberValidNeg :                      @ else {
MOV R8 , #0x2B                        @ '+'
STRB R8, [R0]                         @ [Byteaddress] =  '+'
ADD R0 , R0 , R12                     @byteaddress = byteaddress + c                                      
ConvertorASCII :                                  
MOV R2, R11                           @ expo = b ; 
LDR R4, = 10                          @ d =10 
ADD R5, R5, R1                        @ numberForTest = no.1 ; 
WhileStillHasPowerOfTensB :           @ while [ numberforTest > d ]              
CMP R5, R4                            @ { 
BLT EndIfHasPowerOfTensD                 
UDIV R5, R5 ,R4                       @ numberForTest = numberForTest / d
ADD R2, R2, R12                       @ expo = expo + c
B WhileStillHasPowerOfTensB           @ }
EndIfHasPowerOfTensD :
MOV R3, R12                           @ no.2 =1 ; 

WhilePowerFirstNumber :               @ while expo ! = b    
CMP R2, R11                           @ { 
BEQ EqualZero               
MUL R3, R3, R4                        @ no.2 *= d 
SUB R2, R2, R12                       @ expo = expo - c ; 
B WhilePowerFirstNumber
EqualZero :                          
MOV R7, R11                           @ no.3 = b ; 
GreaterThanZeroWh :                   @ while (expo >b)
CMP R3, R11                           @ { 
BEQ EndTheProgram                          
UDIV R7, R1, R3                       @ no.3 = no.1 / expo ;    
ADD R9 , R7 , 0x30                    @ no.3 += 0x30
STRB R9 , [R0]                        @ [Byteaddress] = no.3 ;
ADD R0 , R0 , R12                     @ [Byteaddress] += 1 ;
MUL R6 , R7 ,R3                       @ (no.3 * expo ) ;   
SUB R1, R1, R6                            
UDIV R3, R3, R4                       @ no.2 = no.2/ d
B GreaterThanZeroWh                    
                                      
EndTheProgram : 
MOV  R11,  0x00                       @ b =  null 
STRB R11 , [R0]                       @ [Byteaddress ] = null ; 
                                      @ } 
End_Main:
  BX    lr

