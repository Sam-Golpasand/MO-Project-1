.ORIG x3000

resultS 
    AND R0, R0, #0
    ADD R0, R0, #1 ; We test for if it is not prime (change to 1 for is prime)
    BRz NOTPRIME

ISPRIME
    LEA R0, ISPRIMEMESSAGE ; Load message and print
    PUTS
    JSR BREAK ; Here we jump to the break subroutine

NOTPRIME
    LEA R0, ISNOTPRIMEMESSAGE
    PUTS    ; Note that we dont jump to the break routine since it is the next in the operation.

BREAK
    HALT

ISPRIMEMESSAGE .STRINGZ "The number is prime \n"
ISNOTPRIMEMESSAGE .STRINGZ "The number is not prime \n"


.END
