intents([ [ [v,b,g,l], [1,1] ], [ [m,t,g,l], [1,0] ], [ [g,l,g,l], [0,0] ], [ [v,b,m,m], [1,1] ], [ [v,t,b,t], [2,2] ]]).


resposta(C, I, E, D) :-
    calcular_E(C, I, E, XS, YS),
    calcular_D(XS, YS, D),
    !.

calcular_E([], [], 0, [], []).
calcular_E([X|XS], [X|YS], E, L1, L2) :-
    calcular_E(XS, YS, E1, L1, L2),
    E is E1 + 1,
    !.

calcular_E([X | XS], [Y | YS], E, [X|L1], [Y|L2]) :-
    calcular_E(XS, YS, E, L1, L2),
    !.

calcular_D([], _, 0).
calcular_D([X|XS], YS, D):-
    select(X, YS, Y1),
    calcular_D(XS, Y1, D1),
    D is D1 + 1,
    !.

calcular_D([_|XS], YS, D):-
    calcular_D(XS, YS, D),
    !.

busca_sol([], 0).
busca_sol([C|XS], N) :-
    N1 is N - 1,
    busca_sol(XS, N1),
    member(C, [v, b, g, l, t, m]).

es_consistent(_, []).
es_consistent(XS, [[C, [E, D]] | L]) :-
    resposta(XS, C, E, D),
    es_consistent(XS, L).

nouIntent(XS) :-
    busca_sol(XS, 4),
    intents(L),
    es_consistent(XS, L).
