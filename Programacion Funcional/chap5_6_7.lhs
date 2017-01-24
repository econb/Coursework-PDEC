>	pairs :: [a] -> [(a,a)]
>	pairs xs = zip xs (tail xs)

>	sorted :: Ord a => [a] -> Bool
>	sorted xs = and [x <= y | (x, y) <- pairs xs]

>	positions :: Eq a => a -> [a] -> [Int]
> 	positions x xs = [i | (x', i) <- zip xs [0..n], x == x']
>				where n = length xs -1

	smaller (x:xs) = [a | a <- xs, a <= x]
	larger (x:xs) = [a | a <- xs, a > x]
	quicksort' :: [Int] -> [Int]
	quicksort' xs = quicksort' (smaller xs) ++ (head xs) ++ quicksort' (larger xs)

>	map' f xs = [f x | x <- xs]

>	map'' f (x:xs) = f x : map'' f xs
>	map'' _ [] = [] 

>	filter :: (a -> Bool) -> [a] -> [a]
>	filter f xs = [x | x <- xs, f x]

>	filter' :: (a -> Bool) -> [a] -> [a]
>	filter' f (x:xs) | f x = x : filter' f xs
>			| otherwise = filter' f xs
>	filter' _ [] = [] 

>	length' = foldr (\_ n -> 1+n)

>	reverse :: [a] -> [a]
>	reverse = foldr (\x xs -> xs ++ [x]) []
