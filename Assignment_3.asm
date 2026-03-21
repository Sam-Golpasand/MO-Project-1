.ORIG x3000
    AND R0, R0, #0 ; resets R0 to 0
    LD R1, ValueToTest ; load the number to test
    ADD R0, R0, R1 ; add the number thats going to be tested if it is a prime number
    
    JSR isPrime
    ST R0, Result ; See if it stored 1 or 0 in R0, before R0 was reset by HALT comand
    HALT
    
isPrime 
    ST R7, SaveR7 ; Save R7 in case it gets overwritten, so we can return to the main program
    
    ; makes sure it returns false if the number is 0 or 1
    ADD R1, R0, #-2
    BRn returnFalse    ; If R0 is 0 or 1, it's NOT prime.
  
    AND R1, R1, #0 ; reset R1 to 0
    ADD R1, R1, #1 ; insert 1 
nextNumber
    ; see if all posible divisions have been tested
    ADD R1, R1, #1 
    NOT R4, R1
    ADD R4, R4, #1
    AND R6, R6, #0 ; reset R6 to 0
    ADD R6, R6, R0 ; insert R0
    ADD R5, R4, R6
    BRnz returnTrue

    NOT R2, R1 ; used to get negtive value of R1
    ADD R2, R2, #1 ; used to get negtive value of R1
    AND R3, R3, #0 ; reset R3 to 0
    ADD R3, R3, R0 ; copy R0 to R3
    
divisionLoop
    ADD R3, R3, R2
    BRz returnFalse
    BRp divisionLoop
    BR nextNumber
    
    
returnFalse
    AND R0, R0, #0 ;resets R0 to 0
    LD R7, SaveR7 ; Restore the original return address
    RET ; Return from subroutine
    
returnTrue
    AND R0, R0, #0 ;resets R0 to 0
    ADD R0, R0, #1 ; insert 1 into R0
    LD R7, SaveR7 ; Restore the original return address
    RET ; Return from subroutine
    
    
SaveR7 .BLKW 1
ValueToTest .FILL #67
Result .BLKW 1

.END
