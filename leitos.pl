% leitos.pl
:- module(leitos, [alocar_leito/2]).
leito(l1).
leito(l2).

ocupado(l2).

alocar_leito(P, L) :-
    leito(L),
    \+ ocupado(L),
    format('Leito ~w alocado para ~w.~n', [L, P]).
