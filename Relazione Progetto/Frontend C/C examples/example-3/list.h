#include <stdio.h>
#include <stdlib.h>

struct listaResult {
  void *memory;
  struct listaResult *next;
} listaResult;

void freeList(struct listaResult *list){
    while (list->next != NULL){
        struct listaResult *tempList = list;
        list = list->next;
        free(tempList);
    }
    free(list);
    printf("To implement!");
};