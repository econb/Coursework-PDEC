/* Las mujeres y sus trabajos
 * Cada mujer tiene un solo trabajo, y cada trabajo es ocupado por solo una mujer.
 * pistas:
 * (a) Clara es violentamente alergica a las plantas 
 * (b) Luisa y la florista comparten el departamento
 * (c) A Maria y Luisa les gusta solamente la musica rock
 * (d) La jardinera, la disenadora de modas y Nelida no se conocen entre si
 */

mujer(clara).
mujer(luisa).
mujer(maria).
mujer(nelida).
ocupacion(disenadora).
ocupacion(florista).
ocupacion(jardinera).
ocupacion(directoraorquesta).

alergica(clara, plantas).
relacionado(jardinera, plantas).
relacionado(florista, plantas).

solo_escucha(luisa, rock).
solo_escucha(maria, rock).
incompatibles(directoraorquesta, rock).

no_es(Mujer, Ocupacion) :- alergica(Mujer, X), relacionado(Ocupacion, X).
no_es(luisa, florista).
no_es(Mujer, Ocupacion) :- solo_escucha(Mujer, X), incompatibles(Ocupacion, X).
no_es(nelida, jardinera).
no_es(nelida, disenadora).

diferentes(A,B,C,D) :-
	not(A=B),not(A=C),not(A=D),not(B=C),not(B=D),not(C=D).

respuesta([[M1,O1],[M2,O2],[M3,O3],[M4,O4]]) :-
	mujer(M1), mujer(M2), mujer(M3), mujer(M4),
	ocupacion(O1), ocupacion(O2), ocupacion(O3), ocupacion(O4),
	diferentes(M1,M2,M3,M4), diferentes(O1,O2,O3,O4),
	not(no_es(M1,O1)), 
	not(no_es(M2,O2)),
	not(no_es(M3,O3)),
	not(no_es(M4,O4)).
