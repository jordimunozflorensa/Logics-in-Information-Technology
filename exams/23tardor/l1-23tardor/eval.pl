%% --------- [3 points] ---------- %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given an expression built up from integers, variables, +, - and *, and
% given an assignment of values to some of the variables, 
% write a Prolog predicate eval that evaluates the expression on the assignment.

% If an expression contains an unassigned variable, the result should be 'evalError'.

% You can use the predicate integer(X), which holds iff X is an integer value.

% For example:
%
% ?- eval((x+y)*(x-y), [assign(x, 2), assign(y, 1)], V).
% V = 3.
% 
% ?- eval(x*x + 1 - y, [assign(x, 3), assign(y, 2)], V).
% V = 8.
%
% ?- eval(x*x + 1 - y, [assign(x, 3)], V).
% V = evalError.

% Hint: write a predicate "my_is" or similar, and use it in eval.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% eval(E, L, V)  holds
%     if the expression E on the assignment L evaluates to the value V
eval(A + B, L, V) :- !, eval(A,L,VA), eval(B,L,VB), isCorrect(VA+VB, V).
eval(A - B, L, V) :- !, eval(A,L,VA), eval(B,L,VB), isCorrect(VA-VB, V).
eval(A * B, L, V) :- !, eval(A,L,VA), eval(B,L,VB), isCorrect(VA*VB, V).

eval(N,_,N) :- integer(N), !.
eval(X,L,V) :- member(assign(X,V), L), !.
eval(_,_,evalError).

% isCorrect(evalError + _, evalError) :- !.
% isCorrect(_ + evalError, evalError) :- !.
isCorrect(X+Y, evalError) :- member(evalError, [X,Y]), !.
isCorrect(X+Y, V) :- V is X+Y.

isCorrect(X-Y, evalError) :- member(evalError, [X,Y]), !.
isCorrect(X-Y, V) :- V is X-Y.

isCorrect(X*Y, evalError) :- member(evalError, [X,Y]), !.
isCorrect(X*Y, V) :- V is X*Y.

