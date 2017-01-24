

>	module ContrerasE where

>	data ArbolG a = Hoja a | NodoG [ArbolG a]

numhojas que cuenta el numero de hojas en un ArbolG

>	numhojas :: ArbolG a -> Int
>	numhojas (Hoja a) = 1
>	numhojas (NodoG []) = 0
>	numhojas (NodoG xs) = sum [numhojas x | x <- xs] 

altura que calcula la altura de un ArbolG. La altura es la longitud del camino (de vertices) mas largo desde la raiz hasta una hoja.

>	altura :: ArbolG a -> Int
>	altura (Hoja a) = 1
>	altura (NodoG []) = 1
>	altura (NodoG xs) = 1 + maximum [altura x | x <- xs]

sumarbol que calcula la suma de las hojas de un ArbolG numerico

>	sumarbol :: ArbolG Integer -> Integer
>	sumarbol (Hoja a) = a
>	sumarbol (NodoG []) = 0
>	sumarbol (NodoG xs) = sum [sumarbol x | x <- xs]

maparbol calcula el map de una funcion sobre los elementos de las hojas de un ArbolG.
Es decir, dado un ArbolG y una funcion f, calcula un nuevo ArbolG totalmente isomorfo al original
pero el contenido de cada hoja se cambia por el resultado de aplicar la funcion f.

>	maparbol :: (a -> b) -> ArbolG a -> ArbolG b
>	maparbol f (Hoja a) = Hoja (f a)
>	maparbol f (NodoG []) = NodoG []
>	maparbol f (NodoG xs) = NodoG [(maparbol f x) | x <- xs]

aplanar que aplana un ArbolG convirtiendolo en una lista.
En la lista resultante aparece el contenido de todas las hojas del arbol, como si se recorriera de izquieda a derecha.

>	aplanar :: ArbolG a -> [a]
>	aplanar (Hoja a) = [a]
>	aplanar (NodoG []) = []
>	aplanar (NodoG (x:xs)) = aplanar x ++ aplanar (NodoG xs)




           Distancia de edición entre cadenas
           ----------------------------------

Una distancia de edición entre dos cadenas s1 y s2 es una sucesión de operaciones
de edición que permitan transgformar a s1 en s2.

Operaciones: insertar, cambiar, copiar, eliminar ... (un caracter)
             borrar hasta el final 

Transformar fish en chips

     fish
        insertar 'c'             -> c|fish
        cambiar 'f' por 'h'      -> ch|ish
        copiar  'i'              -> chi|sh
        insertar 'p'             -> chip|sh
        copiar 's'               -> chips|h
        kill                     -> chips

Definir un tipo para las operaciones

>	data Edit = Cambiar Char 
>		  | Copiar
>		  | Eliminar
>		  | Insertar Char
>		  | Borrar 
>		  | Intercambiar deriving (Eq, Ord, Show, Read)

Encontrar la secuencia óptima de operaciones: la que tenga un menor costo.

- Todas las operaciones cuestan 1, excepto copiar que cuesta cero.

Función que calcula la mejor secuencia que transforma una cadena en otra:

>	transform :: String -> String -> [Edit]

>	transform [] [] = []
>	transform xs [] = [Borrar]
>	transform [] ys = map Insertar ys

En el caso general se podría usar Copiar, Eliminar, Insertar o Cambiar
  - Si los primeros caracteres son iguales, se puede copiar
  - Si son diferentes se intentan todas las posibilidades y se escoge la mejor.

>	transform (x:xs) (y:ys)
>	   | x==y        = Copiar : transform xs ys
>	   | (length xs > 0) && (length ys > 0) && (x == head ys) && (y == head xs) = Intercambiar : transform (tail xs) (tail ys)
>	   | otherwise   = optimo [ Eliminar : transform xs (y:ys) ,
>				   Insertar y : transform (x:xs) ys,
>				   Cambiar y: transform xs ys]

El óptimo es la secuencia de menor costo

>	optimo :: [[Edit]] -> [Edit]
>	optimo [x] = x
>	optimo (x:xs)
>		| costo x <= costo b    = x
>		| otherwise             = b
>			where b = optimo xs

El costo

>	costo :: [Edit] -> Int
>	costo = length . filter (/= Copiar)

rastro, recibe como argumentos una cadena cad y una lista de operaciones de edicion listed
y produce como resultado la lista de cadenas obtenidas durante la aplicacion de las operaciones de listed
sobre la cadena cad.

>	rastro :: [Char] -> [Edit] -> [[Char]]
>	rastro cad listed = cadenas [] cad listed 

cadenas, recibe como argumentos dos cadenas (bfcursor y afcursor) junto con una lista de operaciones de edicion listed y produce
como resultado la lista de cadenas obtenidas durante la aplicacion de las operaciones de listed.
bfcursor: before cursor, la parte de la cadena que esta antes del cursor.
afcursor: after cursor, la parte de la cadena que esta despues del cursor.

>	cadenas :: [Char] -> [Char] -> [Edit] -> [[Char]] 
>	cadenas _ _ [] = []

>	cadenas bfcursor [] ((Cambiar a) : listed) 		= []
>	cadenas bfcursor afcursor ((Cambiar a) : listed) 	= [bfcursor ++ [a] ++ tail afcursor] ++ cadenas (bfcursor ++ [a]) (tail afcursor) listed

>	cadenas bfcursor [] ((Copiar) : listed)    		= []
>	cadenas bfcursor afcursor ((Copiar) : listed)    	= [bfcursor ++ afcursor] ++ cadenas (bfcursor ++ [head afcursor]) (tail afcursor) listed

>	cadenas bfcursor [] ((Eliminar) : listed) 		= []
>	cadenas bfcursor afcursor ((Eliminar) : listed) 	= [bfcursor ++ tail afcursor] ++ cadenas bfcursor (tail afcursor) listed

>	cadenas bfcursor afcursor ((Borrar) : listed) 		= [bfcursor]
>	cadenas bfcursor afcursor ((Insertar a) : listed) 	= [bfcursor ++ [a] ++ afcursor] ++ cadenas (bfcursor ++ [a]) afcursor listed 

>	cadenas bfcursor [] ((Intercambiar) : listed)		= []
>	cadenas bfcursor [af] ((Intercambiar) : listed)		= error ("Intercambiar: Operacion no aplicable sobre '" ++ [af] ++ "'")
>	cadenas bfcursor afcursor ((Intercambiar) : listed) 	= [bfcursor ++ [head (tail afcursor)] ++ [head afcursor] ++ tail (tail afcursor)] ++ 
>		cadenas (bfcursor ++ [head (tail afcursor)] ++ [head afcursor]) (tail (tail afcursor)) listed

--- fish chips
--- Movable, Movible
--- Substract Subtract
--- apropiado approprie
