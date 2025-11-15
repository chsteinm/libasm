NAME = libasm.a
ASMFLAGS = -felf64
SRCS = 	strlen strcpy strcmp write read strdup
OBJ = $(addprefix $(BUILD_DIR)/ft_,$(addsuffix .o,$(SRCS)))
SRCS_BONUS = atoi_base list_push_front list_size list_sort list_remove_if
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

# For download the tests for tha mandotary part
get_main:
	curl -fSL https://raw.githubusercontent.com/chsteinm/libasm/master/main.c -o main.c

# For compile and launch the main test
main: $(NAME) main.c
	cc -g -o main main.c $(NAME)

# For download the tests for tha bonus part
get_main_bonus:
	curl -fSL https://raw.githubusercontent.com/chsteinm/libasm/master/main_bonus.c -o main_bonus.c

# For compile and launch the bonus tests.c
main_bonus: bonus main_bonus.c
	cc -g -o main_bonus main_bonus.c $(NAME)
	./main_bonus

# For download the notes that help me accomplish the subject
get_notes:
	curl -fSL https://raw.githubusercontent.com/chsteinm/libasm/master/notes.txt -o notes.txt

clean:
	rm -rf $(BUILD_DIR)

fclean: clean
	rm -rf $(NAME)

re : fclean
	make

.PHONY: all clean fclean re bonus main main_bonus