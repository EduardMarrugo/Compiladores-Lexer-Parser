%lex
//inicio lexer
%options case-sensitive

%%
/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}
\s+
"//".*										              // comentario simple
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			// comentario multiple líneas

//Palabras reservadas
'catring' return 'string';
'tero' return 'number'; 
'siono' return 'boolean';
'nada' return 'nada';
'const' return 'const';
'consola' return 'consola';
'mostrar' return 'mostrar';
'funcion' return 'funcion';
'devuelve' return 'devuelve';
'nulo' return 'nulo';
'push' return 'push';
'length' return 'length';
'pop' return 'pop';
'sisas' return 'sisas';
'nonada' return 'nonada';
'true' return 'true';
'false' return 'false';
'break' return 'break';
'switch' return 'switch';
'case' return 'case';
'default' return 'default';
'continue' return 'continue';
'bucle' return 'bucle';
'hacer' return 'hacer';
'repetidor' return 'repetidor';
'in' return 'in';
'of' return 'of';
'graficar_ts' return 'graficar_ts';
'Array' return 'Array';

//Signos
';' return 'punto_coma';
',' return 'coma';
':' return 'dos_puntos';
'{' return 'llave_izq';
'}' return 'llave_der';
'(' return 'par_izq';
')' return 'par_der';
'[' return 'cor_izq';
']' return 'cor_der';
'.' return 'punto';
'++' return 'mas_mas'
'+' return 'mas';
'--' return 'menos_menos'
'-' return 'menos';
'**' return 'potencia';
'*' return 'por';
'/' return 'div';
'%' return 'mod';
'<=' return 'menor_igual';
'>=' return 'mayor_igual';
'>' return 'mayor';
'<' return 'menor';
'==' return 'igual_que';
'=' return 'igual';
'<-' return 'asignacion';
'!=' return 'dif_que';
'&' return 'and';
'|' return 'or';
'!' return 'no';
'?' return 'interrogacion';



