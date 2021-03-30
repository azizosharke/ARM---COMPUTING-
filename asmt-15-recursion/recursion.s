  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   quicksort
  .global   partition
  .global   swap

@ quicksort subroutine
@ Sort an array of words using Hoare's quicksort algorithm
@ https://en.wikipedia.org/wiki/Quicksort 
@
@ Parameters:
@   R0: Array start address
@   R1: lo index of portion of array to sort
@   R2: hi index of portion of array to sort
@
@ Return:
@   none
quicksort:
  PUSH    {R4-R7,LR}                 @ add any registers R4...R12 that you use
  MOV R4, R0
  MOV R5, R1
  MOV R6,R2                                   @ *** PSEUDOCODE ***              
  CMP R5,R6                          @ if (lo < hi) { // !!! You must use signed comparison (e.g. BGE) here !!!
  BGE endIfBigger                    @   p = partition(array, lo, hi);
  MOV R0,R4
  MOV R1,R5                          @   quicksort(array, lo, p - 1);
  MOV R2,R6                          @   quicksort(array, p + 1, hi);
  BL partition 
  MOV R7, R0                         @}
  MOV R0,R4
  MOV R1,R5
  SUB R2,R7,#1
  BL quicksort 
  MOV R0,R4
  ADD R1,R7,#1
  MOV R2,R6
  BL quicksort
  endIfBigger : 

  POP     {R4-R7,PC}                      @ add any registers R4...R12 that you use


@ partition subroutine
@ Partition an array of words into two parts such that all elements before some
@   element in the array that is chosen as a 'pivot' are less than the pivot
@   and all elements after the pivot are greater than the pivot.
@
@ Based on Lomuto's partition scheme (https://en.wikipedia.org/wiki/Quicksort)
@
@ Parameters:
@   R0: array start address
@   R1: lo index of partition to sort
@   R2: hi index of partition to sort
@
@ Return:
@   R0: pivot - the index of the chosen pivot value

partition:
PUSH    {R4-R7,R9-R10,LR}                  @ add any registers R4...R12 that you use
MOV R9,R0
MOV R5,R1                                   @ i = lo;
MOV R10,R2
LDR R4,[R9,R10,LSL #2]                        @ pivot = array[hi]; 
MOV R6,R5                                @ for (j = lo; j <= hi; j++) {
ForPartition :                           @   if (array[j] < pivot) {
CMP R6,R10                                @     swap (array, i, j);
BGT endForPartition                              @     i = i + 1;
LDR R7,[R9,R6,LSL #2]                             @   }   
CMP R7,R4                                        @ }
BGE endIf                                        @ swap(array, i, hi);
MOV R0,R9                                        @ return i;
MOV R1,R5
MOV R2,R6
BL swap
ADD R5,R5,#1 
endIf :
ADD R6,R6,#1
B ForPartition
endForPartition :
MOV R0,R9
MOV R1,R5
MOV R2,R10
BL swap
MOV R0,R5




 POP  {R4-R7,R9-R10,PC}                        @ add any registers R4...R12 that you use

@
@ your implementation goes here
@
@ swap subroutine
@ Swap the elements at two specified indices in an array of words.
@
@ Parameters:
@   R0: array - start address of an array of words
@   R1: a - index of first element to be swapped
@   R2: b - index of second element to be swapped
@
@ Return:
@   none
swap:
 PUSH    {R4, LR}
    LDR        R3, [R0, R1, LSL#2]
    LDR        R4, [R0, R2, LSL#2]
    STR        R4, [R0, R1, LSL#2]
    STR        R3, [R0, R2, LSL#2]
    POP        {R4, PC}
  @
  @ your implementation goes here
  @

  POP     {R4,PC}                       @ add any registers R4...R12 that you use


.end