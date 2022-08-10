assume cs:code

data segment
db 32 dup(0)
data ends

stack segment
db 32 dup(0)
stack ends

code segment
start:  	mov ax, data
			mov ds, ax
			mov ax, stack
			mov ss, ax
			mov sp, 32
			
			mov ax, 12666
			mov si, 0
			call dtoc
			
			mov dh, 8
			mov dl, 3
			mov cl, 2
			call show_str
			
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

code ends

end start
