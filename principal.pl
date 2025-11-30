% principal.pl
:- module(principal, [start/0]).


:- use_module(ontologia).
:- use_module(instancias).
:- use_module(autorizacao).
:- use_module(seguranca).
:- use_module(exames).
:- use_module(leitos).
:- use_module(relatorio).

% Predicado principal
start :-
    writeln("----- SISTEMA HOSPITALAR -----"),
    nl,
    writeln("Gerando relatório."),
    gerar_relatorio('saida.txt'),
    writeln("Relatório gerado.").

