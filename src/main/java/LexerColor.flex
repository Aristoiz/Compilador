import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color) {
        return new TextColor((int)start, size, color);
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


/* Numero */
Numero = 0 | [1-9][0-9]*
%state STRING

%%

/* Tipo de dato */
NÚMERO |
COLOR {return textColor(yychar, yylength(), new Color(148,58,173));}

/* Número */
{Numero} {return textColor(yychar, yylength(), new Color(35,120,147));}
0{Numero} {return textColor(yychar, yylength(), Color.RED);}

/* Colores */
#[{Letra} | {Digito} ]{6} {return textColor(yychar, yylength(), new Color(224,195,12));}

/*Operadores*/
"+" |
"-" |
"/" |
"*" { return textColor(yychar, yylength(), new Color(0,0,0)); }

/*Logicos*/
"==" |
"!=" |
">" |
"<" |
">=" |
"<=" |
"Y" | "y" | "ý" | "Ý" | //AND
"O" | "o" | "Ó" | "ó" | //OR
"NO" | "no" | "No" { return textColor(yychar, yylength(), new Color(0,0,0));} //NOT

"." |
"," |
":" |
";" |
\' |
\" [a-zA-Z0-9_.-]* \" { return textColor(yychar, yylength(), new Color(0,0,0)); }

"=>" { return textColor(yychar, yylength(), Color.GREEN);}


\" |
\( |
\) |
\{ |
\} |
\[ |
\] { return textColor(yychar, yylength(), new Color(0,0,0)); }

"++" |
"--" { return textColor(yychar, yylength(), new Color(0,0,0));  }

/*Palabras reservadas*/
"IMPORTAR" | "importar" | "Importar" { return textColor(yychar, yylength(), new Color(155,38,182)); } // import
"DEFINIR" | "definir" | "Definir" { return textColor(yychar, yylength(), new Color(155,38,182)); } // def
"CLASE" | "clase" | "Clase" { return textColor(yychar, yylength(), new Color(155,38,182)); } //class
"SI" | "si" | "Si" { return textColor(yychar, yylength(), new Color(155,38,182)); } //if
"TONCS" | "toncs" | "Toncs" { return textColor(yychar, yylength(), new Color(155,38,182)); } //else
"SINO" | "sino" | "Sino" { return textColor(yychar, yylength(), new Color(155,38,182)); } //else-if
"PARA" | "para" | "Para" { return textColor(yychar, yylength(), new Color(155,38,182)); } //for
"EN" | "en" | "En" { return textColor(yychar, yylength(), new Color(155,38,182)); } //in
"RANGO" | "rango" | "Rango" { return textColor(yychar, yylength(), new Color(155,38,182)); } //range
"MIENTRAS" | "mientras" | "mientras" { return textColor(yychar, yylength(), new Color(155,38,182)); } //while
"INTENTA" | "intenta" | "Intenta" { return textColor(yychar, yylength(), new Color(155,38,182)); } //try
"EXCEPTO" | "excepto" | "Excepto" { return textColor(yychar, yylength(), new Color(155,38,182)); } //except
"RETORNA" | "retorna" | "Retorna" { return textColor(yychar, yylength(), new Color(155,38,182)); } //return
"ROMPER" | "romper" | "Romper" { return textColor(yychar, yylength(), new Color(155,38,182)); } //break
"SIGUE" | "sigue" | "Sigue" {return textColor(yychar, yylength(), new Color(155,38,182)); } //next
"ENTRADA" | "entrada" | "Entrada" { return textColor(yychar, yylength(), new Color(155,38,182)); } //input
"SALIDA" | "salida" | "Salida" { return textColor(yychar, yylength(), new Color(155,38,182)); } //output
"IMPRIME" | "imprime" | "Imprime" { return textColor(yychar, yylength(), new Color(155,38,182)); } //print

"ENTERO" | "entero" | "Entero" { return textColor(yychar, yylength(), new Color(105,99,32));  } //int
"FLOTANTE" | "flotante" | "Flotante" { return textColor(yychar, yylength(), new Color(105,99,32));  } //float
"BOOLEANO" | "booleano" | "Booleano" { return textColor(yychar, yylength(), new Color(155,38,182)); } //boolean
"TEXTO" | "texto" | "Texto" { return textColor(yychar, yylength(), new Color(105,99,32));  } //string
"REAL" | "real" | "Real" { return textColor(yychar, yylength(), new Color(105,99,32));  } //double

"VERDADERO" | "verdadero" | "Verdadero" { return textColor(yychar, yylength(), new Color(155,38,182)); } //true
"FALSO" | "falso" | "Falso" { return textColor(yychar, yylength(), new Color(155,38,182)); } //false

"EXP" | "exp" | "Exp" { return textColor(yychar, yylength(), new Color(105,99,32));} //exp
"SQRT" | "sqrt" | "Sqrt" { return textColor(yychar, yylength(), new Color(105,99,32));} //sqrt



"INICIO" | "inicio" | "Inicio" { return textColor(yychar, yylength(), new Color(155,38,182)); }
"FINAL" | "fin" | "Fin" { return textColor(yychar, yylength(), new Color(155,38,182)); }

/* IDs */
{Identificador} { /* Ignorar */ }

{Comentario} { return textColor(yychar, yylength(), new Color(146,146,146)); }
{EspacioEnBlanco} { /* Ignorar */ }
. { /* Ignorar */ }