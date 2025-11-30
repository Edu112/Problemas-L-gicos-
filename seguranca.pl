% seguranca.pl
:- module(seguranca, [
    alergia_paciente_a/2,
    interacao_medicamento/2,
    contraindicado_para/2,
    principio_ativo/2,
    alergia_substancia/2,
    interacao/2,
    contraindicacao/2
]).


principio_ativo(amoxicilina, penicilina).
principio_ativo(ibuprofeno, ibuprofeno).

alergia_substancia(p1, penicilina).

interacao(ibuprofeno, corticoide).
interacao(corticoide, anticoagulante).

contraindicacao(amoxicilina, insuficiencia_renal).

% Regras
alergia_paciente_a(P, Med) :-
    principio_ativo(Med, A),
    alergia_substancia(P, A).

interacao_medicamento(M1, M2) :-
    interacao(M1, M2) ;
    interacao(M2, M1).

contraindicado_para(P, Med) :-
    false.

