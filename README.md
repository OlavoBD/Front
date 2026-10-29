
# Projeto Integrador — Sistema de Pronto Socorro

**Grupo 6**
- Lorenzo Dias Lanzoni — 26005161
- Olavo Belfante Dias — 26008848
- Arthur Prevedel Fernandes Nogueira — 26009048
- Davi Vieira Caprini — 26006871

**Versão:** 1.0 | **Back-end:** Python 3 | **Front-end:** HTML, CSS e JavaScript | **Banco de dados:** MySQL

---

## Descrição do projeto

Sistema de gerenciamento de atendimentos de um Pronto Socorro. O sistema acompanha o paciente em três etapas:

1. **Recepção** — cadastro do paciente e abertura do atendimento.
2. **Triagem da Enfermagem** — registro dos sinais vitais e classificação de risco pelo Protocolo de Manchester.
3. **Médico** — atendimento, prescrição de medicações e confirmação de alta, com um painel que mostra a fila ordenada por prioridade.

---

## Arquivos do projeto

> Ajuste os nomes abaixo para os arquivos reais do grupo.

| Arquivo | Função |
|---|---|
| `BancodeDados.sql` | Script SQL para criação e população do banco de dados |
| `app.py` | Back-end em Python: conexão com o banco e rotas usadas pelas telas |
| `recepcao.html` | Tela de cadastro e gestão de atendimentos da Recepção |
| `triagem.html` | Tela de Triagem da Enfermagem |
| `painel_medico.html` | Painel Médico com fila ordenada por prioridade e formulário de prescrição/alta |

---

## Divisão de tarefas (PI-2)

| Tarefa | Descrição |
|---|---|
| #1 | Modelagem & Banco de Dados |
| #2 | Documentação |
| #3 | Conexão com BD |
| #4 | Tela de cadastro e gestão de atendimentos da Recepção |
| #5 | Tela de Triagem da Enfermagem |
| #6 | Formulário de prescrição e confirmação de alta médica |
| #7 | Tela do Painel Médico com ordenação visual de prioridades |

---

## Estrutura do banco de dados

> Ajuste as tabelas e colunas para o modelo real do grupo.

- **pacientes** — dados pessoais (nome, CPF, RG, data de nascimento, telefone, nome da mãe, nome do pai, endereço)
- **atendimentos** — número do atendimento (ex: AT0001), paciente, situação, data de abertura
- **triagens** — pressão arterial, temperatura, batimentos cardíacos, queixas e classificação de Manchester
- **prescricoes** — medicações prescritas pelo médico e data da alta

Relacionamentos:

```
Pacientes (1) ---- (N) Atendimentos
Atendimentos (1) ---- (1) Triagens
Atendimentos (1) ---- (N) Prescricoes
```

---

## Requisitos e instalação

- Python 3.8 ou superior
- Biblioteca de conexão com o MySQL:

```
pip install mysql-connector-python
```

- Servidor MySQL em execução (local ou remoto)
- Navegador web atualizado (Chrome, Edge ou Firefox)

**Configuração da conexão** (edite as variáveis no topo do `app.py`):

```python
SERVIDOR = 'endereco_do_servidor'
USUARIO  = 'seu_usuario_mysql'
SENHA    = 'sua_senha'
BD       = 'nome_do_banco'
```

**Criação do banco:**

```
mysql -u seu_usuario -p < BancodeDados.sql
```

---

## Como executar

1. Execute o script SQL para criar o banco.
2. Inicie o back-end:

```
python app.py
```

3. Abra o navegador no endereço exibido no terminal e use o menu de navegação para alternar entre **Recepção**, **Triagem** e **Médico**.

---

## Tutorial de uso

### Passo 1 — Recepção

1. Preencha o formulário **Novo atendimento**: nome completo, CPF, RG, data de nascimento, telefone, nome da mãe, nome do pai e endereço (campos com `*` são obrigatórios).
2. Clique em **Salvar atendimento**. O sistema gera o número do atendimento (ex: `AT0001`).
3. Na lista de atendimentos é possível **filtrar** por nome, CPF ou número e por situação, além de **alterar** ou **cancelar** um atendimento.

### Passo 2 — Triagem da Enfermagem

1. Localize o atendimento com situação "Aguardando triagem".
2. Registre a pressão arterial, a temperatura, os batimentos cardíacos e as queixas do paciente.
3. Defina a classificação de risco pelo Protocolo de Manchester. O atendimento passa para "Aguardando médico".

### Passo 3 — Painel Médico

1. A fila exibe os pacientes ordenados do mais urgente para o menos urgente.
2. Os contadores no topo mostram quantos pacientes existem em cada classificação.
3. É possível filtrar a fila por nome, número do atendimento ou cor.
4. Clique em **Chamar** para abrir os dados do paciente (sinais vitais e queixas da triagem).
5. Registre a **prescrição médica** e clique em **Confirmar Alta**. O paciente sai da fila.

---

## Classificação de prioridade (Protocolo de Manchester)

| Cor | Classificação | Tempo máximo de espera |
|---|---|---|
| Vermelho | Emergência | Imediato |
| Laranja | Muito urgente | 10 minutos |
| Amarelo | Urgente | 60 minutos |
| Verde | Pouco urgente | 120 minutos |
| Azul | Não urgente | 240 minutos |

A classificação é definida na **Triagem** e salva no banco de dados. O Painel Médico usa essa informação para ordenar a fila automaticamente.

---

## Persistência de dados

Todas as informações (pacientes, atendimentos, triagens e prescrições) são gravadas no MySQL. Por isso, os dados permanecem armazenados mesmo depois que a aplicação é encerrada ou reiniciada.

A integridade entre as tabelas é garantida por chaves estrangeiras (`FOREIGN KEY`), que impedem registros órfãos e mantêm a consistência dos relacionamentos.

---

## Observações importantes

- Certifique-se de que o servidor MySQL está acessível antes de iniciar o sistema.
- As credenciais do banco ficam no arquivo `.py`; em ambientes de produção, recomenda-se movê-las para variáveis de ambiente.
- A tela do Painel Médico possui dados de exemplo no JavaScript; ao conectar ao banco, esses dados são substituídos pela resposta do back-end.
