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

} 	t_list;

int     ft_atoi_base(char *str, char *base);
void    ft_list_push_front(t_list **begin_list, void *data);
int     ft_list_size(t_list *begin_list);
void    ft_list_sort(t_list **begin_list, int (*cmp)());
void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

/* no-op free function used for tests (do not free string literals) */

void test_case(char *str, char *base, int expected, char *description) {
    int result = ft_atoi_base(str, base);
    printf("Test: %s\n", description);
    printf("  Input: str=\"%s\", base=\"%s\"\n", str ? str : "NULL", base ? base : "NULL");
    printf("  Expected: %d, Got: %d -> %s\n\n", 
           expected, result, (result == expected) ? "✅ PASS" : "❌ FAIL");
}

int memcmp_simple(const void *ptr1, const void *ptr2) {
    const unsigned char *s1 = (const unsigned char *)ptr1;
    const unsigned char *s2 = (const unsigned char *)ptr2;

    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }

    return (int)(*s1) - (int)(*s2);
}

void print_list(const char *title, t_list *list)
{
    t_list *it = list;
    printf("\n%s", title);
    while (it)
    {
        printf("%s -> ", (char*)it->data);
        it = it->next;
    }
    printf("NULL\n");
}

void create_list_from_array(t_list **list, const char **arr, int n)
{
    /* push elements so that resulting list order matches arr[0], arr[1], ... */
    for (int i = n - 1; i >= 0; --i)
        ft_list_push_front(list, strdup((void*)arr[i]));
}

void list_sort(t_list **begin, int (*cmp)()) {
    if (!begin || !*begin)
        return;
    int swap = 1;
    while (swap) {
        swap = 0;
        t_list *it = *begin;
        while (it && it->next) {
            if (cmp(it->data, it->next->data) > 0) {
                void *tmp = it->data;
                it->data = it->next->data;
                it->next->data = tmp;
                swap = 1;
            }
            it = it->next;
        }
    }
    return;
}

// void list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *)) {
//     if (!begin_list || !*begin_list || !data_ref || !cmp || !free_fct)
//         return;
    
//     t_list *it = *begin_list;
//     t_list *prev = NULL;
//     while (it) {
//         if (!cmp(it->data, data_ref)) {
//             if (prev) {
//                 prev->next = it->next;
//             }
//             free_fct(it->data);
//             prev = it->next;
//             if (*begin_list == it)
//                 *begin_list = it->next;
//             free_fct(it);
//             it = prev;
//         }
//         else {
//             prev = it;
//             it = it->next;
//         }
//     }
// }

