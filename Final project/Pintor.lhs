>	module Pintor (pintarSolucion) where
>	import Fosforos
>	import DatosPrueba

Pinta el estado solucion a un reto

>	pintarSolucion :: Estado -> IO(String)
>	pintarSolucion estado = pintar estadoAPintar
>		where n = length reto
>		      estadoAPintar = todasLasLineas (estadoSolucion estado) (parejas n)

******************************************
* Funciones Auxiliares
******************************************

>	parejas :: Int -> [[[(Int,Int)]]]
>	parejas n = [parejas' n (x,y) | x<-[0..n], y<-[0..n], y == x || y == x+1 ]

>	parejas' :: Int -> (Int,Int) -> [[(Int,Int)]]
>	parejas' n (x,y) | y == x   = [ [(v,x),(w,y)] | (v,w) <- zip [0..(n-1)] [1..n] ]
>			 | y == x+1 = [ [(z,x),(z,y)] | z <- [0..n] ]

>	todasLasLineas :: Estado -> [[[(Int,Int)]]] -> [[Char]]
>	todasLasLineas estado listaDeListas = [enLineas estado lista | lista <- listaDeListas]

>	enLineas :: Estado -> [[(Int,Int)]] -> [Char]
>	enLineas _ [] = []
>	enLineas estado ([(x,y),(x2,y2)]:lista) | y == y2 && (estaEnEstado [(x,y),(x2,y2)] estado) = "____" ++ enLineas estado lista
>						| y2 == y+1 && (estaEnEstado [(x,y),(x2,y2)] estado) = "|   " ++ enLineas estado lista
>						| otherwise = "    " ++ enLineas estado lista

>	estaEnEstado :: [(Int,Int)] -> Estado -> Bool
>	estaEnEstado _ [] = False
>	estaEnEstado [punto1, punto2] ((cabeza:cola):listas) = 
>		(punto1M == cabeza && (elem punto2M cola)) || estaEnEstado [punto1, punto2] listas
>			where punto1M = (toInteger (fst punto1), toInteger (snd punto1))
>			      punto2M = (toInteger (fst punto2), toInteger (snd punto2))

>	pintar :: [[Char]] -> IO(String)
>	pintar [] = do
>			return []
>	pintar (x:xs) = do
>			putStrLn x
>			pintar xs
