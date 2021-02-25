  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @
  LDR R11, = 0x7A                    @ = z
  LDR R10, = 0x5A                    @ = Z
  LDR R9 , = 0x41                    @ = A
  LDR R8 ,= 0x61                     @ = a
  LDR R6, = 0                        @c = 0 
  LDR R7, = 1                        @b = 1
  LDRB R5, [R1]                      @ch = [byteaddress]
  MOV R4 ,R6                         @previousch = c ; 
  WhileNotEqZ :  
  CMP R5, R6                         @ While (ch!= c )
  BEQ FinishTheProgram               @ { 

  CMP R4 , R8                     @ if (previouschar > 'z') 
  BLO IfGreOrLessaz                  @ || previouschar < 'a'    
  CMP R4, R11
  BLO ElseNotaz 
  IfGreOrLessaz : 
  CMP R4 ,R9                         @ if previouschar > 'Z'  
  BLO IfNotNAZ                       @  || previouschar < 'A'
  CMP R4 , R10
  BLO ElseNotaz
  IfNotNAZ : 
  CMP R5 ,R8                          @ if ((char > 'z) 
  BLO ElseNotAZ                       @ ||(char < 'a')) 
  CMP R5, R11
  BHI ElseNotAZ                       @ASCIICONVERT
  SUB R5, R5, 0x20                    @ char = char - c
  B ElseNotAZ

  ElseNotaz :
  CMP R5, R9                          @ else if ((char < 'Z')
  BLO ElseNotAZ                       @ && char > 'A'))
  CMP R5, R10
  BHI ElseNotAZ                      @ASCIICONVERT
  ADD R5, R5, 0x20                   @ char = char + a

  ElseNotAZ :
  MOV R4, R6                        @previouschar = c ; 
  ADD R4, R4, R5                    @previouschar = previous char + newchar 
  STRB R5, [R1]                     @ byteaddress = ch
  ADD R1 , R1, R7                   @ byteaddress = byteaddress + b
  LDRB R5, [R1]                     @ char = [byteaddress]
  
  B WhileNotEqZ                     @ ch =0 
  
  FinishTheProgram :                @ done 
 
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

End_Main:
  BX    lr

