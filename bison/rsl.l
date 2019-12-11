%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "rsl.tab.h"

    void yyerror(const char *);
    int yywrap();    
%}


%%

[0-9]+                          { yylval.double_val = atof(yytext); /*printf("VAL\n");*/ return VAL;}
[0-9]+"."[0-9]+                 { yylval.double_val = atof(yytext); /*printf("VAL\n");*/ return VAL;}
[A-Za-z_]+[a-zA-Z_0-9]*         {   
                                    int i;

                                   

                                    memset(&yylval.input_var_string[0], 0, sizeof(yylval.input_var_string));

                                   

                                    for(i = 0; i < strlen(yytext); i++)
                                    {
                                        yylval.input_var_string[i] = yytext[i];
                                    }
                                    
                                    /*printf("input_var_string AFTER: %s\n",yylval.input_var_string);
                                    printf("VAR   %s\n",yytext);*/ 

                                    return VAR;
                                }
"<ii>"                          {/*printf("DEC\n");*/ return DEC;}
"<id>"                          {/*printf("DEC\n");*/ return DEC;}
"<+>"                           {/*printf("ADD\n");*/ return ADD;}
"<->"                           {/*printf("SUB\n");*/ return SUB;}
"<*>"                           {/*printf("MUL\n");*/ return MUL;}
"</>"                           {/*printf("DIV\n");*/ return DIV;}
"<>>"                           {/*printf("GRE\n");*/ return GRE;}
"<<>"                           {/*printf("LES\n");*/ return LES;}
"<>=>"                          {/*printf("GEQ\n");*/ return GEQ;}
"<<=>"                          {/*printf("LEQ\n");*/ return LEQ;}
"<=>"                           {/*printf("EQUAL\n");*/ return EQUAL;}
"<;>"                           {/*printf("END\n");*/ return END;}
"<(>"                           {/*printf("LFB\n");*/ return LFB;}
"<)>"                           {/*printf("RFB\n");*/ return RFB;}
", "                            {/*printf("COM\n");*/ return COM;}
"<print>"                       {/*printf("PRINT\n");*/ return PRINT;}
"<iif>"                         {/*printf("IIF\n");*/ return IIF;}
">>"                            {/*printf("STMT\n");*/ return STMT;}
"<eif>"                         {/*printf("EIF\n");*/ return EIF;}
"<ndf>"                         {/*printf("NDF\n");*/ return NDF;}
"["                             {/*printf("LTB\n");*/ return LTB;}
"]"                             {/*printf("RTB\n");*/ return RTB;}
"<match>"                       {/*printf("MAT\n");*/ return MAT;}
"<:>"                           {/*printf("COL\n");*/ return COL;}
"<?>"                           {/*printf("CAS\n");*/ return CAS;}
"<ncase>"                       {/*printf("NCAS\n");*/ return NCAS;}
"<dflt>"                        {/*printf("DFLT\n");*/ return DFLT;}
"<loop>"                        {/*printf("LOOP\n");*/ return LOOP;}
"<nmatch>"                      {/*printf("NMAT\n");*/ return NMAT;}
"<in>"                          {/*printf("IN\n");*/ return IN;}
"<..>"                          {/*printf("TO\n");*/ return TO;}
"<lend>"                        {/*printf("LEND\n");*/ return LEND;}
"<while>"                       {/*printf("WHILE\n");*/ return WHILE; }
"<inc>"                         {/*printf("INC\n");*/ return INC; }
"<factorial>"                   {/*printf("FACTORIAL\n");*/ return FACTORIAL; }
"<gcd>"                         {/*printf("GCD\n");*/ return GCD; }
"<sqrt>"                        {/*printf("SQRT\n");*/ return SQRT; }
"<evenodd>"                     {/*printf("EVENODD\n");*/ return EVENODD; }



[0-9]+[A-Za-z0-9_]+             {printf("SyntaxError: Invalid Variable Name \n");}
[ \n\t]+                        { ;}

%%


int yywrap(){

}

void yyerror(const char *msg){
    printf("ParseError: %s", msg);
}

int main(){
    yyin = freopen("input.txt", "r", stdin);
    yyout = freopen("output.txt", "w", stdout);
    yyparse();
}