
.ORIG x3000

LD R0, A ; Lower number
LD R1, B ; Upper number

X
    NOT R2, R0
    ADD R2, R2, #1
    ADD R2, R2, R1 ; Add R1 to R2 and store in R2   
    BRz DONE
    
    ADD R1, R1, #-1 ; Remove 1 from R1 
    ADD R0, R0, #1

    BRNZP X

DONE ST R1, C

TRAP x25

A .BLKW 1
B .BLKW 1
C .BLKW 1

.END


