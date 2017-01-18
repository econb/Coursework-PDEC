sucesor(E1, E2, Costo):- 
estadoFinal(E):-
estadoPoda(E):-

esUnaSolucionEC(EI, Camino) :- 
	esUnaSolucionEC(EI, [E1], Cam), reverse(Cam, Camino).

esUnaSolucionEC(E, _, _) :- estadoPoda(E), !, fail. 
esUnaSolucionEC(E, His, His) :- estadoFinal(E), !.

esUnaSolucionEC(E, His, Camino) :- 
	sucesor(E, Es, _),
	not(member(Es, His)), 
	esUnaSolucionEC(Es, [Es|His], Camino).

esLaMejorSolucionEC(E, Cam) :- 
   	setof([Ct,Cam], (esUnaSolucionEC(E, Cam), costo(Cam, Ct)), [[_,Cam]|_]).

costo([_|[]], 0).
costo([E1,E2|Camino], Costo):-
   	costo([E2|Camino], Ct2), sucesor(E1,E2,Ct), Costo is Ct + Ct2. 
    
