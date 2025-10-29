extern ft_strlen

section .text
    global ft_atoi_base

; Main function: int atoi_base(char *str, char *base)
; mov r12, rdi        ; r12 = str (1st argument)
; mov r13, rsi        ; r13 = base (2nd argument)
; mov r14, rax        ; r14 = base_len
; mov r15, rdx        ; r15 = sign
ft_atoi_base:
        ; prologue
        push    rbp
        mov     rbp, rsp
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15

        ; NULL str handle
        xor     rax, rax
        test    rdi, rdi
        jz      .end
        test    rsi, rsi
        jz      .end

        mov     r12, rdi        ; r12 = str (1st argument)
        mov     r13, rsi        ; r13 = base (2nd argument)

        mov     rdi, r13
        call    is_valid_base
        test    rax, rax
        jz      .end

        mov     rdi, r13
        call    ft_strlen
        mov     r14, rax        ; r14 = base_len

        jmp .skip_wspace
        .skip_char:
            inc r12
        .skip_wspace:
            mov al, byte [r12]
            cmp al, ' '
            je .skip_char
            cmp al, 9
            jl .handle_signe
            cmp al, 13
            jle .skip_char
    
    .handle_signe:
        mov r15, 1      ; r15 = sign (1 || -1)
        .sign_loop:
            cmp al, '+'
            je  .positive
            cmp al, '-'
            je  .negative
            jmp .convert_number

            .positive:
            inc r12
            mov al, byte [r12]
            jmp .sign_loop

            .negative:
            inc r12
            mov al, byte [r12]
            neg r15         ; sign *= -1
            jmp .sign_loop

    .convert_number:
        xor rbx, rbx        ; rbx = result = 0
        .loop:
            movzx   rax, byte [r12]
            test    rax, rax      ; end of str '\0'
            jz      .end_conversion
            mov     rdi, rax
            call    find_index_in_base
            cmp     rax, -1
            je      .end_conversion

            imul    rbx, r14
            add     rbx, rax

            inc     r12
            jmp     .loop

    .end_conversion:
        mov     rax, rbx
        imul    rax, r15

    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

; rdi = char
; rsi = base
find_index_in_base:
        ; prologue
        push    rbp
        mov     rbp, rsp

        xor rax, rax        ; index = 0
        .find_loop:
            movzx   rcx, byte [rsi + rax]
            test    rcx, rcx
            jz      .not_find
            cmp     dil, cl
            je      .end
            inc     rax
            jmp     .find_loop

    .not_find:
        mov rax, -1
    .end:
        pop rbp
        ret

is_valid_base:
    ; function prologue
    push    rbp
    mov     rbp, rsp
    push    r12
    push    r13

        mov     r12, rdi
        call    ft_strlen
        cmp     rax, 2
        jl      .invalid        ; length < 2
        mov     r13, rax        ; r13 = length

        xor     rbx, rbx        ; rbx = i = 0  
        .check_loop:
            cmp     rbx, r13
            je      .valid

            mov al, byte [r12 + rbx]
            cmp al, ' '
            je .invalid
            cmp al, '+'
            je .invalid
            cmp al, '-'
            je .invalid
            cmp al, 9
            jl .check_duplicates
            cmp al, 13
            jle .invalid

        .check_duplicates:
            mov rcx, rbx
            .duplicates_loop:
                inc rcx
                cmp rcx, r13
                jge .next_char

                mov dl, byte [r12 + rcx]
                cmp al, dl
                je .invalid
                jmp .duplicates_loop

        .next_char:
            inc rbx
            jmp .check_loop

    .invalid:
        xor rax, rax
        jmp .check_end

    .valid:
        mov rax, 1
        jmp .check_end
        
    .check_end:
        pop r13
        pop r12
        pop rbp    
        ret