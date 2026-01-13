.386  
.model flat, stdcall  
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
numarr DWORD 10 DUP(?)
temp01 DWORD ?
temp02 DWORD ?
output01 BYTE "Please input 10 integers(0~10000):",0Dh,0Ah,0
output02 BYTE 0Dh,0Ah,"The sorted numbers are:",0Dh,0Ah,0
output03 BYTE " ",0
const DWORD 10

.code
main PROC
	invoke StdOut, addr output01
	mov ecx, 10
	mov esi, 0
L1:
	mov temp01, ecx
	invoke StdIn, addr [numarr+esi*4], 4
	inc esi
	mov ecx, temp01
	loop L1

    	mov ecx, 10
	dec ecx
LN1:  
    	push ecx
    	mov esi, 0
    	dec ecx
    	mov temp02, ecx
LN2:  
    	mov eax, [numarr+esi*4]  
	inc esi
    	mov ebx, [numarr+esi*4]  
	dec esi
    	cmp eax, ebx  
    	jle LN3
	inc esi
    	xchg eax, [numarr+esi*4]  
	dec esi
    	mov [numarr+esi*4], eax
LN3:  
    	inc esi  
    	cmp esi, temp02  
    	jl LN2
    	pop ecx 
    	loop LN1

	invoke StdOut, addr output02
	mov ecx, 10
	mov esi, 0
L2:
	mov temp01, ecx
	invoke StdOut, addr [numarr+esi*4]
	invoke StdOut, addr output03
	inc esi
	mov ecx, temp01
	loop L2
main ENDP
END main