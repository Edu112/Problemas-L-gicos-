# 🏥 Sistema Hospitalar - Raciocínio Clínico em Prolog

Este projeto implementa um **sistema de apoio ao diagnóstico médico**, com funcionalidades de **diagnóstico diferencial**, sugestão de **exames e tratamentos**, e geração de **relatórios detalhados**.  

---

## 📂 Estrutura do Projeto

| Arquivo | Descrição |
|---------|-----------|
| `dados.pl` | Fatos de pacientes, sintomas, doenças, exames e tratamentos. |
| `ontologia.pl` | Hierarquia de classes, medicamentos, exames e profissionais. |
| `autorizacao.pl` | Controle de acesso (quem pode acessar o que). |
| `seguranca.pl` | Alergias, interações medicamentosas e contraindicações. |
| `relatorio.pl` | Geração de relatórios detalhados e resumo final. |
| `execucoes.pl` | Testes automatizados do sistema. |
| `principal.pl` | Ponto de entrada (`start/0`) para gerar relatório completo. |

---

## 🚀 Como Executar o Sistema

1. Abra o **SWI-Prolog**.  
2. Carregue o arquivo principal:

prolog
?- [principal].

?- start.

## 📂 Arquivos de Entrada e Saída

- **Entrada:** Todos os dados estão definidos em `dados.pl`.
- **Saída:** O relatório completo será gerado no arquivo definido em `start/0` (`saida.txt`).

**Exemplo de trecho do relatório:**

=== PACIENTE p1 (joao, 45 anos) ===
Sintomas: [febre_alta,tosse_seca,falta_ar]
Doenças possíveis: [covid19,pneumonia,infarto]
Exame recomendado: covid19 -> teste_pcr
Exame recomendado: pneumonia -> raio_x_torax
Exame recomendado: infarto -> eletrocardiograma
Exame recomendado: infarto -> troponina
Tratamento sugerido: covid19 -> isolamento
Tratamento sugerido: pneumonia -> antibiotico
Tratamento sugerido: infarto -> angioplastia


**Exemplos de Consultas**

Diagnóstico diferencial de um paciente:
?- diagnostico_diferencial(p1, ListaDoencas).
ListaDoencas = [covid19, pneumonia, infarto].

**O arquivo execucoes tem alguns testes.**


## 💡 Exemplos de Resultados Esperados
---
Paciente p1 (joao, 45 anos):

Sintomas: [febre_alta,tosse_seca,falta_ar]
Doenças possíveis: [covid19,pneumonia,infarto]
Exames recomendados: teste_pcr, raio_x_torax, eletrocardiograma, troponina
Tratamentos sugeridos: isolamento, antibiotico, angioplastia


