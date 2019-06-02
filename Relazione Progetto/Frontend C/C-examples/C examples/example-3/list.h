#include <stdio.h>
#include <stdlib.h>

struct listaResult {
  void *memory;
  struct listaResult *next;
} listaResult;

struct listaResult *getNode(){
        struct listaResult *node = malloc(sizeof(listaResult));
        node->memory = malloc(sizeof(char)*256);
        return node;
}