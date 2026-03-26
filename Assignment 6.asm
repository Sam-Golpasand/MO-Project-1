.ORIG x3000


main
    JSR readS
    JSR isPrime
    BRnzp main
 ; Since this is an infinite loop we dont need a HALT. Another implementation
 ; could add a listiner for 'q' or something else to quit the infinite loop.

; R0 is both for the result and the initialization message.
; R1 is mostly for the newline and ascii value offset calulations
; R2-R5 are used for calculations

readS
    ; prints the init message
    LEA R0, MESSAGE
    PUTS

    ; Remember to reset register 3 since we use it as a temp register
    AND R3, R3, #0

readLoop
    GETC
    OUT

    ; Check for enter key
    LD R1, NEWLINE
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    BRz done

    ; Convert ASCII to digit
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1      ; R2 is now the digit for the ASCII

    ; Multiply R3 by 10
    ADD R4, R3, R3      ; 2x
    ADD R5, R4, R4      ; 4x
    ADD R5, R5, R5      ; 8x
    ADD R4, R4, R5      ; 2x + 8x = 10x

    ; Add digit
    ADD R3, R4, R2

    BRnzp readLoop

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
ASCII0  .FILL x0030

ISPRIMEMESSAGE .STRINGZ "\nThe number is prime"
ISNOTPRIMEMESSAGE .STRINGZ "\nThe number is not prime "

NEWLINE .FILL x0A


.END