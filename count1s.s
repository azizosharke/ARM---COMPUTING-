  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  
  @
  @ write your program here
  @
MOV R0 , #0                              @ value =0 
MOV R3 , #0                              @ result = 0 ; 
MOV R4 , #0                              @ onesRow = 0 ; 
MOV R5 , #32                             @ b = 32
MOV R6 , #1

For :                                    @ for ( result = 0 ; result < 32 ; result ++)
CMP R3 , R5
BHS EndFor 
MOVS R1 ,R1, LSL R6                     @ ( shift the bits to the left )
BCC ElseIf                              @ { if ( BSS) {
ADD R4, R4, R6                          @ onesRow = onesRow + 1
 
ElseIf :                                @ else if {
BCS EndIf                               @ if ( onesRow > value )
CMP R4, R0                               
BLE EndIf2 
MOV R0 , #0                             @ value = 0 ;
ADD R0, R0, R4                          @ value = value + onesRow
EndIf2 :  
MOV R4, #0                              @ onesRow = 0 ;
EndIf :
ADD R3, R6                              @ result = result + 1 ; 
B For 
EndFor : 
CMP R4, R0                              @ if ( onesRow > value )
BLE End 
MOV R0 ,#0                              @ value = 0 ; 
ADD R0,R0, R4                           @ value = value + onesRow 
End : 

  @ End of program ... check your result

End_Main:
  BX    lr

.end
