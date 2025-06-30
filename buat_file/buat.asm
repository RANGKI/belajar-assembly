section .data
    hello_guys db "Hello this is file maker, and you only can make content of 50 char",0xA
    hello_guys_len equ $ - hello_guys
    file_name db "Welp whats your file name (20 char) : ",0x0
    file_name_len equ $ - file_name
    content db "Now the content my king : ",0x0
    conetent_len equ $ - content

section .bss
    file_name_input resb 21
    content_input resb 51

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello_guys
    mov edx, hello_guys_len
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, file_name
    mov edx, file_name_len
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, file_name_input
    mov edx, 21
    int 80h
    dec eax
    mov byte [ecx + eax], 0 
    mov eax, 5
    mov ebx, file_name_input
    mov ecx, 0x241
    mov edx, 0x180
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, content
    mov edx, conetent_len
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, content_input
    mov edx, 51
    int 80h
    mov edx, eax
    mov eax, 4
    mov ebx, 3
    mov ecx, content_input
    int 80h
    jmp _exit

_exit:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    mov eax, 1
    int 80h