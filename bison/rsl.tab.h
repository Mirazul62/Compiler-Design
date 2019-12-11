
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ADD = 258,
     SUB = 259,
     MUL = 260,
     DIV = 261,
     GRE = 262,
     LES = 263,
     GEQ = 264,
     LEQ = 265,
     END = 266,
     VAL = 267,
     LFB = 268,
     RFB = 269,
     PRINT = 270,
     EQUAL = 271,
     DEC = 272,
     COM = 273,
     IIF = 274,
     STMT = 275,
     EIF = 276,
     NDF = 277,
     LTB = 278,
     RTB = 279,
     DFLT = 280,
     MAT = 281,
     CAS = 282,
     LOOP = 283,
     LEND = 284,
     IN = 285,
     TO = 286,
     NCAS = 287,
     NMAT = 288,
     COL = 289,
     WHILE = 290,
     INC = 291,
     FACTORIAL = 292,
     GCD = 293,
     SQRT = 294,
     EVENODD = 295,
     VAR = 296
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 75 "rsl.y"

    int int_val;
    double double_val;
    char input_var_string[1000];



/* Line 1676 of yacc.c  */
#line 101 "rsl.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


