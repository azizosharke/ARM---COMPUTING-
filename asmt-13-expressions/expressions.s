  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @ 
 LDR R0,= 0                           // count = 0; 
 LDR R4, =0                            // mainCh = 0 ;      
 LDR R6, =0                            // previousCh =0 ;
 LDR R8 , =0                           // previousNumber = 0;
 LDR R7 , =10                         // testCh =0 ; 

 While  :                              // while ( mainCh!=NULL) {
 LDRB R4, [R1] , #1                   // mainCh = address[index+]
 CMP R4, #0x00                          // 
 BEQ EndWhile                       // {
 CMP R4, #0x30                      // if ( mainCh >= '0' 
                                     // && mainCh <= '9')
 BLO ifCh                           // {
 CMP R4 , #0x39
 BHI ifCh     
 SUB R4, R4, #0x30                  // mainCh-=0x30 
 MOV R5, #0                         // testCh = 0;
 ADD R5, R5, R4                     // testCh = mainCh ; 
 CMP R6, #0                          // if ( prevCH >= 0 
                                    //&& prevCH <=9)
 BLO testForMulti                        //{
 CMP R6 , #9                         //
 BHI testForMulti                        // 
 LDR R8, [R12], #4                  // previousNumber = stack[pop]
 MUL R8,R8, R7                    // previousNumber*=10
 ADD R4, R4, R8                    // mainCh = previousNumber
 testForMulti :                    // }
 STR R4, [R12, #-4]!                // stack[push] =mainCh
 B EndIfs 
 ifCh :
 LDR R5, =10                       // else if ( mainCh == '+')
 CMP R4, #0x2B                     // {
 BNE ifPlus 
 LDR R6, [R12], #4                 // chB = stack[pop]
 LDR R8, [R12], #4                // ch3 = stack [pop]
 ADD R4, R6, R8                  // mainCh = mainCh 1 + mainCh 2
 STR R4 ,[R12, #-4]!             // stack [push ]  = mainCh ; 
 B EndIfs

 ifPlus :                         // else if ( mainCh == '-')
 CMP R4, #0x2D                     // {
 BNE ifMinus 
 LDR R6, [R12], #4                // chB = stack[pop]
 LDR R8 , [R12] , #4              // chA = stack[pop]
 SUB R4, R8 , R6                  // mainCh = chA - chB
 STR R4, [R12, #-4]!              // stack[push] = mainCh 
 B EndIfs

 ifMinus :
 CMP R4, #0x2A                 // else if ( mainCh == '*')
 BNE EndIfs                     // {
 LDR R6, [R12], #4             // chB = stack[pop]
 LDR R8, [R12], #4            // chA = stack[pop]
 MUL R4, R6, R8               // mainCh = chA*chB
 STR R4, [R12, #-4]!          // stack[push]  = mainCh
 EndIfs :
 MOV R6, R5                   // previousCh = testCh
 B While                        // 
 EndWhile :                     // } 
 LDR R0 , [R12]                  // pop {R0}
                                 // }


  
 
  @ You can use either
  @
  @   The System stack (R4/SP) with PUSH and POP operations
  @
  @   or
  @
  @   A user stack (R12 has been initialised for this purpose)
  @


  @ End of program ... check your count

End_Main:

  BX    lr

