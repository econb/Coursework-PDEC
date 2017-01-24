

***************************************************
PICASFAMAS
***************************************************
Objetivo: Calcular el numero de picas y famas obtenidas por el ensayo con respecto al secreto.
Retorno: Lista [numeroFamas, numeroPicas]

>	picasfamas :: [Int] -> [Int] -> [Int]
>	picasfamas secreto ensayo | (length ensayo) == 0 || (length secreto) == 0 = [0,0]
>				  | otherwise = [length ensayo - length (elimFamas ensayo secreto)] ++ [contarPicas (elimFamas ensayo secreto) (elimFamas secreto ensayo)] 

Elimina las famas de una lista con respecto a otra

>	elimFamas :: Eq a => [a] -> [a] -> [a]
>	elimFamas (x:xs) (y:ys) | x == y = elimFamas xs ys
>					       | otherwise = x : elimFamas xs ys
>	elimFamas _ [] = []
>	elimFamas [] _ = []

Elimina la primera coincidencia de un elemento en una lista

>	elimPrimCoincidencia :: Eq a => a -> [a] -> [a] 
>	elimPrimCoincidencia x (y:ys) | x /= y = y : elimPrimCoincidencia x ys
>				      | otherwise = ys
>	elimPrimCoincidencia _ [] = []

Cuenta el numero de picas de una lista con respecto a otra

>	contarPicas :: Eq a => [a] -> [a] -> Int
>	contarPicas (x:xs) ys | estaen x ys = 1 + contarPicas xs (elimPrimCoincidencia x ys)
>				  | otherwise = contarPicas xs ys
>	contarPicas _ [] = 0
>	contarPicas [] _ = 0

******************************************************************
Estrategia de solucion
******************************************************************
Como se necesita comparar un vector con otro para encontrar si un digito de un ensayo es igual a uno del secreto,
todas estas comparaciones se pueden representar como una matriz:

Ej: 
ensayo = [1, 1, 1, 2]
secreto = [2, 1, 1, 1]

comparaciones:
[(1,2), (1,1), (1,1), (1,1)]
[(1,2), (1,1), (1,1), (1,1)]
[(1,2), (1,1), (1,1), (1,1)]
[(2,2), (2,1), (2,1), (2,1)]

Paso 1> Eliminar digitos que correspondan a una fama tanto en el ensayo como en el secreto, esto con el proposito de 
no volver a contar estos digitos cuando se esten contando picas. 

1.1> Identificar candidatos a famas, en la matriz corresponderian a la diagonal que va desde el punto (0,0) al (n-1, n-1)
1.2> En los candidatos a famas, buscar una pareja cuyos digitos sean iguales.
1.3> Eliminar una pareja que sea fama, junto con la fila y la columna donde esta se encuentra.

[(1,2),	      (1,1), (1,1)]

[(1,2),	      (1,1), (1,1)]
[(2,2),       (2,1), (2,1)]

1.4> repetir 1.3 hasta que se eliminen todas las parejas de digitos iguales de la diagonal de la matriz

[(1,2),	             (1,1)]

	             
[(2,2),              (2,1)]

Paso 2> Eliminar y contar picas.
2.1> Identificar candidatos a picas, corresponde a parejas con digitos iguales.
2.2> Eliminar una pareja que es pica, junto con la fila y la columna donde esta se encuentra.
	             
[(2,2)                    ]

2.3> repetir 1.6 hasta que se eliminen todas las parejas de digitos iguales en la matriz. 

NOTA: La solucion anterior es abstracta, en la solucion real, no se arma la matriz, solo eliminan digitos
de los vectores para evitar hacer comparaciones que pueden llevar a un error de conteo. 
Por lo tanto el hecho de decir que se elimina una pareja en la matriz, quiere decir que se evita hacer esa comparacion 
en la solucion real.

******************************************************************
SOLUCION AL QUIZ
******************************************************************

PUNTO 1: Producto escalar

recursion basica

>	prodEsc :: Num a => [a] -> [a] -> a 
>	prodEsc (x:xs) (y:ys) = (x * y) + prodEsc xs ys
>	prodEsc _ [] = 0
>	prodEsc [] _ = 0

Listas por comprension

>	prodEsc' :: Num a => [a] -> [a] -> a
>	prodEsc' xs ys = sum [x*y | (x,y) <- zip xs ys ] 

Usando zipWith

>	prodEsc'' :: Num a => [a] -> [a] -> a 
>	prodEsc'' xs ys = sum (zipWith (*) xs ys)

--------------------------------------------------------------
PUNTO 2: dropFirst

>	dropFirst :: Eq a => a -> [a] -> [a]
>	dropFirst x (y:ys) | x /= y = y : dropFirst x ys
>			| x == y = ys
>	dropFirst _ [] = []	

--------------------------------------------------------------
PUNTO 3: espermut

>	espermut :: Eq a => [a] -> [a] -> Bool
>	espermut xs ys = (subset xs ys) && (subset ys xs)

Decide si un conjunto es subconjunto de otro

>	subset :: Eq a => [a] -> [a] -> Bool
>	subset (x:xs) ys = estaen x ys && subset xs ys
>	subset [] _ = True

Decide si un valor esta o no en una lista

>	estaen :: Eq a => a -> [a] -> Bool
>	estaen n (x:xs) = n == x || estaen n xs
>	estaen _ [] = False

--------------------------------------------------------------
PUNTO 4: rifle

>	rifle :: [Integer] -> [Integer]
>	rifle xs = concat' [x | x <- xs, odd x] [x | x <- xs, even x]

>	concat' :: [a] -> [a] -> [a]
>	concat' (x:xs) (y:ys) = [x] ++ [y] ++ concat' xs ys
>	concat'	_ [] = []
>	concat' [] _ = []


