% PD 2005-06: practica_2b.pl (7 y 9 de Noviembre 2005)
% Departamento de Ciencias de la Computación e I.A.
% Universidad de Sevilla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 1: 
% (a) Definir la relacion elimina_1(N,L1,L2) que se verifica si L2 es el
%     resultado de eliminar el elemento N-ésimo de la lista L1 (si la
%     lista L1 tiene menos de N elementos, el predicado falla). Por ejemplo,
%        ?- elimina_1(2,[a,b,c,d],L).
%        L = [a,c,d] 
%        ?- elimina_1(7,[a,b,c,d],L).
%        No
% (b) Definir la relación elimina_2(N,L1,L2) que se verifica si L2 es el
%     resultado de eliminar el elemento N-ésimo de la lista L1 (si la lista
%     L1 tiene menos de N elementos, devuelve la propia lista L1). Por ejemplo,
%        ?- elimina_2(2,[a,b,c,d],L).
%        L = [a,c,d] 
%        ?- elimina_2(7,[a,b,c,d],L).
%        L = [a,b,c,d]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 2: Un número natural N es suma de cuadrados si puede escribirse de
% la forma N = M^2 + K^2, con M,K > 0. Análogamente, N es suma de cubos si
% puede escribirse de la forma N = P^3 + Q^3, P,Q > 0. 
% (a) Definir la relación suma_de_cuadrados(N) que se verifica si el número N
%     es suma de cuadrados. Por ejemplo, 
%        ?- suma_de_cuadrados(13).
%        Yes
%        ?- suma_de_cuadrados(35).
%        No
% (b) Definir la relación suma_de_cubos(N) que se verifica si el número N es
%     suma de cubos. Por ejemplo,
%        ?- suma_de_cubos(13).
%        No
%        ?- suma_de_cubos(35).
%        Yes
% (c) Calcular el menor número de dos cifras que es, a la vez, suma de
%     cuadrados y suma de cubos.
% (d) Calculr el menor número par de tres cifras que es suma de
%     cuadrados y, además, su mitad es suma de cubos.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 3:  El problema de la partición puede expresarse informalmente como
% sigue: 
%    Dos compañeros de piso hacen juntos la compra de la semana, ¿es posible
%    repartir los productos comprados en dos bolsas de manera que cada bolsa 
%    pese exactamente lo mismo?
% Una versión formal del problema anterior es la siguiente:
%    Dada una lista de números naturales L = [P1,P2, ... ,Pi] determinar 
%    si es posible dividir la lista L en dos listas, L1 y L2, de manera 
%    que la suma de los elementos de L1 coincida con la suma de los elementos 
%    de L2.
% El objetivo de este ejercicio es definir la relación partición/3 que resuelva
% el problema anterior. Para ello se piden los siguientes apartados.
% (a) Definir, usando recursión sobre una lista L, la relación
%     subconjunto(+L,?S) que se verifica si S es un subconjunto de L.
%     Por ejemplo,
%        ?- subconjunto([a,b,c],S).
%        S = [] ;
%        S = [c] ;
%        S = [b] ;
%        S = [b, c] ;
%        S = [a] ;
%        S = [a, c] ;
%        S = [a, b] ;
%        S = [a, b, c] ;
%        No
% (b) Definir la relación reparto(+L,?L1,?L2) que se verifica si L1 y L2 es un
%     reparto de L; es decir, L1 y L2 son dos conjuntos disjuntos cuya unión es
%     L. Por ejemplo,
%        ?- reparto([a,b,c],L1,L2). 
%        L1 = []	  L2 = [a, b, c] ;
%        L1 = [c]	  L2 = [a, b] ;
%        L1 = [b]	  L2 = [a, c] ;
%        L1 = [b, c]      L2 = [a] ;
%        L1 = [a]	  L2 = [b, c] ;
%        L1 = [a, c]      L2 = [b] ;
%        L1 = [a, b]      L2 = [c] ;
%        L1 = [a,b,c]     L2 = [];
%        No
%     Nótese que las últimas cuatro respuestas son redundantes (se intercambian
%     los papeles de L1 y L2). ¿Cómo es posible modificar la relación anterior 
%     para no obtener respuestas redundantes?
% (c) Definir la relación partición(+L,?L1,?L2) que se verifica si L1 y L2 es
%     un reparto de la lista de números L tal que la suma de los elementos en
%     sendas listas coincide. Por ejemplo,
%        ?- partición([1,4,6,8,1],L1,L2).
%        L1 = [4,6]   L2 = [1,8,1] ;
%        L1 = [1,8,1] L2 = [4,6]   ;
%        No
%        ?- partición([1,4,6,8,2],L1,L2).
%        No
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 4: (Complementario) Se dice que L es una sucesión de Lanford si L 
% es una lista de longitud 27 en la cual aparecen 3 veces cada uno de los 
% dígitos del 1 al 9 y que además cumple la propiedad de que entre dos 1 
% siempre hay un dígito, entre dos 2 hay dos dígitos, entre dos 3 hay tres 
% dígitos, etc.  
%
% El objetivo de este ejercicio es definir la relación lanford(L) que se 
% verifica si L es una sucesión de Lanford. Por ejemplo,
%    ?- lanford(L).
%    L = [1,9,1,2,1,8,2,4,6,2,7,9,4,5,8,6,3,4,7,5,3,9,6,8,3,5,7]
% Para ello consideramos primero la siguiente relación sublista/2 definida por
%    sublista(L1,L2):-
%       append(_,L3,L2),
%       append(L1,_,L3).
%
% (a) ¿Qué responde Prolog a las siguientes preguntas?
%        ?- length(L,5).
%        ?- length(L,3), member(a,L), member(b,L), member(c,L).
%        ?- sublista([b],[X,Y,Z]), sublista([a,_,a],[X,Y,Z]).
%
% (b) Defineir la relación lanford(L) (Idea: usar los relaciones sublista/2 y 
%     length/2).
%
% (c) Calcular todas las sucesiones de Lanford.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%% CULTURILLA COMBINATORIA

permutaciones2([],[]).
permutaciones2([X|Xs],PXs):-
permutaciones2(Xs,Ps),
select(X,PXs,Ps).

combinaciones(0,_,[]).
combinaciones(_,[],[]).
combinaciones(_,[X],[X]).
combinaciones(N,[X|Xs],[X|Xs]):- length([X|Xs],N).
combinaciones(N,[X|Xs],Solu):- length([X|Xs],N2), N2>N, select(_Z,[X|Xs],S), combinaciones(N,S,Solu).


combinacion2(0,_Xs,[]).
combinacion2(N,[X|Xs],[X|Cs]) :- N>0, N1 is N-1, combinacion2(N1,Xs,Cs). 
combinacion2(N,[_X|Xs],Cs) :- N>0, combinacion2(N,Xs,Cs).















