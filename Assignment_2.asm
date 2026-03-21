    .ORIG x3000
    JSR readS
    HALT
    
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
    
    
    
    
    
    
SaveR7  .BLKW 1
PromtMsg    .STRINGZ "Input a 2 digit decimal number: "
NegASCIIOffset  .FILL xFFD0  ; xFFD0 is two's complement for -x30 (-48 in decimal)
.END