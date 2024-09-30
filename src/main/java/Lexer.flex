import compilerTools.Token;


%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/* Tipo de dato */
NÚMERO |
COLOR {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}

/* Número */
{Numero} {return token(yytext(), "NUMERO", yyline, yycolumn);}
{Numero} "." {Numero} {return token(yytext(), "REAL", yyline, yycolumn);}
0{Numero} {return token(yytext(), "ERROR_01", yyline, yycolumn);}

/* Colores */
#[{Letra} | {Digito} ]{6} {return token(yytext(), "COLOR", yyline, yycolumn);}

/*Operadores*/
"+" { return token(yytext(), "SUMA", yyline, yycolumn); }
"-" { return token(yytext(), "RESTA", yyline, yycolumn); }
"/" { return token(yytext(), "DIVISION", yyline, yycolumn); }
"*" { return token(yytext(), "MULTIPLICACION", yyline, yycolumn); }

/*Logicos*/
"==" { return token(yytext(), "IGUAL", yyline, yycolumn); }
"!=" { return token(yytext(), "DIFERENTE", yyline, yycolumn); }
">" { return token(yytext(), "MAYORQUE", yyline, yycolumn); }
"<" { return token(yytext(), "MENORQUE", yyline, yycolumn); }
">=" { return token(yytext(), "MAYORIGUALQUE", yyline, yycolumn); }
"<=" { return token(yytext(), "MENORIGUALQUE", yyline, yycolumn); }
"Y" | "y" | "ý" | "Ý" { return token(yytext(), "AND", yyline, yycolumn); } //AND
"O" | "o" | "Ó" | "ó" { return token(yytext(), "OR", yyline, yycolumn); } //OR
"NO" | "no" | "No" { return token(yytext(), "NOT", yyline, yycolumn); } //NOT

"." { return token(yytext(), "PUNTO", yyline, yycolumn); }
"," { return token(yytext(), "COMA", yyline, yycolumn); }
":" { return token(yytext(), "DOSPUNTOS", yyline, yycolumn); }
";" { return token(yytext(), "PUNTOCOMA", yyline, yycolumn); }
\' { return token(yytext(), "COMILLASIMPLE", yyline, yycolumn); }
\" [a-zA-Z0-9_.-]* \" { return token(yytext(), "CADENA", yyline, yycolumn); }

"=>" { return token(yytext(), "ASIGNACION", yyline, yycolumn); }


\" { return token(yytext(), "COMILLADOBLE", yyline, yycolumn); }
\( { return token(yytext(), "PARENTESISABIERTO", yyline, yycolumn); }
\) { return token(yytext(), "PARENTESISCERRADO", yyline, yycolumn); }
\{ { return token(yytext(), "LLAVEABIERTO", yyline, yycolumn); }
\} { return token(yytext(), "LLAVECERRADO", yyline, yycolumn); }
\[ { return token(yytext(), "CORCHETEABIERTO", yyline, yycolumn); }
\] { return token(yytext(), "CORCHETECERRADO", yyline, yycolumn); }

"++" { return token(yytext(), "INCREMENTO", yyline, yycolumn); }
"--" { return token(yytext(), "DECREMENTO", yyline, yycolumn); }

/*Palabras reservadas*/
"IMPORTAR" | "importar" | "Importar" { return token(yytext(), "IMPORT", yyline, yycolumn); } // import
"DEFINIR" | "definir" | "Definir" { return token(yytext(), "DEF", yyline, yycolumn); } // def
"CLASE" | "clase" | "Clase" { return token(yytext(), "CLASS", yyline, yycolumn); } //class
"SI" | "si" | "Si" { return token(yytext(), "IF", yyline, yycolumn); } //if
"TONCS" | "toncs" | "Toncs" { return token(yytext(), "ELSE", yyline, yycolumn); } //else
"SINO" | "sino" | "Sino" { return token(yytext(), "ELSEIF", yyline, yycolumn); } //else-if
"PARA" | "para" | "Para" { return token(yytext(), "FOR", yyline, yycolumn); } //for
"EN" | "en" | "En" { return token(yytext(), "IN", yyline, yycolumn); } //in
"RANGO" | "rango" | "Rango" { return token(yytext(), "RANGE", yyline, yycolumn); } //range
"MIENTRAS" | "mientras" | "mientras" { return token(yytext(), "WHILE", yyline, yycolumn); } //while
"INTENTA" | "intenta" | "Intenta" { return token(yytext(), "TRY", yyline, yycolumn); } //try
"EXCEPTO" | "excepto" | "Excepto" { return token(yytext(), "EXCEPT", yyline, yycolumn); } //except
"RETORNA" | "retorna" | "Retorna" { return token(yytext(), "RETURN", yyline, yycolumn); } //return
"ROMPER" | "romper" | "Romper" { return token(yytext(), "BREAK", yyline, yycolumn); } //break
"SIGUE" | "sigue" | "Sigue" { return token(yytext(), "NEXT", yyline, yycolumn); } //next
"ENTRADA" | "entrada" | "Entrada" { return token(yytext(), "INPUT", yyline, yycolumn); } //input
"SALIDA" | "salida" | "Salida" { return token(yytext(), "OUTPUT", yyline, yycolumn); } //output
"IMPRIME" | "imprime" | "Imprime" { return token(yytext(), "PRINT", yyline, yycolumn); } //print

"ENTERO" | "entero" | "Entero" { return token(yytext(), "INT", yyline, yycolumn); } //int
"FLOTANTE" | "flotante" | "Flotante" { return token(yytext(), "FLOAT", yyline, yycolumn); } //float
"BOOLEANO" | "booleano" | "Booleano" { return token(yytext(), "BOOLEAN", yyline, yycolumn); } //boolean
"TEXTO" | "texto" | "Texto" { return token(yytext(), "STRING", yyline, yycolumn); } //string

"VERDADERO" | "verdadero" | "Verdadero" { return token(yytext(), "TRUE", yyline, yycolumn); } //true
"FALSO" | "falso" | "Falso" { return token(yytext(), "FALSE", yyline, yycolumn); } //false

"EXP" | "exp" | "Exp" { return token(yytext(), "POWER", yyline, yycolumn); } //exp
"SQRT" | "sqrt" | "Sqrt" { return token(yytext(), "SQRT", yyline, yycolumn); } //sqrt



"INICIO" | "inicio" | "Inicio" { return token(yytext(), "BEGIN", yyline, yycolumn); }
"FINAL" | "fin" | "Fin" { return token(yytext(), "END", yyline, yycolumn); }

/* IDs */
{Identificador} { return token(yytext(), "ID", yyline, yycolumn); }


/**/
. { return token(yytext(), "ERROR", yyline, yycolumn); }

