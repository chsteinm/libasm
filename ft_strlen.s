section .text
    global  ft_strlen

; rdi = str
ft_strlen:
        mov rcx, -1     ; max value for rep instruction (put all bits on 1)
        xor al, al      ; al = 0
        repne scasb     ; repne : rep until Zero flag is on. scasb : cmp AL and byte [RDI] and inc RDI
        not rcx         ; inverse all bits
        dec rcx         ; -1 for the '\0'
        mov rax, rcx
        ret

; simpler understanding but less powerfull version :
; ft_strlen:
;         mov     rax, rdi
;     .loop:
;         cmp     byte [rax], 0
;         je      .end
;         inc     rax
;         jmp     .loop
;     .end:
;         sub     rax, rdi
;         ret
