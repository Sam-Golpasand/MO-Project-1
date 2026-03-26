.ORIG x3000

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
    AND r0, r0, #0
    JSR break

prime
    AND r0, r0, #0
    ADD r0, r0, #1

break
    HALT

.END