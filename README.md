## Instrucciones
- Instalar Jison global con "npm i jison -g" para usar sus comandos y tipos de archivos
- El archivo parser.txt hay que cambiarle la extension a .jison despues la instalación del jison para seguir las instrucciones
- Se genera el lexer dentro de los expresiones %lex %% /lex (ya estan en el parser.txt)
- Se crean las precedencias y las asociaciones de operaciones con %left y %right (Esto ya hace parte del parser) (ya estan en el parser.txt)
- Luego se le da paso a la creación del parser entre las expresiones %start S %% (ya estan en el parser.txt)
- Se abre la consola y se escribe "jison parser.jison" para generar el JS del parser y lexer

## Extras
- La librería usada obliga a tener el parser y el lexer en el mismo archivo 
- Todo se realizo tomando como referencia la docs de Jison https://gerhobbelt.github.io/jison/docs/ y el video https://www.youtube.com/watch?v=quxDddqkGsc
- Tambien se tomo el siguiente proyecto como referencía que sale en la docuemntación de Jison git://github.com/zaach/jison.git y  https://github.com/dmomotic/matriosh-ts