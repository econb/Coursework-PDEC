>	type SuperString = (String, String)
>	fusionarString :: String -> String -> SuperString
>	fusionarString cad1 cad2 = (cad1, cad2)

>	data Bool' = True' | False'
 
>	data Shape = Circle Float | Rect Float Float
>	square :: Float -> Shape
>	square n = Rect n n

>	area :: Shape -> Float
>	area (Circle r) = pi * r^2
>	area (Rect x y) = x * y 
