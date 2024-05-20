%% estat [l en g5l, l en g8l]
main :- EstatInicial = [0,0],    EstatFinal = [0,4],
        between(1, 1000, CostMax),                  % Busquem soluciÃ³ de cost 0; si no, de 1, etc.
        cami(CostMax, EstatInicial, EstatFinal, [EstatInicial], Cami),
        reverse(Cami, Cami1), write(Cami1), write(' amb cost '), write(CostMax), nl, halt.

cami(0, E, E, C, C).                                % Cas base: quan l'estat actual Ã©s l'estat final.
cami(CostMax, EstatActual, EstatFinal, CamiFinsAra, CamiTotal) :-
        CostMax > 0, 
        unPas(CostPas, EstatActual, EstatSeguent),  % En B.1 i B.2, CostPas Ã©s 1.
        \+ member(EstatSeguent, CamiFinsAra),
        CostMax1 is CostMax-CostPas,
        cami(CostMax1, EstatSeguent, EstatFinal, [EstatSeguent|CamiFinsAra], CamiTotal).

unPas(1, [N,M], [5,M]) :- N < 5.                        % omplir la galleda de 5 litres
unPas(1, [N,M], [N,8]) :- M < 8.                        % omplir la galleda de 8 litres
unPas(1, [N,M], [0,M]) :- N > 0.                        % buidar la galleda de 5 litres
unPas(1, [N,M], [N,0]) :- M > 0.                        % buidar la galleda de 8 litres
unPas(1, [N1,M1], [N2,M2]) :- N1 > 0, M1 < 8,           % transf 5 -> 8
                              N2 is max((N1-(8-M1)), 0), 
                              M2 is min((M1+N1), 8).
unPas(1, [N1,M1], [N2,M2]) :- N1 < 5, M1 > 0,           % transf 8 -> 5
                              M2 is max((N1-(5-M1)), 0), 
                              N2 is min((M1+N1), 5).
