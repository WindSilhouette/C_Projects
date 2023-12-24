#include "heap.h"
 
// The root to the Huffman tree
huffman_tree_node *huffman_tree= NULL;

/**********************************************************************************************
 *
 * Declare and define any local function here to support your implementation of the heap
 *
 **********************************************************************************************/


/* 
 * Create a single tree node initialized with the given parameters 
 */

huffman_tree_node* create_node(char c, huffman_tree_node* l, huffman_tree_node* r) {
    huffman_tree_node* node = malloc(sizeof(huffman_tree_node)); 

    node->c = c;
    node->left = l;
    node->right = r;
 
    return node;
}
 
/* 
 * Builds Huffman Tree 
 * 1. Step through the heap and initialize t_node with a new huffman tree node 
 * 2. Repeat while there are more than 1 elements in the heap: 
 *    2a. Remove two elements from the heap
 *    2b. Create a new huffman tree node 
 *    2c. Reinsert a new heap element that is the parent of thw two deleted elements
 * 3. The last element in the heap contains the root of the huffman tree
 */

void build_huffman_tree()
{
	for(int i = 1; i <= heapSize; i++){
		heap[i].t_node = create_node(heap[i].c, NULL, NULL);
	}
	while (heapSize > 1) {
        // Step 2: remove the two smallest elements from the heap
        HeapNode e1 = DeleteMin();
        HeapNode e2 = DeleteMin();

        // create a new Huffman tree node with the two removed elements as its children
        huffman_tree_node* new_node = create_node(0, e1.t_node, e2.t_node);

        // insert the new node into the heap
        HeapInsert(0, new_node, e1.freq + e2.freq);
    }

    // Step 3: the last remaining element in the heap is the root of the Huffman tree
    //HeapNode e = DeleteMin();
    huffman_tree = heap[heapSize].t_node;

} 

void print_huffman_tree(huffman_tree_node *root, int level)  {
	int i; 

	if(level == 0)
	   printf("\n----------------\n  TREE BEGIN\n-----------------\n");


	if(root == NULL)
		return;

	for(i = 0; i < level; i++)
		printf("   ");

	if(root->left != NULL || root->right != NULL) 
		printf("Node (I)\n");
	else if(isprint(root->c)) 
		printf("Node %d(%c)\n", root->c, root->c);
	else 
		printf("Node %d(--)\n", root->c);


	print_huffman_tree(root->left, level + 1);
	print_huffman_tree(root->right, level + 1);

	if(level == 0)
        	printf("\n-----------\n  TREE END\n------------\n");
}

#ifdef TEST

int main() {
    heapInit();

    HeapInsert('a', NULL, 44);
    HeapInsert('b', NULL, 32);
    HeapInsert('d', NULL, 99);
    HeapInsert('f', NULL, 43);
    HeapInsert('u', NULL, 51);
    HeapInsert('y', NULL, 1);

    build_huffman_tree();
    print_huffman_tree(huffman_tree, 0); 
    return 0;
}

#endif // TEST
