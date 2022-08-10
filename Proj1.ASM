assume cs:codesg, ds:datasg

datasg segment
db '1975', 0, '1976', 0, '1977', 0, '1978', 0, '1979', 0, '1980', 0, '1981', 0, '1982', 0, '1983', 0
db '1984', 0, '1985', 0, '1986', 0, '1987', 0, '1988', 0, '1989', 0, '1990', 0, '1991', 0, '1992', 0
db '1993', 0, '1994', 0, '1995', 0

dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
dw 11542, 14430, 15257, 17800
datasg ends

stack segment
db 32 dup(0)
stack ends

strbuffer segment
db 48 dup(0)
strbuffer ends

codesg segment
start:		mov ax, datasg
			mov es, ax
			mov ax, stack
			mov ss, ax
			mov sp, 32
			
			mov dh, 3
			mov dl, 0
			
			mov bx, 0
			mov di, 0
			mov si, 0
			
			mov cx, 21
			
	s:		push cx
			push si
			push dx
			
			mov si, 0
			mov ax, strbuffer
			mov ds, ax
			
			mov ax, es:[105+di]
			mov dx, es:[105+di+2]
			call dtoc
			
			mov cx, es:[189+bx]
			call divdw
			mov si, 32
			call dtoc
			
			mov ax, es:[189+bx]
			mov dx, 0
			mov si, 16
			call dtoc
			
			add bx, 2
			add di, 4
			
			pop dx
			mov cl, 10000111B
			mov dl, 30
			call show_str
			mov si, 32
			mov dl, 40
			call show_str
			mov si, 0
			mov dl, 20
			call show_str
			
			mov cx, 24
			mov si, 0
	s1:		mov word ptr ds:[si], 0
			add si, 2
			loop s1
			
			mov ax, datasg
			mov ds, ax
			pop si
			mov dl, 10
			call show_str
			add si, 5
			add dh, 1
			
			pop cx
			
			loop s
			
			mov ax, 4C00H
			int 21H
	
			
show_str:	push es
			push ax
			push bx
			push cx
			push si
			
			mov ax, 000AH
			mul dh
			add ax, 0B800H
			mov es, ax
			mov bl, dl
			mov bh, 0
			sub bx, 1
			add bx, bx
			mov si, 0
			mov al, cl
			mov ah, 0
show_strs:	mov cl, ds:[si]
			mov ch, 0
			jcxz show_strok
			mov byte ptr es:[bx], cl
			mov byte ptr es:[bx+1], al
			inc si
			add bx, 2
			jmp short show_strs
		
show_strok: pop si
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
			jcxz dtocok
			add cx, 30H
			push cx
			inc bx
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