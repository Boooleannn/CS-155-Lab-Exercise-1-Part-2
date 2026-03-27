%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "node.h"

void yyerror(const char *msg);
int yylex(void);

Node *root = NULL;
%}

%union {
    int ival;
    double fval;
    Node *node;
}

%token <ival> NUM
%token <fval> FNUM
%token PLUS MINUS TIMES DIVIDE POWER LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER
%right UMINUS

%type <node> expr term factor program

%%

program: expr { 
    root = $1; 
    print_tree(root, 0); 
    free_tree(root); 
    printf("\n"); 
} ;

expr: expr PLUS term   
    { 
        $$ = create_node("expr", "+");
        $$->left = $1;
        $$->right = $3;
    }
    | expr MINUS term  
    { 
        $$ = create_node("expr", "-");
        $$->left = $1;
        $$->right = $3;
    }
    | term             
    { 
        $$ = create_node("expr", NULL); /* Wrap term in expr */
        $$->left = $1; 
    } ;

term: term TIMES factor   
    { 
        $$ = create_node("term", "*");
        $$->left = $1;
        $$->right = $3;
    }
    | term DIVIDE factor  
    { 
        $$ = create_node("term", "/");
        $$->left = $1;
        $$->right = $3;
    }
    | factor              
    { 
        $$ = create_node("term", NULL); /* Wrap factor in term */
        $$->left = $1; 
    } ;

factor: NUM                   
    { 
        char buf[20];
        sprintf(buf, "%d", $1);
        $$ = create_node("factor", buf);
    }
    | FNUM
    { 
        char buf[20];
        sprintf(buf, "%f", $1);
        $$ = create_node("factor", buf);
    }
    | LPAREN expr RPAREN    
    { 
        $$ = create_node("factor", "(");
        $$->left = $2;  
        $$->right = create_node(")", NULL);
    }
    | MINUS factor %prec UMINUS 
    { 
        $$ = create_node("factor", "-");
        $$->left = $2;
    }
    | factor POWER factor
    { 
        $$ = create_node("factor", "^");
        $$->left = $1;
        $$->right = $3;
    } ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Parse error: %s\n", msg);
}

int main(void) {
    return yyparse();
}