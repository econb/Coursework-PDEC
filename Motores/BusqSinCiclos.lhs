*********************************************
* Modelado general del problema
*********************************************

Un estado del problema

>	type Estado = (Int,Int)

Los sucesores con sus costos de avance

>	type Sucesores = [(Estado, Float)]

Un camino con su costo total de avance.

>	type Camino = (Float, [Estado])

Verifica si es un estado final

>	estadoFinal :: Estado -> Bool

Verifica si es un estado poda

>	estadoPoda :: Estado -> Bool

Calcula los sucesores de un nodo

>	sucesores :: Estado -> Sucesores

*********************************************
* Problema de busqueda
*********************************************

>	adicione :: Camino -> [Camino] -> [Camino]
>	adicione cam [] = [cam]
>	adicione (cst,cam) ((cst2,cam2):xs) | cst2 < cst = (cst2,cam2) : (adicione (cst,cam) xs)
>					    | otherwise =  (cst,cam) : ((cst2,cam2):xs)

>	adicioneCs :: [Camino] -> [Camino] -> [Camino]
>	adicioneCs [] lisCam2 = lisCam2
>	adicioneCs (cam:lisCam)  lisCam2 = adicioneCs lisCam (adicione cam lisCam2)

>	expanda :: Camino -> [Camino]
>	expanda (cst,estados) = [(costoTotalAvance, estados ++ [estado]) 
>				| (estado, cstAvance) <- sucesores (last estados)]
>					where costoTotalAvance = cst + cstAvance					      						

Busca todas las posibles soluciones a partir de caminos iniciales
>	sonSolucionesCaminos :: [Camino] -> [Camino]
>	sonSolucionesCaminos [] = []
>	sonSolucionesCaminos ((cstAv,estados):caminos) | estadoFinal (last estados) = [(cstAv,estados) : sonSoluciones caminos]
>						       | otherwise = sonSoluciones posiblesCaminos
>								where posiblesCaminos = asicioneCs (expanda (cstAv,estados)) caminos

Busca todas las posibles soluciones a partir de un estado inicial
>	sonSoluciones :: Estado -> [Camino]
>	

