% estat = [esq, dreta, on es la linterna]
main :- EstatInicial = [[1,2,5,8],[], e],    EstatFinal = [[],[1,2,5,8], d],
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

unPas(C, [P1,P2,e], [P3,P4,d]) :- % 2 cap a la dreta
        select(X1, P1, PA),
        select(X2, PA, P3),
        C is max(X1,X2),
        append([X1,X2], P2, PC),
        sort(PC, P4).

unPas(C, [P1,P2,d], [P3,P4,e]) :- % 1 cap a l'esquerra
        select(X1, P2, P4),
        C is X1,
        append([X1], P1, PB),
        sort(PB, P3).

        
        

