  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
// R0 = addresaA      
// R2 = addressB                                                
// R1 = largeSize                             
// R3 = smallSize      
LDR R8,=0                         // index =0              
SUB R8 , R1, R3                   // index = largeSzie - smallSize                        
compWhile :                       // while ( countA <= countB)                                
CMP R7, R8                        // {                             
BGT compEndWh                                               
                                                                
compWhileB :                     // while ( countC <= countD)
CMP R9, R8
BGT compEndWhB                   // {                               
                                                                 

 compWhileC :                    // while ( countE < smallSize )                                           
 CMP R5, R3                                                   
 BGE compEndWhC                  // {
                                                                	
 compWhileD :                    // while ( countF < smallSize)
 CMP R4, R3                                                     
 BGE compEndWhD                  // {                                 
 LDR R6, =0                      // ( indexA = 0 )                                
 ADD R6 , R7, R5                 // indexA = countA +countE                                    
 MUL R6, R6 , R1                 // indexA = indexA * largeSize                                    			
 ADD R6 , R6, R9                 // indexA = indexA +countC                                       
 ADD R6 , R6 , R4                // indexA = indexA + countF                                     	
 LDR R12, [R0 , R6 , LSL #2]     // indexB = addressA[indexA]
 MUL R6 , R5 , R3                // indexA = indexA * smallSize                                     
 ADD R6 , R6 , R4                // indexA = indexA + countF                                      
 LDR  R11, [R2, R6 , LSL #2]     // indexC = addressB[indexA]                                         
 CMP R12 , R11                   //if indexB != indexC
 BNE compEndWhD                  // {                                           
 ADD R10 , R10, #1               // iOne =iOne +1
 MUL R6 , R3, R3                 // indexA = indexA*smallSize
 CMP R10 , R6                    // if iOne <=indexA
 BGE compEndWh                   // {
 ADD R4 , R4 , #1                // countF = countF +1
 B compWhileD                    // }
 compEndWhD :                    // { 
 LDR R4 , =0                     // countF = 0 ;
 ADD R5, R5 , #1                 // countE = countE +1
 B compWhileC                    // }
 compEndWhC :                    // {
 LDR R10, =0                     // iOne = 0 
 LDR R5 , =0                     // countE =0
 ADD R9 ,R9, #1                  // countC = countC +1
 B compWhileB                    // }
 compEndWhB :                    // {
 LDR R9 , =0                     // countC = 0
 ADD R7, R7 , #1                 // countA = countA +1
 B compWhile                     // }
 compEndWh :                     // {
 MUL R6, R3, R3                  // indexA = indexA*smallSize
 CMP R10 , R6                    // if iOne != indexA
 BNE theSame                     // {
 LDR R0 ,=1                      // addressA =0 
 B theDifferent                  // }
 theSame :                       // { else 
 LDR R0 ,=0                      // addressA = 1 
 theDifferent :                  // }
 
 	                           
         

							                                                        
								 		                                                  
									 	                                                   
									                                                    	
								                                                         
									                                                   				
								                                                        
										                  




	
	

	

 
  @ End of program ... check your result


End_Main:
BX    lr
 

