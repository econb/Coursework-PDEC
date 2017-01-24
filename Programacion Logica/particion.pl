/* particion(L,P): verdad si P es una particion de L */
particion(L, P) :- posibilidades(L, Lx), length(Lx, N), partes(N, Lx, P).

/* partes(N, Conj, ConjP): verdad si ConjP es un conjunto que puede tener desde 1 hasta N subconjuntos de Conj*/
partes(N, Conj, Nparticion) :- npartes(N, Conj, Nparticion); (N1 is N - 1, N > 0, partes(N1, Conj, Nparticion)).

/* npartes(N, Conj, ConjP): verdad si ConjP es un conjunto con N subconjuntos de Conj*/
npartes(_, [], []) :- !.
npartes(1, Conj, [Conj]) :- !.
npartes(N, Conj, [[X|L1]|ConjL2]) :- length(Conj,Len), N =< Len , N > 0, 
	append([X|L1], [Y|L2], Conj), N1 is N - 1, npartes(N1, [Y|L2], ConjL2).

/* Este predicado es del profesor Raul Chaparro que se encuentra en las diapositivas del curso */
permutacion([],[]).
permutacion(L,Lp):- member(X,L), remove(X,L,L1), permutacion(L1,L2), Lp=[X|L2].

/* remove(X, L, L1): verdad si L1 es la lista L sin el elemento X */
remove(_, [], []) :- !.
remove(X, [X|T], Tsx) :- remove(X, T, Tsx), !.
remove(X, [Y|T], [Y|Tsx]) :- remove(X, T, Tsx).



next([H|T], L) :- append(T, [H], L).
n_next(N, L, Lnx) :- N > 0, (next(L, Lnx) ; (N1 is N - 1, next(L, Ln), n_next(N1, Ln, Lnx))).
posibilidades(L, Lnx) :- length(L, N), n_next(N, L, Lnx). 



