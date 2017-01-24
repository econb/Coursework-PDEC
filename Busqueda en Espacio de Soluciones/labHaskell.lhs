Laboratorio motor A - A*. 
Punto 1
PDEC

Estado: Un estado de un problema.

>	type Estado = Char

Sucesores: Sucesores con sus costos.

>	type Sucesores = [(Estado, Float)]

Camino: camino con su costo posible hacia el final.

>	type Camino = (Float, [Estado])

>	estadoFinal :: Estado -> Bool
>	estadoFinal 'g' = True
>	estadoFinal _ = False

>	sucesores :: Estado -> Sucesores
>	sucesores 's' = [('a',3), ('d',4)] 
>	sucesores 'a' = [('b',4), ('d',5), ('s',3)]
>	sucesores 'b' = [('c',4), ('e',5), ('a',4)]
>	sucesores 'c' = [('b',4)]
>	sucesores 'd' = [('e',2), ('a',5), ('s',4)]
>	sucesores 'e' = [('f',4), ('b',5), ('d',2)]
>	sucesores 'f' = [('g',3), ('e',4)]
>	sucesores 'g' = [('f',3)]
>	sucesores _ = []

>	costoEstimado :: Estado -> Float
>	costoEstimado 's' = 11.0
>	costoEstimado 'a' = 10.4
>	costoEstimado 'b' = 6.7
>	costoEstimado 'c' = 4.0
>	costoEstimado 'd' = 8.9
>	costoEstimado 'e' = 6.9
>	costoEstimado 'f' = 3.0
>	costoEstimado 'g' = 0.0
>	costoEstimado _	= 0.0


adicione: Adiciona de manera ordenada un camino en una secuencia ordenada de caminos.

>	adicione :: Camino -> [Camino] -> [Camino]
>	adicione cam [] = [cam]
>	adicione (cst,cam) ((cst2,cam2):xs) | cst2 < cst = (cst2,cam2) : (adicione (cst,cam) xs)
>					    | otherwise =  (cst,cam) : ((cst2,cam2):xs)

adicioneCs: Adiciona manteniendo el orden caminos a una secuencia ordenada de caminos.

>	adicioneCs :: [Camino] -> [Camino] -> [Camino]
>	adicioneCs [] lisCam2 = lisCam2
>	adicioneCs (cam:lisCam)  lisCam2 = adicioneCs lisCam (adicione cam lisCam2)

expanda: Expande un camino incluyendo únicamente caminos sin ciclos.

>	expanda :: Camino -> [Camino]
>	expanda (cst,estados) = [(cst - (costoEstimado (last estados)) + cstReal + costoEstimado (estado),
>				(estados ++ [estado])) 
>				| (estado,cstReal) <- sucesores (last estados), notElem estado estados]

mejorSolucionEnCaminos: busca la mejor solucion considerando una secuencia ordenada de posibles caminos iniciales.

>	mejorSolucionEnCaminos :: [Camino] -> Camino
>	mejorSolucionEnCaminos [] = (0, [])
>	mejorSolucionEnCaminos ((cst, estados):caminos) | estadoFinal (last estados) = (cst, estados)
>							| otherwise = mejorSolucionEnCaminos posiblesCaminos
>								where posiblesCaminos = adicioneCs (expanda (cst, estados)) caminos

mejorSolucion: busca la mejor solucion usando el algoritmo A - A*. Si no es posible (0, []).

>	mejorSolucion :: Estado -> Camino
>	mejorSolucion estado = mejorSolucionEnCaminos [camino]
>		where camino = (costoEstimado estado, [estado])


