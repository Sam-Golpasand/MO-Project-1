
.ORIG x3000

LD R0, A ; Lower number
LD R1, B ; Upper number

X
    ; Check if A - B is zero. If so, break to DONE
    NOT R2, R0
    ADD R2, R2, #1
    ADD R2, R2, R1
    BRz DONE
    
    ; De/increment both A and B
    ADD R1, R1, #-1
    ADD R0, R0, #1

    BRNZP X


DONE ST R1, C ; Store the midpoint in C

TRAP x25

A .BLKW 1
B .BLKW 1
C .BLKW 1

.END


