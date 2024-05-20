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




