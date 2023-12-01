         YREGS
DAY1     CSECT
         STM   R14,R12,12(R13)         
         LR    R12,R15                 
         USING DAY1,R12
         ST    R13,SAVE+4              
         LR    R14,R13
         LA    R13,SAVE               
         ST    R13,8(,R14) 
*     
         OPEN  (IN01,INPUT)
*
IN01READ GET   IN01
         LR    R4,R1 
*
*        PART 1
*        
         TRT   0(255,R4),TRT_TABL 
         STC   R2,FIRST
         
         LA    R5,REVREC 
         MVCIN 0(255,R5),254(R4)
         TRT   0(255,R5),TRT_TABL 
         STC   R2,LAST 
          
         PACK  DECDIGIT,DIGITS
         AP    SUM,DECDIGIT
         
         B     IN01READ
*                
CLEANUP  EQU   *
         CLOSE IN01
         UNPK  WTOTEXT,SUM
         OI    WTOTEXT+10,X'F0'
         BAL   R3,WTOROUT
RETURN   L     R13,SAVE+4             
         LM    R14,R12,12(R13)         
         LA    R15,0                  
         BR    R14
*
WTOROUT  EQU   *
         WTO   MF=(E,WTOBLOCK)
         BR    R3
*
IN01     DCB   DDNAME=INPUT,DSORG=PS,MACRF=GL,RECFM=FB,LRECL=255,      -
               EODAD=CLEANUP
         LTORG
SAVE     DC    18F'0'
WTOBLOCK EQU   *
         DC    H'22'
         DC    H'0' 
         DC    C'PART1: '
WTOTEXT  DC    CL11' '
*
DECDIGIT DS    PL3
DIGITS   DS    0XL2
FIRST    DS    XL1
LAST     DS    XL1
REVREC   DS    CL255
SUM      DC    PL6'0'
TRT_TABL DC    256X'00'
         ORG   TRT_TABL+C'1'
         DC    C'123456789'
	     ORG   ,
         END