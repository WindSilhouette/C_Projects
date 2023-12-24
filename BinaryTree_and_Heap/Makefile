CC = gcc -Wall -g
TEST = -DTEST

all: huffman heaptest treetest

huffman: huffman.o heap.o tree.o code.o
	$(CC) -o huffman huffman.o heap.o tree.o code.o

heaptest: heaptest.o 
	$(CC) -o heaptest heaptest.o

treetest: treetest.o heap.o
	$(CC) -o treetest treetest.o heap.o


heaptest.o: heap.c heap.h 
	$(CC) -c -DTEST -o heaptest.o heap.c

treetest.o: tree.c tree.h 
	$(CC) -c -DTEST -o treetest.o tree.c

heap.o: heap.h heap.c

tree.o: tree.h tree.c

code.o: code.h code.c

huffman.o: huffman.c

clean:
	rm -rf *.o huffman heaptest treetest
