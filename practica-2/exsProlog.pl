%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NotaciÃ³:
%%   * "donat N" significa que l'argument N estarÃ  instanciat inicialmente.
%%   * "ha de ser capaÃ§ de generar totes les respostes possibles" significa que
%%     si hi ha backtracking ha de poder generar la segÃ¼ent resposta, com el
%%     member(E,L) que per una llista L "donada" pot generar tots els elements E.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% En LI adapterem la "Notation of Predicate Descriptions" de SWI-Prolog per
%% descriure els predicats, prefixant cada argument amb un d'aquests 3 sÃ­mbols:
%%   '+' quan l'argument ha d'estar necessÃ riament instanciat (no pot ser una
%%       variable sense instanciar). Pot ser ground (f(a) o 34)" o no (X+1 o g(a,Y)).
%%       Quan parlem de "donada L", llavors especficarem +L en la *descripciÃ³*.
%%       Per exemple, l'argument de +L del predicat esta_ordenada(+L).
%%   '-' quan l'argument ha de ser necessÃ riament una variable que quedarÃ 
%%       instanciada, al satisfer-se el predicat, amb un cert terme que podem
%%       veure com un "resultat".
%%       Per exemple, l'argument -F en el predicat fact(+N,-F) que per un N donat,
%%       se satisfÃ  fent que F sigui el valor N!.
%%   '?' quan s'accepta que l'argument pugui estar instanciat o no.
%%       Es tracta dels casos en que es diu "ha de poder generar la S i tambÃ©
%%       comprovar una S donada". Llavors especificarem ?S en la *descripciÃ³*.
%%       Per exemple, l'argument ?S de suma(+L,?S).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% En aquests exercicis feu servir els predicats:
%%   * member(E,L)         en lloc de  pert(E,L)
%%   * append(L1,L2,L3)    en lloc de  concat(L1,L2,L3)
%%   * select(E,L,R)       en lloc de  pert_amb_resta(E,L,R)
%%   * permutation(L,P)    en lloc de  permutacio(L,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FUNCIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write(X)  (nl -> nl es per canviar de linia)
% permutation(L,L1)
% reverse(L,L1)
% member(X,L)
% append(L1,L2,L) -> L1 ++ L2 = L
% select(X,L,R) R = L - {X}
% sum_list(L, X) 
% subtract(L,S1,S2) -> S2 = L-S1


% PROB. A =========================================================
% Escriu un predicat
% prod(+L,?P)  que signifiqui: P Ã©s el producte dels
% elements de la llista de enters donada L. Ha de poder generar la
% P i tambÃ© comprovar una P donada
prod([], 1).
prod([X|L], P) :- prod(L, Y), P is X*Y. 

sum([], 0).
sum([X|L], S) :- sum(L, Y), S is X+Y.


% PROB. B =========================================================
% Escriu un predicat
% pescalar(+L1,+L2,?P) que signifiqui: P Ã©s el producte escalar dels
% vectors L1 i L2, on els vectors es representen com llistes
% d'enters. El predicat ha de fallar si els dos vectors
% tenen longituds diferents.

pescalar([],[],0).
pescalar([X|L1], [Y|L2], P) :- pescalar(L1, L2, P1), P is X*Y+P1.


% PROB. C =========================================================
% Representant conjunts com llistes sense repeticions, escriu
% predicats per les operacions d'intersecciÃ³ i uniÃ³ de conjunts donats

% intersection(+L1,+L2,?L3)
intersection([], _, []).
intersection([X|L1], L2, [X|L3]) :-   member(X,L2), intersection(L1, L2, L3).
intersection([X|L1], L2, L3)     :- \+member(X,L2), intersection(L1, L2, L3).


% % notinboth(+L1,+L2,?L3)
% notinboth([], _, []).
% notinboth([X|L1], L2, L3) :-    member(X, L2),    notinboth(L1, L2, L3).
% notinboth([X|L1], L2, [X|L3]) :-    \+ member(X, L2),    notinboth(L1, L2, L3).


% union(+L1,+L2,?L3)
union( [],     L,  L ).
union( [X|L1], L2, L3     ):-     member(X,L2), union( L1, L2, L3 ). 
union( [X|L1], L2, [X|L3] ):-     \+member(X,L2), union( L1, L2, L3 ).



% PROB. D =========================================================
% Usant append/3, escriu un predicat per calcular l'Ãºltim 
% element d'una llista donada, i un altre per calcular la llista
% inversa d'una llista donada.

% ultim(+L,?E)
% ultim([X|[]], X).
% ultim([_|L], E) :- ultim(L,E).
ultim(X, Y) :- append(_,[Y],X).

% inversa(+L1,?L2)
inversa([],[]).
inversa([X|L1], L2) :- inversa(L1, I), append(I, [X], L2). % El primer element de L1 es l'ultim de L2. append(_,[Y],X).


% PROB. E =========================================================
% Escriu un predicat
% fib(+N,?F) que signifiqui: F Ã©s l'N-Ã©ssim nombre de Fibonacci
% per a la N donada. Aquests nombres es defineixen aixÃ­:
% fib(1) = 1, fib(2) = 1, i si N > 2 llavors
% fib(N) = fib(N-1) + fib(N-2)
fib(0,0).
fib(1,1).
fib(N, F) :- N1 is N-1,
             N2 is N-2, 
             fib(N1, X),
             fib(N2, Y),
             F is X+Y.
             

% PROB. F =========================================================
% Escriu un predicat
% dados(+P,+N,-L) que signifiqui: la llista L expressa una forma de
% sumar P punts llanÃ§ant N daus. Per exemple: si P Ã©s 5, i
% N Ã©s 2, una soluciÃ³ seria [1,4] (noteu que la longitud de L Ã©s N.
% Tant P com N venen instanciats. El predicat deu ser capaÃ§ de
% generar totes les solucions possibles,

dados(0,0,[]).
dados(P,N,[X|L]) :- N > 0,
                    member(X, [1,2,3,4,5,6]),
                    P1 is P-X,
                    N1 is N-1,
                    dados(P1,N1,L).


% PROB. G =========================================================
% Escriu un predicat
% suma_la_resta(+L) que, donada una llista d'enters L, es satisfÃ  si
% existeix algun element en L que Ã©s igual a la suma de la resta
% d'elements de L, i que altrament falla.
% Escriu abans un predicat
% suma(+L,?S) que, donada una llista d'enters L, se satisfÃ  si S
% Ã©s la suma dels elements d'L.

% suma(+L,?S)
suma([], 0).
suma([X|L], S) :-  suma(L, S1), S is S1+X.
% suma([X|L], S) :-  S1 is S-X, suma(L, S1).

% suma_la_resta(+L)
suma_la_resta([]).
suma_la_resta(L) :- select(X,L,R), 
                    suma(R, RX),
                    X == RX.



% PROB. H =========================================================
% Escriu un predicat
% card(+L) que, donada una llista d'enters L, escriba la llista
% que, para cada element d'L, diu quantes vegades surt aquest
% element en L.
% Per exemple, si fem la consulta
% card( [1,2,1,5,1,3,3,7] ).  l'intÃ¨rpret escriurÃ :
% [[1,3],[2,1],[5,1],[3,2],[7,1]].

% count(_, [], 0).
% count(X, [X|L], N) :- count(X, L, N1), N is N1+1.
% count(X, [Y|L], N) :- X \= Y, count(X, L, N).

% elim(_, [], []).
% elim(L1,[X|L],L3) :- L1 \= X, elim(L1, L, L2), append([X], L2, L3).
% elim(L1,[L1|L],L3) :- elim(L1, L, L3).

% card([]) :- write('[]').
% card([L1|L2]) :- write('['),
%                  count(L1, [L1|L2], N),
%                  write([L1,N]),
%                  elim(L1, [L1|L2], X),
%                  card2(X).

% card2([]) :- write(']').
% card2([L1|L2]) :- count(L1, [L1|L2], N),
%                  write(','),
%                  write([L1,N]),
%                  elim(L1, [L1|L2], X),
%                  card2(X).

card(L):- cards(L, R), write(R).

cards([], []).
cards([X|L], [[X, N]|R]):- cards(L, R1),
                           elim_pair([X, N1], R1, R), !, % R es la llista sense [X,N-1]
                           N is N1+1.
cards([X|L], [[X, 1]|R]):- cards(L, R). % cas en el que nomes hi hagi una X i sigui la primera de L

elim_pair(X, LX, R):- append(L1, [X|L2], LX),  % R = LX - [X]
    				  append(L1, L2, R). 


% PROB. I ========================================================
% Escriu un predicat
% esta_ordenada(+L) que signifiqui: la llista L de nombres enters
% estÃ  ordenada de menor a major.
% Per exemple, a la consulta:
% ?- esta_ordenada([3,45,67,83]).
% l'intÃ¨rpret respon yes, i a la consulta:
% ?- esta_ordenada([3,67,45]).
% respon no.

esta_ordenada([]).
esta_ordenada([_]).
esta_ordenada([X, Y|L]) :- X < Y, esta_ordenada([Y|L]).


% PROB. J ========================================================
% Escriu un predicat
% palÃ­ndroms(+L) que, donada una llista de lletres L escrigui
% totes les permutacions dels seus elements que siguin palÃ­ndroms
% (capicues). Per exemple, amb la consulta palindroms([a,a,c,c])
% s'escriu [a,c,c,a] i [c,a,a,c]
% (possiblement diverses vegades, no cal que eviteu les repeticions).

isPalindrome(L) :- reverse(L, L).

palindroms(L) :- permutation(L, P), isPalindrome(P), write(P), nl, fail.


% PROB. K ========================================================
% Volem obtenir en Prolog un predicat
% dom(+L) que, donada una llista L de fitxes de dominÃ³ (en el format
% indicat abaix), escrigui una cadena de dominÃ³fent servir *totes*
% les fitxes de L, o escrigui "no hi ha cadena" si no Ã©s possible.
% Per exemple,
% ?- dom( [ f(3,4), f(2,3), f(1,6), f(2,2), f(4,2), f(2,1) ] ).
% escriu la cadena correcta:
% [ f(2,3), f(3,4), f(4,2), f(2,2), f(2,1), f(1,6) ].
%
% TambÃ© podem "girar" alguna fitxa como f(N,M), reemplaÃ§ant-la
% per f(M,N). AixÃ­, per:
% ?- dom( [ f(4,3), f(2,3), f(1,6), f(2,2), f(2,4), f(2,1) ] ).
% nomÃ©s hi ha cadena si es gira alguna fitxa (per exemple, hi ha
% mateixa cadena d'abans).
%
% El segÃ¼ent programa Prolog encara no tÃ© implementat els possibles
% girs de fitxes, ni tÃ© implementat el predicat ok(P), que
% significa: P Ã©s una cadena de dominÃ³ correcta (tal qual,
% sense necessitat de girar cap fitxa):

% b) EstÃ©n el predicat p/2 per a que el programa tambÃ© pugui
%    fer cadenes girant alguna de les fitxes de l'entrada.

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).
p(L,[f(X,Y)|P]) :- select(f(Y,X), L, R), p(R,P).

dom(L) :- p(L,P), ok(P), write(P), nl.
dom(_) :- write('no hi ha cadena'), nl.

% a) Escriu el predicat ok(+P) que falta.
ok([]).
ok([_]).
ok([f(_,X), f(Y,Z)| L]) :- X == Y, ok([f(Y,Z)|L]).


