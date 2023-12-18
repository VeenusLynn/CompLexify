#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct nodeIC
{
    int state;
    char name[20];
    char code[20];
    char type[20];
    float val;
    struct nodeIC *next;
} nodeIC;

typedef struct nodeKS
{
    int state;
    char name[20];
    char type[20];
    struct nodeKS *next;
} nodeKS;

nodeIC *symbolTableIDF;
nodeKS *symbolTableSeparator;
nodeKS *symbolTableKeyword;

// initialisation of the symbol tables
void initST()
{
    symbolTableIDF = NULL;
    symbolTableSeparator = NULL;
    symbolTableKeyword = NULL;
}

// insertion of an element in the symbol tables

void insertIC(nodeIC **head, char entity[], char code[], char type[], float val)
{
    nodeIC *newNodeIC = (nodeIC *)malloc(sizeof(nodeIC));
    if (newNodeIC == NULL)
    {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    newNodeIC->state = 1;
    strcpy(newNodeIC->name, entity);
    strcpy(newNodeIC->code, code);
    strcpy(newNodeIC->type, type);
    newNodeIC->val = val;
    newNodeIC->next = *head;
    *head = newNodeIC;
}

void insertKS(nodeKS **head, char entity[], char code[])
{
    nodeKS *newNodeKS = (nodeKS *)malloc(sizeof(nodeKS));
    if (newNodeKS == NULL)
    {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    newNodeKS->state = 1;
    strcpy(newNodeKS->name, entity);
    strcpy(newNodeKS->type, code);
    newNodeKS->next = *head;
    *head = newNodeKS;
}

void insert(char entity[], char code[], char type[], float val, int y)
{
    switch (y)
    {
    case 0:
        // insert in the symbol table IDF and CONST
        insertIC(&symbolTableIDF, entity, code, type, val);
        break;

    case 1:
        // insert in the symbol table Keyword
        insertKS(&symbolTableKeyword, entity, code);
        break;

    case 2:
        // insert in the symbol table Separator
        insertKS(&symbolTableSeparator, entity, code);
        break;
    }
}

// search for an element in the symbol tables and insert it if it doesn't exist
void searchIC(nodeIC **head, char entity[], char code[], char type[], float val)
{
    nodeIC *current = *head;
    while (current != NULL)
    {
        if (strcmp(current->name, entity) == 0)
        {
            // printf("entity already exists\n");
            return;
        }
        current = current->next;
    }
    insertIC(head, entity, code, type, val);
}

void searchKS(nodeKS **head, char entity[], char code[])
{
    nodeKS *current = *head;
    while (current != NULL)
    {
        if (strcmp(current->name, entity) == 0)
        {
            // printf("entity already exists\n");
            return;
        }
        current = current->next;
    }
    insertKS(head, entity, code);
}

void search(char entity[], char code[], char type[], float val, int y)
{
    switch (y)
    {
    case 0:
        // search in the symbol table IDF and CONST
        searchIC(&symbolTableIDF, entity, code, type, val);
        break;

    case 1:
        // search in the symbol table Keyword
        searchKS(&symbolTableKeyword, entity, code);
        break;

    case 2:
        // search in the symbol table Separator
        searchKS(&symbolTableSeparator, entity, code);
        break;
    }
}

void displayIC(nodeIC *head)
{
    nodeIC *current = head;
    printf("\n\n\n\t\t\t\t\tSymbol Table IDF and CONST:\t\t\t\t\t\n\n\n");
    printf("\tState\t|\tname\t|\tcode\t|\ttype\t|\tval\t\t|\t\n");
    printf("_________________________________________________________________________________________________\n");
    while (current != NULL)
    {
        printf("\t%d\t|\t%s\t|\t %s\t|\t%s\t|\t %f\t|\t\n", current->state, current->name, current->code, current->type, current->val);
        printf("_________________________________________________________________________________________________\n");
        current = current->next;
    }
}

void displayKS(nodeKS *head)
{
    nodeKS *current = head;
    printf("\tState\t|\tname\t|\ttype\t|\t\n");
    printf("_____________________________________________________________\n");

    while (current != NULL)
    {
        printf("\t%d\t|\t%s\t|\t %s\t|\t\n", current->state, current->name, current->type);
        printf("_____________________________________________________________\n");
        current = current->next;
    }
}

void displayST()
{
    displayIC(symbolTableIDF);
    printf("\n\n\n\t\t\t\t\tSymbol Table Separator :\t\t\t\t\t\n\n\n");
    displayKS(symbolTableSeparator);
    printf("\n\n\n\t\t\t\t\tSymbol Table Keyword :\t\t\t\t\t\n\n\n");
    displayKS(symbolTableKeyword);
}

// free all the memory allocated for the symbol tables
void freeIC(nodeIC **head)
{
    nodeIC *current = *head;
    nodeIC *next;

    while (current != NULL)
    {
        next = current->next;
        free(current);
        current = next;
    }

    *head = NULL;
}

void freeKS(nodeKS **head)
{
    nodeKS *current = *head;
    nodeKS *next;

    while (current != NULL)
    {
        next = current->next;
        free(current);
        current = next;
    }

    *head = NULL;
}

void freeST()
{
    freeIC(&symbolTableIDF);
    freeKS(&symbolTableSeparator);
    freeKS(&symbolTableKeyword);
}
