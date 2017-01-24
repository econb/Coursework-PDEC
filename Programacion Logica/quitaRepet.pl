/* Problema: Eliminar repetidos multinivel
 * Asignatura: PDEC 
 */

%prueba 1: quitaRepet([1,1,1,1,1,3,3,3,3,5,5,5,5], L).
%prueba 2: quitaRepet([1, [[2,2],[[1,1,1]]], [3,3,3,[3,3,3]], 2,1,1,5,5,6], L).
%pueba 3: quitaRepet([1, [[2,2],[[1,1,1]]], [3,3,3,[3,[[3,3]]]]], L).

/* quitaRepet(L, Ls): verdad si Ls es la lista L sin elementos repetidos, sin importar el nivel de anidamiento */
quitaRepet([], []).
quitaRepet(H, H) :- not(is_list(H)), !.
quitaRepet([H|T], Ts) :- quitaRepet(H, Hs), quitaRepet(T, Ts), member(Hs, Ts).
quitaRepet([H|T], [Hs|Ts]) :- quitaRepet(H, Hs), quitaRepet(T, Ts), not(member(Hs, Ts)).
