#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

int ft_atoi_base(char *str, char *base);

void test_case(char *str, char *base, int expected, char *description) {
    int result = ft_atoi_base(str, base);
    printf("Test: %s\n", description);
    printf("  Input: str=\"%s\", base=\"%s\"\n", str ? str : "NULL", base ? base : "NULL");
    printf("  Expected: %d, Got: %d -> %s\n\n", 
           expected, result, (result == expected) ? "✅ PASS" : "❌ FAIL");
}

int main(int ac, char **av) {
    printf("=== Tests ft_atoi_base ===\n\n");
    
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
    test_case("42", "0", 0, "Base trop courte");
    test_case("42", "01+", 0, "Base avec +");
    test_case("42", "01-", 0, "Base avec -");
    test_case("42", "01 ", 0, "Base avec espace");
    test_case("42", "011", 0, "Base avec doublons");
    test_case("42", "01\t", 0, "Base avec tab");
    test_case("1", "0123456789", 1, "Base OK");
    
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
    
    printf("=== Tests terminés ===\n");
    return 0;
}