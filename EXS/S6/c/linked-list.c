#include "linked-list.h"
#include <stdlib.h>
#include <stdio.h>

struct List *list_create()
{
    struct List *list = malloc(sizeof(struct List));
	list->first = NULL;
	return list;	
}

status list_append(struct List *list, int value)
{
	if (list == NULL) {
		return -1;
	}
    struct ListNode *node = malloc(sizeof(struct ListNode));
	node->value = value;
	node->next = NULL;
	
	if (list->first == NULL) {
		list->first = node;
	}
	else {
		struct ListNode *lastNode = list->first;
		while (lastNode->next != NULL) {
			lastNode = lastNode->next;
		}
		lastNode->next = node;
	}
	return 1;
}

int list_length(struct List *list)
{
	if (list == NULL) {
		return -1;
	}
		
	if (list->first == NULL) {
		return 0;
	}
	else {
		struct ListNode *lastNode = list->first;
		int count = 1;
		while (lastNode->next != NULL) {
			lastNode = lastNode->next;
			count++;
		}
		return count;
	}
	
}

status list_get(struct List *list, int index, int *value)
{
	if (list == NULL) {
		return -1;
	}
	if (index >= list_length(list)) {
		return -3;
	}
	if (index < 0) {
		return -3;
	}
	if (value == NULL) {
		return -4;
	}
	else {
		struct ListNode *currNode = list->first;
		while (index > 0) {
			currNode = currNode->next;
			index--;
		}
		*value = currNode->value;
		return 1;
	}
}

status list_print(struct List *list)
{
    if (list == NULL)
		return -1;
	
	struct ListNode *lastNode = list->first;
	printf("LinkedList = {%d", lastNode->value);
	while (lastNode->next != NULL) {
		lastNode = lastNode->next;
		printf(" ,%d", lastNode->value); 
	}
	printf("}\n");
	return 1;
}

status list_remove_item(struct List *list, int index)
{

	if (list == NULL) {
		return -1;
	}
	if (index >= list_length(list)) {
		return -3;
	}
	if (index < 0) {
		return -3;
	}
	
	struct ListNode *oldNode = NULL;
	struct ListNode *currNode = list->first;
	while (index > 0) {
		oldNode = currNode;
		currNode = currNode->next;
		index--;
	}
	if (oldNode != NULL) {
		oldNode->next = currNode->next;
	} else {
		list->first = currNode->next;
	}
	free(currNode);
	return 1;
}

status list_delete(struct List *list)
{
	if (list == NULL) {
		return -1;
	}
	
	struct ListNode *nextNode = list->first;
	while (nextNode != NULL) {
		struct ListNode *toBeDeletedNode = nextNode;
		nextNode = nextNode->next;
		free(toBeDeletedNode);
	}
	free(list);
	return 1;
}

status list_insert(struct List *list, int index, int value)
{
    if (list == NULL) {
		return -1;
	}
	if (index > list_length(list) || index < 0) {
		return -3;
	}
	
	struct ListNode *currNode = list->first;
	struct ListNode *newNode = malloc(sizeof(struct ListNode));
	
	if (index == 0) {
		newNode->next = list->first;
		newNode->value = value;
		list->first = newNode;
	}
	
	else {
		struct ListNode *oldNode;
		while (index > 0) {
			oldNode = currNode;
			currNode = currNode->next;
			index--;
		}
		oldNode->next = newNode;
		newNode->next = currNode;
		newNode->value = value;
	}
	return 1;
}
