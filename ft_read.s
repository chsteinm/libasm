%define SYS_READ 0

extern __errno_location

section .text
    global  ft_read

ft_read:
        mov rax, SYS_READ
        syscall
        cmp rax, 0
        jge .end
        neg rax
        mov rcx, rax
        call __errno_location
        mov [rax], ecx
        mov rax, -1
    .end:
        ret