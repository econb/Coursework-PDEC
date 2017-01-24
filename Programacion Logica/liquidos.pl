:- dynamic con_veneno/1, sin_veneno/1.
retractall(con_veneno).
retractall(sin_veneno).

/* sin_veneno(X): verdad si X no tiene veneno*/
sin_veneno(rojo).

/* uno(X, Y): X es venenoso y Y no es venenoso, o viceversa. */
uno(violeta, azul).
uno(rojo, amarillo).
uno(azul, anaranjado).

/* almenosuno(X, Y): X o Y son venenosos, al menos uno debe serlo. */
almenosuno(violeta, amarillo).
almenosuno(rojo, anaranjado).
almenosuno(verde, azul).

clasificar(X) :- 
	sin_veneno(X),
	(uno(X,Y); uno(Y,X)),
	not(con_veneno(Y)),
	assert(con_veneno(Y)),
	clasificar(Y).

clasificar(Y) :-
	con_veneno(Y),
	(uno(X,Y); uno(Y,X); almenosuno(X,Y); almenosuno(Y,X)),
	not(sin_veneno(X)),
	assert(sin_veneno(X)),
	clasificar(X).

liquido_peligroso(X) :- clasificar(X), con_veneno(X).		
