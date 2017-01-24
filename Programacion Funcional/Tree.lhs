>	module Tree where

>	data Tree = Leaf Int | Node Tree Int Tree | Null

Verifica si un valor se encuentra en un arbol.

>	occurs :: Int -> Tree -> Bool
>	occurs x Null = False
>	occurs x (Leaf n) = x == n
>	occurs x (Node l n r) | x == n = True
>				| x < n = occurs x l
>				| x > n = occurs x r

Verifica si un arbol es completo.
Un arbol es completo si los dos subarboles de cada nodo son de igual tamaño.

>	size :: Tree -> Int
>	size Null = 0
>	size (Leaf n) = 1
>	size (Node l n r) = 1 + size l + size r

>	iscomplete :: Tree -> Bool
>	iscomplete (Leaf n) = True
>	iscomplete (Node l n r) = size l == size r

Agrega un nodo a un arbol.
Utiliza patron de acumulacion.

	addelem :: Int -> Tree -> Tree -> Tree
	addelem x (Leaf n) cm  | x > n = 
			   | x < n = 


	addelem x (Node l n r) cm | x > n = addelem x r 
			       | x < n = addelem x l

>	addnode 
