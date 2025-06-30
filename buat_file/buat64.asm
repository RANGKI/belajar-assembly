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
    mov rax, 1
    mov rdi, 1
    mov rsi, hello_guys
    mov rdx, hello_guys_len
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, file_name
    mov rdx, file_name_len
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, file_name_input
    mov rdx, 21
    syscall
    dec rax
    mov byte [rsi + rax], 0 
    mov rax, 2
    mov rdi, file_name_input
    mov rsi, 0x241
    mov rdx, 0x180
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, content
    mov rdx, conetent_len
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, content_input
    mov rdx, 51
    syscall
    mov rdx, rax
    mov rax, 1
    mov rdi, 3
    mov rsi, content_input
    syscall
    jmp _exit

_exit:
    xor rax, rax
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    mov rdi, 60
    syscall