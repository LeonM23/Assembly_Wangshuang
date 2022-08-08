assume cs:code, ds:data

data segment
db 'w e l c o m e   t o   m a s m ! '
db 5, 10001010B, 10101100B, 11111001B
data ends

code segment

start:  mov ax, data
        mov es, ax
        mov ax, 0B800H
        mov ds, ax
        mov ax, 00A0H
        mul byte ptr es:[32]
        mov dx, ax
        mov bx, 820H
        sub bx, dx

        mov cx, 3
        mov di, 0
    s:  push cx
        mov cx, 16
        mov si, 0

   s0:  mov al, es:[si]
        mov ds:[bx+64+si], al
        mov al, es:[33+di]
        mov ds:[bx+64+si+1], al
        add si, 2
        loop s0

        pop cx
        inc di
        add bx, dx
        loop s

        mov ax, 4C00H
        int 21H

code ends

end start


