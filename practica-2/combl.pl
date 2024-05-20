% permutacio(L,P) "P és una permutació de L"

permutacio([],[]).
permutacio([X|L1], L2) :- select(X,L2,R), permutacio(L1,R).

% subcjt(L,S) "S es sub de L"

subcjt([],[]).
subcjt([_|L1], L2) :- subcjt(L1,L2).
subcjt([X|L1],[X|L2]) :- subcjt(L1,L2).
