%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    //sym holds the variables, so basically maximum variable declaration is set to 1000 for now
    char sym[1000][1000];
    //values hold the corresponding values of variables according to index
    //for example values[0] hold the values for the variable contained in sym[0][]
    double values[1000];

    float ifOpValues[1000];

    int currentIfOp = 0;

    int current = 0;

    char dump;

    char input[1000];
    int inval;

    int choice;

    int matchedStringValue = 0;

    double switchValue = 0;
    int printedCaseBefore = 0;

    int wasItDeclaredBefore(char string[1000]);
    int matchStrings(char string1[1000], char string2[1000]);
    int getIndexNumber(char string[1000]);
    void pushIfOpValues(float );
    void resetIfOpValues();
    void printIfOpValues();

    extern void yyerror(const char *);
    extern int yylex();

 int factorial(int n)
{
  int c;
  int result = 1;
 
  for (c = 1; c <= n; c++)
    result = result * c;
 
  return result;
}

 int gcd(int x,int y)
 {
        int i;
        int res=0;
        for(i=1;i<=x,i<=y;i++)
         {
         if(x%i==0 && y%i==0)
         res=i;
         }
      return res;

 }

 int evenodd(int x)
  {
        
        if(x%2==0)
          printf("The number is even\n");
        else
          printf("The number is odd\n");
  }

%}

%union{
    int int_val;
    double double_val;
    char input_var_string[1000];
}

%start program
%token <double_val> ADD SUB MUL DIV GRE LES GEQ LEQ END VAL LFB RFB PRINT EQUAL DEC COM  IIF STMT EIF NDF LTB RTB DFLT MAT CAS LOOP LEND IN TO NCAS NMAT COL WHILE INC FACTORIAL GCD  SQRT EVENODD
%token <input_var_string>   VAR
%type <double_val> expression ifelse

%%

program: program root_node 
       | root_node 
       ;

root_node: expression END                                       { printf("Expression: %f\n", $1); }
         | statement END                                        { ; }
         | ifelse
         | forloop
         | switch
         | fwhile
         | increment
         | fact
         | fgcd
         | fsqrt
         | evenodd
         ;

expression: expression GRE expression                           { $$ = $1 > $3; }
          | expression LES expression                           { $$ = $1 < $3; }
          | expression GEQ expression                           { $$ = $1 >= $3; }
          | expression LEQ expression                           { $$ = $1 <= $3; }
          | expression ADD expression                           { $$ = $1 + $3; }
          | expression SUB expression                           { $$ = $1 - $3; }
          | expression DIV expression                           { 
                                                                  if($3 == 0)
                                                                  {
                                                                      printf("ERROR: Divide By Zero Error\n");
                                                                      exit(0);
                                                                  } 
                                                                  $$ = $1 / $3;
                                                                }
          | expression MUL expression                           { $$ = $1 * $3; }
          | LFB expression RFB                                  { $$ = $2; }
          | VAL                                                 { $$ = $1; }
          | VAR                                                 {
                                                                    int result;
                                                                    result = wasItDeclaredBefore($1);
                                                                    int indexOfVar;
                                                                    int valueOfVar = 0;
                                                                    if(result == 0)
                                                                    {
                                                                        printf("ERROR: Wasn't declared before\n");
                                                                        exit(0);
                                                                    }
                                                                    else
                                                                    {
                                                                        printf("Declared Before\n");

                                                                        indexOfVar = getIndexNumber($1);
                                                                        valueOfVar = values[indexOfVar];
                                                                    }
                                                                    
                                                                    $$ = valueOfVar;
                                                                }
          ;

