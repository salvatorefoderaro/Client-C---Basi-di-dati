#include <stdio.h>
#include <stdlib.h>

struct listaResult {
  void *memory;
  struct listaResult *next;
} listaResult;

int freeList(struct listaResult *list){
    int counter = 0;
    struct listaResult *tempList;
    printf("Enter in the while?");
    while (list->next != NULL){
        printf("Enter in the while?");
        tempList = list;
        list = list->next;
        free(tempList);
        counter++;
    }

    printf("This is invalid?");
    free(list);
    return counter;
};

struct listaResult *getNode(){
        struct listaResult *node = malloc(sizeof(listaResult));
        node->memory = malloc(sizeof(char)*256);
        return node;
}