

.ORIG x3000

JSR readS
HALT

readS
    LEA R0, MESSAGE
    PUTS
    
    ; Get the first number
    GETC
    OUT
    
    ; Convert from ASCII to number by taking value for "0" and getting its negative and 
    ; taking it from the ASCII value of the character to get the number (x0035 - x0030 = x0005 = 5);
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    
    ; multiply by 10 by adding itself 10 times since it is base 10
    ADD R3, R2, R2 ; 2x r2
    ADD R4, R3, R3 ; 4x r2
    ADD R4, R4, R4 ; 8x r2
    ADD R3, R3, R4 ; 2x + 8x = 10x r2
    
    ; Get the second character
    GETC
    OUT
    LD R1, ASCII0
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1
    
    ADD R0, R3, R2
    
    RET



MESSAGE .STRINGZ "Input a 2 digit decimal number:"
ASCII0  .FILL x0030
.END