% instancias.pl
:- module(instancias, [instancia/2]).

/* ----------- INSTÂNCIAS (ABox) ----------- */

% Profissionais
instancia(dr_joao, medico).
instancia(dr_carla, cardiologista).
instancia(enf_maria, enfermeiro).
instancia(enf_ana, enfermeiro).

% Pacientes
instancia(p1, paciente).
instancia(p2, paciente).

% Medicamentos
instancia(ibuprofeno, antiinflamatorio).
instancia(amoxicilina, antibiotico).
instancia(paracetamol, analgesico).

% Exames
instancia(rx1, raio_x).
