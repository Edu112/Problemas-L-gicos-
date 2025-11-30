% exames.pl

:- module(exames, [
    diagnostico/2,
    exame_recomendado/2
]).

:- use_module(dados).

% --- Regras de Diagnóstico ---

cobre_todos_sintomas(Paciente, ListaDoenca) :-
    forall(member(S, ListaDoenca), sintoma(Paciente, S)).

diagnostico(Paciente, Doenca) :-
    doenca(Doenca, Lista),
    cobre_todos_sintomas(Paciente, Lista).

exame_recomendado(Doenca, Exame) :-
    exame_para(Doenca, Exame).
