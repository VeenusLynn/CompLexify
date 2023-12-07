%{
int nb_ligne = 1;
int Col = 1;
%}

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*(\_?({lettre}|{chiffre})+)*
cst_int -?{chiffre}+
cst_real -?{cst_int}\.{cst_int}
cst_char \"({lettre}|{chiffre})+\"

comment %.*

%%

"PROGRAM" { 
    printf("keyword recognized %s \n", yytext);   
    Col= Col + strlen(yytext);
}
"REAL" { 
    printf("keyword recognized %s \n", yytext); 
    Col= Col + strlen(yytext); 
}
"INTEGER" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"LOGICAL" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"CHARACTER" { 
    printf("keyword recognized %s \n", yytext); 
    Col= Col + strlen(yytext); 
}
"END" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"IF" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"THEN" { 
    printf("keyword recognized %s \n", yytext);   
    Col= Col + strlen(yytext); 
}
"ELSE" { 
    printf("keyword recognized %s \n", yytext); 
    Col= Col + strlen(yytext); 
}
"ENDIF" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"WRITE" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"READ" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext); 
}
"DOWHILE" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext); 
}
"ENDDO" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"ROUTINE" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext); 
}
"ENDR" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"CALL" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext); 
}
"EQUIVALENCE" { 
    printf("keyword recognized %s \n", yytext);    
    Col= Col + strlen(yytext); 
}
"DIMENSION" { 
    printf("keyword recognized %s \n", yytext);    
    Col= Col + strlen(yytext);
}
"TRUE" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"FALSE" { 
    printf("keyword recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}


"GT" { 
    printf("sep recognized %s (>=)\n", yytext);  
    Col= Col + strlen(yytext);
}
"GE" { 
    printf("sep recognized %s (>)\n", yytext);  
    Col= Col + strlen(yytext);
}
"EQ" { 
    printf("sep recognized %s (==) \n", yytext);  
    Col= Col + strlen(yytext);
}
"NE" { 
    printf("sep recognized %s(!=) \n", yytext);  
    Col= Col + strlen(yytext);
}
"LE" { 
    printf("sep recognized %s (<=)\n", yytext);  
    Col= Col + strlen(yytext);
}
"LT" { 
    printf("sep recognized %s (<)\n", yytext);  
    Col= Col + strlen(yytext);
}


{IDF} {
    if (strlen(yytext) > 10){
        fprintf(stderr,"Warning : IDF longer than 10 chars\n");
    } else {
        printf("IDF recognized : %s\n",yytext);   
        Col= Col + strlen(yytext);
    }
}
{cst_int} {
    if (atoi(yytext) >= -32768 && atoi(yytext) <= 32767) {
        printf("cst integer recognized : %s\n",yytext);   
        Col= Col + strlen(yytext);
    } else {
        fprintf(stderr,"Warning : out of range \n");
    }
}
{cst_real} {
    if (atof(yytext) >= -32768.32767 && atof(yytext) <= 32767.32767) {
        printf("cst real recognized : %s\n",yytext);   
        Col= Col + strlen(yytext);
    } else {
        fprintf(stderr,"Warning : out of range \n");
    }
}
{cst_char} {
    if (strlen(yytext) <= 20) {
        printf("cst char recognized : %s\n",yytext);   
        Col= Col + strlen(yytext);
    } else {
        fprintf(stderr,"Warning : string out of range \n");
    }
}



"," { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}  
";" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"=" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"+" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"-" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"*" { 
    printf("sep recognized %s \n", yytext); 
    Col= Col + strlen(yytext);
}
"/" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"(" { 
    printf("sep recognized %s \n", yytext); 
    Col= Col + strlen(yytext);
}
")" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"." { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
"\"" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}
":" { 
    printf("sep recognized %s \n", yytext);  
    Col= Col + strlen(yytext);
}


{comment} { printf("comment \n");}

[\t]   
[ ] { Col++;}  
\n { 
    nb_ligne++;
    Col= 1; 
}

. { printf ("\n Erreur lexical: Ligne: %d; Colone: %d; Entity  %s  not recognized \n",nb_ligne, Col, yytext);}

%%


int main (){
    yylex ();
    return 0;
}
