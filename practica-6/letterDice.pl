:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.



% Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

% num(?X, ?N)   "La lletra X és a la posició N de la llista"
num(X, N) :- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).


main :-
%1: Variables i dominis:
    length(D1, 6),
    length(D2, 6),
    length(D3, 6),
    length(D4, 6),
    append([D1,D2,D3,D4], Aux),
    Aux ins 1..24,
%2: Constraints:
    all_distinct(Aux),
    % sorted(D1),
    % sorted(D2),
    % sorted(D3),
    % sorted(D4),
    genera_incompatibilitats(L),
    make_constraints(L, D1),
    make_constraints(L, D2),
    make_constraints(L, D3),
    make_constraints(L, D4),
    
%3: Labeling:
    label(Aux),

%4: Escrivim el resultat:
    writeN(D1), nl,
    writeN(D2), nl,
    writeN(D3), nl,
    writeN(D4), nl, halt.
    
writeN(D) :- findall(X, (member(N,D),num(X,N)), L), write(L), nl, !.


sorted([A,B,C,D,E,F]) :- A #< B, B #< C, C #< D, D #< E, E #< F.


genera_incompatibilitats(L) :- 
    findall(X-Y, (word(W), member(A, W), member(B, W), num(A, X), num(B, Y), X < Y), L1),
    sort(L1, L).


make_constraints([], _).
make_constraints([X-Y|L], [A,B,C,D,E,F]) :-
    A #\= X #\/ B #\= Y,
    A #\= X #\/ C #\= Y,
    A #\= X #\/ D #\= Y,
    A #\= X #\/ E #\= Y,
    A #\= X #\/ F #\= Y,
    B #\= X #\/ C #\= Y,
    B #\= X #\/ D #\= Y,
    B #\= X #\/ E #\= Y,
    B #\= X #\/ F #\= Y,
    C #\= X #\/ D #\= Y,
    C #\= X #\/ E #\= Y,
    C #\= X #\/ F #\= Y,
    D #\= X #\/ E #\= Y,
    D #\= X #\/ F #\= Y,
    E #\= X #\/ F #\= Y,
    make_constraints(L, [A,B,C,D,E,F]).