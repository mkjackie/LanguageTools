package lang_processor;

import java_cup.runtime.*;
      
%%

/* Name of the lexer class to be generated */

%class Lexer

/* Use unicode */

%unicode

/* Track the current line and column using yyline and yycolumn */

%line
%column
    
/* The class containing the token type constants */

%cupsym TokenType

/* Make the resulting lexer compatible with CUP */

%cup
   

   
/* 
   Put any helper fields or methods to be included in your lexer
   class between the following %{ and }% 
*/

%{   
 	/*
 		Create a new token for something that does not have
 		a specific associated value (e.g., keywords, symbols)
 	*/
    private Symbol newToken(int tokType) {
    	System.out.println("Lexed token type " + tokType 
    						+ " at line " + yyline + ", column " 
    						+ yycolumn);
        return new Symbol(tokType, yyline, yycolumn);
    }
    
 	/*
 		Create a new token for something that has a specific
 		associated value (e.g., numerics, labels)
 	*/
    private Symbol newToken(int tokType, Object tokValue) {
        System.out.println("Lexed " + tokValue + " at line " 
    						+ yyline + ", column " + yycolumn);
        return new Symbol(tokType, yyline, yycolumn, tokValue);
    }
%}
   
/*-----------------------------*
 * REGEXP PATTERN DEFINITIONS:
 */
 
whitespace	= [ \r\n\t\f]
 
digit		= [0-9]
nzDecDigit	= [1-9]
integer		= 0 | {nzDecDigit}{digit}*

alpha			= [A-Za-z_]
alphaOrDigit	= ({alpha} | {digit})	
label			= {alpha}{alphaOrDigit}*

/* PossibLe lexer states other than YYINITIAL */

%state STRING
%state COMMENT

%%

/*-----------------------------*
 * LEXICAL RULES
 */
 
/* YYINITIAL is the starting lexer state */
   
<YYINITIAL> {

":="		{ return newToken(TokenType.ASMT_SYMBOL); }
";"    		{ return newToken(TokenType.SEMICOLON); }
"("    		{ return newToken(TokenType.LEFTBRACKET); }
")"    		{ return newToken(TokenType.RIGHTBRACKET); }
"+"    		{ return newToken(TokenType.PLUS); }
"-"    		{ return newToken(TokenType.MINUS); }
"*"    		{ return newToken(TokenType.STAR); }
"/"    		{ return newToken(TokenType.SLASH); }
"{"    		{ return newToken(TokenType.LCBRACKET); }
"}"    		{ return newToken(TokenType.RCBRACKET); }
"<"    		{ return newToken(TokenType.SIGN); }
"<="    	{ return newToken(TokenType.ARROW); }
"=="    	{ return newToken(TokenType.EQUAL); }
"initialize"    { return newToken(TokenType.INITIALIZE); }
"begin"         { return newToken(TokenType.BEGIN); }
"end"           { return newToken(TokenType.END); }
"to"            { return newToken(TokenType.TO); }
"if"            { return newToken(TokenType.IF); }
"then"          { return newToken(TokenType.THEN); }
"while"         { return newToken(TokenType.WHILE); }
"do"            { return newToken(TokenType.DO); }

{integer}	{ return newToken(TokenType.INTEGER, new Integer(yytext())); }
{label}		{ return newToken(TokenType.LABEL, yytext()); }



{whitespace}    { /* Ignore whitespace */ }

.      		{ throw new Error("Lexical error, cannot process: " 
					+ yytext()); }
}