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
>		  | Borrar deriving (Eq, Ord, Show, Read)

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

--- fish chips
--- Movable, Movible
--- Substract Subtract
--- apropiado approprie
