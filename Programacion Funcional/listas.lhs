

Decide si un valor esta o no en una lista

>	estaen :: Eq a => a -> [a] -> Bool
>	estaen n (x:xs) = n == x || estaen n xs
>	estaen n [] = False

Decide si una lista es un conjunto

>	isset :: Eq a => [a] -> Bool
>	isset (x:xs) = not (estaen x xs) && isset xs
>	isset [] = True

Convierte una lista en un conjunto

>	toset :: Eq a => [a] -> [a]
>	toset (x:xs) | not (estaen x xs) = x : toset xs
>			       | otherwise = toset xs
>	toset [] = []

Calcula la interseccion de dos conjuntos

>	inter :: Eq a => [a] -> [a] -> [a]
>	inter (x:xs) (y:ys) | estaen x (y:ys) = x : inter xs (y:ys)
>					| otherwise = inter xs (y:ys)
>	inter _ [] = []
>	inter [] _ = []

Calcula la union de dos conjuntos

>	union :: Eq a => [a] -> [a] -> [a]
>	union xs ys = (inter xs ys) ++ (diff xs ys) ++ (diff ys xs)  

Calcula la diferencia entre conjuntos

>	diff :: Eq a => [a] -> [a] -> [a]
>	diff (x:xs) ys | not (estaen x ys) = x : diff xs ys
>				     | otherwise =  diff xs ys
>	diff [] _ = []

Decide si dos conjuntos son iguales

>	eqset :: Eq a => [a] -> [a] -> Bool
>	eqset xs ys = (subset xs ys) && (subset ys xs)


Decide si un conjunto es subconjunto de otro

>	subset :: Eq a => [a] -> [a] -> Bool
>	subset (x:xs) ys = estaen x ys && subset xs ys
>	subset [] _ = True