statement: VAR EQUAL expression                                 {
                                                                    
                                                                    int result;
                                                                    result = wasItDeclaredBefore($1);

                                                                    if(result == 0)
                                                                    {
                                                                        printf("ERROR: Wasn't declared before\n");
                                                                        exit(0);
                                                                        
                                                                    }
                                                                    else{
                                                                      //  printf("declared before\n");

                                                                        int indexOfVar = getIndexNumber($1);
                                                                        values[indexOfVar] = $3;

                                                                    }    

                                                                    
                                                                }
         | PRINT VAR                                            {
                                                                    
                                                                    int result1;
                                                                    result1 = wasItDeclaredBefore($2);

                                                                    if(result1 == 0)
                                                                    {
                                                                        printf("Wasn't declared before\n");
                                                                    }
                                                                    else{
                                                                        //this works because wasItDeclaredBefore automatically sets 
                                                                        //the matchedStringValue to the value if the variable already
                                                                        //exists
                                                                        printf("Var value: %d\n", matchedStringValue);
                                                                    }    
                                                                }

         | declaration                                  
         ;

declaration: DEC vari                                           
           ;

vari: vari COM vari                                             {printf("Multiple declaration\n");}
    | VAR                                                       {
                                                                    int result;
                                                                    result = wasItDeclaredBefore($1);
                                                                    
                                                                    printf("VarName: %s\n",$1);
                                                                    
                                                                    if(result == 0)
                                                                    {
                                                                        printf("Wasn't declared before\n");
                                                                        //store the values as input
                                                                        int i;
                                                                        for( i = 0; i < strlen($1) ; i++)
                                                                        {
                                                                            sym[current][i] = $1[i];
                                                                        }
                                                                        values[current] = 0;

                                                                        //increase current 
                                                                         current++;
                                                                    }
                                                                    else{
                                                                        printf("declared before\n");
                                                                        
                                                                    } 
                                                                }
    ;

ifelse: IIF LTB expression RTB ifelse                           {
                                                                    //single if structure
                                                                    printf("Value of Argument: %f\n",$3);
                                                                    if($3)
                                                                    {
                                                                        printf("Value of expressions: \n");
                                                                        printIfOpValues();
                                                                    }
                                                                    resetIfOpValues();
                                                                }
      | IIF LTB expression RTB STMT expression END DFLT STMT expression END NDF {

                                                                    //if-else structure
                                                                    if($3)
                                                                    {
                                                                        printf("Inside if Structure\n");
                                                                        printf("Value of Argument: %f\n", $3);
                                                                        printf("Value of expression: %f\n",$6);
                                                                    }
                                                                    else
                                                                    {
                                                                        
                                                                        printf("Value of expression: %f\n", $10);
                                                                    }
                                                                }

      | STMT expression END ifelse                              {
                                                                    pushIfOpValues($2);
                                                                }
      | NDF
      ;

forloop: LOOP VAR IN VAL TO VAL STMT expression END LEND        {
                                                                    int result = wasItDeclaredBefore($2);
                                                                    if(result)
                                                                    {
                                                                        int index = getIndexNumber($2);
                                                                        float expressionResult = $8;
                                                                        int i;
                                                                        
                                                                        //printf("Exp: %f\n",$8);
                                                                        
                                                                        if($4 < $6)
                                                                        {
                                                                            for(i = $4; i <= $6; i++)
                                                                            {
                                                                                printf("Expression Result: %f\n",expressionResult);
                                                                                printf("Variable Value: %d\n", i);
                                                                                values[index] = i;
                                                                            }
                                                                        }
                                                                        else if($4 > $6)
                                                                        {
                                                                            for(i = $6; i >= $4; i--)
                                                                            {
                                                                                printf("Expression Result: %f\n",expressionResult);
                                                                                printf("Variable Value: %d\n", i);
                                                                                values[index] = i;
                                                                            }
                                                                        }
                                                                        else
                                                                        {
                                                                            printf("Expression Result: %f\n",expressionResult);
                                                                            printf("Variable Value: %f\n", $4);
                                                                            values[index] = $4;
                                                                        }
                                                                    }
                                                                    else
                                                                    {
                                                                        printf("Variable in loop not declared before\n");
                                                                        
                                                                    }
                                                                }
       ;

