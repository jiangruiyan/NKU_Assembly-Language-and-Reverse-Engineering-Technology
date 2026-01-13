.386
.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
decstr BYTE 20 DUP(0)
hexstr BYTE 9 DUP(0)
decnum DWORD 0
const10 DWORD 10
const16 DWORD 16
strInput BYTE "Please input a decimal number(0~4294967295):",0
strOutput BYTE "The hexdecimal number is:",0

.code
dec2dw PROC
	mov esi, 0
	mov ebx, 0
L1:
	mov bl, [decstr+esi]
	sub bl, 48
	mov eax, decnum
	mul const10
	mov decnum, eax
	add decnum, ebx
	inc esi
	mov bl, [decstr+esi]
	cmp bl, 0
	jnz L1
	ret
dec2dw ENDP

dw2hex01 PROC
    mov ecx, 8
    mov edi, OFFSET hexstr + 8 
    mov eax, [decnum] 
L2:    
    xor edx, edx
    div DWORD PTR const16
    add dl, '0' 
    cmp dl, '9'  
    jbe short L3
    add dl, 7  
L3:  
    mov [edi-1], dl  
    dec edi
    loop L2
    mov BYTE PTR [edi-1], 0  
    ret
dw2hex01 ENDP

start:
	invoke StdOut, addr strInput
	invoke StdIn, addr decstr, 20
	
	call dec2dw
	call dw2hex01
	
	invoke StdOut, addr strOutput
	invoke StdOut, addr hexstr
	invoke ExitProcess, 0
END start