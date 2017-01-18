

>	module Fosforos (estadoSolucion, Estado, Coord) where
>	import ContadorCuadros
>	import DatosPrueba

*************************************************************
* Modelado del problema
*************************************************************

>	type Estado = [[Coord]]
>	type Sucesores = [(Estado, Float)]
>	type Camino = (Float, [Estado])
>	type Coord = (Integer, Integer)

>	estadoFinal :: Estado -> Bool
>	estadoFinal estado = (contarCuadros n estado) == reto
>		where n = toInteger (length reto)

>	estadoPoda :: Estado -> Bool
>	estadoPoda estado = p3 || p2 || p1
>		where p1 = poda1 (contarCuadros n estado) reto
>		      p2 = poda2 reto
>		      p3 = poda3 estado
>		      n = toInteger (length reto)

>	sucesores :: Estado -> Sucesores
>	sucesores estado =  [ ((reemplazarElem estado elemento sustituto), 1) 
>		| (elemento, sustituto) <- (crearListaSustitutos estado) ]

>	costoEstimado :: Estado -> Float
>	costoEstimado estado = intToFloat(distancia)
>		where distancia = distListas (contarCuadros n estado) reto
>		      n = toInteger (length reto)

*************************************************************
Motor de busqueda A
*************************************************************

>	adicione :: Camino -> [Camino] -> [Camino]
>	adicione cam [] = [cam]
>	adicione (cst,cam) ((cst2,cam2):xs) | cst2 < cst = (cst2,cam2) : (adicione (cst,cam) xs)
>					    | otherwise =  (cst,cam) : ((cst2,cam2):xs)

>	adicioneCs :: [Camino] -> [Camino] -> [Camino]
>	adicioneCs [] lisCam2 = lisCam2
>	adicioneCs (cam:lisCam)  lisCam2 = adicioneCs lisCam (adicione cam lisCam2)

>	expanda :: Camino -> [Camino]
>	expanda (cst,estados) = [(cst - (costoEstimado (last estados)) + cstReal + costoEstimado (estado),
>				(estados ++ [estado])) 
>				| (estado,cstReal) <- sucesores (last estados), notElem estado estados]

>	mejorSolucionEnCaminos :: [Camino] -> Camino
>	mejorSolucionEnCaminos [] = (0, [])
>	mejorSolucionEnCaminos ((cst, estados):caminos) | verifPoda estados = mejorSolucionEnCaminos caminos
>							| estadoFinal (last estados) = (cst, estados)
>							| otherwise = mejorSolucionEnCaminos posiblesCaminos
>								where posiblesCaminos = adicioneCs (expanda (cst, estados)) caminos

>	mejorSolucion :: Estado -> Camino
>	mejorSolucion estado = mejorSolucionEnCaminos [camino]
>		where camino = (costoEstimado estado, [estado])

*******************************************************
* Funciones Auxiliares
*******************************************************

Forma parejas de elementos sustitutos entre si.
Esta lista de sustitutos servira para construir los posibles sucesores de un estado 

>	crearListaSustitutos :: Estado -> [([Coord],[Coord])]
>	crearListaSustitutos [] = []
>	crearListaSustitutos (elemento:tablero) = zip (repeat elemento) (sublistas elemento) ++ crearListaSustitutos tablero

Calcula las sublistas resultantes al remover un elemento de una lista

>	sublistas :: Eq a => [a] -> [[a]]
>	sublistas lista = sublistas' (length lista) lista

>	sublistas' :: Eq a => Int -> [a] -> [[a]]
>	sublistas' n lista | n == 2 =  [elimElem lista 1]
>			   | n > 2 = [elimElem lista (n-1)] ++ (sublistas' (n-1) lista)
>			   | otherwise = []

Elimina un elemento de una lista en una posicion dada

>	elimElem :: [a] -> Int -> [a]
>	elimElem [] _ = []
>	elimElem (_:xs) 0 = xs
>	elimElem (x:xs) n = x : elimElem xs (n-1)

Reemplaza un elemento por un elemento sustituto en una lista

>	reemplazarElem :: Eq a => [a] -> a -> a -> [a]
>	reemplazarElem [] _ _ = []
>	reemplazarElem (x:xs) elemento elemsust  
>		| x == elemento = elemsust:xs
>		| otherwise = x:(reemplazarElem xs elemento elemsust)

Calcula la distancia entre dos listas de enteros

>	distListas :: [Integer] -> [Integer] -> Integer
>	distListas [] [] = 0
>	distListas _ [] = 0
>	distListas [] _ = 0
>	distListas (x:xs) (y:ys) = abs (x - y) + distListas xs ys

Verifica si en una lista de estados, hay estados poda

>	verifPoda :: [Estado] -> Bool
>	verifPoda [] = False
>	verifPoda (e:estados) = estadoPoda e || verifPoda estados

Verdad si el numero de cuadrados de un estado es menor que el requerido por el reto

>	poda1 :: [Integer] -> [Integer] -> Bool
>	poda1 [] [] = False
>	poda1 _ [] = False
>	poda1 [] _ = False
>	poda1 (x:xs) (y:ys) = x < y || poda1 xs ys

Verdad si el reto es no valido considerando que sus maximos valores
deben ser de la forma [n^2,...,2^2,1^2], siendo n el tamaño de la lista

>	poda2 :: [Integer] -> Bool
>	poda2 [] = False
>	poda2 (x:xs) = excedeLim || poda2 xs
>		where excedeLim = x > toInteger ((length (x:xs))^2)

Verdad si estado es un estado invalido contando el numero de relaciones de cada punto.
Un estado es invalido cuando hay un punto que solo esta relacionado con otro punto.

>	poda3 :: Estado -> Bool
>	poda3 estado = elem 1 [relaciones (toInteger x, toInteger y) estado| y <- [0..n], x <- [0..n]]
>		where n = length reto


Cuenta el numero de relaciones que tiene un punto con otros puntos en el tablero.
Una relacion significa que hay un fosforo

>	relaciones :: Coord -> Estado -> Int
>	relaciones _ [] = 0
>	relaciones puntoBus ((punto:lpuntos):listas) | puntoBus == punto = (length lpuntos) + relaciones puntoBus listas
>						     | elem puntoBus lpuntos = 1 + relaciones puntoBus listas
>						     | otherwise = relaciones puntoBus listas	

Retorna el ultimo estado de un camino luego de encontrar una solucion

>	estadoSolucion :: Estado -> Estado
>	estadoSolucion estado = estadoSolucion' (mejorSolucion estado)

>	estadoSolucion' :: Camino -> Estado
>	estadoSolucion' (_, []) = []
>	estadoSolucion' (cst, estados) = last estados
