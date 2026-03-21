    .ORIG x3000
    AND R0, R0, #0 ; clear R0
    ADD R0, R0, #1 ; add a number, so functionality can be tested
    JSR resultS
    HALT
    
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
    
    
ValueIsZero .STRINGZ "The number is prime"
ValueIsNotZero .STRINGZ "The number is not prime"
SaveR7 .BLKW 1
.END