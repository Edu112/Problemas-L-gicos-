% autorizacao.pl
:- module(autorizacao, [pode_acessar/2]).
:- use_module(ontologia).

% Profissionais de saúde podem acessar qualquer prontuário
pode_acessar(User, prontuario) :-
    inferir_classe(User, profissional_saude).

% Enfermeiros podem acessar leitos
pode_acessar(User, leito) :-
    inferir_classe(User, enfermeiro).

% Médicos podem acessar exames
pode_acessar(User, exames) :-
    inferir_classe(User, medico).

% Pacientes podem acessar seu próprio prontuário
pode_acessar(Paciente, prontuario(Paciente)).
