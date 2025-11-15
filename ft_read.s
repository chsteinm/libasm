%define SYS_READ 0

extern __errno_location

section .text
    global  ft_read

ft_read:
        mov     rax, SYS_READ
        syscall
        cmp     rax, 0
        jge     .end
        neg     rax
        mov     rdx, rax
        push    rdx
        call    __errno_location
        pop     rdx
        mov     [rax], edx
        mov     rax, -1
    .end:
        ret