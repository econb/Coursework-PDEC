#Proyecto final

##Problemática

Fósforos Lógicos: Remover el mínimo número de fósforos posibles de un tablero con el fin de lograr una configuración dada por un reto.

El juego es representado por un tablero con fósforos, éstos son rectas dispuestas en un plano que pueden ser perpendiculares o paralelas,
pero no oblicuas.

Para solucionar un reto, se deben remover N fósforos de la matriz, de modo que se consiga un número de cuadrados que pueden ser de distinto tamaño, siendo estos parámetros dados por el reto. El problema como tal consiste en saber exactamente cuales fósforos de la matriz son los que se deben remover para cumplir con un reto.

##Estrategia de Solución

El juego se puede representar como un espacio de estados donde cada nodo represente un “snapshot” del juego, y una búsqueda en este espacio permitiría llegar a un estado meta, que este caso sería la solución a un reto.

El método de búsqueda se puede caracterizar de la siguiente forma:
* Informado: la ramificación del espacio de búsqueda es bastante grande, así que se necesita conocimiento heurístico para disminuir el costo computacional de buscar una solución. (consultar anexo)
* Óptimo: es necesario ir óptimo debido pueden existir varios caminos para llegar a un estado meta, y se desea que sea el menos costoso que de acuerdo al contexto del juego, correspondería a remover el menor número de fósforos posibles.

Por estas razones, optar por el método A* sería conveniente para solucionar el problema.

##Paradigma

El paradigma funcional, usando el lenguaje Haskell puede ser una buena opción debido a:

1. Renombrar o crear nuevos tipos de datos puede ser una ventaja, pues uno de los retos del problema será escoger una buena representación de la información que sea fácil de manejar y entender.

2. El motor de inferencia de Prolog hace búsqueda en profundidad, este no sería aprovechado debido a que el método A* hace otro tipo de búsqueda en el cual varias trayectorias se tienen a consideración y se abre camino por la más opcionada, pero sin dejarde considerar las demás.

#Espacio de Búsqueda

Estado inicial: se han removido 0 fósforos.

Estado final:
* Se han removido 4 fósforos
* 4 cuadros con lados que miden 1.
* 1 cuadro con lados que miden 3.

Hay varias soluciones al reto [4,0,1], a continuación se muestran algunas, pero la mejor solución será aquella donde se remueva el menor número de fósforos.

![Search space](https://github.com/ecosdev/PDEC/blob/master/Final%20project/searchspace.png)

#El problema de contar cuadrados

Estado inicial: (0,0)  
Estado final: (0,0)  
Camino: [ (0,0), (1,0), (2,0), (2,1), (2,2), (1,2), (0,2), (0,1) (0,0) ]  

![Square](https://github.com/ecosdev/PDEC/blob/master/Final%20project/square.PNG)

Identificar un cuadrado se reduce a reconocer cuatro ángulos rectos a partir de la secuencia de coordenadas, y el patrón para reconocer ángulos rectos es el siguiente:

(X,_), (X,Y), (_,Y) ó (_,Y), (X,Y), (X,_)
