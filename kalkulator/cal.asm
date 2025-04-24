section .data
    banner db "HELLO WELCOME TO THE ROOTSANCTUM KALKULATOR",0xa
    len_banner equ $ - banner
    options db "CHOOSE YOUR OPTION +,-,*,/ OR YOU WANT TO EXIT (type 'e'): "
    len_options equ $ - options
    plus db "+"
    subb db "-"
    mull db "*"
    divv db "/"
    exitMsg db "e"
    tidakValid db "Input tidak valid !",0xa
    len_tidakValid equ $ - tidakValid
    byee db "Byee!",0xa
    hasilMsg db "AND THE RESULT IS : "
    len_hasilMsg equ $ - hasilMsg

section .bss
    operator resb 1
    angka1_input resb 0xc       
    angka2_input resb 0xc
    angka1 resd 1               
    angka2 resd 1
    hasil resd 1
    hasil_str resb 12


section .text
    global _start

_start:
    mov eax,4
    mov ebx,0
    mov ecx,banner
    mov edx,len_banner
    int 80h

_cal:
    mov eax,4
    mov ebx,0
    mov ecx,options
    mov edx,len_options
    int 80h
    mov eax,3
    mov ebx,1
    mov ecx,operator
    mov edx,0x2
    int 80h
    mov al, [operator]
    mov bl, [plus]
    cmp al,bl
    je _tambah
    mov bl, [subb]
    cmp al,bl
    je _kurang
    mov bl, [mull]
    cmp al,bl
    je _kali
    mov bl, [divv]
    cmp al,bl
    je _bagi
    mov bl, [exitMsg]
    cmp al,bl
    je _exit
    mov eax,4
    mov ebx,0
    mov ecx,tidakValid
    mov edx,len_tidakValid
    int 80h
    mov eax,1
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
    int 80h

get_input:
    ; Read angka1 input (ASCII)
    mov eax, 3
    mov ebx, 1
    mov ecx, angka1_input
    mov edx, 0xc
    int 80h
    mov ecx, angka1_input   
    mov edi, angka1         
    call ascii_to_int

    ; Read angka2 input (ASCII)
    mov eax, 3
    mov ebx, 1
    mov ecx, angka2_input
    mov edx, 0xc
    int 80h
    mov ecx, angka2_input
    mov edi, angka2
    call ascii_to_int
    ret


_tambah:
    call get_input
    mov eax, [angka1]
    mov ebx, [angka2]
    add eax, ebx
    mov [hasil], eax

    ; print label
    mov eax, 4
    mov ebx, 1
    mov ecx, hasilMsg
    mov edx, len_hasilMsg
    int 0x80

    ; convert to string
    mov eax, [hasil]
    call int_to_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, edi             
    mov edx, hasil_str + 12
    sub edx, edi             
    int 0x80



    jmp _cal

_kurang:
    call get_input
    mov eax, [angka1]
    mov ebx, [angka2]
    sub eax, ebx
    mov [hasil], eax

    ; print label
    mov eax, 4
    mov ebx, 1
    mov ecx, hasilMsg
    mov edx, len_hasilMsg
    int 0x80

    ; convert to string
    mov eax, [hasil]
    call int_to_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, edi             
    mov edx, hasil_str + 12
    sub edx, edi             
    int 0x80
    
    jmp _cal

_kali:
    call get_input
    mov eax, [angka1]
    mov ebx, [angka2]
    mul ebx
    mov [hasil], eax

    ; print label
    mov eax, 4
    mov ebx, 1
    mov ecx, hasilMsg
    mov edx, len_hasilMsg
    int 0x80

    ; convert to string
    mov eax, [hasil]
    call int_to_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, edi             
    mov edx, hasil_str + 12
    sub edx, edi             
    int 0x80

    jmp _cal

_bagi:
    call get_input
    mov eax, [angka1]
    mov ebx, [angka2]
    xor edx,edx
    div ebx
    mov [hasil], eax

    ; print label
    mov eax, 4
    mov ebx, 1
    mov ecx, hasilMsg
    mov edx, len_hasilMsg
    int 0x80

    ; convert to string
    mov eax, [hasil]
    call int_to_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, edi             
    mov edx, hasil_str + 12
    sub edx, edi             
    int 0x80

    jmp _cal

_exit:
    mov eax,4
    mov ebx,0
    mov ecx,byee
    mov edx,6
    int 80h
    mov eax,1
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
    int 80h

ascii_to_int:
    xor ebx, ebx            
    xor edx, edx            

.convert_loop:
    mov al, [ecx + edx]
    cmp al, 0xA             
    je .done
    sub al, '0'             
    imul ebx, ebx, 10       
    add ebx, eax            
    inc edx
    jmp .convert_loop

.done:
    mov [edi], ebx          
    ret

int_to_ascii:
    mov ecx, 10         ; base 10
    mov edi, hasil_str + 11  ; point to the end of buffer
    mov byte [edi], 0xa ; newline for cleaner output
    dec edi

.convert:
    xor edx, edx
    div ecx             ; divide EAX by 10 -> quotient in EAX, remainder in EDX
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz .convert
    inc edi             ; edi now points to start of the number string
    ret
