  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

 LDR R8, =0                                                      // row = 0
 LDR R7, =0                                                     // coloumn = 0
 LDR R9, =0                                                     // z = 0//
 LDR R5, =0                                                     // while(z =0 //z <= L - S ;z++)
 LDR R4, =0                                                     // {  = L-S
 SUB R8 , R1, R3                                                 //		n = 0
 compWhile :                                                        // 		while(n = 0// n<= L - S ;n++)
 CMP R7, R8                                                     //		{
 BGT compEndWh                                                   //			row = 0
                                                                //      h_curr =0 
 compWhileB : 
 CMP R9, R8
 BGT compEndWhB                                                   //			while(row<S&&small[row,coloumn]==
                                                                 // big[z + row, n + coloumn])

 compWhileC :                                                        // {
 CMP R5, R3                                                      //				coloumn++;
 BGE compEndWhC 
                                                                	//				if(coloumn==S)
 compWhileD : 
 CMP R4, R3                                                       // { 
 BGE compEndWhD                                                    //					coloumn = 0;
 LDR R6, =0                                                       	//					row++/;
 ADD R6 , R7, R5                                                    // }
 MUL R6, R6 , R1                                                     //				if(row == S)
 ADD R6 , R6, R9                                                      // {
 ADD R6 , R6 , R4                                                     	//					
 LDR R12, [R0 , R6 , LSL #2]
 MUL R6 , R5 , R3                                                      // = 1 
 ADD R6 , R6 , R4                                                      // }  
 LDR  R11, [R2, R6 , LSL #2]                                            // else 
 CMP R12 , R11    
 BNE compEndWhD                                                         // = 0 
 ADD R10 , R10, #1
 MUL R6 , R3, R3
 CMP R10 , R6 
 BGE compEndWh
 ADD R4 , R4 , #1 
 B compWhileD 
 compEndWhD :
 LDR R4 , =0 
 ADD R5, R5 , #1
 B compWhileC
 compEndWhC :
 LDR R10, =0
 LDR R5 , =0
 ADD R9 ,R9, #1 
 B compWhileB
 compEndWhB : 
 LDR R9 , =0
 ADD R7, R7 , #1 
 B compWhile 
 compEndWh :
 MUL R6, R3, R3
 CMP R10 , R6 
 BNE theSame 
 LDR R0 ,=1
 B theDifferent 
 theSame :
 LDR R0 ,=0 
 theDifferent : 
 	                                                                       


							                                                        
								 		                                                  
									 	                                                   
									                                                    	
								                                                         
									                                                   				
								                                                        
										                  




	
	

	

 
  @ End of program ... check your result


End_Main:
BX    lr
 

