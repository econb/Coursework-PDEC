/* Tema: Arbol Genealogico
 * Asignatura: PDEC
 */

/* [fact] persona(nombre, signo_zodiacal, edad) */
persona(mateo, aries, 70). 
persona(irene, tauro, 70).
persona(ana, leo, 50).
persona(pedro, leo, 50).
persona(maria, libra, 50).
persona(pablo, tauro, 30).
persona(juan, cancer, 30).
persona(andrea, aries, 30).
persona(milena, virgo, 30).
persona(carlos, cancer, 30).
persona(john, tauro, 20).
persona(sara, acuario, 18).
persona(erika, libra, 6).
persona(otto, sagitario, 19). 

/* [fact] padre(padre, hijo) */
/* [fact] madre(madre, hijo) */
padre(mateo, ana).
padre(mateo, pedro).
padre(pedro, milena).
padre(pedro, pablo).
padre(pedro, juan).
padre(juan, john).
padre(juan, sara).
padre(juan, otto).
padre(carlos, erika).

madre(irene, ana).
madre(irene, pedro).
madre(maria, milena).
madre(maria, pablo).
madre(maria, juan).
madre(andrea, john).
madre(andrea, sara).
madre(andrea, otto).
madre(milena, erika).


/* list_sin_repetidos(L, Lsin): verdad si Lsin es la transformacion de la secuencia L en un conjunto. */
list_sin_repetidos([], []).
list_sin_repetidos([H|T], Elems) :- member(H, T), list_sin_repetidos(T, Elems).
list_sin_repetidos([H|T], [H|Elems]) :- not(member(H,T)), list_sin_repetidos(T, Elems).

/* [rule] progenitor(X, Y): verdad si X es el padre o la madre de Y */
progenitor(X, Y) :- padre(X, Y); madre(X, Y).

/* [rule] hermano(X, Y): verdad si X es el hermano de Y */
hermano(X, Y) :- progenitor(Z, X), progenitor(Z, Y), not(X=Y).
/*hermanos(X, Z) :- findall(Y, hermano(X, Y), L), list_sin_repetidos(L, Lsin), member(Z, Lsin).*/

/* [rule] abuelo(X, Y): verdad si X es el abuelo de Y */
abuelo(X, Y) :- progenitor(X, Z), progenitor(Z, Y).

/* [rule] tio(X, Y): verdad si X es el tio de Y */
tio(X, Y) :- hermano(X, Z), progenitor(Z, Y).

/* [rule] primo(X, Y): verdad si X es el primo de Y */
primo(X, Y) :- progenitor(Z, X), tio(Z, Y).

/* [rule] bisabuelo(X, Y): verdad si X es el bisabuelo de Y */
bisabuelo(X, Y) :- progenitor(X, Z), abuelo(Z, Y).

/* [rule] primosegundo(X, Y): verdad si X es el primo segundo de Y */
primosegundo(X, Y) :- abuelo(Z, X), hermano(W, Z), abuelo(W, Y).

/* personas_signo_zodiacal(Personas, SignoZ): verdad si SignoZ es el signo zodiacal de todas las personas de la lista Personas */
personas_signo_zodiacal(Personas, SignoZ) :- findall(X, persona(X, SignoZ, _), Personas).

/* personas_edad(L, E): verdad si Edad es la edad de todas las personas de la lista Personas */
personas_edad(Personas, Edad) :- findall(X, persona(X, _, Edad), Personas).
personas_edad([H|Personas], Edad) :- revisar_edad([H|Personas], Edad).

/* revisar_edad(L, E): verdad si la edad de todas las personas de L es la misma */
revisar_edad([], _).
revisar_edad([X], Ed) :- persona(X,_,Ed).
revisar_edad([H|T], E) :- revisar_edad(T, E), persona(H,_,E1), E=E1.

/* descendiente(X, Y): verdad si X es descendiente de W */
descendiente(X, W) :- progenitor(W, X).
descendiente(X, W) :- progenitor(Y, X), descendiente(Y, W).

/* descendientes(Desc, X): verdad si Desc es la lista de descendientes de X */
descendientes(Desc, X) :- findall(Y, descendiente(Y, X), Desc).
/*descendientes([], []).
descendientes([H|T], X) :- descendiente(H, X), descendientes(T, X).*/

/* numdescendientes(Num, X): verdad si Num es el numero de descendientes de X */
numdescendientes(Num, X) :- descendientes(Desc, X), length(Desc, Num).

/* ancestros(L, X): verdad si Ancs es la lista de ancestros de X */
ancestros(Ancs, X):- findall(W, descendiente(X, W), Ancs).

/* numancestros(Num, X): verdad si Num es el numero de ancestros de X */
numancestros(Num, X) :- ancestros(Ancs, X), length(Ancs, Num).

/* tiene_mas_edad(X): verdad si X es la persona con mayor edad */
tiene_mas_edad(Nombre, Edad) :- findall([Ed, Nom], persona(Nom,_,Ed), L), sort(L, Lsort), reverse(Lsort, [[Edad, Nombre]|_]).

/* tiene_mas_desc(X): verdad si X es la persona con mayor numero de descendientes */
tiene_mas_desc(Nombre, N) :- findall([Ndes, Nom], (persona(Nom,_,_), numdescendientes(Ndes,Nom)), L), sort(L, Lsort), reverse(Lsort,[[N, Nombre]|_]).

/* reverso(L, LRev): verdad si L es la lista inversa de LRev */
reverso([], []). 
reverso(L, [X|LRev]) :- append(L1, [X], L), reverso(L1, LRev).

/* palindrome(L): verdad si Pal puede ser leido igual al derecho y al reves */
palindrome(Pal) :- name(Pal, L), reverso(L, L).

/* personas_palindrome(L) :- verdad si L es la lista de todas las personas con nombre palindrome */
personas_palindrome(L) :- findall(X, (persona(X,_,_), palindrome(X)), L).


/*
Probar:
?- hermano(sara, X).
X = john ;
X = john ;
false.

?- descendientes(L, juan).
L = [john, sara].

?- descendientes([sara, john], X).
false.
*/

