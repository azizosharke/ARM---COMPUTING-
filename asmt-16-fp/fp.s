  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   fp_exp
  .global   fp_frac
  .global   fp_enc



// fp_exp subroutine
// Obtain the exponent of an IEEE-754 (single precision) number as a signed
//   integer (2's complement)
//
// Parameters:
//   R0: IEEE-754 number
//
// Return:
//   R0: exponent (signed integer using 2's complement)
fp_exp:

 PUSH    {R4-R5, LR}                      // add any registers R4...R12 that you use
  MOV   R4, R0                            // create a mask to f and s and move e into last 8 bits  to return r+127
  LDR   R5, =0x7F800000                   // create the mask
  AND   R4, R4, R5                       // mask to f and s 
  MOV   R4, R4, LSR #23                  // shift by 23 bit shift 
  SUB   R0, R4, #127                     // return the value e + 127 
  POP     {R4-R5, PC}                      // add any registers R4...R12 that you use
 

// fp_frac subroutine
// Obtain the fraction of an IEEE-754 (single precision) number.
//
// The returned fraction will include the 'hidden' bit to the left
//   of the radix point (at bit 23). The radix point should be considered to be
//   between bits 22 and 23.
//
// The returned fraction will be in 2's complement form, reflecting the sign
//   (sign bit) of the original IEEE-754 number.
//
// Parameters:
//   R0: IEEE-754 number
//
// Return:
//   R0: fraction (signed fraction, including the 'hidden' bit, in 2's
//         complement form)
 fp_frac:

 // clear bit 1 - bit 9
 // mask to clear bits 
 // set hidden bit to 1 
 // If the signed bit is 1 then negate the fraction 
PUSH    {R4-R9, LR}                      @ add any registers R4...R12 that you use
  MOV R6,#1
  MOV R4, R0

  MOV R7, R0

  LDR R9, =0                                @ negativeFractionBoolean = 0
ifFracNeg:
  MOVS R4, R4, LSL R6                       @ shift IEEE-754 number 1 space to the left
  BCC endIfFracNeg
  ADD R9, R9, #1                            @ negativeFractionBoolean = negativeFractionBoolean + 1
endIfFracNeg:
  LDR R5, =0x7FFFFF
  AND R7, R7, R5                            @ get fraction by itself (clear bits 23 - 31 (24th to 32nd bit))
  LDR R8, =0x800000
  ORR R7, R7, R8                            @ set hidden bit to 1 (set bit 23 (24th bit) of IEEE-754 number)
ifNegOne:
  CMP R9, #1
  BNE endIfNegOne
  NEG R7, R7
endIfNegOne:

  MOV R0, R7

  POP     {R4-R9, PC}                      @ add any registers R4...R12 that you us
// fp_enc subroutine
// Encode an IEEE-754 (single precision) floating point number given the
//   fraction (in 2's complement form) and the exponent (also in 2's
//   complement form).
//
// Fractions that are not ifNormalisied will be ifNormalisied by the subroutine,
//   with a corresponding adjustment made to the exponent.
//
// Parameters:
//   R0: fraction (in 2's complement form)
//   R1: exponent (in 2's complement form)
//
// Return:
//   R0: IEEE-754 single precision floating point number

fp_enc:

// if the fraction negative     
// set the singed bit to 1 
// negate the fraction 
// normalise 
// test for the fraction is already by couting the leading 0 (CLZ)
// either = 8 , <8 , >8
// = 8 it is normalized 
// less than 8 , shift LSR by 8-n bits n = CLZ , then add 8-n to the exponent 
// more than 8 , shift the LSL BY n-8 bits and sub n-8 to exponent 
// hid the hidden bit by BIC 
// add 127 to the exponent 
// shift the exponent left by 23 bits 
// merge sign exponent and fraction into a single 32 bit value 
  PUSH  {R4-R11, LR}                  // ...   
  MOV R11,#8                                           
  MOV   R4, R0                        // fracTest = fraction;                    
  MOV   R5, R1                        // expTest = exponent;                    
  MOV   R8, #0                        // sign = 0;                    
  CMP   R4, #0                        // if (fracTest < 0)                    
  BPL   ifNegA                       // {                    
  LDR   R8, =0x80000000               //   sign = 0x80000000;                          
  NEG   R4, R4                        //   fracTest *= -1;             
                                      // }     
 ifNegA  :                              // ...  
  CLZ   R6, R4                        // 0'sCount = countLeadingZeros(fracTest);                 
  CMP   R6, R11                        // if (0'sCount != 8)                    
  BEQ   ifNorm                    // {                        
  CMP   R6, R11                        //   if (0'sCount < 8)                 
  BGT   ifGreater                       //   {                  
  RSB   R6, R6, R11                    //     0'sCount = 8 - 0'sCount;                  
  MOV   R4, R4, LSR R6                //     fracTest = LSR(fracTest, 0'sCount);                        
  ADD   R5, R6                        //     expTest += 0'sCount;               
  B     ifNorm                    //   }  
 ifGreater :                              //   else {           
  SUB   R6, R6, R11                    //     0'sCount = 0'sCount - 8;                
  MOV   R4, R4, LSL R6                //     fracTest = LSL(fracTest, 0'sCount);                       
  SUB   R5, R6                        //     expTest -= 0'sCount; }
                                      // }              
 ifNorm :                           // ...              
  LDR   R9, =0x00800000               // mask = 0x00800000;                            
  BIC   R4, R4, R9                    // fracTest = BIC(fracTest, mask);                       
  ADD   R5, #127                      // expTest += 127;                      
  MOV   R5, R5, LSL #23               // expTest = LSL(expTest, 23);                            
  ADD   R10, R4, R5                   // float = fracTest + expTest;                        
  ADD   R7, R10, R8                   // return float + sign; 
  MOV   R0,R7                       
  POP   {R4-R11, PC}                  // ...  
 
.end