//Patrones (Expresiones regulares)
\"[^\"]*\"			{ yytext = yytext.substr(0,yyleng-0); return 'string'; }
\'[^\']*\'			{ yytext = yytext.substr(0,yyleng-0); return 'string'; }
\`[^\`]*\`			{ yytext = yytext.substr(0,yyleng-0); return 'string'; }
[0-9]+("."[0-9]+)?\b  	return 'number';
([a-zA-Z])[a-zA-Z0-9_]* return 'id';

//Fin del archivo
<<EOF>>				return 'EOF';
//Errores lexicos
.					{
  const er = new error_1.Error({ tipo: 'lexico', linea: `${yylineno + 1}`, descripcion: `El valor "${yytext}" no es valido, columna: ${yylloc.first_column + 1}` });
  errores_1.Errores.getInstance().push(er);
  }
/lex
//fin lexer
/* operator associations and precedence */
%left 'interrogacion'
%left 'or'
%left 'and'
%left 'no'
%left 'igual_que' 'dif_que'
%left 'mayor' 'menor' 'mayor_igual' 'menor_igual'
%left 'mas' 'menos'
%left 'por' 'div' 'mod'
%left 'umenos' 
%right 'potencia'
%left 'mas_mas' 'menos_menos'

%start S

%%

/*

Definición de la Grámatica

*/

/*-->TR - EJ<--*/
S
  : INSTRUCCIONES EOF { return new NodoAST({label: 'S', hijos: [$1], linea: yylineno}); }
;

/*-->TR - EJ<--*/
INSTRUCCIONES
  : INSTRUCCIONES INSTRUCCION  { $$ = new NodoAST({label: 'INSTRUCCIONES', hijos: [...$1.hijos, ...$2.hijos], linea: yylineno}); }
  | INSTRUCCION                { $$ = new NodoAST({label: 'INSTRUCCIONES', hijos: [...$1.hijos], linea: yylineno}); }
;

INSTRUCCION
  : DECLARACION_VARIABLE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | DECLARACION_FUNCION /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | ASIGNACION /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | PUSH_ARREGLO /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | CONSOLA_MOSTRAR /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | INSTRUCCION_SISAS /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | SWITCH /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | BREAK /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | DEVUELVE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | CONTINUE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | BUCLE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | HACER_BUCLE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | REPETIDOR /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | LLAMADA_FUNCION /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | INCREMENTO_DECREMENTO { $$ = new NodoAST({label: 'INSTRUCCION', hijos: [$1], linea: yylineno}); }
  | error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

LLAMADA_FUNCION /*-->TR - EJ<--*/
  : id MENOR MAYOR punto_coma { $$ = new NodoAST({label: 'LLAMADA_FUNCION', hijos: [$1,$2,$3,$4], linea: yylineno}); }
  | id MENOR LISTA_EXPRESIONES MAYOR punto_coma { $$ = new NodoAST({label: 'LLAMADA_FUNCION', hijos: [$1,$2,$3,$4,$5], linea: yylineno}); }
;

LLAMADA_FUNCION_EXP /*-->TR - EJ<--*/
  : id MENOR MAYOR { $$ = new NodoAST({label: 'LLAMADA_FUNCION_EXP', hijos: [$1,$2,$3], linea: yylineno}); }
  | id MENOR LISTA_EXPRESIONES MAYOR { $$ = new NodoAST({label: 'LLAMADA_FUNCION_EXP', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;


BUCLE /*-->TR - EJ<--*/
  : bucle MENOR EXP MAYOR llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'BUCLE', hijos: [$1,$2,$3,$4,$5,$6,$7], linea: yylineno}); }
;

HACER_BUCLE /*-->TR - EJ<--*/
  : hacer llave_izq INSTRUCCIONES llave_der bucle MENOR EXP MAYOR punto_coma { $$ = new NodoAST({label: 'HACER_BUCLE', hijos: [$1,$2,$3,$4,$5,$6,$7,$8,$9], linea: yylineno}); }
;

REPETIDOR /*-->TR - EJ<--*/
  : repetidor par_izq DECLARACION_VARIABLE EXP punto_coma ASIGNACION_PARA par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'REPETIDOR', hijos: [$1,$2,$3,$4,$5,$6,$7,$8,$9,$10], linea: yylineno}); }
  | repetidor par_izq ASIGNACION EXP punto_coma ASIGNACION_PARA par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'REPETIDOR', hijos: [$1,$2,$3,$4,$5,$6,$7,$8,$9,$10], linea: yylineno}); }
;

PARA_OF /*-->TR - EJ<--*/
  : repetidor par_izq TIPO_DEC_VARIABLE id of EXP par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'PARA_OF', hijos: [$1,$2,$3,$4,$5,$6,$7,$8,$9,$10], linea: yylineno}); }
;

PARA_IN /*-->TR - EJ<--*/
  : repetidor par_izq TIPO_DEC_VARIABLE id in EXP par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'PARA_IN', hijos: [$1,$2,$3,$4,$5,$6,$7,$8,$9,$10], linea: yylineno}); }
;

ASIGNACION /*-->TR - EJ<--*/
  /*
    variable <- EXP;
  */
  /*-->TR - EJ <--*/
  : id ASIGNACION EXP punto_coma { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1,$2,$3,$4], linea: yylineno}); }

  // type.accesos <- EXP; || type.accesos[][] <- EXP;
  /*-->TR - EJ<--*/
  | id LISTA_ACCESOS_TYPE ASIGNACION EXP punto_coma { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1,$2,$3,$4,$5], linea: yylineno}); }

  /*
    variable[][] <- EXP ;
  */
  
  /*-->TR - EJ<--*/
  | ACCESO_ARREGLO ASIGNACION EXP punto_coma { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

ASIGNACION /*-->TR - EJ<--*/
  : asignacion { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1], linea: yylineno}); }
  | mas asignacion { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1,$2], linea: yylineno}); }
  | menos asignacion { $$ = new NodoAST({label: 'ASIGNACION', hijos: [$1,$2], linea: yylineno}); }
;

ASIGNACION_PARA /*-->TR - EJ<--*/
  : id ASIGNACION EXP { $$ = new NodoAST({label: 'ASIGNACION_PARA', hijos: [$1,$2,$3], linea: yylineno}); }
  | id mas_mas { $$ = new NodoAST({label: 'ASIGNACION_PARA', hijos: [$1,$2], linea: yylineno}); }
  | id menos_menos { $$ = new NodoAST({label: 'ASIGNACION_PARA', hijos: [$1,$2], linea: yylineno}); }
;

SWITCH /*-->TR - EJ<--*/
  : switch par_izq EXP par_der llave_izq LISTA_CASE llave_der { $$ = new NodoAST({label: 'SWITCH', hijos: [$1,$2,$3,$4,$5,$6,$7], linea: yylineno}); }
;

LISTA_CASE /*-->TR - EJ<--*/
  : LISTA_CASE CASE { $$ = new NodoAST({label: 'LISTA_CASE', hijos: [...$1.hijos,$2], linea: yylineno}); }
  | CASE { $$ = new NodoAST({label: 'LISTA_CASE', hijos: [$1], linea: yylineno}); }
  | DEFAULT { $$ = new NodoAST({label: 'LISTA_CASE', hijos: [$1], linea: yylineno}); }
  | LISTA_CASE DEFAULT { $$ = new NodoAST({label: 'LISTA_CASE', hijos: [...$1.hijos,$2], linea: yylineno}); }
;

CASE /*-->TR - EJ<--*/
  : case EXP dos_puntos INSTRUCCIONES { $$ = new NodoAST({label: 'CASE', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

DEFAULT /*-->TR - EJ<--*/
  : default dos_puntos INSTRUCCIONES { $$ = new NodoAST({label: 'DEFAULT', hijos: [$1,$2,$3], linea: yylineno}); }
;

CONTINUE /*-->TR - EJ<--*/
  : continue punto_coma { $$ = new NodoAST({label: 'CONTINUE', hijos: [$1, $2], linea: yylineno}); }
;

BREAK /*-->TR - EJ<--*/
  : break punto_coma { $$ = new NodoAST({label: 'BREAK', hijos: [$1,$2], linea: yylineno}); }
;

RETORNO /*-->TR - EJ<--*/
  : retorno EXP punto_coma { $$ = new NodoAST({label: 'RETORNO', hijos: [$1,$2,$3], linea: yylineno}); }
  | retorno punto_coma { $$ = new NodoAST({label: 'RETORNO', hijos: [$1,$2], linea: yylineno}); }
;

INSTRUCCION_SI /*-->TR - EJ<--*/
  : SI /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION_SI', hijos: [$1], linea: yylineno}); }
  | SI NONADA /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION_SI', hijos: [$1,$2], linea: yylineno}); }
  | SI LISTA_SINO_SI /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION_SI', hijos: [$1,$2], linea: yylineno}); }
  | SI LISTA_SINO_SI NONADA /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'INSTRUCCION_SI', hijos: [$1,$2,$3], linea: yylineno}); }
;

SI /*-->TR - EJ<--*/
  : SI par_izq EXP par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'SI', hijos: [$1,$2,$3,$4,$5,$6,$7], linea: yylineno}); }
;

NONADA /*-->TR - EJ<--*/
  : NONADA llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'NONADA', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

SINO_SI /*-->TR - EJ<--*/
  : NONADA SI par_izq EXP par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'SINO_SI', hijos: [$1,$2,$3,$4,$5,$6,$7,$8], linea: yylineno}); }
;

LISTA_SINO_SI /*-->TR - EJ<--*/
  : LISTA_SINO_SI SINO_SI /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_SINO_SI', hijos: [...$1.hijos, $2], linea: yylineno}); }
  | SINO_SI /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_SINO_SI', hijos: [$1], linea: yylineno}); }
;

PUSH_ARREGLO /*-->TR - EJ<--*/
  : id punto push par_izq EXP par_der punto_coma /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'PUSH_ARREGLO', hijos: [$1,$2,$3,$4,$5,$6,$7], linea: yylineno}); }
  | id LISTA_ACCESOS_TYPE punto push par_izq EXP par_der punto_coma /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'PUSH_ARREGLO', hijos: [$1,$2,$3,$4,$5,$6,$7,$8], linea: yylineno}); }
;

DECLARACION_FUNCION /*-->TR - EJ<--*/
  /*

  Funcion sin parametros y con tipo -> funcion test<> : TIPO { INSTRUCCIONES }

  */
  /*-->TR - EJ<--*/
  : funcion id par_izq par_der dos_puntos TIPO_VARIABLE_NATIVA llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7, $8, $9], linea: yylineno}); }

   /*
   
   Funcion sin parametros y con tipo -> funcion test<> : TIPO[][] { INSTRUCCIONES }

   */
  | funcion id par_izq par_der dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7, $8, $9, $10], linea: yylineno}); }

  /*

  Funcion sin parametros y sin tipo -> funcion test<> { INSTRUCCIONES }

  */
  /*-->TR - EJ<--*/
  | funcion id par_izq par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7], linea: yylineno}); }

  /*

  Funcion con parametros y con tipo -> funcion test < LISTA_PARAMETROS > : TIPO { INSTRUCCIONES }

  */
  /*-->TR - EJ<--*/
  | funcion id par_izq LISTA_PARAMETROS par_der dos_puntos TIPO_VARIABLE_NATIVA llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7, $8, $9, $10], linea: yylineno}); }

  /*

  Funcion con parametros y con tipo -> funcion test < LISTA_PARAMETROS > : TIPO[][] { INSTRUCCIONES }

  */
  | funcion id par_izq LISTA_PARAMETROS par_der dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11], linea: yylineno}); }

  /*

  Funcion con parametros y sin tipo -> funcion test < LISTA_PARAMETROS > { INSTRUCCIONES }

  */
  /*-->TR - EJ<--*/
  | funcion id par_izq LISTA_PARAMETROS par_der llave_izq INSTRUCCIONES llave_der { $$ = new NodoAST({label: 'DECLARACION_FUNCION', hijos: [$1, $2, $3, $4, $5, $6, $7, $8], linea: yylineno}); }

;

LISTA_PARAMETROS /*-->TR - EJ<--*/
  : LISTA_PARAMETROS coma PARAMETRO { $$ = new NodoAST({label: 'LISTA_PARAMETROS', hijos: [...$1.hijos,$2,$3], linea: yylineno}); } //Revisar SI agrego o no coma
  | PARAMETRO { $$ = new NodoAST({label: 'LISTA_PARAMETROS', hijos: [$1], linea: yylineno}); }
;

PARAMETRO /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA { $$ = new NodoAST({label: 'PARAMETRO', hijos: [$1, $2, $3], linea: yylineno}); }
  | id dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES { $$ = new NodoAST({label: 'PARAMETRO', hijos: [$1, $2, $3, $4], linea: yylineno}); }
  | id dos_puntos Array menor TIPO_VARIABLE_NATIVA mayor { $$ = new NodoAST({label: 'PARAMETRO', hijos: [$1,$2,$3,$4,$5,$6], linea: yylineno}); }
;

LISTA_ATRIBUTOS /*-->TR -- EJ<--*/
  : ATRIBUTO coma LISTA_ATRIBUTOS { $$ = new NodoAST({label: 'LISTA_ATRIBUTOS', hijos: [$1,$2,...$3.hijos], linea: yylineno}); } //Revisar SI agrego o no coma
  | ATRIBUTO { $$ = new NodoAST({label: 'LISTA_ATRIBUTOS', hijos: [$1], linea: yylineno}); }
;

ATRIBUTO /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA { $$ = new NodoAST({label: 'ATRIBUTO', hijos: [$1, $2, $3], linea: yylineno}); }
  | id dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES { $$ = new NodoAST({label: 'ATRIBUTO', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

DECLARACION_VARIABLE /*-->TR - EJ<--*/
  : TIPO_DEC_VARIABLE LISTA_DECLARACIONES punto_coma { $$ = new NodoAST({label: 'DECLARACION_VARIABLE', hijos: [$1,$2,$3], linea: yylineno});  }
;

//TODO: REVISAR DEC_ID_COR Y DEC_ID_COR_EXP
LISTA_DECLARACIONES /*-->TR - EJ<--*/
  : LISTA_DECLARACIONES coma DEC_ID /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); } //No utilice las comas
  | LISTA_DECLARACIONES coma DEC_ID_TIPO /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); }
  | LISTA_DECLARACIONES coma DEC_ID_TIPO_CORCHETES /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); }
  | LISTA_DECLARACIONES coma DEC_ID_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); }
  | LISTA_DECLARACIONES coma DEC_ID_TIPO_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); }
  | LISTA_DECLARACIONES coma DEC_ID_TIPO_CORCHETES_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [...$1.hijos,$3], linea: yylineno}); }
  | DEC_ID /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
  | DEC_ID_TIPO /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
  | DEC_ID_TIPO_CORCHETES /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
  | DEC_ID_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
  | DEC_ID_TIPO_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
  | DEC_ID_TIPO_CORCHETES_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'LISTA_DECLARACIONES', hijos: [$1], linea: yylineno}); }
;

//tipo_varible id : TIPO_VARIABLE_NATIVA LISTA_CORCHETES <- EXP ;
DEC_ID_TIPO_CORCHETES_EXP /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES asignacion EXP { $$ = new NodoAST({label: 'DEC_ID_TIPO_CORCHETES_EXP', hijos: [$1,$2,$3,$4,$5,$6], linea: yylineno}); }
;

//tipo_varible id : TIPO_VARIABLE_NATIVA = EXP;
DEC_ID_TIPO_EXP /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA asignacion EXP { $$ = new NodoAST({label: 'DEC_ID_TIPO_EXP', hijos: [$1,$2,$3,$4,$5], linea: yylineno}); }
;

//tipo_varible id = EXP ;
DEC_ID_EXP /*-->TR - EJ<--*/
  : id asignacion EXP { $$ = new NodoAST({label: 'DEC_ID_EXP', hijos: [$1,$2,$3], linea: yylineno}); }
;

//tipo_varible id : TIPO_VARIABLE_NATIVA ;
DEC_ID_TIPO  /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA { $$ = new NodoAST({label: 'DEC_ID_TIPO', hijos: [$1,$2,$3], linea: yylineno}); }
;

//tipo_varible id ;
DEC_ID  /*-->TR - EJ<--*/
  : id  { $$ = new NodoAST({label: 'DEC_ID', hijos: [$1], linea: yylineno}); }
;

//tipo_varibleid : TIPO_VARIABLE_NATIVA LISTA_CORCHETES ;
DEC_ID_TIPO_CORCHETES /*-->TR - EJ<--*/
  : id dos_puntos TIPO_VARIABLE_NATIVA LISTA_CORCHETES { $$ = new NodoAST({label: 'DEC_ID_TIPO_CORCHETES', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

LISTA_CORCHETES /*-->TR - EJ<--*/
  : LISTA_CORCHETES cor_izq cor_der { $$ = new NodoAST({label: 'LISTA_CORCHETES', hijos: [...$1.hijos, '[]'], linea: yylineno}); }
  | cor_izq cor_der { $$ = new NodoAST({label: 'LISTA_CORCHETES', hijos: ['[]'], linea: yylineno}); }
;

INCREMENTO_DECREMENTO
  : id mas_mas punto_coma { $$ = new NodoAST({label: 'INCREMENTO_DECREMENTO', hijos: [$1,$2,$3], linea: yylineno}); }
  | id menos_menos punto_coma { $$ = new NodoAST({label: 'INCREMENTO_DECREMENTO', hijos: [$1,$2,$3], linea: yylineno}); }
;

EXP
  //Operaciones Aritmeticas
  : menos EXP %prec umenos /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2], linea: yylineno}); }
  | EXP mas EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP menos EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP por EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP div EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP mod EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP potencia EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | id mas_mas /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2], linea: yylineno}); }
  | id menos_menos /*-->TR- EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2], linea: yylineno}); }
  | par_izq EXP par_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  //Operaciones de Comparacion
  | EXP mayor EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP menor EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP mayor_igual EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP menor_igual EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP igual_que EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP dif_que EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  //Operaciones Lógicas
  | EXP and EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | EXP or EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2, $3], linea: yylineno}); }
  | no EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1, $2], linea: yylineno}); }
  //Valores Primitivos
  | tero /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'TERO', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  | catring /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'CATRING', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  | id /*-->TR - EJ<--*/  { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'ID', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  | true /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'SIONO', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  | false /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'SIONO', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  | null /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [new NodoAST({label: 'NULL', hijos: [$1], linea: yylineno})], linea: yylineno}); }
  //Arreglos
  | cor_izq LISTA_EXPRESIONES cor_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1,$2,$3], linea: yylineno}); }
  | cor_izq cor_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1,$2], linea: yylineno}); }
  | ACCESO_ARREGLO /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  | ARRAY_LENGTH /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  | ARRAY_POP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  //Types - accesos
  | ACCESO_TYPE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  | TYPE /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  //Ternario
  | TERNARIO /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
  //Funciones
  | LLAMADA_FUNCION_EXP /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'EXP', hijos: [$1], linea: yylineno}); }
;

TYPE /*-->TR - EJ<--*/
  : llave_izq ATRIBUTOS_TYPE llave_der { $$ = new NodoAST({label: 'TYPE', hijos: [$1,$2,$3], linea: yylineno}); }
;

ATRIBUTOS_TYPE /*-->TR - EJ<--*/
  : ATRIBUTO_TYPE coma ATRIBUTOS_TYPE { $$ = new NodoAST({label: 'ATRIBUTOS_TYPE', hijos: [$1,$2,...$3.hijos], linea: yylineno}); }
  | ATRIBUTO_TYPE { $$ = new NodoAST({label: 'ATRIBUTOS_TYPE', hijos: [$1], linea: yylineno}); }
;

ATRIBUTO_TYPE /*-->TR - EJ<--*/
  : id dos_puntos EXP { $$ = new NodoAST({label: 'ATRIBUTO_TYPE', hijos: [$1,$2,$3], linea: yylineno}); }
;

ARRAY_LENGTH /*-->TR - EJ<--*/
  : id punto length /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_LENGTH', hijos: [$1,$2,$3], linea: yylineno}); }
  | id LISTA_ACCESOS_ARREGLO punto length /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_LENGTH', hijos: [$1,$2,$3,$4], linea: yylineno}); }
  | id LISTA_ACCESOS_TYPE punto length /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_LENGTH', hijos: [$1,$2,$3,$4], linea: yylineno}); }
;

ARRAY_POP /*-->TR - EJ<--*/
  : id punto pop par_izq par_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_POP', hijos: [$1,$2,$3,$4,$5], linea: yylineno}); }
  | id LISTA_ACCESOS_ARREGLO punto pop par_izq par_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_POP', hijos: [$1,$2,$3,$4,$5,$6], linea: yylineno}); }
  | id LISTA_ACCESOS_TYPE punto pop par_izq par_der /*-->TR - EJ<--*/ { $$ = new NodoAST({label: 'ARRAY_POP', hijos: [$1,$2,$3,$4,$5,$6], linea: yylineno}); }
;

TERNARIO /*-->TR - EJ<--*/
  : EXP interrogacion EXP dos_puntos EXP { $$ = new NodoAST({label: 'TERNARIO', hijos: [$1,$2,$3,$4,$5], linea: yylineno}); }
;

ACCESO_ARREGLO /*-->TR - EJ<--*/
  : id LISTA_ACCESOS_ARREGLO { $$ = new NodoAST({label: 'ACCESO_ARREGLO', hijos: [$1, $2], linea: yylineno}); }
;

ACCESO_TYPE /*-->TR - EJ<--*/
  : id LISTA_ACCESOS_TYPE { $$ = new NodoAST({label: 'ACCESO_TYPE', hijos: [$1, $2], linea: yylineno}); }
;

LISTA_ACCESOS_TYPE /*-->TR - EJ<--*/
  : LISTA_ACCESOS_TYPE punto id { $$ = new NodoAST({label: 'LISTA_ACCESOS_TYPE', hijos: [...$1.hijos,$2,$3], linea: yylineno}); }
  | punto id { $$ = new NodoAST({label: 'LISTA_ACCESOS_TYPE', hijos: [$1,$2], linea: yylineno}); }
  | LISTA_ACCESOS_TYPE punto id LISTA_ACCESOS_ARREGLO { $$ = new NodoAST({label: 'LISTA_ACCESOS_TYPE', hijos: [...$1.hijos,$2,$3,$4], linea: yylineno}); }
  | punto id LISTA_ACCESOS_ARREGLO { $$ = new NodoAST({label: 'LISTA_ACCESOS_TYPE', hijos: [$1,$2,$3], linea: yylineno}); }
;

LISTA_ACCESOS_ARREGLO /*-->TR - EJ<--*/
  : LISTA_ACCESOS_ARREGLO cor_izq EXP cor_der { $$ = new NodoAST({label: 'LISTA_ACCESOS_ARREGLO', hijos: [...$1.hijos,$2,$3,$4], linea: yylineno}); }
  | cor_izq EXP cor_der { $$ = new NodoAST({label: 'LISTA_ACCESOS_ARREGLO', hijos: [$1,$2,$3], linea: yylineno}); }
;

LISTA_EXPRESIONES /*-->TR - EJ<--*/
  : LISTA_EXPRESIONES coma EXP { $$ = new NodoAST({label: 'LISTA_EXPRESIONES', hijos: [...$1.hijos,$2,$3], linea: yylineno}); }
  | EXP { $$ = new NodoAST({label: 'LISTA_EXPRESIONES', hijos: [$1], linea: yylineno}); }
;

/*TR - EJ*/
TIPO_DEC_VARIABLE
  : let       { $$ = new NodoAST({label: 'TIPO_DEC_VARIABLE', hijos: [$1], linea: yylineno}); }
  | const     { $$ = new NodoAST({label: 'TIPO_DEC_VARIABLE', hijos: [$1], linea: yylineno}); }
;

/*TR - EJ*/
TIPO_VARIABLE_NATIVA
  : catring  { $$ = new NodoAST({label: 'TIPO_VARIABLE_NATIVA', hijos: [$1], linea: yylineno}); }
  | tero  { $$ = new NodoAST({label: 'TIPO_VARIABLE_NATIVA', hijos: [$1], linea: yylineno}); }
  | boolean { $$ = new NodoAST({label: 'TIPO_VARIABLE_NATIVA', hijos: [$1], linea: yylineno}); }
  | vacio    { $$ = new NodoAST({label: 'TIPO_VARIABLE_NATIVA', hijos: [$1], linea: yylineno}); }
  | id      { $$ = new NodoAST({label: 'TIPO_VARIABLE_NATIVA', hijos: [new NodoAST({label: 'ID', hijos: [$1], linea: yylineno})], linea: yylineno}); }
;

ESCRIBA_REGISTRO /*-->TR - EJ<--*/
  : escriba punto registro par_izq LISTA_EXPRESIONES par_der punto_coma { $$ = new NodoAST({label: 'ESCRIBA_REGISTRO', hijos: [$1,$2,$3,$4,$5,$6,$7], linea: yylineno}); }
;
