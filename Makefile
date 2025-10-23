NAME = libasm.a
ASMFLAGS = -felf64
SRCS = 	strlen strcpy strcmp write read strdup
OBJ = $(addprefix $(BUILD_DIR)/ft_,$(addsuffix .o,$(SRCS)))
SRCS_BONUS = atoi_base
OBJ_BONUS = $(addprefix $(BUILD_DIR)/ft_,$(addsuffix _bonus.o,$(SRCS_BONUS)))
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
	cc -g -o main main.c $(NAME)

main_bonus: bonus main_bonus.c
	cc -g -o main_bonus main_bonus.c $(NAME)

clean:
	rm -rf $(BUILD_DIR)

fclean: clean
	rm -rf $(NAME)

re : fclean
	make

.PHONY: all clean fclean re bonus main