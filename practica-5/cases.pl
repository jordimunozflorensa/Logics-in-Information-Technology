%% [numcasa,color,professio,animal,beguda,pais]

solucio(Sol) :-
    Sol = [ [1,_,_,_,_,_],
            [2,_,_,_,_,_],
            [3,_,_,_,_,_],
            [4,_,_,_,_,_],
            [5,_,_,_,_,_] ],
    %% El que viu a la casa vermella es del Peru
    member([_,vermella,_,_,_,peru], Sol),

    %% Al frances li agrada el gos
    member([_,_,_,gos,_,francia], Sol),

    %% El pintor es japones
    member([_,_,pintor,_,_,japo], Sol),

    %% Al xines li agrada el rom
    member([_,_,_,_,rom,xina], Sol),

    %% L’hongares viu en la primera casa
    member([1,_,_,_,_,hungria], Sol),

    %% Al de la casa verda li agrada el conyac
    member([_,verda,_,_,conyac,_], Sol),

    %% La casa verda esta just a l’esquerra de la blanca
    member([N,verda,_,_,_,_], Sol), N1 is N+1,
    member([N1,blanca,_,_,_,_], Sol),
    

    %% L’escultor cria caragols
    member([_,_,escultor,caragols,_,_], Sol),

    %% El de la casa groga es actor
    member([_,groga,actor,_,_,_], Sol),

    %% El de la tercera casa beu cava
    member([3,_,_,_,cava,_], Sol),

    %% El que viu al costat de l’actor te un cavall
    member([N2,_,actor,_,_,_], Sol), N3 is N2+1, N4 is N2-1,
    (member([N3,_,_,cavall,_,_], Sol) ; member([N4,_,_,cavall,_,_], Sol)),
    

    %% L’hongares viu al costat de la casa blava
    member([N5,_,_,_,_,hungria], Sol), N6 is N5+1, N7 is N5-1,
    (member([N6,blava,_,_,_,_], Sol) ; member([N7,blava,_,_,_,_], Sol)),
    

    %% Al notari l’agrada el whisky
    member([_,_,notari,_,whisky,_], Sol),

    %% El que viu al costat del metge te un esquirol
    member([N8,_,metge,_,_,_], Sol), N9 is N8+1, N10 is N8-1,
    (member([N9,_,_,esquirol,_,_], Sol) ; member([N10,_,_,esquirol,_,_], Sol)).
    


