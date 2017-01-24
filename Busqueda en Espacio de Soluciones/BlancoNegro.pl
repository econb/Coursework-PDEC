
%movimientos a la izquierda
sucesor(E1, E2, 1):- append(X, [°,Ficha1,Ficha1|Y], E1), append(X, [Ficha1,Ficha1,°|Y], E2).
sucesor(E1, E2, 1):- append(X, [°,Ficha1,Ficha2|Y], E1), not(Ficha1=Ficha2), append(X, [Ficha1,Ficha1,°|Y], E2).
sucesor(E1, E2, 1):- append(X, [°,Ficha|Y], E1), append(X, [Ficha,°|Y], E2).

%movimientos a la derecha
sucesor(E1, E2, 1):- append(X, [Ficha1,Ficha1,°|Y], E1), append(X, [°,Ficha1,Ficha1|Y], E2).
sucesor(E1, E2, 1):- append(X, [Ficha1,Ficha2,°|Y], E1), not(Ficha1=Ficha2), append(X, [°,Ficha2,Ficha2|Y], E2).
sucesor(E1, E2, 1):- append(X, [Ficha,°|Y], E1), append(X, [°,Ficha|Y], E2).

estadoFinal(E):-forall((member(X,E), not(X=°)), X=n).
estadoPoda(E):-not(member(°,E)).
estadoPoda(E):-member(X,E), not(X=n),not(X=b),not(X=°).
estadoPoda(E):-forall((member(X,E), not(X=°)), X=b).

esUnaSolucionEC(EI, Camino) :- 
    esUnaSolucionEC(EI, [], Cam), reverse(Cam, Camino).

esUnaSolucionEC(E, His, [E|His]) :- estadoPoda(E), !, fail. 
esUnaSolucionEC(E, His, [E|His]) :- estadoFinal(E), !.
esUnaSolucionEC(E, His, Camino) :- 
    sucesor(E, Es, _), not(member(E, His)), esUnaSolucionEC(Es, [E|His], Camino).

esLaMejorSolucionEC(E, Cam) :- 
    setof([Ct,Cam], (esUnaSolucionEC(E, Cam), costo(Cam, Ct)), [[_,Cam]|_]).

costo([_|[]], 0).
costo([E1,E2|Camino], Costo):-
    costo([E2|Camino], Ct2), sucesor(E1,E2,Ct), Costo is Ct + Ct2. 
    
