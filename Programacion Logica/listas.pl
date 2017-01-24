/* maximo(Max, L): verdad si Max es el valor maximo en una lista L */
maximo(0, []) :- !.
maximo(H, [H]) :- !.
maximo(Max, [H|T]) :- findall(X, (member(X, T), X > H), Mayores), maximo(M, Mayores), ((M >= H, Max is M); (M < H, Max is H)).

/* suma(S, L): verdad si S es la suma de los elementos de L */
suma(0, []) :- !.
suma(H, [H]) :- !.
suma(Sum, [H|T]) :- suma(S, T), Sum is S + H. 

/* elim_rep(L, Lsin): verdad si Lsin es la lista L sin valores repetidos */
elim_rep([], []) :- !.
elim_rep([X], [X]) :- !.
elim_rep([H|T], Lsin) :- member(H, T), elim_rep(T, Lsin).
elim_rep([H|T], [H|Lsin]) :- not(member(H, T)), elim_rep(T, Lsin).

/* aplanar(L, Lflat): verdad si Lflat es la lista L aplanada */
aplanar([], []) :- !. 
aplanar([H|L], Lflat) :- is_list(H), aplanar(H, Hf), aplanar(L, Lf), append(Hf, Lf, Lflat).
aplanar([H|L], Lflat) :- not(is_list(H)), aplanar(L, Lf), append([H], Lf, Lflat).

/* kelem(K, L, Elem): verdad si Elem es el k-esimo elemento de L */
kelem(_, [], _) :- false,!.
kelem(1, [H|_], H) :- !.
kelem(K, [_|T], Elem) :- K > 1, K1 is K -1, kelem(K1, T, Elem).

/* factorial(N, Fac): verdad si F es el factorial de N */
factorial(0, 1) :- !.
factorial(N, Fac) :- N1 is N - 1, factorial(N1, F), Fac is N * F.

/* fibonacci(K, Fib): verdad si Fib es el fibonacci de K */
fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(K, Fib) :- K1 is K - 1, K2 is K - 2, fibonacci(K1, F1), fibonacci(K2, F2), Fib is (F1 + F2).


