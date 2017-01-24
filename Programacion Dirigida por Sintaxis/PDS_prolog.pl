/* Problema A
 * Prolog
 */

/* Lista multinivel
1. Gramatica
  	lista -> \
	lista -> elem lista
	lista -> lista lista
*/

/* Lista multinivel
2. Atributos
	lista.suma
3. Reglas sematicas
 	lista.suma = 0
	lista.suma = 1 + lista1.suma
	lista.suma = lista1.suma + lista2.suma
*/
sumaMultinivel([], 0).
sumaMultinivel([H|T], Suma) :- not(is_list(H)), sumaMultinivel(T,Sum), Suma is H + Sum.
sumaMultinivel([H|T], Suma) :- is_list(H), sumaMultinivel(H, Sum1), sumaMultinivel(T, Sum2), Suma is Sum1 + Sum2.
 
/* Lista multinivel
2. Atributos
	lista.busqueda
3. Reglas semanticas
	lista.busqueda = { [1] 		e == buscado
			 { [H+1|T]	[H|T] = lista2.busqueda	
	lista.busqueda = { [1] ++ x	x = lista1.busqueda	
			 { [H+1|T]	[H|T] = lista2.busqueda
*/
busquedaMultinivel(Elem, [Elem|_], [1]).
busquedaMultinivel(Elem, [_|T], [Pos|Poss]) :- busquedaMultinivel(Elem, T, [P|Poss]), Pos is P + 1.
busquedaMultinivel(Elem, [H|_], [1|Poss]) :- is_list(H), busquedaMultinivel(Elem, H, Poss).

/* Lista simple
1. Gramatica
	lista -> \
	lista -> elem lista
*/

/* Dos Listas simples
2. Atributos
	lista1.lista2.mezcla
3. Reglas semanticas
	lista1.lista2.mezcla = \
	lista1.lista2.mezcla = lista2
	lista1.lista2.mezcla = lista1
	lista1.lista2.mezcla = { [elem1|L]	elem1 =< elem2, L = lista2.lista3.mezcla	
			       { [elem2|L]	elem2 < elem1, L = lista1.lista4.mezcla	
*/
mezcla([], [], []).
mezcla([], L2, L2).
mezcla(L1, [], L1).
mezcla([E1|L3], [E2|L4], [E1|Mezcla]) :- E1 =< E2, mezcla([E2|L4], L3, Mezcla).
mezcla([E1|L3], [E2|L4], [E2|Mezcla]) :- E2 < E1, mezcla([E1|L3], L4, Mezcla).
