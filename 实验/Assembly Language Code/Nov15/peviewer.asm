.386
.model flat,stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\macros\macros.asm
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
 
.data
str0 BYTE "Please input a PE file: ",0
str1 BYTE "IMAGE_DOS_HEADER",0Ah,0Dh,0
str2 BYTE "    e_magic:",0
str3 BYTE "    e_lfanew:",0
str4 BYTE "IMAGE_DOS_HEADER",0Ah,0Dh,0
str5 BYTE "    Signature:",0
str6 BYTE "IMAGE_DOS_HEADER",0Ah,0Dh,0
str7 BYTE "    NumberOfSections:",0
str8 BYTE "    TimeDateStamp:",0
str9 BYTE "    Charateristics:",0
str10 BYTE "IMAGE_DOS_HEADER",0Ah,0Dh,0
str11 BYTE "    e_magic:",0
str12 BYTE "    e_lfanew:",0
str13 BYTE "IMAGE_DOS_HEADER",0Ah,0Dh,0
str14 BYTE "    AddressOfEntryPoint:",0
str15 BYTE "    ImageBase:",0
str16 BYTE "    SectionAlignment:",0
str17 BYTE "    FileAlignment:",0
buf3 DWORD 4000 DUP(0)
buf4 DWORD 4000 DUP(0)
buf5 WORD 4000 DUP (0)
file BYTE 20 DUP(0),0
hfile DWORD 0,0
endl BYTE 0Ah,0Dh,0
temp DWORD 0,0
temp1 DWORD 0,0

.code
Output PROC        
    mov esi,OFFSET buf3
    add esi,edx
    add esi,temp1   
    mov eax,DWORD PTR[esi]  
    mov ebx,eax    
    invoke dw2hex,eax,addr buf4        
    mov ecx,temp
    .if ecx==8
    invoke StdOut,addr buf4    
    .else                  
    mov ax,WORD PTR [buf4+4]   
    mov buf5,ax                
    invoke StdOut,addr buf5
    mov ax,WORD PTR [buf4+6]   
    mov buf5,ax
    invoke StdOut,addr buf5    
    .endif
    invoke StdOut,addr endl
    ret
Output ENDP
 
start:
    invoke StdOut,addr str0
    invoke StdIn,addr file,20
    invoke CreateFile,addr file,\        
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    mov hfile,eax   
    invoke SetFilePointer,hfile,0,0,FILE_BEGIN
    invoke ReadFile,hfile,addr buf3,4000,0,0   
    mov esi,OFFSET buf3
    invoke StdOut,addr str1
    invoke StdOut,addr str2

    mov edx,0
    mov temp1,edx
    mov ecx,4
    mov temp,ecx
    invoke Output
 
    invoke StdOut,addr str3
  
    mov edx,3ch
    mov ecx,8
    mov temp,ecx
    invoke Output
    
    invoke StdOut,addr str4
    invoke StdOut,addr str5
    mov temp1,ebx

    mov edx,0
    invoke Output
 
    invoke StdOut,addr str6
    invoke StdOut,addr str7    

    mov edx,6h
    mov ecx,4
    mov temp,ecx
    invoke Output
 
    invoke StdOut,addr str8

    mov edx,8h
    mov ecx,8
    mov temp,ecx
    invoke Output
 
    invoke StdOut,addr str9

    mov edx,16h
    mov ecx,4
    mov temp,ecx
    invoke Output
 
    invoke StdOut,addr str13
    invoke StdOut,addr str14    

    mov edx,28h
    mov ecx,8
    mov temp,ecx
    invoke Output
 
    invoke StdOut,addr str15

    mov edx,34h
    invoke Output
    
    invoke StdOut,addr str16

    mov edx,38h
    invoke Output
 
    invoke StdOut,addr str17

    mov edx,3ch
    invoke Output
    invoke CloseHandle,hfile
    invoke ExitProcess,0
end start