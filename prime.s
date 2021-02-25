  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write an ARM Assembly Language Program that will determine
  @   whether the unsigned number in R1 is a prime number
  @
  @ Output:
  @   R0: 1 if the number in R1 is prime
  @       0 if the number in R1 is not prime
  @

  
  @ *** your solution goes here ***

 LDR R6, =2 

 MOV R5, R6                                @random1Number = 2  
                                           @randomNumber = result
 MOV R3, R1                               
 
 CMP R1, #1                                @if (result >2 )
 BLS IfPrime            

 CMP R1, #2
 
 BEQ ElsePrime

 WhilePrime  :      
                                         @ while ( randomNumber > random1Number)
 CMP R3, R5 
 BLO EndWhuP                             @ randomNumber = randomnNumber - random1Number 
 SUB R3,R3,R5 
 B WhilePrime      

 EndWhuP : 

 CMP R3, #0 
 BEQ IfPrime                               @ if ( random == 0 )
 MOV R3, R1                
 ADD R5,R5,#1                               
 CMP R5, R3 
 BEQ ElsePrime 

 B WhilePrime

 ElsePrime :                                 @ else 

 MOV R0, #1                                  @ r = 1 

 B EndIfNotPrime                            

 IfPrime :                                  @ if != prime                     

 MOV R0, #0                                 @ r = 0  

 EndIfNotPrime : 




                                                                                       

  

  @ End of program ... check your result

End_Main:
  BX    lr

.end
