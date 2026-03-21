    .ORIG x3000
start
    JSR readS
    JSR isPrime
    JSR resultS
    BR start
    
readS
    ST R7, SaveR7 ; Save R7 in case it gets overwritten, so we can return to the main program
    
    ; prints the saved string to the console
    LEA R0, PromtMsg
    PUTS
    
    GETC    ; reads the first digit into R0
    OUT     ; echoes to the console
    
    ; subtracks 48 from R0 to get the numerical value of R0
    LD R1, NegASCIIOffset
    ADD R2, R0, R1 ;store the numerical value in R2
    
    AND R3, R3, #0 ;Rest R3 to 0
    AND R4, R4, #0 ;Rest R4 to 0
    ADD R3, R3, #10 ; insert number 10 into R3
    
MultiplyLoop
    ADD R4, R4, R2
    ADD R3, R3, #-1
    BRp MultiplyLoop
    
    GETC    ; reads the secound digit into R0
    OUT     ; echoes to the console
    
    ADD R2, R0, R1 ; ;store the numerical value in R2
    
    ADD R0,R2,R4 ; add the two digits together
    
    LD R7, SaveR7 ; Restore the original return address
    RET ; Return from subroutine
    


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

    
    
resultS
    ST R7, SaveR7

    ADD R1, R0, #0 ; add R0 and R1 to see if R0 is set to 0
    BRz notPrime ; if R1 + R0 is zero, branch to the notPrime message
    BR prime ; if R1 + R0 is not zero, branch to the Prime message

prime
    LEA R0, ValueIsZero
    PUTS
    LD R7, SaveR7
    RET
    
notPrime
    LEA R0, ValueIsNotZero
    PUTS
    LD R7, SaveR7
    RET
    
    
    
    
SaveR7  .BLKW 1
PromtMsg    .STRINGZ "\n Input a 2 digit decimal number: "
NegASCIIOffset  .FILL xFFD0  ; xFFD0 is two's complement for -x30 (-48 in decimal)

Result .BLKW 1

ValueIsZero .STRINGZ "\n The number is prime"
ValueIsNotZero .STRINGZ "\n The number is not prime"

.END

