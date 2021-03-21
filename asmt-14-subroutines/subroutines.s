  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global  get9x9
  .global  set9x9
  .global  average9x9
  .global  blur9x9


@ get9x9 subroutine
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@
@ Return:
@   R0: element at row r, column c
Main : 

get9x9:
  PUSH    {R9-R10,LR}                      @ add any registers R9...R12 that you use
  MOV R9, R0                                // index = address 
  LDR R10, =9                              // count = 9 
  MUL R9, R1, R10                         // index* row*count
  ADD R9, R9, R2                         // count = count + coloumn
  LDR R0 , [R0, R9 , LSL #2]            // address = [address + index ]
  POP   {R9-R10, PC}                      @ add any registers R9...R12 that you use  
@ set9x9 subroutine
@ Set the value of the element at row r, column c of a 9x9
@   2D array of word-size values stored using row-major
@   ordering.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: value - new word-size value for array[r][c]
@
@ Return:
@   none
set9x9:
  PUSH    {R7-R8,LR}                      @ add any registers R9...R12 that you use
  MOV R7,#9                              //index = 9 
  MUL R8,R7,R1                         // index* row*count
  ADD R8, R8, R2                         // count = count + coloumn
  STR R3, [R0, R8, LSL #2]
  POP   {R7-R8, PC}                      @ add any registers R9...R12 that you use  
@ average9x9 subroutine
@ Calculate the average value of the elements up to a distance of
@   n rows and n columns from the element at row r, column c in
@   a 9x9 2D array of word-size values. The average should include
@   the element at row r, column c.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: n - element radius
@
@ Return:
@   R0: average value of elements
average9x9:
PUSH  {R4-R11,LR}                      @ add any registers R9...R12 that you use
 
  MOV R11, R0                          // tempaddress = address
  MOV R10, #0                           // rowCompare = 0 
  MOV R4, #0                           // columnCompare = 0
  MOV R5, #0                           // elementA = 0
  MOV R6, #0                           // elementB = 0 
  ADD R7 , R1, R3                      // rowSize = r+n

  CMP R7, #8                          // if ( rowSize > 8)
  BLS ifEqual                           //{
  MOV R7, #8                           // rowSize = 8
  ifEqual :                            // }
  
  ADD R8, R2, R3                      // columnSize = c+n
  CMP R8, #8                          // if ( columnSize > 8)
  BLS ifEqualA 
  MOV R8, #8                          // columnSize =8
  ifEqualA :

  CMP R1,R3                           // if ( r<n)
  BHS ifGreater 
  MOV R10 , #0                         // rowCompare = 0 
  B ifElse                            // }
  ifGreater :                          // }
  SUB R10 , R1, R3                     // rowCompare = r-n
  ifElse :                            // }
 

  CMP R2,R3                           // if ( c<n)
  BHS ifGreaterA 
  MOV R4 , #0                         // columnCompare = 0 
  B ifElseA                            // }
  ifGreaterA :                          // }
  SUB R4 , R2, R3                     // columnCompare = c-n
  ifElseA :                            // }
  


  MOV R9, R4                          // tempCAddress = columnCompare 
  ForAverageA :                      // for ( rowCompare ; rowCompare <= rowSize ; rowCompare ++ ) {
  CMP R10 , R7                       // rowCompare <= rowSize
  BHI averageA                      // columnCompare = tempColumnStart 
  MOV R4, R9                        // for ( columnCompare ; columnCompare <=columnSize ; ColumnStart ++)
  ForAverageB :                     // columnCompare <= columnSize
  CMP R4, R8 
  BHI averageB                     
  MOV R2, R4                        // c = columnCompare 
  MOV R1, R10                       // r = rowCompare
  MOV R0 , R11                     // address = array start address 
  BL get9x9                       // get9x9()
  ADD R5, R5, R0                 // elementA = elementA + address
  ADD R6, R6 , #1                // elementB ++
  ADD R4, R4, #1                // columnCompare ++
  B ForAverageB               // }
  averageB :                  // rowCompare ++
  ADD R10 , R10 , #1         // }
  B ForAverageA 
  averageA : 
  UDIV R0 , R5, R6        //  address = elementA % elementB 

POP {R4-R11,PC}                      @ add any registers R9...R12 that you use



@ blur9x9 subroutine
@ Create a new 9x9 2D array in memory where each element of the new
@ array is the average value the elements, up to a distance of n
@ rows and n columns, surrounding the corresponding element in an
@ original array, also stored in memory.
@
@ Parameters:
@   R0: addressA - start address of original array
@   R1: addressB - start address of new array
@   R2: n - radius
@
@ Return:
@   none

blur9x9:

 PUSH {R4-R10,LR}                         @ add any registers R9...R12 that you use
  MOV R9, #1                              // = 1
  MOV R10, #9                             // = 9
  MOV R4, R0                             // tempAddress = addressA
  MOV R5, R1                             // tempAddressB = addressB
  MOV R6, R2                             // radius =  n
  MOV R7, #0                             // row = 0
  forBlurA :                           // for ( row =0 ; r <9 ; row++)
  CMP R7, R10                            // {
  BHS endForBlurB                      //
  MOV R8 ,#0                             // column = 0
  forBlurB :                          // for ( column =0 ; column <9 ; column++)
  CMP R8, R10                             // {
  BHS endForBlurA                     //
  MOV R0, R4                             // address = tempAddress
  MOV R1, R7                             // r = row 
  MOV R2, R8                             // c = column
  MOV R3, R6                             // n = radius
  BL average9x9                          // average9x9
  MOV R3, R0                             // n = addressA
  MOV R1, R7                             // r = row 
  MOV R2, R8                             // c = count
  MOV R0 ,R5                             // address = tempAddressB
  BL set9x9                              // set9x9
  ADD R8, R8, R9                         // c ++
  B forBlurB                          //
  endForBlurA :                       // }
  ADD R7, R7, R9                         // r ++
  B forBlurA                        //
  endForBlurB :                        // }
  POP {R4-R10, PC}                     @ add any registers R9...R12 that you use


 
  

  





  
  
                   
 

.end