#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

// Count words, lines, chars
int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;
    char c;
    *lines = *words = *chars = 0;
    int inWord = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if (c == ' ' || c == '\n' || c == '\t') {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }
    rewind(file);
    return 0;
}

// Search lines containing search_str
int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp) return -1;

    size_t size = 0, capacity = 10;
    *matches = malloc(capacity * sizeof(char*));
    char line[1024];

    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, search_str)) {
            if (size == capacity) {
                capacity *= 2;
                *matches = realloc(*matches, capacity * sizeof(char*));
            }
            (*matches)[size] = strdup(line);
            size++;
        }
    }
    rewind(fp);
    return (int)size;
}
