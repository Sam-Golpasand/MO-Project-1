.ORIG x3000


main
    JSR readS
    JSR isPrime
    BRnzp main

HALT

; R0 is both for the result and the initialization message.
; R1 is mostly for the newline and ascii value offset calulations
; R2-R5 are used for calculations
; R6 is used to check the number of digits

readS
    ; prints the init message
    LEA R0, MESSAGE
    PUTS

    ; Remember to reset register 3 since we use it as a temp register
    AND R3, R3, #0
    
    ; And we use Register 6 for the digit tracker.
    AND R6, R6, #0
    ADD R6, R6, #6

readLoop
    ADD R6, R6, #-1
    BRn lengthWarning

    GETC
    OUT
    

    ; Check ENTER
    LD R1, NEWLINE
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    BRz done
    
    ; Check if R0 less than '0'
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    BRn illegalInputWarning
    
    ; Check if R0 bigger than '9'
    LD R1, ASCII9
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    BRp illegalInputWarning

    ; Convert ASCII to digit
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1      ; R2 is now the digit

    ; Multiply R3 by 10
    ADD R4, R3, R3      ; 2x
    ADD R5, R4, R4      ; 4x
    ADD R5, R5, R5      ; 8x
    ADD R4, R4, R5      ; 2x + 8x = 10x

    ; Add digit
    ADD R3, R4, R2

    BRnzp readLoop

lengthWarning
    LEA R0, INPUTLENGTHWARNING
    PUTS
    RET
    
illegalInputWarning
    LEA R0, INPUTTYPEWARNING
    PUTS
    RET

done
    ; Move the result to R0 and return
    ADD R0, R3, #0
    RET


; R0 is the value to check
; R1 is the number we are dividing with
; R2 is temp
; R3 is the negative of R1
; R5 is for comparisons

isPrime
    ; If the user input is less than 2 go to not prime
    ADD R1, R0, #-2
    BRn notPrime

    AND R1, R1, #0
    ADD R1, R1, #2

outerLoop
    ; If the divisor is equal to the value we are checking then go to prime
    NOT R5, R1
    ADD R5, R5, #1
    ADD R5, R0, R5
    BRz prime

    ; make the temp into the value being checked so we can perform operations on it
    ADD R2, R0, #0

    ; Get the negative divisor
    NOT R3, R1
    ADD R3, R3, #1

innerLoop
    ; Check if the current number is divisable by the divisor
    ADD R2, R2, R3

    BRz notPrime        ; If it divides to 0 then its not prime
    BRn nextDivisor          ; If we went negative then we try to divide with the next divisor
    BRp innerLoop ; Otherwise we repeat until we reach 0 or negative number

nextDivisor
    ADD R1, R1, #1
    BRnzp outerLoop
    
notPrime
    LEA R0, ISNOTPRIMEMESSAGE
    PUTS
    RET

prime
    LEA R0, ISPRIMEMESSAGE
    PUTS
    RET



MESSAGE .STRINGZ "\nInput a 2 digit decimal number:"


INPUTLENGTHWARNING .STRINGZ "\nYou can only input a number up to 5 digits"

ASCII0  .FILL x0030
ASCII9  .FILL x0039

ISPRIMEMESSAGE .STRINGZ "\nThe number is prime"
ISNOTPRIMEMESSAGE .STRINGZ "\nThe number is not prime "

INPUTTYPEWARNING .STRINGZ "\nYou can only write a number between the digits 0-9"

NEWLINE .FILL x0A


.END