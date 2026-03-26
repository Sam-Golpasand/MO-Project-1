.ORIG x3000

MAIN ; Just calls each function in a row and starts over 
    JSR readS
    JSR isPrime
    JSR resultS
    JSR MAIN


;-----------------------------------
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
    
    
;-----------------------------------------
isPrime
    ST R7, SaveR7
    ADD R1, R0, #-2     ; Minus R0 med 2 og tilføj den til R1
    BRn NOTPRIME        ; Hvis svaret er negativt, er tallet mindre end det laveste primtal

    AND R1, R1, #0      ; Nulstil R1 
    ADD R1, R1, #2      ; 2 er vores første divisor, siden alle tal kan divideres med 1

CHECKDIV
    NOT R4, R1          ; Lav R4 til NOT R1, altså det negative
    ADD R2, R0, R4      ; Minus R0 med R1 (2) og tilføj den til R2
    ADD R2, R2, #1      ; A - B laves som A + NOT(B) + 1
    BRz PRIME           ; Første tjek er om R0 minus divisor = 0. Hvis det er, så er dette et primtal
    
    ADD R3, R0, #0      ; Gem vores originale R0 værdi siden vi ødelægger den senere

DIVLOOP
    NOT R4, R1          ; Lav R4 til NOT R1, altså det negative
    ADD R3, R3, R4      ; Minus vores tidligere gemte R0 værdi med divisor
    ADD R3, R3, #1      ; A - B laves som A + NOT(B) + 1
    BRz NOTPRIME        ; Hvis divisoren går op (efter alle tidligere tjeks mislykkedes), er dette ikke et primtal
    BRn NEXT            ; Hvis remainder < 0, går divisoren ikke op i tallet, så prøv næste divisor

    BR DIVLOOP          ; Hvis ingen branch condition er opfyldt, skal den køre loopet igen

NEXT
    ADD R1, R1, #1      ; Tilføj 1 til divisor
    BR CHECKDIV         ; Gå tilbage til CHECKDIV label og kør samme checks som før

PRIME
    AND R0, R0, #0      ; Nulstil R0
    ADD R0, R0, #1      ; Lav R0 til 1
    LD R7, SaveR7       ; Restore the original return address
    RET                 ; Return

NOTPRIME
    AND R0, R0, #0      ; Nulstil R0
    LD R7, SaveR7       ; Restore the original return address
    RET                 ; Return
    
    
;-------------------------------------
resultS
    ST R7, SaveR7
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
    
    LD R7, SaveR7       ; Restore the original return address
    RET
    
    
;------------------------------------
PRIME_MSG .STRINGZ "The number is prime"
NOTPRIME_MSG .STRINGZ "The number is not prime"
PromtMsg    .STRINGZ "Input a 2 digit decimal number: "
NegASCIIOffset  .FILL xFFD0  ; xFFD0 is two's complement for -x30 (-48 in decimal)
NEWLINE .FILL x0A ; Line break
SaveR7 .BLKW #1      

.END