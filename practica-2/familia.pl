% mare(F,M) "la mare de F Ã©s M"
mare(joan,angela).
mare(maria,angela).

% germana(A,G) "la germana d'A Ã©s G"
germana(angela,cris).
germana(angela,judit).

% tia(N,T) "la tia de N Ã©s T"
tia(N,T) :- mare(N,M), germana(M,T).
