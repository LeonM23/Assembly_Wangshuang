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

stack segment
db 64 dup(0)
stack ends

strbuffer segment
db 64 dup(0)
strbuffer ends

codesg segment
start:		mov ax, datasg
			mov es, ax
			mov ax, stack
			mov ss, ax
			mov sp, 64
			
			mov dh, 3
			mov dl, 0
			
			mov bx, 0
			mov di, 0
			
			mov cx, 21
			
	s:		push cx
			push dx
			
			mov ax, strbuffer
			mov ds, ax
			mov ax, es:[di]
			mov ds:[0], ax
			mov ax, es:[di+2]
			mov ds:[2], ax
			
			mov si, 16
			mov ax, es:[84+di]
			mov dx, es:[84+di+2]
			call dtoc
			
			mov cx, es:[168+bx]
			call divdw
			mov si, 48
			call dtoc
			
			mov ax, es:[168+bx]
			mov dx, 0
			mov si, 32
			call dtoc
			
			add bx, 2
			add di, 4
			
			pop dx
			mov cl, 11000010B
			mov si, 0
			mov dl, 20
			call show_str
			mov si, 16
			mov dl, 30
			call show_str
			mov si, 32
			mov dl, 40
			call show_str
			mov si, 48
			mov dl, 50
			call show_str
			
			mov cx, 32
			mov si, 0
	s1:		mov word ptr ds:[si], 0
			add si, 2
			loop s1
			
			add dh, 1
			pop cx
			
			loop s
			
			mov ax, 4C00H
			int 21H
	
			
show_str:	push es
			push ax
			push bx
			push cx
			push bp
			
			mov ax, 000AH
			mul dh
			add ax, 0B7F6H
			mov es, ax
			mov bl, dl
			mov bh, 0
			sub bx, 1
			add bx, bx
			mov bp, 0
			mov al, cl
			mov ah, 0
show_strs:	mov cl, ds:[si+bp]
			mov ch, 0
			jcxz show_strok
			mov byte ptr es:[bx], cl
			mov byte ptr es:[bx+1], al
			inc bp
			add bx, 2
			jmp short show_strs
		
show_strok: pop bp
			pop cx
			pop bx
			pop ax
			pop es
			ret
			
divdw:		push bx
			push ax
			
			mov ax, dx
			mov dx, 0
			div cx
			mov bx, ax

			pop ax
			div cx
			mov cx, dx
			mov dx, bx
			
			pop bx
			ret

dtoc:		push ax
			push bx
			push cx
			push dx
			
			mov bx, 0
dtocs:  	mov cx, 10
			call divdw
			add cx, 30H
			push cx
			inc bx
			
			mov cx, ax
			jcxz dtocok
			jmp short dtocs
			
dtocok:		mov cx, bx
			mov bx, 0
dtocs1:		pop ax
			mov ds:[si + bx], al
			inc bx
			loop dtocs1
			mov byte ptr ds:[si+bx], 0
			
			pop dx
			pop cx
			pop bx
			pop ax
			ret
			
codesg ends

end start