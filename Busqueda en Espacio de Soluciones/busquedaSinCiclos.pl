/* sucesor(A, B): verdad si A es sucesor de B */
sucesor(a, s).
sucesor(d, s).
sucesor(b, a).
sucesor(d, a).
sucesor(c, b).
sucesor(e, d).
sucesor(b, e).
sucesor(f, e).
sucesor(g, f).

estadoFinal(g).
estadoPoda(b).

haySolucion(E1) :- estadoFinal(E1).
haySolucion(E1) :- estadoPoda(E1), fail.
haySolucion(E1) :- sucesor(E2, E1), haySolucion(E2).

esUnaSolucion(E1,[E1]) :- estadoFinal(E1).
esUnaSolucion(E1, _) :- estadoPoda(E1), fail.
esUnaSolucion(E1, [E1|Camino]) :- sucesor(E2, E1), esUnaSolucion(E2, Camino).

esLaMejorSolucion(E1, Mejor) :- setof([Len,Cam], (esUnaSolucion(E1, Cam), length(Cam, Len)), [[_,Mejor]|_]).
