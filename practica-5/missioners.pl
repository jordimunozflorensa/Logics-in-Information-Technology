% Missioners: Busquem la manera m´es r`apida per tal que tres missioners i tres can´ıbals
% travessin un riu en una canoa que pot ser utilitzada per 1 o 2 persones (missioners o can´ıbals),
% per`o sempre evitant que els missioners quedin en minoria en qualsevol riba (per raons `obvies).

% estat = [misi riba esq,
%          can riba esq,
%          riba on es la canoa]

main :- EstatInicial = [3,3,e],    EstatFinal = [0,0,d],
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

unPas(1, [M1,C1,e], [M2,C2,d]) :- 
        between(0, M1, MI), 
        between(0, C1, CI),
        S is MI+CI, 
        between(1, 2, S),
        M2 is M1-MI, 
        C2 is C1-CI,
        (M2 == 0; M2 >= C2),
        MR is 3-M2,
        CR is 3-C2,
        (MR == 0; MR >= CR).


unPas(1, [M1,C1,d], [M2,C2,e]) :- 
        M is 3-M1,
        C is 3-C1,
        between(0, M, MI),
        between(0, C, CI),
        S is MI+CI, 
        between(1, 2, S),
        M2 is M1+MI, 
        C2 is C1+CI,
        (M2 == 0; M2 >= C2),
        MR is 3-M2,
        CR is 3-C2,
        (MR == 0; MR >= CR).