% PROB. L ========================================================
% Write in Prolog a predicate flatten(+L,?F) that ``flattens''
% (cat.: ``aplana'') the list F as in the example:
% ?- flatten( [a,b,[c,[d],e,[]],f,[g,h]], F ).
% F = [a,b,c,d,e,f,g,h]

flatten([],[]).
flatten([X|L], F) :- flatten(X, L1), flatten(L, L2), append(L1,L2,F), !. % cas de llista en el head i en la tail
flatten(L, [L]). % cas de que hi hagi una llista


% PROB. M ========================================================
% Consider two groups of 10 people each. In the first group,
% as expected, the percentage of people with lung cancer among smokers
% is higher than among non-smokers.
% In the second group, the same is the case.
% But if we consider the 20 people of the two groups together, then
% the situation is the opposite: the proportion of people with
% lung cancer is higher among non-smokers than among smokers!
% Can this be true? Write a little Prolog program to find it out.

main :-
    between(0,10,SC1),    % SC1:   "no.    smokers with    cancer group 1"
    between(0,10,SNC1),   % SNC1:  "no.    smokers with no cancer group 1"
    between(0,10,NSC1),   % NSC1:  "no. no smokers with    cancer group 1"
    between(0,10,NSNC1),  % NSNC1: "no. no smokers with no cancer group 1"

    10 is SC1+SNC1+NSC1+NSNC1, % check that there is 10 people group 1

    between(0,10,SC2),    % SC1:   "no.    smokers with    cancer group 2"
    between(0,10,SNC2),   % SNC1:  "no.    smokers with no cancer group 2"
    between(0,10,NSC2),   % NSC1:  "no. no smokers with    cancer group 2"
    between(0,10,NSNC2),  % NSNC1: "no. no smokers with no cancer group 2"

    10 is SC2+SNC2+NSC2+NSNC2, % check that there is 10 people group 2

    SC1+SNC1 > 0, NSC1+NSNC1 > 0,
    div(SC1,SC1+SNC1) > div(NSC1,NSC1+NSNC1), 
    
    SC2+SNC2 > 0, NSC2+NSNC2 > 0,
    div(SC2,SC2+SNC2) > div(NSC2,NSC2+NSNC2), % check individual proportions

    div(SC1+SC2, SC1+SNC1+SC2+SNC2) < div(NSC1+NSC2, NSC1+NSNC1+NSC2+NSNC2), !.

