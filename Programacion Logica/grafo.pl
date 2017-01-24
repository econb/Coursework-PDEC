/* camino(X, Y): verdad si hay un camino desde X hasta Y */
camino(a,b).
camino(a,e).
camino(b,c).
camino(b,h).
camino(c,e).
camino(c,d).
camino(c,f).
camino(d,g).
camino(e,f).
camino(e,g).
camino(f,d).
camino(f,g).
camino(g,m).
camino(h,g).
camino(h,m).

/* ruta(A, B, H): verdad si hay una ruta desde A hasta B, Acum es la ruta acumulada */
ruta(A, B, Acum, [B|Acum]) :- camino(A, B), !.
ruta(A, B, Acum, Ruta) :- camino(A, X), ruta(X, B, [X|Acum], Ruta).
