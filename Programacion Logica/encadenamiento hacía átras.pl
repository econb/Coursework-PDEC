/**Encadenamiento hacía átras  ***/


p :-q , r, s, t.                       

q :- m, n, b.		        
s :-  a.			        
t :- a, b.			        
a :- b.
b :- c.
m.
c. 
n:- m, c.  
r.

p :-q , s, t, r.                         
q :- m, n, b.		       
s :-  a.			        
t :- a, b.			
a :- b.
b :- c.
m.
c.
n:- m, c.