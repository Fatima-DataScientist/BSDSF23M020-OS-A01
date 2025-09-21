#ifndef MYFILEFUNCTIONS_H
#define MYFILEFUNCTIONS_H

#include <stdio.h>

// Count words, lines, and characters from a file stream.
// Returns 0 on success and -1 on failure.
int wordCount(FILE* file, int* lines, int* words, int* chars);

// Search lines containing search_str in a file.
// Matches are stored in a dynamically allocated array.
// Returns the count of matches, or -1 on failure.
int mygrep(FILE* fp, const char* search_str, char*** matches);

#endif

