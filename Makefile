NAME = libasm.a
ASMFLAGS = -felf64
SRCS = 	ft_strlen.s
OBJ = $(addprefix $(BUILD_DIR)/,$(SRCS:.s=.o))
SRCS_BONUS =	
OBJ_BONUS = $(addprefix $(BUILD_DIR)/,$(SRCS_BONUS:.s=.o))
BUILD_DIR = .build
-include $(OBJ:.o=.d) $(OBJ_BONUS:.o=.d)

all: $(NAME)

$(NAME): $(OBJ) Makefile
	ar rcs $@ $^

bonus: $(NAME) $(OBJ_BONUS) Makefile
	 @if [ "$$(find $(OBJ_BONUS) -newer "$(NAME)" -print -quit)" ]; then \
		ar rcs $(NAME) $^; \
	 else \
	  	echo "make bonus: Nothing to be done for 'bonus'."; \
	 fi

$(BUILD_DIR)/%.o: %.s Makefile
	@mkdir -p $(BUILD_DIR)
	nasm $(ASMFLAGS) $< -o $@

# For compile the test main.c
main: $(NAME) main.c
	cc -o main main.c $(NAME)

clean:
	rm -rf $(BUILD_DIR)

fclean: clean
	rm -rf $(NAME)

re : fclean
	make

.PHONY: all clean fclean re bonus main