
.ORIG x3000

; R0 is the value to check
; R1 is the location of the array
; R2 is the size of the PRIMEARRAY
; R3 is the value of the address at R1
; R4 is the negative of R3


ISPRIME
    LEA R1, PRIMEARRAY
    AND R2, R2, #0
    ADD R2, R2, #15    
    ADD R2, R2, #10 ; number of elements (we do this in 2 because we cant add more than 16 in one immediate opperation.)

    
LOOP 

    ; Load array value
    LDR R3, R1, #0
    NOT R4, R3
    ADD R4, R4, #1
    
    ; Check if they are equal. If so return true, otherwise check the size and loop.
    ADD R5, R0, R4
    
    BRz PRIME
    
    ADD R1, R1, #1
    ADD R2, R2, #-1
    BRp LOOP

NOTPRIME
    AND R0, R0, #0
    BRnzp BREAK


PRIME
    AND R0, R0, #0
    ADD R0, R0, #1


BREAK
    HALT



PRIMEARRAY .FILL #2
      .FILL #3
      .FILL #5
      .FILL #7
      .FILL #11
      .FILL #13
      .FILL #17
      .FILL #19
      .FILL #23
      .FILL #29
      .FILL #31
      .FILL #37
      .FILL #41
      .FILL #43
      .FILL #47
      .FILL #53
      .FILL #59
      .FILL #61
      .FILL #67
      .FILL #71
      .FILL #73
      .FILL #79
      .FILL #83
      .FILL #89
      .FILL #97

.END