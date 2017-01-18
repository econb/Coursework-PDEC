

Problema:
Dada una lista de listas de coordenadas cartesianas representando un estado del tablero de juego,
contar el numero de cuadrados de distintos tamaños que puedan estar presentes.

>	module ContadorCuadros (contarCuadros, intToFloat) where

*************************************************************
* Modelado del problema
*************************************************************

>	type Estado = (Integer, Integer)
>	type Sucesores = [(Estado, Float)]
>	type Camino = (Float, [Estado])

>	costoEstimado :: Estado -> Estado -> Float
>	costoEstimado (x1, y1) (x2, y2) = sqrt ( intToFloat((x2-x1)^2) + intToFloat((y2-y1)^2) )

*************************************************************
* Motor de busqueda A modificado
*************************************************************

>	adicione :: Camino -> [Camino] -> [Camino]
>	adicione cam [] = [cam]
>	adicione (cst,cam) ((cst2,cam2):xs) 
>		| cst2 < cst = (cst2,cam2) : (adicione (cst,cam) xs)
>    		| otherwise =  (cst,cam) : ((cst2,cam2):xs)

>	adicioneCs :: [Camino] -> [Camino] -> [Camino]
>	adicioneCs [] lisCam2 = lisCam2
>	adicioneCs (cam:lisCam)  lisCam2 = adicioneCs lisCam (adicione cam lisCam2)

>	expanda :: Camino -> Estado -> [[Estado]] -> [Camino]
>	expanda (cst, estados) estFinal estSucesores = 
>			[ ( (cst - (costoEstimado (last estados) estFinal) + 1 + (costoEstimado estSucesor estFinal)), 
>			   estados ++ [estSucesor])  
>			 | estSucesor <- buscarSucesores (last estados) estSucesores ]

>	buscarSucesores :: Estado -> [[Estado]] -> [Estado]
>	buscarSucesores est1 [] = []
>	buscarSucesores est1 ((est2:sucesores):lista) 
>		| est1 == est2 = sucesores
>     		| otherwise = buscarSucesores est1 lista

>	mejoresSolucionesEnCaminos :: [Camino] -> Estado -> [[Estado]] -> [Camino]
>	mejoresSolucionesEnCaminos [] _ _ = []
>	mejoresSolucionesEnCaminos ((cst, estados):caminos) estFinal tablero
>		| estFinal == (last estados) = take 2 ( (mejoresSolucionesEnCaminos caminos estFinal tablero) ++ [(cst, estados)] )
>		| otherwise = mejoresSolucionesEnCaminos posiblesCaminos estFinal tablero
>				where posiblesCaminos = adicioneCs (expanda (cst, estados) estFinal tablero) caminos

>	mejoresSoluciones :: Estado -> Estado -> [[Estado]] -> [Camino]
>	mejoresSoluciones estado estFinal tablero = mejoresSolucionesEnCaminos [camino] estFinal tablero
>		where camino = (costoEstimado estado estFinal, [estado])

*************************************************************
* Contar Cuadrados
*************************************************************

Cuenta el numero de cuadrados considerando todos los puntos del tablero.

>	contarCuadros :: Integer -> [[Estado]] -> [Integer]
>	contarCuadros n tablero = sumaListasCons [(contarCuadros' n estado estado tablero) | (estado:sucesores) <- tablero] 

Cuenta el numero de cuadrados a partir de un punto que coincide con su esquina superior izquierda

>	contarCuadros' :: Integer -> Estado -> Estado -> [[Estado]] -> [Integer]
>	contarCuadros' 0 _ _ _ = []
>	contarCuadros' n (xi,yi) (xf,yf) tablero 
>		| estaEnTablero && esCuadrado(posibleCuadrado) = [1] ++ (contarCuadros' n (xi,yi) (xf+1,yf+1) tablero)
>		| estaEnTablero && not(esCuadrado(posibleCuadrado)) = [0] ++ (contarCuadros' n (xi,yi) (xf+1,yf+1) tablero)
>		| otherwise = []
>			where estaEnTablero = (xf+1 <= n && yf+1 <= n)
>			      posibleCuadrado = mejoresSoluciones (xi,yi) (xf+1,yf+1) tablero

Suma los elementos de una lista con los de otras listas.

>	sumaListasCons :: [[Integer]] -> [Integer]
>	sumaListasCons [] = []
>	sumaListasCons (l:listas) = sumaListas l (sumaListasCons listas)

Suma los elementos de una lista con los de otra lista.

>	sumaListas :: [Integer] -> [Integer] -> [Integer]
>	sumaListas x [] = x
>	sumaListas [] y = y
>	sumaListas (x:xs) (y:ys) = [x+y] ++ sumaListas xs ys

Recibe de 0 a 2 caminos y evalua si forman un cuadrado.

>	esCuadrado :: [Camino] -> Bool
>	esCuadrado [(_,xs),(_,ys)] = anguloRecto(xs) && anguloRecto(ys)
>	esCuadrado _ = False

Verifica que exista un angulo recto en un camino (secuencia de coordenadas cartesianas).

>	anguloRecto :: [Estado] -> Bool
>	anguloRecto list = (absIguales(parte1) && ordIguales(parte2)) || (absIguales(parte2) && ordIguales(parte1))
>		where parte1 = take (div (length list) 2 + 1) list
>		      parte2 = drop (div (length list) 2) list

Verifica que un camino (secuencia de coordenadas cartesianas) es una linea recta horizontal.

>	absIguales :: [Estado] -> Bool
>	absIguales (x:[]) = True
>	absIguales ((x1,_):(x2,y2):xs) = (x1 == x2) && absIguales ((x2,y2):xs)

Verifica que un camino (secuencia de coordenadas cartesianas) es una linea recta vertical.

>	ordIguales :: [Estado] -> Bool
>	ordIguales (y:[]) = True
>	ordIguales ((_,y1):(x2,y2):ys) = (y1 == y2) && ordIguales ((x2,y2):ys)

Convierte un entero en un real

>	intToFloat :: Integer -> Float
>	intToFloat n = fromInteger (toInteger n)
