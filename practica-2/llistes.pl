% pert(E, L) 
pert(X,[X|_]).
pert(X,[_|L]) :- pert(X,L).

% concat(L1,L2,L3)
concat([], L, L).
concat([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).


% pert_amb_resta(E,L,R) 
% pert_amb_resta(X,L,Resta) :- concat(L1,[X|L2], L), concat(L1,L2,Resta).

pert_amb_resta(X,[X|L],L).
pert_amb_resta(X,[Y|L],[Y|R]) :- pert_amb_resta(X,L,R)   
