  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
 
	
    CMP	R2, R1			              // if (fromIndex < toIndex)
	BHS	indexChange			  
	LDR	R9, [R0, R1, LSL #2]	      //storage = [startAddress+(toIndex]//
	MOV	R8, R2	                     //testIndex = fromIndex//
whileLoopA :	
	CMP	R8, R1			            //	while(testIndex<=toIndex)
	BHI	TestB			
	LDR	R7, [R0, R8, LSL #2]	      //		storageA = [startAddress+(testIndex)]//
	STR	R9, [R0, R8, LSL #2]	      //		storage =[startAddress+(testIndex*4)] 
	MOV	R9, R7			              //		storage = storageA//
	ADD	R8, R8, #1		              //		testIndex++//
	B	whileLoopA			          //	}	
					                  // }
					
indexChange	:
    CMP	R2, R1			            // else if (fromIndex > toIndex)
	BLS	TestA		
	LDR	R9, [R0, R1, LSL #2]	       //	storage = [startAddress+(toIndex*4)]//
	MOV	R8, R2	               //	testIndex = fromIndex//
whileLoopB	:
	CMP	R8, R1			                 //	while(testIndex>=toIndex)
	BLT	TestB			
	LDR	R7, [R0, R8, LSL #2]	 //		storageA =[startAddress+(testIndex)]//
	STR	R9, [R0, R8, LSL #2]	 //		storage = [startAddress+(testIndex)] 
	MOV	R9, R7		           	//		storage = storageA//
	SUB	R8, R8, #1		       //		testIndex--//
	B	whileLoopB		      //	}
					         // }
TestA :			
TestB :

	


	
	
	






	
  

  @ End of program ... check your result

					
End_Main:
  BX    lr

