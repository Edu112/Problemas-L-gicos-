% execucoes.pl

:- module(execucoes, [
    testar/0,
    diagnostico/2
]).

:- use_module(dados).
:- use_module(exames).
:- use_module(ontologia).

% ---------- TESTES PRINCIPAIS ----------

testar :-
    writeln("===== TESTES DO SISTEMA ====="),
    nl,
    teste_ontologia,
    teste_autorizacao,
    teste_alergias,
    teste_interacoes,
    teste_exames,
    nl.

% ----------- TESTES -------------------

teste_ontologia :-
    writeln("\n--- Ontologia ---"),
    (inferir_classe(dr_joao, profissional_saude) ->
        writeln("OK: dr_joao é profissional_saude") ;
        writeln("FALHOU: dr_joao é profissional_saude")
    ),
    (inferir_classe(dr_carla, medico) ->
        writeln("OK: dr_carla é medico") ;
        writeln("FALHOU: dr_carla é medico")
    ),
    (inferir_classe(ibuprofeno, medicamento) ->
        writeln("OK: ibuprofeno é medicamento") ;
        writeln("FALHOU: ibuprofeno é medicamento")
    ),
    (inferir_classe(paracetamol, medicamento) ->
        writeln("OK: paracetamol é medicamento") ;
        writeln("FALHOU: paracetamol é medicamento")
    ).

teste_autorizacao :-
    writeln("\n--- Autorização ---"),
    (pode_acessar(dr_joao, prontuario) ->
        writeln("OK: dr_joao pode acessar prontuario") ;
        writeln("FALHOU: dr_joao pode acessar prontuario")
    ),
    (pode_acessar(enf_maria, leito) ->
        writeln("OK: enf_maria pode acessar leito") ;
        writeln("FALHOU: enf_maria pode acessar leito")
    ),
    (pode_acessar(dr_carla, exames) ->
        writeln("OK: dr_carla pode acessar exames") ;
        writeln("FALHOU: dr_carla pode acessar exames")
    ).

teste_alergias :-
    writeln("\n--- Alergia ---"),
    (\+ alergia_paciente_a(p2, amoxicilina) ->
        writeln("OK: p2 não é alérgico a amoxicilina") ;
        writeln("FALHOU: p2 não é alérgico a amoxicilina")
    ),
    (alergia_paciente_a(p1, amoxicilina) ->
        writeln("OK: p1 é alérgico a amoxicilina") ;
        writeln("FALHOU: p1 é alérgico a amoxicilina")
    ).

teste_interacoes :-
    writeln("\n--- Interações ---"),
    (interacao_medicamento(ibuprofeno, corticoide) ->
        writeln("OK: ibuprofeno interage com corticoide") ;
        writeln("FALHOU: ibuprofeno interage com corticoide")
    ),
    (\+ interacao_medicamento(ibuprofeno, paracetamol) ->
        writeln("OK: ibuprofeno não interage com paracetamol") ;
        writeln("FALHOU: ibuprofeno não interage com paracetamol")
    ).

teste_exames :-
    writeln("\n--- Diagnóstico e Exames ---"),
    forall(
        paciente(P, _, _, _),
        (
            findall(D, diagnostico(P, D), Diagnosticos),
            format("Paciente ~w: Diagnósticos = ~w~n", [P, Diagnosticos]),
            forall(
                member(Diag, Diagnosticos),
                (
                    findall(Ex, exame_para(Diag, Ex), Exames),
                    format("Diagnóstico ~w: Exames = ~w~n", [Diag, Exames]),
                    findall(T, tratamento(Diag, T), Tratamentos),
                    format("Diagnóstico ~w: Tratamentos = ~w~n", [Diag, Tratamentos])
                )
            )
        )
    ).

% ---------- DIAGNÓSTICO ----------

diagnostico(Paciente, Doenca) :-
    paciente(Paciente, _, _, _),
    doenca(Doenca, SintomasDoenca),
    findall(S, sintoma(Paciente, S), SintomasPaciente),
    subset(SintomasDoenca, SintomasPaciente).

% ---------- PREDICADOS AUXILIARES ----------
% Você pode implementar de acordo com seu sistema:
pode_acessar(dr_joao, prontuario).
pode_acessar(enf_maria, leito).
pode_acessar(dr_carla, exames).

alergia_paciente_a(p1, amoxicilina).

interacao_medicamento(ibuprofeno, corticoide).
