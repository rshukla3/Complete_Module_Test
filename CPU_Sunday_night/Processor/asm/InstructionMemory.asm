LLW R1 0x1001 ;
LLW R2 0x8003 ;
LLW R3 0x8005 ;
LLW R4 0x8007 ;
LLW R5 0x8009 ;
LLW R6 0x800B ;
LLW R7 0x800D ;
LLW R8 0x800F ;

ADD R3 R1 R2 ;
SUB R4 R1 R2 ;
LLW R5 0xABCD ;
LHW R6 0xABCD ;
AND R7 R1 R2 ;
OR  R8 R1 R2 ;
XOR R3 R1 R2 ;
NOT R4 R2 ;
SLL R5 R1 8 ;
SRL R6 R2 1 ;
SRA R7 R2 1 ;

AND R8 R1 R3 ;
B EQ 0x000003 ;
MULT R3 R1 R2 ;
CALL 0x0021 ;
ADD R0 R0 R0 ;
CALL 0x8000 ;

LLW R1 0x0001 ;
LLW R2 0x0003 ;
LLW R3 0x0005 ;
LLW R4 0x0007 ;
LLW R5 0x0009 ;
LLW R6 0x000B ;
LLW R7 0x000D ;
LLW R8 0x000F ;

ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
HALT ;

LLW R1 0x1001 ;
LLW R2 0x0007 ;
LLW R3 0x0006 ;
LLW R4 0x0005 ;
LLW R5 0x0004 ;
LLW R6 0x0003 ;
LLW R7 0x0002 ;
LLW R8 0x0001 ;

STORE R1 R2 0x0FF9 ;
LOAD R3 R2 0xFF9 ;

RET ;

ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
ADD R0 R0 R0 ;
HALT ;