switch: MAT VAR COL VAL  STMT expression END                                   {
                                                                    int result;
                                                                    result = wasItDeclaredBefore($2);

                                                                    if(result == 0)
                                                                    {
                                                                        printf("ERROR: wasn't declared before\n");
                                                                        exit(0);
                                                                    }
                                                                    else
                                                                    {
                                                                        int indexOfVar;
                                                                        printf("Was declared before\n");
                                                                        indexOfVar = getIndexNumber($2);
                                                                        switchValue = values[indexOfVar];
                                                                       printf("Switch Value: %f\n", switchValue);
                                                                    }
                                                                      if($4 == switchValue && printedCaseBefore == 0)
                                                                    {
                                                                        printf("Case Matched \n");
                                                                        printf("Value of Expression: %f\n", $6);
                                                                        printedCaseBefore = 1;
                                                                    }
                                                                }
      ;


      | DFLT  STMT expression END NCAS                        {
                                                                    if(printedCaseBefore == 0)
                                                                    {
                                                                        printf("Default case matched\n");
                                                                        printf("Value of expression: %f\n", $3);
                                                                    }
                                                                }
     ;
fwhile: WHILE VAL    {
                                                        int wcount = $2;
                                                        while(wcount)
                                                        {
                                                            printf("Expression value in while is %d\n",wcount);
                                                            wcount--;
                                                        }

                                                    }
    ;

increment: VAR INC END           {
                                // var[$1] = var[$1] + 1;
                                 printf("increment \n"); 
                                 
                        }
    ;

fact: FACTORIAL VAL 
        {

             int f = factorial($2);
              int v1=$2;
             printf("Factorial Value %d is: %d\n",v1, f) ;
        }
   ;
fgcd: GCD VAL VAL
       {
              int f=gcd($2,$3);
              int v1=$2;
              int v2=$3;
              printf("GCD Value of %d & %d is: %d\n",v1,v2, f) ;



       }
    ;

fsqrt: SQRT VAL
      {
                int v1=$2;
               printf("sqrt Value of %d  is: %d\n",v1, v1*v1) ;  
      }
    ;
evenodd: EVENODD VAL END
     {

               int v1=$2;
               evenodd($2);
     }


%%

int wasItDeclaredBefore(char string[1000])
{  
    //returns 0 if not delcared before
    //returns 1 if declared before
    int i;
    for(i = 0; i < current; i++)
    {
        if(strlen(string) == strlen(sym[i]))
        {
            int result2;
            result2 = matchStrings(string, sym[i]);
            if(result2 == 1)
            {             
                matchedStringValue = values[i];
                return 1;
            }
            else
            {               
               continue;
            }
        }
        else
        {
            continue;
        }
    }  
    return 0;
}

int matchStrings(char string1[1000], char string2[1000])
{
    //returns 1 if match
    //returns 0 if not match
    int len;
    len = strlen(string1);
    int i;
    for(i = 0; i < len; i++)
    {
        if(string1[i] == string2[i])
        {          
            continue;
        }
        else
        {           
            return 0;
        }
    }   
    return 1;
}

int getIndexNumber(char string[1000])
{
    int i;
    for( i = 0; i < current; i++)
    {
       
        if(strlen(string) == strlen(sym[i]))
        {
            if(matchStrings(string, sym[i]))
            {
                return i;
            }
        }
        
    }
}

void pushIfOpValues(float value)
{
    ifOpValues[currentIfOp] = value;
    currentIfOp++;
}

void printIfOpValues()
{
    int i;
    for( i = currentIfOp-1; i >= 0; i--)
    {
        printf("%f\n",ifOpValues[i]);
    }
}

void resetIfOpValues()
{
    memset(&ifOpValues[0], 0, sizeof(ifOpValues));
    currentIfOp = 0;
}