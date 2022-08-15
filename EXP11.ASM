assume cs:codesg, ds:datasg

datasg segment
db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

codesg segment
start:		mov ax, datasg
			mov ds, ax
			mov si, 0
			call letterc
			
			mov ax, 4C00H
			int 21H
			
letterc:	pushf
			push cx
			push bx
			
			mov bx, 0
			mov ch, 0
	s:		mov cl, ds:[si+bx]
			jcxz q
			cmp cl, 97
			jb nonletter
			cmp cl, 122
			ja nonletter
			and cl, 11011111B
			mov ds:[si+bx], cl
nonletter:	inc bx
			jmp short s
			
	q:		pop bx
			pop cx
			popf
			
			ret

codesg ends
end start