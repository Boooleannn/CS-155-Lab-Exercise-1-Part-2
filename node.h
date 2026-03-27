#ifndef NODE_H
#define NODE_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct Node {
    char *label;
    char *value;
    struct Node *left;
    struct Node *right;
} Node;

Node *create_node(const char *label, const char *value);
void print_tree(Node *node, int depth);
void free_tree(Node *node);

#endif