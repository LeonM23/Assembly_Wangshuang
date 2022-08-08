assume cs:codesg, ds:datasg

datasg segment
db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
db '1993', '1994', '1995'

dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
dw 11542, 14430, 15257, 17800
datasg ends

table segment
db 21 dup ('year summ ne ?? ')
table ends

codesg segment
start:  mov ax, datasg
        mov ds, ax
        mov ax, table
        mov es, ax
        mov bx, 0

        mov cx, 21
    s0: mov bx, 21
        sub bx, cx
        add bx, bx
        mov bp, bx
        add bp, bp
        add bp, bp
        add bp, bp

        mov ax, [168+bx]
        mov es:[bp+10], ax
        add bx, bx
        mov ax, [bx]
        mov es:[bp], ax
        mov ax, [bx+2]
        mov es:[bp+2], ax

        mov ax, [bx + 84]
        mov es:[bp+5], ax
        mov dx, [bx + 86]
        mov es:[bp+7], dx
        div word ptr es:[bp+10]
        mov es:[bp+13], ax

        loop s0

        mov ax, 4C00H
        int 21H
codesg ends

end start



