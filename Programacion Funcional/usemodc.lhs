>	import ContrerasE

Datos de prueba

>	t1 = NodoG [NodoG [Hoja 3, Hoja 2, Hoja 1], NodoG [Hoja 0, Hoja 2],Hoja 5]
>	t2 = NodoG [NodoG [Hoja 1, NodoG [Hoja 2, Hoja 3, Hoja 4]], NodoG [Hoja 5, Hoja 6]]
>	t3 = NodoG []
>	t4 = NodoG [Hoja 0]
>	t5 = NodoG [NodoG [NodoG [NodoG [NodoG [Hoja 10]]]]]
>	f1 = (\x -> (x ^ 2))
>	f2 = (\x -> (x*(-1)))

>	listed1 = transform "fish" "chips"
>	listed2 = transform "Movable" "Movible"
>	listed3 = transform "Substract" "Subtract"
>	listed4 = transform "apropiado" "approprie"
>	rastro1 = rastro "fish" listed1
>	rastro2 = rastro "Movable" listed2
>	rastro3 = rastro "Substract" listed3
>	rastro4 = rastro "apropiado" listed4
>	rastro5 = rastro "abad" [Insertar 'd', Copiar, Copiar, Copiar, Borrar]
>	rastro6 = rastro "caso" [Copiar, Copiar, Intercambiar]
>	rastro7 = rastro "caso" [Copiar, Copiar, Cambiar 'x', Intercambiar]

Añadiendo a su solución las definiciones de la función test y las variables t1 a t4 
se deberían obtener los resultados que se muestran más abajo

-----------------  DEFINICIONES -----------------------------
Funcion de test que aplica sobre la cadena s1 las operaciones que la transforman en
la cadena s2.

>	test s1 s2 = (s1,listed,rastro s1 listed) where listed = transform s1 s2

Pruebas usando la función anterior

	t1 = test "abad" "daba"
	t2 = test "caso" "caos"
	t3 = test "arroz" "zorra"
	t4 = test "rastro" "trasto"

----------------  FIN DEFINICIONES  ------------------------------
