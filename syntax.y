%{
#include <stdio.h>
#include <string.h>

char currentFileName[100];

int nb_line = 1;
int Col = 1; 
%}

%token idf cst_int cst_real cst_char cst_logical program_kw real_kw integer_kw logical_kw character_kw end_kw if_kw then_kw else_kw endif_kw write_kw read_kw dowhile_kw enddo_kw routine_kw endr_kw call_kw equivalence_kw dimension_kw true_kw false_kw and or gt ge eq ne le lt comma semi_colon assign plus minus mult divi lpar rpar string 

// associativity and precedence
%left or
%left and
%left gt ge eq ne le lt
%left plus minus
%left mult divi

// axiom
%start S

%%

S : LIST_ROUTINE program_kw idf PRGM end_kw {
    printf("Syntax correct ! \n");
    YYACCEPT;
};

LIST_ROUTINE : LIST_ROUTINE ROUTINE | 
;

PRGM : LIST_DEC LIST_INST 
;

ROUTINE : TYPE routine_kw idf lpar LIST_IDF rpar PRGM endr_kw 
;

LIST_DEC : LIST_DEC DEC |
;

DEC : DEC_SIMPLE | DEC_TAB | DEC_AFFECTATION | DEC_CHAR
;

DEC_SIMPLE : TYPE LIST_IDF semi_colon
;

DEC_CHAR : character_kw idf mult cst_int semi_colon 
| character_kw LIST_IDF semi_colon
;

DEC_TAB : TYPE idf dimension_kw lpar DIMENSION rpar semi_colon
;

DEC_AFFECTATION : TYPE LIST_AFFECTATION semi_colon
;

LIST_AFFECTATION : AFFECTATION | LIST_AFFECTATION comma AFFECTATION
;

AFFECTATION : idf assign EXPR
;

DIMENSION : cst_int | DIMENSION comma cst_int 
;

TYPE : real_kw | integer_kw | logical_kw 
;

LIST_IDF : idf |  LIST_IDF comma idf
;

LIST_INST : LIST_INST INST |
;

INST : ASSIGN | READ | WRITE | EQUIVALENCE | CALL | IF | DOWHILE 
;

ASSIGN : AFFECTATION semi_colon
;

EQUIVALENCE : equivalence_kw lpar LIST_EQUIV rpar comma lpar LIST_EQUIV rpar semi_colon
;

LIST_EQUIV : EQUIV | LIST_EQUIV comma EQUIV
;

EQUIV : idf | APPEL_TAB
;

READ : read_kw lpar LIST_IDF rpar semi_colon
;

WRITE : write_kw lpar LIST_OUTPUT rpar semi_colon
;

LIST_OUTPUT : OUTPUT | LIST_OUTPUT comma OUTPUT
;

OUTPUT : EXPR | string 
;

CALL : idf assign call_kw idf lpar LIST_IDF rpar semi_colon
;

LIST_EXPR : EXPR | LIST_EXPR comma EXPR

EXPR : EXPR plus EXPR 
| EXPR minus EXPR
| EXPR mult EXPR
| EXPR divi EXPR
| lpar EXPR rpar 
| OPERAND 
;

OPERAND : idf | cst_int | cst_real | cst_char | cst_logical | APPEL_TAB
;

APPEL_TAB : idf lpar LIST_EXPR rpar
;

LOGICAL : true_kw | false_kw
;

IF : if_kw lpar LIST_COND rpar then_kw LIST_INST else_kw LIST_INST endif_kw
;

LIST_COND : COND | LIST_COND OPERATOR COND
;

COND : EXPR ge EXPR
| EXPR gt EXPR
| EXPR eq EXPR
| EXPR ne EXPR
| EXPR le EXPR
| EXPR lt EXPR
| lpar COND rpar
| LOGICAL 
;

OPERATOR : and | or
;

DOWHILE : dowhile_kw lpar LIST_COND rpar LIST_INST enddo_kw semi_colon
;

%%


int yyerror(char *msg)
{   
    fprintf(stderr,"\n\nFile: %s. Syntax Error at Line: %d , Column: %d ; \n",currentFileName, nb_line, Col);
    return 1;
}

int main(int argc, char *argv[]) 
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    // Store the file name from command-line arguments
    strncpy(currentFileName, argv[1], sizeof(currentFileName) - 1);
    currentFileName[sizeof(currentFileName) - 1] = '\0';

    // Open the file for parsing
    FILE *inputFile = fopen(argv[1], "r");
    if (inputFile == NULL) {
        fprintf(stderr, "Error opening file.\n");
        return 1;
    }

    yyrestart(inputFile);

    initST();
    yyparse();
    displayST();

    fclose(inputFile);
}
yywrap()
{}
 