% ontologia.pl
:- module(ontologia, [
    herda_trans/2,
    inferir_classe/2,
    classe_de_medicamento/2,
    classe_de_exame/2,
    classe_de_profissional/2,
    herda/2
]).

% importar instancias (exporta instancia/2)
:- use_module(instancias).

/* ----------- HIERARQUIA (TBox) ----------- */

% Medicamentos
herda(analgesico, medicamento).
herda(antiinflamatorio, medicamento).
herda(antibiotico, medicamento).

% Exames
herda(exame_sangue, exame).
herda(hemograma, exame_sangue).
herda(exame_imagem, exame).
herda(raio_x, exame_imagem).

% Profissionais
herda(medico, profissional_saude).
herda(enfermeiro, profissional_saude).
herda(cardiologista, medico).
herda(neurologista, medico).

/* ----------- HERANÇA TRANSITIVA ----------- */
herda_trans(CF, CP) :- herda(CF, CP).
herda_trans(CF, CP) :- herda(CF, X), herda_trans(X, CP).

/* ----------- INFERÊNCIA (ABox + TBox) ----------- */
inferir_classe(X, C) :-
    instancia(X, C).            % instância direta (importada de instancias)

inferir_classe(X, C) :-
    instancia(X, C2),
    herda_trans(C2, C).         % instância via hierarquia

/* ----------- CLASSIFICAÇÃO UTILITÁRIA ----------- */
classe_de_medicamento(M, Classe) :-
    inferir_classe(M, Classe),
    herda_trans(Classe, medicamento).

classe_de_exame(E, Classe) :-
    inferir_classe(E, Classe),
    herda_trans(Classe, exame).

classe_de_profissional(P, Classe) :-
    inferir_classe(P, Classe),
    herda_trans(Classe, profissional_saude).
