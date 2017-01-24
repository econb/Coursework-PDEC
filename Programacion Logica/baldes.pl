/* Tema: Problema Baldes
 */

%prueba: ruta([24,11,8,5], [24,0,0,0], [8,8,8,0], [[24,0,0,0]], R). 

/* distancia(Lin, Lout, DisT): verdad si DisT es la distancia entre Lin y Lout */
distancia([], [], 0).
distancia([In|Lin], [Out|Lout], DisT) :- 
	distancia(Lin, Lout, Dis), DisT is sqrt(abs(In - Out) + Dis).
	
/* camino(Lcap, Lin, Lout): verdad si Lout es el estado siguiente a Lin, luego de que se haya pasado agua de un balde a otro.
 * Lcap: lista de capacidades de cada uno de los baldes.
 * Lin: lista con el contenido de cada balde.
 * Lout: lista con el contenido de cada balde, luego de que se ha pasado agua de un balde a otro.
 * Lfin: lista con el contenido final (estado meta) al cual se espera llegar. */
camino(Lcap, Lin, Lout, Lfin) :-
	setof([Dis,Lx], (pasar_agua(Lcap, Lin, Lx), distancia(Lx, Lfin, Dis)), Lord), member([Dis,Lout], Lord).

/* ruta(Lcap, Lin, Lout, Lfin, Acum, Ruta): verdad si Ruta es la lista de caminos que llevan desde Lin hasta Lout */
ruta(Lcap, Lin, Lout, Acum, [Lout|Acum]) :- camino(Lcap, Lin, Lout, Lout), !.
ruta(Lcap, Lin, Lout, Acum, Ruta) :- camino(Lcap, Lin, W, Lout), not(member(W, Acum)), ruta(Lcap, W, Lout, [W|Acum], Ruta).

/* intercambiar_agua(Lcap, Lin, Lout): verdad si Lout es el estado siguiente a Lin, luego de que se haya pasado agua de balde1 a balde2.*/
intercambiar_agua([Cap|[Cap2|_]], [In|[In2|Lin]], [Out|[Out2|Lin]]) :- 
	(Falta is Cap2 - In2, Falta > 0, ((In >= Falta, Out2 is In2 + Falta, Out is In - Falta);  (In < Falta, In > 0, Out2 is In2 + In, Out is 0)));
	(Falta is Cap - In, Falta > 0,   ((In2 >= Falta, Out is In + Falta, Out2 is In2 - Falta); (In2 < Falta, In2 > 0, Out is In + In2, Out2 is 0))).
	
/* Pasar_agua(Lcap, Lin, Lout): verdad si Lout es el estado siguiente a Lin, luego de que se haya pasado agua de balde1 a balde2. 
 * Permite obtener todas las posibles jugadas.*/
pasar_agua([Cap,Cap2], [In,In2], Lout) :- !, intercambiar_agua([Cap,Cap2], [In,In2], Lout).
pasar_agua([Cap|[Cap2|_]], [In|[In2|Lin]], Lout) :- intercambiar_agua([Cap|[Cap2|_]], [In|[In2|Lin]], Lout).
pasar_agua([Cap|[_|Lcap]], [In|[In2|Lin]], [Out|[In2|Lout]]) :- pasar_agua([Cap|Lcap], [In|Lin], [Out|Lout]).
pasar_agua([_|Lcap], [In|Lin], [In|Lout]) :- pasar_agua(Lcap, Lin, Lout).



