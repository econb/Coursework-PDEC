subconjunto([X], [X]).
subconjunto([_], []) :- !.
subconjunto([H|T], [H|Sub]) :- subconjunto(T, Sub).
subconjunto([_|T], Sub) :- subconjunto(T, Sub).

subconjuntos(L, SubCon) :- findall(Lx, subconjunto(L, Lx), SubCon).

/* lengthlist(L, Len): verdad si Len es la cantidad de elementos de la lista L. La lista L puede no estar aplanada.*/
lengthlist([], 0) :- !.
lengthlist([C|Conj], Len) :- not(is_list(C)), lengthlist(Conj, LnCj), Len is 1 + LnCj.
lengthlist([C|Conj], Len) :- is_list(C), lengthlist(C, LnC), lengthlist(Conj, LnCj), Len is LnC + LnCj.

aja(L, [X,Y,Z]) :- member(X,L), member(Y,L),member(Z,L), not(X=Y), not(Y=Z), not(X=Z).


n_partes(N, L, Acum, [X|Acum]) :- 
	member(X, L), lengthlist([X|Acum], N), !.  
n_partes(N, L, Acum, Partes) :-
	member(L, X), lengthlist([X|Acum], Len), Len < N, n_partes(N,L,[X|Acum], Partes).

partes(N, L, Partes) :- subconjuntos(L, S), n_partes(N, S, [[]], Partes).
