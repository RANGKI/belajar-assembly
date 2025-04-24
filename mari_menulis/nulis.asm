section .data
    banner db "Hello Whats Your Names ?",0xa
    exitMsg db "exit"
    menyapa db "Hello ! "


section .bss
    input resb 0x40

section .text
    global _start
_start:
    mov eax,4
    mov ebx,0
    mov ecx,banner
    mov edx,0x19
    int 80h
_input:
    mov eax,3
    mov ebx,1
    mov ecx,input
    mov edx,0x40
    int 80h
    push eax
    mov eax, [input]
    mov ebx, [exitMsg] 
    cmp eax,ebx
    je _exit
    mov eax,4
    mov ebx,0
    mov ecx, menyapa
    mov edx,8
    int 80h
    mov eax,4
    mov ebx,0
    mov ecx, input
    pop edx
    int 80h
    jmp _start
_exit:
    mov eax,1
    xor ebx,ebx
    int 80h