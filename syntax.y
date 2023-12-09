%{
int nb_line = 1;
int Col = 1; 
%}

%union {
    int integer;
    char* string;
    float real;
}

%token idf cst_int cst_real cst_char cst_logical program_kw real_kw integer_kw logical_kw character_kw end_kw if_kw then_kw else_kw endif_kw write_kw read_kw dowhile_kw enddo_kw routine_kw endr_kw call_kw equivalence_kw dimension_kw true_kw false_kw gt ge eq ne le lt comma semi_colon assign plus minus mult divi lpar rpar dot quote colon 

// associativity and precedence
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

DEC : TYPE LIST_IDF semi_colon 
;

TYPE : real_kw | integer_kw | logical_kw | character_kw 
;

LIST_IDF : idf |  LIST_IDF comma idf
;

LIST_INST : LIST_INST INST |
;

INST : ASSIGN | READ | CALL
;

ASSIGN : idf assign EXPR semi_colon
;

READ : read_kw lpar idf rpar semi_colon
;

CALL : idf assign call_kw idf lpar LIST_IDF rpar semi_colon
;

EXPR : OPERAND | lpar EXPR rpar | EXPR OPERATOR OPERAND
;

OPERAND : idf | cst_int | cst_real | cst_char | cst_logical | true_kw | false_kw
;

OPERATOR : plus | minus | mult | divi 
;


%%


int yyerror(char *msg)
{
    printf("Syntax Error at Line: %d ; Column: %d ; \n",nb_line, Col);
    return 1;
}

main ()
{
    yyparse();
}
yywrap()
{}
 