void	ft_lstclear(t_list **lst, void (*del)(void *))
{
	t_list	*tmp;

	if (!lst)
		return ;
	while (*lst)
	{
		tmp = (*lst)->next;
		if (del)
			(*del)((*lst)->data);
		free(*lst);
		*lst = tmp;
	}
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

    printf("\n=== Tests ft_list_push_front ===\n\n");
    
    t_list *list = NULL;
    // ft_list_push_front(&list, "first");
    ft_list_push_front(&list, "second");
    ft_list_push_front(&list, "third");
    ft_list_push_front(&list, "third");

    printf("List content after pushes: ");
    t_list *it = list;
    while (it)
    {
        printf("%s -> ", (char*)it->data);
        it = it->next;
    }
    printf("NULL\n");
    
    printf("\n=== Tests ft_list_size ===\n\n");
    printf("Count = %d (expected 3)\n\n", ft_list_size(list));

    printf("\n=== Tests ft_list_sort ===\n\n");
    ft_list_sort(&list, &memcmp_simple);
    it = list;
    printf("List content after pushes: ");
    while (it)
    {
        printf("%s -> ", (char*)it->data);
        it = it->next;
    }
    printf("NULL\n");
    ft_lstclear(&list, NULL);

    // empty list
    t_list *empty = NULL;
    printf("Empty list before: "); print_list("", empty);
    ft_list_sort(&empty, &memcmp_simple);
    printf("Empty list after sort: "); print_list("", empty);

    // single element
    t_list *one = NULL;
    ft_list_push_front(&one, "solo");
    printf("Single before: "); print_list("", one);
    ft_list_sort(&one, &memcmp_simple);
    printf("Single after: "); print_list("", one);
    free(one);

    // duplicates
    t_list *dup = NULL;
    const char *dup_arr[] = {"beta", "alpha", "beta", "gamma"};
    create_list_from_array(&dup, dup_arr, 4);
    printf("Duplicates before: "); print_list("", dup);
    ft_list_sort(&dup, &memcmp_simple);
    printf("Duplicates after: "); print_list("", dup);
    ft_lstclear(&dup, &free);

    // numeric strings (lexicographic order)
    t_list *nums = NULL;
    t_list *nums1 = NULL;
    const char *num_arr[] = {"10", "2", "1", "3", "10", "2", "1"};
    create_list_from_array(&nums, num_arr, 7);
    create_list_from_array(&nums1, num_arr, 7);
    printf("Numbers before: "); print_list("", nums);
    list_sort(&nums1, &memcmp_simple);
    printf("Numbers after C: "); print_list("", nums1);
    ft_list_sort(&nums, &memcmp_simple);
    printf("Numbers after: "); print_list("", nums);
    ft_lstclear(&nums1, &free);
    ft_lstclear(&nums, &free);

    // larger shuffled list
    t_list *shuf1 = NULL;
    t_list *shuf = NULL;
    const char *shuf_arr[] = {"delta", "alpha", "echo", "alpha", "alpha", "alpha"};
    create_list_from_array(&shuf1, shuf_arr, 6);
    create_list_from_array(&shuf, shuf_arr, 6);
    printf("Shuffled before: "); print_list("", shuf);
    list_sort(&shuf1, &memcmp_simple);
    printf("Shuffled after C (bubble): "); print_list("", shuf1);
    ft_list_sort(&shuf, &memcmp_simple);
    printf("Shuffled after (your asm): "); print_list("", shuf);
    ft_lstclear(&shuf, &free);
    ft_lstclear(&shuf1, &free);

    printf("\n=== Tests for list_remove_if ===\n\n");

    // remove 'alpha' from beginning/middle/end and various cases
    t_list *rm_head = NULL;
    const char *a1[] = {"alpha", "beta", "gamma"};
    create_list_from_array(&rm_head, a1, 3);
    printf("Before remove head: "); print_list("", rm_head);
    ft_list_remove_if(&rm_head, (void*)"alpha", &memcmp_simple, free);
    printf("After remove head: "); print_list("", rm_head);
    ft_lstclear(&rm_head, &free);

    t_list *rm_mid = NULL;
    const char *a2[] = {"one", "alpha", "two"};
    create_list_from_array(&rm_mid, a2, 3);
    printf("Before remove middle: "); print_list("", rm_mid);
    ft_list_remove_if(&rm_mid, (void*)"alpha", &memcmp_simple, free);
    printf("After remove middle: "); print_list("", rm_mid);
    ft_lstclear(&rm_mid, &free);

    t_list *rm_tail = NULL;
    const char *a3[] = {"a", "b", "alpha"};
    create_list_from_array(&rm_tail, a3, 3);
    printf("Before remove tail: "); print_list("", rm_tail);
    ft_list_remove_if(&rm_tail, (void*)"alpha", &memcmp_simple, free);
    printf("After remove tail: "); print_list("", rm_tail);
    ft_lstclear(&rm_tail, &free);

    t_list *rm_all = NULL;
    const char *a4[] = {"x", "x", "x"};
    create_list_from_array(&rm_all, a4, 3);
    printf("Before remove all: "); print_list("", rm_all);
    ft_list_remove_if(&rm_all, (void*)"x", &memcmp_simple, free);
    printf("After remove all: "); print_list("", rm_all);
    ft_lstclear(&rm_all, &free);

    t_list *rm_none = NULL;
    const char *a5[] = {"f", "r", "e", "e"};
    create_list_from_array(&rm_none, a5, 4);
    printf("Before remove none: "); print_list("", rm_none);
    ft_list_remove_if(&rm_none, (void*)"nope", &memcmp_simple, free);
    printf("After remove none: "); print_list("", rm_none);
    char *ptr = rm_none->data;
    ft_list_remove_if(&rm_none, (void*)"f", &memcmp_simple, NULL);
    printf("After remove f but with NULL ptr instead of free: "); print_list("", rm_none);
    free(ptr);
    ft_lstclear(&rm_none, &free);

    t_list *rm_empty = NULL;
    printf("Before remove on empty: "); print_list("", rm_empty);
    ft_list_remove_if(&rm_empty, (void*)"any", &memcmp_simple, free);
    printf("After remove on empty: "); print_list("", rm_empty);

    return 0;
}
