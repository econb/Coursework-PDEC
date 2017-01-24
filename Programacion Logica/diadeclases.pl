/* Problema: Un dia de clase
 * Asignatura: PDEC 
 */

% Para probar el programa: horario(X).

profesor(maria).
profesor(jesus).
profesor(faraon).
asignatura(logica).
asignatura(programacion).
asignatura(matematicas).
dia(lunes).
dia(miercoles).
dia(jueves).

/* no_trabaja(Profesor, Dia): verdad si al profesor Profesor no le gusta trabajar el dia Dia.*/
no_trabaja(faraon, lunes).

/* no_imparte(Profesor, Asignatura): verdad si el profesor Profesor no imparte la asignatura Asignatura.*/
no_imparte(maria, logica).
no_imparte(maria, matematicas).
no_imparte(Profesor, Asignatura) :- no_trabaja(Profesor, Dia), not(no_se_dicta(Asignatura, Dia)).

/* anterior(Diaant, Dia): verdad si el dia Diaant es anterior al dia Dia. */
anterior(lunes, miercoles).
anterior(miercoles, jueves).

/* no_se_dicta(Asignatura, Dia): verdad si la asignatura Asignatura no se dicta el dia Dia */
no_se_dicta(logica, lunes).
no_se_dicta(programacion, lunes).

/* verif_orden(A1,D1,A2,D2): verdad si el el dia que se dicta Logica es anterior al dia que se dicta Programacion */
verif_orden(programacion, DiaPrg, logica, DiaLog) :- anterior(DiaLog, DiaPrg).
verif_orden(logica, DiaLog, programacion, DiaPrg) :- anterior(DiaLog, DiaPrg).

/* diferentes(A,B,C): verdad si A, B y C son diferentes.*/
diferentes(A,B,C) :-
	not(A=B),not(A=C),not(B=C).

/* horario([X,Y,Z]): verdad si cada uno de los parametros X, Y y Z corresponden a informacion sobre cada clase (profesor, asignatura y dia) */
horario([[P1,A1,D1],[P2,A2,D2],[P3,A3,D3]]) :- 
	profesor(P1), profesor(P2), profesor(P3),
	asignatura(A1), asignatura(A2), asignatura(A3),	
	dia(D1), dia(D2), dia(D3),
	diferentes(P1,P2,P3), diferentes(A1,A2,A3), diferentes(D1,D2,D3),
	not(no_imparte(P1,A1)), not(no_se_dicta(A1,D1)),
	not(no_imparte(P2,A2)), not(no_se_dicta(A2,D2)),
	not(no_imparte(P3,A3)), not(no_se_dicta(A3,D3)),
	(verif_orden(A1,D1,A2,D2);verif_orden(A2,D2,A3,D3);verif_orden(A1,D1,A3,D3)), !.
	











