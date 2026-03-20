.ORIG x3000


; Immediately jump to the readS function
MAIN
    JSR readS
    JSR ISPRIME
    BRnzp MAIN

HALT

readS
    ; Print the start message
    LEA R0, MESSAGE
    PUTS
    
    ; Get the first number from console
    GETC
    OUT
    
    ; Convert from ASCII to number by taking value for "0" and getting its negative and 
    ; taking it from the ASCII value of the character to get the number (e.g x0035 - x0030 = x0005 = 5);
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    
    ; multiply by 10 by adding itself 10 times since it is base 10
    ADD R3, R2, R2 ; 2x r2
    ADD R4, R3, R3 ; 4x r2
    ADD R4, R4, R4 ; 8x r2
    ADD R3, R3, R4 ; 2x + 8x = 10x r2
    
    ; Get the second character from console and repeat the ASCII conversion from before.
    GETC
    OUT
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    
    ; add the 2 numbers and insert into register 0
    ADD R0, R3, R2
    
    RET


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
    LEA R0, ISNOTPRIMEMESSAGE
    PUTS
    RET

PRIME
    LEA R0, ISPRIMEMESSAGE
    PUTS
    RET



MESSAGE .STRINGZ "\nInput a 2 digit decimal number:"
ASCII0  .FILL x0030

ISPRIMEMESSAGE .STRINGZ "\nThe number is prime"
ISNOTPRIMEMESSAGE .STRINGZ "\nThe number is not prime "

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