%{
#include "syntax.tab.h"

extern nb_line;
extern Col;
%}

letter [a-zA-Z]
number [0-9]
IDF {letter}({letter}|{number}|\_)*
cst_int -?{number}+
cst_real -?{cst_int}\.{cst_int}
/* cst_char \"({letter}|{number})+\" */
cst_char \".{1,20}\"
cst_logical "TRUE"|"FALSE"
string \"[^\"]+\"

comment %.*

%%

"PROGRAM" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return program_kw;
}
"REAL" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng; 
    return real_kw;
}
"INTEGER" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return integer_kw;
}
"LOGICAL" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return logical_kw;
}
"CHARACTER" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return character_kw;
}
"END" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return end_kw;
}
"IF" { 
    printf("Keyword recognized : %s\n", yytext); 
    Col += yyleng;
    return if_kw;
}
"THEN" { 
    printf("Keyword recognized : %s\n", yytext);  
    Col += yyleng; 
    return then_kw;
}
"ELSE" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return else_kw; 
}
"ENDIF" { 
    printf("Keyword recognized : %s\n", yytext);  
    Col += yyleng;
    return endif_kw;
}
"WRITE" { 
    printf("Keyword recognized : %s\n", yytext); 
    Col += yyleng;
    return write_kw;
}
"READ" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng; 
    return read_kw;
}
"DOWHILE" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng; 
    return dowhile_kw;
}
"ENDDO" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return enddo_kw;
}
"ROUTINE" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return routine_kw; 
}
"ENDR" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng;
    return endr_kw;
}
"CALL" { 
    printf("Keyword recognized : %s\n", yytext);
    Col += yyleng; 
    return call_kw;
}
"EQUIVALENCE" { 
    printf("Keyword recognized : %s\n", yytext); 
    Col += yyleng; 
    return equivalence_kw;
}
"DIMENSION" { 
    printf("Keyword recognized : %s\n", yytext); 
    Col += yyleng;
    return dimension_kw;
}


".AND." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return and;
}
".OR." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return or;
}
".GT." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return gt;
}
".GE." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return ge;
}
".EQ." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return eq;
}
".NE." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return ne;
}
".LE." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return le;
}
".LT." { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return lt;
}

{cst_logical} {   
    printf("Logical constant recognized : %s\n", yytext);
    Col += yyleng;
    return cst_logical;
}

{IDF} {
    if (strlen(yytext) > 10){
        fprintf(stderr,"Warning line %d : IDF longer than 10 chars\n",nb_line);
    } else {
        printf("IDF recognized : %s\n", yytext);
        Col += yyleng;
        return idf;
    }
}
{cst_int} {
    if (atoi(yytext) >= -32768 && atoi(yytext) <= 32767) {
        printf("Integer constant recognized : %s\n", yytext);
        Col += yyleng;
        return cst_int;
    } else {
        fprintf(stderr,"Warning line %d : Integer out of range \n",nb_line);
    }
}
{cst_real} {
    if (atof(yytext) >= -32768.32767 && atof(yytext) <= 32767.32767) {
        printf("Real constant recognized : %s\n", yytext);
        Col += yyleng;
        return cst_real;
    } else {
        fprintf(stderr,"Warning line %d : Real out of range \n",nb_line);
    }
}
{cst_char} {
        printf("Character constant recognized : %s\n", yytext);
        Col += yyleng;
        return cst_char;
}
{string} {
        printf("String recognized : %s\n", yytext);
        Col += yyleng;
        return string;
}



"," { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return comma;
}  
";" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return semi_colon;
}
"=" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return assign;
}
"+" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return plus;
}
"-" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return minus;
}
"*" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return mult;
}
"/" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return divi;
}
"(" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return lpar;
}
")" { 
    printf("separator recognized : %s\n", yytext);
    Col += yyleng;
    return rpar;
}


{comment} { 
    printf("Comment recognized \n");
}

[\t ] { 
    Col += yyleng;
} 
\n { 
    nb_line++;
    Col= 1; 
}

. { 
    printf ("\nLexical Error at Line: %d ; Column: %d ; Entity  %s  not recognized \n",nb_line, Col, yytext);
    Col += yyleng;  
    // Terminate the lexer
    printf("Lexical error encountered. Stopping further processing.\n");
    yyterminate();  
}

%%
