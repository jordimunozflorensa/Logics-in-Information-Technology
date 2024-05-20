% fact(N,F)

fact(0,1) :- !.                                 % !. es un corte, obliga a que no siga probando de hacer backtracking con otros casos
fact(N,F) :- N1 is N-1, fact(N1,F1), F is F1*N.