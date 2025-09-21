#include "../include/mystrfunctions.h"

// Custom implementation of strlen
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }
    return len;
}

// Custom strcpy
int mystrcpy(char* dest, const char* src) {
    int i = 0;
    while ((dest[i] = src[i]) != '\0') {
        i++;
    }
    return i; // return number of chars copied
}

// Custom strncpy
int mystrncpy(char* dest, const char* src, int n) {
    int i = 0;
    while (i < n && src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return i;
}

// Custom strcat
int mystrcat(char* dest, const char* src) {
    int i = 0, j = 0;
    while (dest[i] != '\0') i++;
    while ((dest[i++] = src[j++]) != '\0');
    return i - 1; // length of new string
}
