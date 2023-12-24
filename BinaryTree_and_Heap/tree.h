#ifndef TREE_H
#define TREE_H

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>

#include "heap.h"

typedef struct _Huffman_Node {
    char c;
    struct _Huffman_Node *left, *right;
} huffman_tree_node;

// Root for huffman tree
extern huffman_tree_node *huffman_tree;
 
// Building the huffman tree
void build_huffman_tree();
void print_huffman_tree(huffman_tree_node *root, int level);

#endif // TREE_H
