:- module(relatorio, [gerar_relatorio/1]).

:- use_module(dados).

% ----------------------------
% GERAÇÃO DO RELATÓRIO
% ----------------------------
gerar_relatorio(Arquivo) :-
    open(Arquivo, write, S),
    write(S, '=== SISTEMA DE RACIOCÍNIO CLÍNICO ===\n\n'),

    % Percorre todos os pacientes
    forall(
        paciente(Id, Nome, Idade, _Sexo),
        (
            % Cabeçalho do paciente
            format(S, '=== PACIENTE ~w (~w, ~w anos) ===~n', [Id, Nome, Idade]),

            % Sintomas
            findall(Sint, sintoma(Id, Sint), ListaSint),
            format(S, 'Sintomas: ~w~n', [ListaSint]),

            % Diagnósticos possíveis
            diagnostico_diferencial(Id, Doencas),
            format(S, 'Doenças possíveis: ~w~n', [Doencas]),

            % Exames recomendados
            forall(
                (member(D, Doencas), exame_para(D, Ex)),
                format(S, 'Exame recomendado: ~w -> ~w~n', [D, Ex])
            ),

            % Tratamentos sugeridos
            forall(
                (member(D, Doencas), tratamento(D, T)),
                format(S, 'Tratamento sugerido: ~w -> ~w~n', [D, T])
            ),

            nl(S)
        )
    ),

    % ==========================
    %      RESUMO FINAL
    % ==========================
    escrever_resumo(S),

    close(S).

% ----------------------------
% DIAGNÓSTICO DIFERENCIAL
% ----------------------------
diagnostico_diferencial(PacienteID, ListaDoencas) :-
    findall(Doenca,
        (doenca(Doenca, SintomasDoenca),
         findall(S, sintoma(PacienteID, S), SintomasPaciente),
         intersection(SintomasPaciente, SintomasDoenca, Comum),
         Comum \= []
        ),
        ListaDoencas).

% ----------------------------
% RESUMO FINAL
% ----------------------------
escrever_resumo(S) :-
    contar_pacientes(TP),
    contar_diagnosticos(TD),
    contar_exames(TE),
    contar_tratamentos(TT),

    write(S, "=== RESUMO ===\n"),
    format(S, "Pacientes atendidos: ~w~n", [TP]),
    format(S, "Doenças possíveis: ~w~n", [TD]),
    format(S, "Exames recomendados: ~w~n", [TE]),
    format(S, "Tratamentos sugeridos: ~w~n", [TT]),
    nl(S).

% ----------------------------
% FUNÇÕES AUXILIARES
% ----------------------------
contar_pacientes(Total) :-
    findall(P, paciente(P, _, _, _), Lista),
    length(Lista, Total).

contar_diagnosticos(Total) :-
    findall(Doenca,
        (paciente(P, _, _, _),
         diagnostico_diferencial(P, Doencas),
         member(Doenca, Doencas)
        ),
        Lista),
    sort(Lista, ListaUnica),   % remove duplicados
    length(ListaUnica, Total).

contar_exames(Total) :-
    findall(Exame,
        (paciente(P, _, _, _),
         diagnostico_diferencial(P, Doencas),
         member(D, Doencas),
         exame_para(D, Exame)
        ),
        Lista),
    sort(Lista, ListaUnica),
    length(ListaUnica, Total).

contar_tratamentos(Total) :-
    findall(T,
        (paciente(P, _, _, _),
         diagnostico_diferencial(P, Doencas),
         member(D, Doencas),
         tratamento(D, T)
        ),
        Lista),
    sort(Lista, ListaUnica),
    length(ListaUnica, Total).
