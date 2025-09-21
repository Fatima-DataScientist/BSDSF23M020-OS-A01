#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[50] = "Hello";
    char str2[50];

    printf("Length of '%s' = %d\n", str1, mystrlen(str1));
    mystrcpy(str2, str1);
    printf("Copied string: %s\n", str2);
    mystrcat(str1, " World");
    printf("Concatenated string: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* f = fopen("test.txt", "r");
    if (!f) {
        printf("Cannot open test.txt\n");
        return 1;
    }

    int lines, words, chars;
    wordCount(f, &lines, &words, &chars);
    printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);

    char** matches;
    int count = mygrep(f, "Hello", &matches);
    printf("Found %d matches:\n", count);
    for (int i = 0; i < count; i++) {
        printf("%s", matches[i]);
        free(matches[i]);
    }
    free(matches);

    fclose(f);
    return 0;
}
