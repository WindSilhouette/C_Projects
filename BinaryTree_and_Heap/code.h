#ifndef CODE_H
#define CODE_H

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>

#include "tree.h" 
#include "heap.h" 

extern char huffman_code[256][20];
 
void init_code();
void gen_code(huffman_tree_node *node, int pos); 
void print_code();

#endif
