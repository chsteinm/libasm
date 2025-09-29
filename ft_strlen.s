# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: chrstein <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/29 18:02:13 by chrstein          #+#    #+#              #
#    Updated: 2025/09/29 18:02:16 by chrstein         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

section .text
    global  ft_strlen

ft_strlen:
    mov     rax, rdi
    .loop:
        cmp     byte [rax], 0
        je      .end
        inc     rax
        jmp     .loop
    .end:
        sub     rax, rdi
        ret
