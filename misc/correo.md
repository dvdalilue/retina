Hola,

Les escribo es relación a las dos primeras fases en el desarrollo del intérprete. Hay observaciones puntuales para ambas etapas. 

En el lexer, algunos simplemente implementaron un reconocedor de palabras que imprimía algo como lo que especifiqué en la salida ejemplo. Independientemente de qué estructuras hayan usado, esa no era la idea El trabajo del lexer es convertir un texto en una lista de objetos, palabras válidas del lenguaje. Por otro lado, el hecho de usar condicionales medianos o grandes, dificultaría extender o entender cualquier código. Algunos implementaron su lexer usando clases aunque lo hicieron agrupando cierto tipo de tokens siguiendo ciertas categorías, lo que podría ser perjudicial y también dificultaría extender las palabras permitidas en caso de ser necesario. 

Más adelante, en el parser, se necesitan palabras distinguibles y no palabras pertenecientes a un conjunto de palabras. Las mismas, que ya se sabe que son válidas en el lenguaje, serán usadas para formar oraciones gracias a las reglas de la gramática. Estás definen el orden que deben seguir las palabras para tener una oración válida, obteniendo al final un texto válido del lenguaje, conformado desde elementos más internos, en nuestro caso identificadores, literales y expresiones. Así hasta las instrucciones o el programa completo. Haciendo uso de una estructura abstracta de un árbol, cuya raíz es el programa completo.

Entonces, ahora se tiene un texto del lenguaje bien ordenado que debe ser recorrido desde las estructuras más externas hasta las más internas. Llegando hasta las hojas, se validan esos elementos más pequeños. Estos a su vez conforman otros elementos más grandes y así se debe ir subiendo en el árbol hasta la raíz; verificando en cada nodo. Habiendo hecho esto, se tiene un objeto abstracto con información que posee información válida y con sentido, un programa representado por un árbol abstracto, donde el paso restante sería ejecutarlo, siendo esta etapa la validación. La última etapa sería correr el programa.

Comentario: el uso de clases para representar comportamientos es necesario para el desarrollo de cualquier proyecto que use un lenguaje orientado a objetos. Yo veo con detalle cómo resolvieron cada problema; mi idea es que cada vez lo hagan mejor y entiendan el por qué de ciertas cosas.

Detalle: No hay necesidad de distinguir entre tipos durante el análisis sintáctico, máximo la existencia de cada tipo, un token para number y otro para boolean.

En resumen, los trabajos de cada fase serían:
Lexer. Tomar un texto y ver si solo contiene palabras válidas del lenguaje.
Parser. Tomar un conjunto de palabras válidas y ver si están bien ordenadas.
Contexto. Tomar un conjunto de palabras bien ordenadas y ver si ese orden tiene un significado coherente.
Intérprete. Tomar un objeto con información semántica de un programa y realizar un cómputo.