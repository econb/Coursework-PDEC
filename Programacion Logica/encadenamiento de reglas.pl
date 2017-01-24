/**Regla de encadenamiento **/
/*** Preparado por Raul Chaparro ****/

/**Definicion de operadores basicos**/

/*** Le permite trabajar las reglas con operadores:  si,entonces..**/ 

%%%%%%%%%%   SE DEFINEN LOS OPERADORES Y SU PRECEDENCIA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-op(800,fx,si).
:-op(700,xfx,entonces).
:-op(300,xfy,o).
:-op(200,xfy, y). 
 
/** Definicion de la semantica para los oiperadores anteriormente definidos **/

 es_verdad(P):-
          hecho(P).

 es_verdad(P):-
          si Cond entonces P,
          es_verdad(Cond).

 es_verdad(P y Q):-
          es_verdad(P),
          es_verdad(Q).

 es_verdad(P o Q):-
          es_verdad(P);
          es_verdad(Q).


/*** Encadenamiento hacia adelante ***/

 adelante:-
           nuevo_deriva_hecho(P),
           !,
           write(`Derivado:`),
           write(P),nl,
           assert(hecho(P)), 
           adelante
           ;
           write(`No_hay_mas`),nl.  


     
 nuevo_deriva_hecho(Conc):-
                   si Cond entonces Conc,
                   not hecho(Conc),
                   comp_hecho(Cond).   

 comp_hecho(Cond):-
           hecho(Cond).  
  
 comp_hecho(Cond1 y Cond2):-
           comp_hecho(Cond1),
           comp_hecho(Cond2).

 comp_hecho(Cond1 o Cond2):-
           comp_hecho(Cond1)
           ;
           comp_hecho(Cond2).

/***Ejemplo **/
 
  si (tem(X,T),T>38) entonces fiebre(X,si).
  si (tem(X,T)) entonces fiebre(X,no).

  si p entonces q.
  si q entonces r.
  si r entonces w.
  si w entonces h.

  si p y q entonces m.
  si q o t entonces s.

  si (p y m) o r entonces (a o b).
  
  si a entonces b.
  si h entonces b.
  si b y q entonces m.
  si r entonces h.
 

 /***genera el arbol de prueba **/

 :-op(800,xfx,<=).
 
 es_verdad(P,[P]):-
          hecho(P).
 es_verdad(P, [P<=CondPrueba,Cond]):-
          si Cond entonces P,
          es_verdad(Cond, [CondPrueba]).

  es_verdad(P y Q,[Prueba1 , Prueba2]):-
           es_verdad(P,[Prueba1]),
           es_verdad(Q,[Prueba2]).

  es_verdad(P o Q,[Prueba]):-
           es_verdad(P,[Prueba])
           ;
           es_verdad(Q,[Prueba]).

 inter:- write(holaxxxesciba_su_nombre_y_depues), nl,read(Nombre),
              nl, write(digitetemperatura),read(Temp),assert(tem(Nombre,Temp)),
              si (tem(Nombre,Temp),Temp>38) entonces fiebre(Nombre,V),
              write(V),nl,nl.