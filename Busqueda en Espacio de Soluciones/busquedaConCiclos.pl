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

sucesor(s, a).
sucesor(s, d).
sucesor(a, b).
sucesor(a, d).
sucesor(b, c).
sucesor(d, e).
sucesor(e, b).
sucesor(e, f).
sucesor(f, g).

estadoFinal(g).

haySolucionEC(E1) :- haySolucionCiclos(E1, []).
haySolucionCiclos(E1, _) :- estadoFinal(E1).
haySolucionCiclos(E1, Acum) :- sucesor(E2, E1), not(member(E1, Acum)), haySolucionCiclos(E2, [E1|Acum]).

esUnaSolucionEC(E1, Camino) :- esUnaSolucionCiclos(E1, [], Cam), reverse(Cam, Camino).
esUnaSolucionCiclos(E1, Acum, [E1|Acum]) :- estadoFinal(E1).
esUnaSolucionCiclos(E1, Acum, Camino) :- sucesor(E2, E1), not(member(E1, Acum)), esUnaSolucionCiclos(E2, [E1|Acum], Camino).

esLaMejorSolucionEC(E1, Mejor) :- setof([Len,Cam], (esUnaSolucionEC(E1, Cam), length(Cam, Len)), [[_,Mejor]|_]).
