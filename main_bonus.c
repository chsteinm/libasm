#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

int     ft_atoi_base(char *str, char *base);
void    ft_list_push_front(t_list **begin_list, void *data);
int     ft_list_size(t_list *begin_list);
void    ft_list_sort(t_list **begin_list, int (*cmp)());
void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

void test_case(char *str, char *base, int expected, char *description) {
    int result = ft_atoi_base(str, base);
    printf("Test: %s\n", description);
    printf("  Input: str=\"%s\", base=\"%s\"\n", str ? str : "NULL", base ? base : "NULL");
    printf("  Expected: %d, Got: %d -> %s\n\n", 
           expected, result, (result == expected) ? "✅ PASS" : "❌ FAIL");
}

int main(int ac, char **av) {
    // printf("=== Tests ft_atoi_base ===\n\n");
    
    // // Tests basiques
    // test_case("101", "01", 5, "Binaire simple");
    // test_case("42", "0123456789", 42, "Décimal");
    // test_case("2a", "0123456789abcdef", 42, "Hexadécimal");
    // test_case("FF", "0123456789ABCDEF", 255, "Hexadécimal majuscule");
    
    // // Tests avec signes
    // test_case("-101", "01", -5, "Binaire négatif");
    // test_case("+42", "0123456789", 42, "Décimal positif");
    // test_case("--42", "0123456789", 0, "Double moins");
    // test_case("+-42", "0123456789", 0, "Plus et moins");
    
    // // Tests avec espaces
    // test_case("   \t\n  42", "0123456789", 42, "Espaces avant");
    // test_case("   -42", "0123456789", -42, "Espaces et signe");
    
    // Tests base invalide
    // test_case("42", "0", 0, "Base trop courte");
    // test_case("42", "01+", 0, "Base avec +");
    // test_case("42", "01-", 0, "Base avec -");
    // test_case("42", "01 ", 0, "Base avec espace");
    // test_case("42", "011", 0, "Base avec doublons");
    // test_case("42", "01\t", 0, "Base avec tab");
    // test_case("1", "0123456789", 1, "Base OK");
    
    // // Tests string invalide
    // test_case("", "01", 0, "String vide");
    // test_case(NULL, "01", 0, "String NULL");
    // test_case("42", NULL, 0, "Base NULL");
    // test_case("xyz", "01", 0, "Caractères invalides");
    
    // // Tests edge cases
    // test_case("0", "01", 0, "Zéro");
    // test_case("000", "0123456789", 0, "Zéros multiples");
    // test_case("42abc", "0123456789", 42, "String avec caractères invalides après");
    // test_case("   ", "01", 0, "Que des espaces");
    
    // // Tests bases spéciales
    // test_case("poneyvif", "poneyvif", 42, "Base custom");
    // test_case("love", "love", 0, "Base avec doublons");
    
    // // Tests limites
    // test_case("1111111111111111111111111111111", "01", -1, "Overflow binaire");
    // test_case("2147483647", "0123456789", 2147483647, "INT_MAX");
    // test_case("-2147483648", "0123456789", -2147483648, "INT_MIN");
    
    // printf("=== Tests terminés ===\n");

    printf("=== Tests ft_list_push_front ===\n\n");
    {
        t_list *list = NULL;
        ft_list_push_front(&list, "third");
        ft_list_push_front(&list, "second");
        ft_list_push_front(&list, "first");

        printf("List content after pushes: ");
        t_list *it = list;
        while (it)
        {
            printf("%s -> ", (char*)it->data);
            it = it->next;
        }
        printf("NULL\n");

        int cnt = 0;
        for (it = list; it; it = it->next)
            cnt++;
        printf("Count = %d (expected 3)\n\n", cnt);
    }
    return 0;
}