# PRD - Sistema Inventário Florestal

Documento de Requisitos de Produto (PRD)

Versão 1.0

Finalidade didática: cadastro, gerenciamento e exportação de amostras de campo.

---

# 1. Visão Geral do Produto

## Nome do Produto

Inventário Florestal

## Resumo Executivo

O sistema Inventário Florestal será uma aplicação desenvolvida para auxiliar no processo de coleta, organização e gerenciamento de dados florestais obtidos em campo. A solução permitirá o cadastro rápido de amostras, armazenamento estruturado das informações e exportação dos dados para planilhas eletrônicas no formato `.xlsx`.

O projeto busca reduzir erros em registros manuais, melhorar a organização dos dados coletados e facilitar análises futuras realizadas por estudantes, pesquisadores ou profissionais da área ambiental e florestal.

---

## Descrição do Projeto

O projeto de Inventário Florestal tem como objetivo otimizar e agilizar o processo de cadastro de amostras coletadas em campo, proporcionando maior organização, precisão e praticidade no armazenamento das informações florestais.

O sistema permitirá o registro de dados importantes das amostras, como:

* Código da amostra;
* Circunferência;
* Altura comercial;
* Altura total;
* Qualidade do fuste.

Além do cadastro das informações, o projeto contará com a funcionalidade de exportação dos dados em formato `.xlsx`, facilitando análises, relatórios e integração com planilhas eletrônicas.

---

## Objetivo

Desenvolver uma aplicação capaz de simplificar o processo de coleta e gerenciamento de dados de inventário florestal, reduzindo o tempo gasto em registros manuais e aumentando a confiabilidade das informações obtidas em campo.

---

## Assunto

Sistema de Inventário Florestal para cadastro, gerenciamento e exportação de amostras de campo.

---

# 2. Problema de Negócio

O processo tradicional de inventário florestal geralmente é realizado manualmente, utilizando anotações em papel ou planilhas descentralizadas. Isso pode ocasionar:

* Perda de informações;
* Erros de preenchimento;
* Dificuldade na organização dos dados;
* Retrabalho na digitalização;
* Lentidão na geração de relatórios.

O sistema proposto busca centralizar e automatizar essas atividades, proporcionando maior eficiência operacional e confiabilidade das informações coletadas.

---

# 3. Objetivo do Produto

Criar um sistema capaz de:

* Registrar amostras florestais de forma rápida;
* Armazenar informações organizadas em banco de dados;
* Permitir consulta e gerenciamento dos registros;
* Exportar os dados em formato `.xlsx`;
* Facilitar análises e geração de relatórios;
* Melhorar a produtividade durante a coleta em campo.

---

# 4. Público-Alvo

## Primário

* Estudantes de Engenharia Florestal;
* Pesquisadores ambientais;
* Técnicos florestais;
* Equipes de inventário florestal.

## Secundário

* Instituições acadêmicas;
* Empresas do setor ambiental;
* Órgãos de monitoramento florestal;
* Projetos de pesquisa científica.

---

# 5. Proposta de Valor

## Benefícios principais

* Redução de erros em registros manuais;
* Maior agilidade no cadastro das amostras;
* Organização centralizada dos dados;
* Facilidade na exportação de informações;
* Melhor suporte para análises florestais;
* Processo de coleta mais eficiente e confiável.

---

# 6. Justificativa Tecnológica

## Por que usar Flutter + SQLite?

### Flutter

O uso do Flutter permite criar aplicações móveis multiplataforma com interface moderna, rápida e responsiva, ideal para utilização em campo.

### SQLite

O SQLite garante armazenamento confiável, estruturado e seguro dos dados cadastrados.

---

# 7. Escopo do Produto

O sistema contemplará:

* Cadastro de amostras;
* Edição de registros;
* Exclusão de registros;
* Listagem das amostras cadastradas;
* Exportação para `.xlsx`;
* Persistência em banco de dados;
* Interface mobile para coleta em campo.

---

# 8. Funcionalidades Principais

## MVP (Versão Inicial)

### F1. Cadastro de Amostras

Permitir cadastrar:

* Código da amostra;
* Circunferência;
* Altura comercial;
* Altura total;
* Qualidade do fuste.

---

### F2. Gerenciamento de Registros

Permitir:

* Editar amostras;
* Excluir registros;
* Consultar dados cadastrados.

---

### F3. Resultado Imediato

Exibir:

* Lista de amostras cadastradas;
* Quantidade total de registros;
* Informações detalhadas da amostra.

---

### F4. Dashboard Simples

Mostrar:

* Total de amostras cadastradas;
* Média das alturas;
* Média da circunferência;
* Indicadores básicos do inventário.

---

### F5. Registro e Exportação

Permitir:

* Salvar os dados localmente;
* Exportar registros em `.xlsx`.

---

# 9. Requisitos Funcionais

| Código | Requisito                                              |
| ------ | ------------------------------------------------------ |
| RF01   | O sistema deve permitir cadastrar amostras florestais  |
| RF02   | O sistema deve permitir editar informações cadastradas |
| RF03   | O sistema deve permitir excluir registros              |
| RF04   | O sistema deve exportar os dados em formato `.xlsx`    |
| RF05   | O sistema deve listar todas as amostras cadastradas    |
| RF06   | O sistema deve validar campos obrigatórios             |
| RF07   | O sistema deve armazenar os dados em banco de dados    |

---

# 10. Requisitos Não Funcionais

| Código | Requisito                                                         |
| ------ | ----------------------------------------------------------------- |
| RNF01  | O sistema deve possuir interface simples e intuitiva              |
| RNF02  | O sistema deve apresentar boa performance em dispositivos Android |
| RNF03  | O sistema deve garantir integridade dos dados armazenados         |
| RNF04  | O sistema deve permitir fácil manutenção do código                |
| RNF05  | O sistema deve possuir arquitetura escalável                      |
| RNF06  | O sistema deve suportar exportação rápida de planilhas            |

---

# 11. Arquitetura Proposta

```text
[ Flutter App ]
       |
       v
[   SQLite ]
       |
       v
[ Exportação XLSX ]
```

---

# 12. Hardware Alvo

* Smartphones Android;
* Tablets Android;

---

# 13. Roadmap

## Fase 0

* Criar estrutura inicial do projeto;
* Configurar ambiente Flutter;
* Configurar API Quarkus;
* Configurar banco PostgreSQL.

---

## Fase 1

* Desenvolver tela de cadastro;
* Implementar entidade de amostra;
* Criar API REST básica.

---

## Fase 2

* Implementar listagem de registros;
* Desenvolver funcionalidades de edição e exclusão;
* Integrar frontend com backend.

---

## Fase 3

* Implementar exportação `.xlsx`;
* Criar dashboard simples;
* Melhorar validações.

---

## Fase 4

* Testes finais;
* Correções de bugs;
* Publicação da aplicação;
* Documentação final do sistema.

---

# 14. Possíveis Evoluções Futuras

* Geolocalização das amostras;
* Funcionamento offline;
* Sincronização em nuvem;
* Geração automática de relatórios PDF;
* Upload de imagens das árvores;
* Dashboard analítico avançado;
* Integração com sensores IoT;
* Inteligência Artificial para análise florestal.
