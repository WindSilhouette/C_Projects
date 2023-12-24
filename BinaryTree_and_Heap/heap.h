#ifndef HEAP_H
#define HEAP_H

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>

#include "tree.h"


// Type declaration for the heap nodes
typedef struct _Heap_Node {
	char c;     // The symbol 
	int freq;   // The frequency of the symbol 
	struct _Huffman_Node *t_node;  // Pointer to the corresponding huffman tree node
} HeapNode;  

// The heap data structure and the size 
extern HeapNode heap[256];
extern int heapSize;

// Heap functions:  
// These functions maintain heap such that the node with the smallest freq is at the head of the heap.   
void heapInit();
void HeapInsert(char c, huffman_tree_node *t, int freq);
HeapNode DeleteMin();

void heapPrint(); 
 
#endif // HEAP_H
