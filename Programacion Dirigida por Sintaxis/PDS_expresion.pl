/* Problema C
 * Expresion

 */

/* Expresion
1. Gramatica
	expr -> term * expr
	expr -> term / expr
	expr -> term
	
	term -> operando + term
	term -> operando - term
	term -> operando
	operando -> A|B...|Z

2. Atributos
	expr.eparentesis
	term.tparentesis
	operando.valor

3. Reglas semanticas
	expr.eparentesis = "(" ++ term.tparentesis ++ "*" ++ expr'.eparentesis ++ ")"
	expr.eparentesis = "(" ++ term.tparentesis ++ "/" ++ expr'.eparentesis ++ ")"
	expr.eparentesis = term.tparentesis

	term.tparentesis = "(" ++ operando.valor ++ "+" ++ term'.tparentesis ++ ")"
	term.tparentesis = "(" ++ operando.valor ++ "-" ++ term'.tparentesis ++ ")"
	term.tparentesis = operando.valor
	operando.valor = { X		si X esta en {'A','B',...,'Z'}
		      	 { '?'		si X no esta en {'A','B',...,'Z'} 
*/

%prueba: expresion('(A+B*C)', X).

expresion(Atom, AtomRes) :- 
	atom_chars(Atom, Chars), sinParentesis(Chars, SinParChars), 
	eParentesis(SinParChars, CharsRes), atom_chars(AtomRes, CharsRes).

eParentesis(Expr, ExprParentesis) :- 
	append(L1, ['*'|L2], Expr), tParentesis(L1, Term), eParentesis(L2, Expr1), 
	append(Term, ['*'|Expr1], ExprP), conParentesis(ExprP, ExprParentesis), !.

eParentesis(Expr, ExprParentesis) :- 
	append(L1, ['/'|L2], Expr), tParentesis(L1, Term), eParentesis(L2, Expr1), 
	append(Term, ['/'|Expr1], ExprP), conParentesis(ExprP, ExprParentesis), !.

eParentesis(Expr, ExprParentesis) :- tParentesis(Expr, ExprParentesis), !.


tParentesis(Term, TermParentesis) :- 
	append(L1, ['+'|L2], Term), valorOp(L1, ValOp), tParentesis(L2, Term1), 
	append(ValOp, ['+'|Term1], TermP), conParentesis(TermP, TermParentesis), !.

tParentesis(Term, TermParentesis) :- 
	append(L1, ['-'|L2], Term), valorOp(L1, ValOp), tParentesis(L2, Term1), 
	append(ValOp, ['-'|Term1], TermP), conParentesis(TermP, TermParentesis), !.

tParentesis(Op, ValOp) :- valorOp(Op, ValOp).

valorOp([Op], [Op]) :- member(Op, ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']), !.
valorOp(_, ['?']). 

conParentesis(List, ListP) :- append(['('|List], [')'], ListP).

sinParentesis(List, ListSinP) :- findall(X, (member(X, List), not(X==')'), not(X=='(')), ListSinP).

