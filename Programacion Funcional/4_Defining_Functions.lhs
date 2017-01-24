>	twice f x = f (f x)


>	some x | x < 0 = 0 
>		| x > 0 = 1

>	tail' :: [a] -> [a]
>	tail' (_:xs) = xs


>	odds n = map (\x -> x*2+1) [0..n-1]

>	double' = \x -> \y -> x+y

>	(|||) :: Bool -> Bool -> Bool
>	(|||) _ True = True
>	(|||) a False = a
