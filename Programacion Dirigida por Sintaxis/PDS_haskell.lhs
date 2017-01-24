Problema B
Haskell

-----------------------------------------------
Arbol binario
-----------------------------------------------
1. Gramatica
	arbol -> \
	arbol -> arbol, nodo, arbol

>	data ArbolBinario a = AV | 
>		AB (ArbolBinario a) a (ArbolBinario a)
>		deriving (Eq, Show)

>	a1 = AB (AB (AV) 4 (AV)) 3 (AV)
>	a2 = AB (AB (AV) 5 (AV)) 6 (AB (AV) 7 (AV))
>	a3 = AV
>	a4 = AB (AB (AV) 8 (AV)) 5 (AB (AB (AV) 4 (AV)) 3 (AV))
>	a5 = AB (AB (AV) 4 (AV)) 4 (AV)
>	a6 = AB (AB (AV) 8 (AV)) 5 (AB (AB (AV) 4 (AV)) 3 (AB (AV) 8 (AV)))

-----------------------------------------------
Dos Arboles binarios
-----------------------------------------------
2. Atributos
	arbol1.arbol2.igual
3. Reglas semanticas
	arbol1.arbol2.igual = True
	arbol1.arbol2.igual = False
	arbol1.arbol2.igual = False
	arbol1.arbol2.igual = raiz1 == raiz2 && arbol3.arbol5.iguales && arbol4.arbol6.iguales

>	iguales :: Eq a => ArbolBinario a -> ArbolBinario a -> Bool
>	iguales (AV) (AV) = True
>	iguales (AV) (AB ai r ad) = False
>	iguales (AB ai r ad) (AV) = False
>	iguales (AB ai3 r1 ad4) (AB ai5 r2 ad6) = r1 == r2 && iguales ai3 ai5 && iguales ad4 ad6

-----------------------------------------------
Dos Arboles binarios
-----------------------------------------------
2. Atributos
	arbol1.arbol2.subarbol
3. Reglas semanticas
	arbol1.arbol2.subarbol = False
	arbol1.arbol2.subarbol = True
	arbol1.arbol2.subarbol = False
	arbol1.arbol2.subarbol = arbol1 == arbol5 || arbol1.arbol5.subarbol || arbol1 == arbol6 || arbol1.arbol6.subarbol 

>	subarbol :: Eq a => ArbolBinario a -> ArbolBinario a -> Bool
>	subarbol (AV) (AV) = False
>	subarbol (AV) (AB ai r ad) = True
>	subarbol (AB ai r ad) (AV) = False
>	subarbol a1 (AB ai5 r2 ad6) = iguales a1 ai5 || iguales a1 ad6 || subarbol a1 ai5 || subarbol a1 ad6

------------------------------------------------
Arbol Binario
------------------------------------------------
2. Atributos
	ab.camino
3. Reglas semanticas
	ab.camino = []
	ab.camino = { [r]			si buscado = r
		    { [r] ++ y			si buscado /= r, x = ab1.camino, y = ab2.camino, x.length > y.length
		    { [r] ++ x			si buscado /= r, x = ab1.camino, y = ab2.camino, x.length =< y.length

>	camino :: Eq a => ArbolBinario a -> a -> [a]
>	camino (AV) elem = []
>	camino (AB ai r ad) elem | (elem == r) = [r]
>				 | not(null cad) && (length(cad) < length(cai) || null cai)= r:cad
>				 | not(null cai) && (length(cai) <= length(cad) || null cad) = r:cai
>				 | otherwise = []
>					where cai = camino ai elem
>					      cad = camino ad elem
