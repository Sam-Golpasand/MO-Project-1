
.ORIG x3000

MAIN ; Just calls each function in a row and starts over 
    JSR readS
    JSR isPrime
    JSR resultS
    JSR MAIN


;-----------------------------------
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
    
    
;-----------------------------------------
isPrime
    ADD R1, R0, #-2     ; Minus R0 med 2 og tilføj den til R1
    BRn NOTPRIME        ; Hvis svaret er negativt, er tallet mindre end det laveste primtal

    AND R2, R2, #0      ; Nulstil R2 hvis den indeholder en anden værdi
    ADD R2, R2, #2      ; R2 er vores første divisor, siden alle tal kan divideres med 1

CHECKDIV
    NOT R5, R2          ; Lav R5 til NOT R2, altså det negative
    ADD R3, R0, R5      ; Minus R0 med R2 (2) og tilføj den til R3
    ADD R3, R3, #1      ; A - B laves som A + NOT(B) + 1
    BRz PRIME           ; Første tjek er om R0 minus divisor = 0. Hvis det er, så er dette et primtal
    
    ADD R4, R0, #0      ; Gem vores originale R0 værdi siden vi ødelægger den senere

DIVLOOP
    NOT R5, R2          ; Lav R5 til NOT R2, altså det negative
    ADD R4, R4, R5       ; Minus vores tidligere gemte R0 værdi med divisor
    ADD R4, R4, #1      ; A - B laves som A + NOT(B) + 1
    BRz NOTPRIME        ; Hvis divisoren går op (efter alle tidligere tjeks mislykkedes), er dette ikke et primtal
    BRn NEXT            ; Hvis remainder < 0, går divisoren ikke op i tallet, så prøv næste divisor

    BR DIVLOOP          ; Hvis ingen branch condition er opfyldt, skal den køre loopet igen

NEXT
    ADD R2, R2, #1      ; Tilføj 1 til divisor
    BR CHECKDIV         ; Gå tilbage til CHECKDIV label og kør samme checks som før

PRIME
    AND R0, R0, #0      ; Nulstil R0
    ADD R0, R0, #1      ; Lav R0 til 1
    RET                 ; Return

NOTPRIME
    AND R0, R0, #0      ; Nulstil R0
    RET                 ; Return
    
    
;-------------------------------------
resultS
    ADD R0, R0, #0
    BRz RESULTNOTPRIME  ; Checks the value from isPrime function stored in R0, jumps to NOTPRIME if =0, otherwise continues

RESULTPRIME ; Prints result on new line and adds line break
    LD R0, NEWLINE
    OUT
    LEA R0, PRIME_MSG
    PUTS
    LD R0, NEWLINE
    OUT
    RET

RESULTNOTPRIME ; Prints result on new line and adds line break
    LD R0, NEWLINE
    OUT
    LEA R0, NOTPRIME_MSG
    PUTS
    LD R0, NEWLINE 
    OUT
    
    RET
    
    
;------------------------------------
PRIME_MSG .STRINGZ "The number is prime"
NOTPRIME_MSG .STRINGZ "The number is not prime"
MESSAGE .STRINGZ "Input a 2 digit decimal number:"
ASCII0  .FILL x0030
NEWLINE .FILL x0A ; Line break


.END