sucesor(E1, E2, Costo):- 
estadoFinal(E):-
estadoPoda(E):-

esUnaSolucionEC(EI, Camino) :- 
    	esUnaSolucionEC(EI, Cam).

esUnaSolucionEC(E, _) :- estadoPoda(E), !, fail. 
esUnaSolucionEC(E, [E]) :- estadoFinal(E), !.
esUnaSolucionEC(E, [EI|Camino]) :- 
    	sucesor(E, Es, _), 
	esUnaSolucionEC(Es, Camino).

esLaMejorSolucionEC(E, Cam) :- 
    setof([Ct,Cam], (esUnaSolucionEC(E, Cam), costo(Cam, Ct)), [[_,Cam]|_]).

costo([_|[]], 0).
costo([E1,E2|Camino], Costo):-
    costo([E2|Camino], Ct2), sucesor(E1,E2,Ct), Costo is Ct + Ct2. 
    
