assume cs:code

a segment
db 1, 2, 3, 4, 5, 6, 7, 8
a ends

b segment
db 1, 2, 3, 4, 5, 6, 7, 8
b ends

c segment
db 0, 0, 0, 0, 0, 0, 0, 0
c ends

code segment
start:  mov ax, c
        mov ds, ax
        mov ax, b
        mov es, ax
        mov ax, a
        mov ss, ax

        mov cx, 8
        mov bx, 0
     s: mov al, es:[bx]
        add al, ss:[bx]
        mov ds:[bx], al
        inc bx
        loop s

        mov ax, 4C00H
        int 21H
code ends
end start



