section .data
    hello_guys db "Hello guys!",0xA
    tes db 0x1
    stop db 0x64

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello_guys
    mov edx, 0xc
    int 80h

_loop:
    mov al, [tes]
    mov bl, [stop]
    cmp al, bl
    je _exit
    inc al
    mov [tes], al
    jmp _start

_exit:
    mov eax, 1
    xor ebx,ebx
    int 80h