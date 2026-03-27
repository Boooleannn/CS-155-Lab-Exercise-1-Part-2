#include "node.h"

Node *create_node(const char *label, const char *value) {
    Node *n = malloc(sizeof(Node));
    n->label = strdup(label);
    n->value = value ? strdup(value) : NULL;
    n->left = NULL;
    n->right = NULL;
    return n;
}

void print_tree(Node *node, int depth) {
    if (!node) return;
    
    for (int i = 0; i < depth; i++) printf("  ");
    printf("%s\n", node->label);
    
    if (node->value && strcmp(node->value, "(") == 0) {
        for (int i = 0; i < depth + 1; i++) printf("  ");
        printf("(\n");
        
        if (node->left) print_tree(node->left, depth + 1);
        
        if (node->right) {
            for (int i = 0; i < depth + 1; i++) printf("  ");
            printf(")\n");
        }
        return;
    }

    if (node->left) print_tree(node->left, depth + 1);
    

    if (node->value) {
        for (int i = 0; i < depth + 1; i++) printf("  ");
        printf("%s\n", node->value);
    }
    
    if (node->right) print_tree(node->right, depth + 1);
}

void free_tree(Node *node) {
    if (!node) return;
    free(node->label);
    free(node->value);
    free_tree(node->left);
    free_tree(node->right);
    free(node);
}