.ORIG x3000

isPrime
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
    ADD R3, R3, R4       ; Minus vores tidligere gemte R0 værdi med divisor
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
    TRAP x25            ; HALT

NOTPRIME
    AND R0, R0, #0      ; Nulstil R0
    TRAP x25            ; HALT
    
SaveR7 .BLKW 1

.END