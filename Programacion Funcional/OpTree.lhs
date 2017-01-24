>	module OpTree where 
>	import Tree

>	t1 = Node (Leaf 4) 5 (Leaf 6)
>	t2 = Node (Node (Leaf 9) 10 (Leaf 11)) 12 (Node (Leaf 13) 14 (Leaf 14))
>	t3 = Node (Node (Leaf 6) 7 (Leaf 8)) 15 (Node (Leaf 22) 23 (Node (Leaf 24) 25 (Leaf 26)))
>	t4 = Leaf 5
>	t5 = Node (Leaf 4) 5 (Node (Leaf 6) 7 (Leaf 5))
>	t6 = Node (Leaf 4) 5 Null



