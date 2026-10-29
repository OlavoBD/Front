# Projeto Integrador — Sistema de Pronto Socorro

**Grupo 6**

- Lorenzo Dias Lanzoni — 26005161
- Olavo Belfante Dias — 26008848
- Arthur Prevedel Fernandes Nogueira — 26009048
- Davi Vieira Caprini — 26006871

**Versão:** 1.0  
**Frontend:** HTML, CSS e JavaScript  
**Backend:** Node.js com Express  
**Banco de dados:** MySQL

## Descrição do projeto

Sistema acadêmico de gerenciamento de atendimentos de um pronto socorro, com frontend e backend integrados ao MySQL. O fluxo principal acompanha o paciente em três etapas:

1. **Recepção:** cadastro do paciente e abertura do atendimento.
2. **Enfermagem:** registro dos sinais vitais e classificação de urgência.
3. **Médico:** atendimento, diagnóstico, prescrição e confirmação da alta.

O paciente também pode solicitar um atendimento e acompanhar sua situação pela área do paciente, acessada por CPF.

O projeto está preparado para demonstração local com dados fictícios. Ainda precisa de controles de autenticação e autorização para uso com prontuários reais.

## Tecnologias

| Tecnologia | Uso |
|---|---|
| HTML, CSS e JavaScript | Interface e comunicação com a API por `fetch` |
| Node.js e Express | Servidor HTTP e rotas da API |
| MySQL e mysql2 | Persistência e acesso ao banco |
| bcryptjs | Armazenamento e verificação de senhas de profissionais por hash |
| dotenv | Carregamento das configurações locais do `.env` |
| cors | Configuração de acesso HTTP entre origens |
| node:test | Testes automatizados |

## Estrutura dos arquivos

A pasta da aplicação é aquela que contém `Front.html`, `Back.sql` e `backend`. Se houver duas pastas chamadas `pronto-socorro`, entre na pasta interna.

```text
pronto-socorro/
├── Front.html                    # Interface integrada dos quatro perfis
├── Back.sql                      # Instalação de um banco novo
├── README.md
├── .gitignore
├── tela-verificada.png           # Registro da tela de entrada verificada
└── backend/
    ├── server.js                 # Servidor, entrega do HTML e rotas da API
    ├── db.js                     # Pool de conexões MySQL
    ├── atendimentos.js           # Consultas e gravações dos atendimentos
    ├── mapeamento.js             # Tradução de situações e classificações
    ├── seed.js                   # Criação dos profissionais de demonstração
    ├── check-db.js               # Diagnóstico somente leitura do banco
    ├── integration.test.js       # Testes com banco simulado
    ├── mysql.integration.test.js # Teste de integração com MySQL real
    ├── package.json
    ├── package-lock.json
    ├── .env.example              # Modelo de configuração sem senha
    └── .env                      # Configuração local; não versionar
```

`node_modules` é gerada pela instalação das dependências e não precisa ser copiada para outro computador.

## Divisão de tarefas (PI-2)

| Tarefa | Descrição |
|---|---|
| #1 | Modelagem e banco de dados |
| #2 | Documentação |
| #3 | Conexão com o banco de dados |
| #4 | Tela de cadastro e gestão de atendimentos da recepção |
| #5 | Tela de triagem da enfermagem |
| #6 | Formulário de prescrição e confirmação de alta médica |
| #7 | Painel médico com ordenação visual de prioridades |

## Requisitos

- Node.js com npm. A validação local foi realizada com Node.js 26.13.0.
- Servidor MySQL em execução. A validação local foi realizada com MySQL 9.6.0.
- Navegador atualizado.
- Credenciais MySQL com permissão para acessar o banco da aplicação.
- Para instalar um banco novo, permissão para criar banco e tabelas.

O MySQL Workbench é opcional: ele permite administrar o banco, mas não é necessário para a aplicação funcionar. O VSCode também é opcional. Apenas abrir `Back.sql` no editor não executa o script nem estabelece uma conexão com o MySQL.

## Instalação em outro computador

### 1. Preparar os arquivos

Copie a pasta da aplicação e abra um terminal dentro de `backend`:

```powershell
cd "C:\caminho\para\pronto-socorro\backend"
npm.cmd install
```

Substitua o caminho pelo local real da pasta no computador. No Linux ou macOS, utilize `npm` no lugar de `npm.cmd`.

### 2. Preparar o banco

**Se o banco `pronto_socorro` ainda não existir**, execute `Back.sql` no MySQL. No Workbench:

1. Abra a conexão com o servidor MySQL.
2. Selecione **File → Open SQL Script** e abra `Back.sql`.
3. Execute o script completo pelo botão de raio correspondente à execução do script.
4. Atualize a lista de schemas e confira o banco `pronto_socorro`.

O script cria as tabelas, os cinco status e as cinco classificações de Manchester. Os profissionais de demonstração são criados separadamente pelo comando `seed`.

**Se já houver um banco com dados, não execute `Back.sql` sobre ele.** O script é de instalação inicial, não uma migração. Verifique a estrutura com `check:db` e revise uma migração aditiva se necessário. A inicialização do servidor não importa SQL nem limpa dados automaticamente.

Para levar os pacientes e atendimentos de outro computador, exporte o banco de origem e importe o backup no destino, em vez de usar apenas `Back.sql`. Copiar os arquivos do projeto não copia os dados do MySQL.

### 3. Configurar o `.env`

Dentro de `backend`, crie `.env` a partir de `.env.example`, caso ele ainda não exista:

```powershell
Copy-Item .env.example .env
```

Não sobrescreva um `.env` já configurado. Edite-o localmente:

```dotenv
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=seu_usuario_mysql
DB_PASSWORD="sua_senha_mysql"
DB_NAME=pronto_socorro
PORT=3000
```

Use o usuário, a senha e a porta do MySQL daquele computador. O valor acima é apenas um exemplo; não é uma credencial válida. Coloque senhas com `#` entre aspas para evitar que o caractere seja interpretado como comentário.

O arquivo `.env` está no `.gitignore`. Não publique esse arquivo, não envie sua senha no chat e não inclua credenciais em capturas de tela. A senha do MySQL é diferente da senha de demonstração dos funcionários.

### 4. Verificar a conexão e criar os usuários de demonstração

Ainda na pasta `backend`, execute:

```powershell
npm.cmd run check:db
npm.cmd run seed
```

`check:db` executa somente consultas de leitura: verifica conexão, tabelas e colunas necessárias e apresenta contagens sem exibir prontuários ou senhas.

`seed` insere os três profissionais de demonstração ausentes. Se os CPFs desses usuários já existirem, suas senhas, perfis e situações são preservados.

| Perfil na tela | Senha dos novos usuários de demonstração |
|---|---|
| Secretária | `1234` |
| Enfermeira | `1234` |
| Médico | `1234` |

### 5. Iniciar a aplicação

```powershell
npm.cmd start
```

O terminal deve mostrar:

```text
Pronto Socorro: http://127.0.0.1:3000
```

Abra **http://127.0.0.1:3000** no navegador. No VSCode, use **Ctrl + clique** no link do terminal. Mantenha o terminal aberto enquanto utilizar o sistema. Para encerrar, pressione **Ctrl + C**.

O próprio backend entrega `Front.html`, e a tela usa a API na mesma origem. Não é necessário usar Live Server. Ao reiniciar o computador, verifique se o serviço MySQL está funcionando e execute novamente `npm.cmd start`.

O servidor escuta somente em `127.0.0.1`: o endereço é acessível no próprio computador. Ele não publica a aplicação na internet nem a disponibiliza automaticamente para outros computadores.

## Tutorial de uso

Use dados fictícios para testar os fluxos.

### Recepção

1. Escolha **Secretária** e entre com a senha de demonstração `1234`.
2. Preencha o formulário **Novo atendimento**, incluindo os campos obrigatórios marcados com `*`.
3. Clique em **Registrar atendimento**. O backend gera o número do atendimento.
4. Consulte a lista e utilize os filtros por texto e situação. Também é possível editar ou cancelar um atendimento.

### Triagem da enfermagem

1. Clique em **Sair** e entre como **Enfermeira**, com a senha de demonstração `1234`.
2. Selecione um paciente na fila de triagem.
3. Registre pressão arterial, pulso, frequência respiratória, temperatura, saturação, escala de dor e observações, conforme necessário.
4. Defina a urgência e clique em **Salvar triagem e encaminhar**.
5. O atendimento passa para **Aguardando médico**.

### Atendimento médico

1. Saia e entre como **Médico**, com a senha de demonstração `1234`.
2. Consulte o painel e selecione um paciente na fila de atendimento médico, ordenada por urgência.
3. Confira os dados do paciente e da triagem.
4. Preencha diagnóstico, orientações, tipo de alta e medicamentos, quando aplicável.
5. Clique em **Confirmar alta médica**, confira o resumo e confirme a alta.
6. O atendimento fica finalizado e sai da fila ativa.

### Área do paciente

1. Na tela inicial, informe o CPF e clique em **Acessar**.
2. Se não houver atendimento associado, preencha os dados para solicitar um atendimento.
3. Use o mesmo CPF para acompanhar a situação e as informações disponibilizadas pela tela.

O acesso por CPF não verifica a identidade do paciente; é uma limitação da demonstração.

## Classificação de urgência

O banco contém cinco classificações de Manchester. A interface atual apresenta quatro níveis, conforme o mapeamento de `backend/mapeamento.js`:

| Classificação no banco | Cor cadastrada | Tempo máximo cadastrado em minutos | Nível exibido na tela |
|---|---|---|---|
| Emergente | Vermelho | 0 | Crítica |
| Muito Urgente | Laranja | 10 | Alta |
| Urgente | Amarelo | 60 | Média |
| Pouco Urgente | Verde | 120 | Baixa |
| Não Urgente | Azul | 240 | Baixa |

Ao selecionar **Baixa** na triagem, a aplicação grava **Pouco Urgente**. Se um registro do banco tiver **Não Urgente**, ele também será exibido como **Baixa**. Para permitir a seleção dos cinco níveis, será necessário ampliar a interface e o mapeamento.

Os tempos acima são valores cadastrados no projeto; a aplicação não garante seu cumprimento nem substitui uma avaliação clínica.

## Estrutura do banco de dados

| Tabela | Finalidade |
|---|---|
| `pacientes` | Dados cadastrais do paciente |
| `profissionais` | Profissionais, perfis e hashes de senha |
| `status_atendimento` | Situações possíveis do atendimento |
| `classificacoes_manchester` | Classificações de risco, cores e prioridades |
| `atendimentos` | Número, paciente, situação, sintomas e datas do atendimento |
| `triagens` | Sinais vitais, observações, enfermeiro e classificação |
| `medicamentos` | Cadastro de medicamentos |
| `atendimentos_medicos` | Médico, diagnóstico, conduta, tipo de alta e datas |
| `prescricoes` | Medicamentos prescritos, dose, via, frequência e duração |

Relacionamentos principais:

```text
pacientes              1 ─── N atendimentos
status_atendimento     1 ─── N atendimentos
atendimentos           1 ─── 0..1 triagens
profissionais          1 ─── N triagens (enfermeiro)
classificacoes_manchester 1 ─ N triagens
atendimentos           1 ─── 0..1 atendimentos_medicos
profissionais          1 ─── N atendimentos_medicos (médico)
atendimentos_medicos   1 ─── N prescricoes
medicamentos           1 ─── N prescricoes
```

Um atendimento também pode estar associado a um profissional recepcionista; esse vínculo pode ser nulo quando o próprio paciente solicita o atendimento.

A data da alta pertence ao atendimento médico e à saída do atendimento. As prescrições se vinculam ao atendimento médico, não diretamente ao paciente.

## Persistência e consulta dos dados

As operações da tela enviam requisições ao backend, que consulta ou grava no MySQL. O frontend não usa o `localStorage` como banco de atendimentos. Os registros permanecem salvos após fechar o navegador ou reiniciar o computador.

Para consultar os pacientes no Workbench ou em outro cliente conectado ao MySQL:

```sql
SELECT * FROM pronto_socorro.pacientes;
```

No Workbench, deixe o cursor na consulta e pressione **Ctrl + Enter**. Essa consulta apenas lê os dados. Para consultar pelo VSCode, é necessário configurar uma extensão compatível com MySQL; uma extensão exclusiva de SQL Server pode apontar falsos erros em `Back.sql`.

O endereço digitado na tela é salvo em `pacientes.endereco`. Medicamentos informados na prescrição que ainda não existirem recebem um cadastro mínimo em `medicamentos`.

As chaves estrangeiras ajudam a preservar os relacionamentos. As gravações de abertura, edição, triagem e alta utilizam transações. Isso não substitui rotinas de backup nem controles de acesso.

## Testes e diagnóstico

Execute os comandos abaixo na pasta `backend`:

| Comando | Finalidade |
|---|---|
| `npm.cmd run check:db` | Verificar conexão, estrutura requerida e contagens sem alterar dados |
| `npm.cmd test` | Verificar JavaScript da tela, rotas HTTP com banco simulado e regressões de edição e triagem |
| `npm.cmd run test:mysql` | Testar o fluxo completo por HTTP com MySQL real em banco temporário exclusivo |

O teste com MySQL real cria um banco chamado `ps_test_<identificador aleatório>` e remove somente o banco criado pelo próprio teste ao terminar. Requer permissão para criar e remover bancos. Ele não grava pacientes ou atendimentos nos bancos existentes. Se o processo for interrompido abruptamente, a limpeza automática pode não terminar.

O endpoint **GET `/api/health`** retorna HTTP 200 quando o MySQL responde e HTTP 503 quando a conexão está indisponível. A verificação detalhada de estrutura é feita pelo comando `check:db`.

Na validação local de 29/10/2026:

- Os quatro testes com banco simulado passaram.
- O teste com MySQL real passou para login, cadastro, edição de CPF, triagem, prescrição, alta, repetição de alta sem duplicar prescrições e cancelamento.
- Os painéis de recepção, enfermagem, médico e paciente foram verificados no navegador.
- O banco definitivo não recebeu pacientes ou atendimentos temporários desses testes.

Essa validação cobre os fluxos exercitados; não equivale a certificação para uso clínico, teste de carga ou auditoria de segurança.

## Problemas comuns

| Mensagem ou situação | Como resolver |
|---|---|
| `EADDRINUSE`, porta 3000 ocupada | Verifique se a aplicação já está acessível no navegador. Se houver outra instância deste projeto, encerre-a com Ctrl + C no terminal correspondente antes de iniciar novamente. |
| `Cannot find module 'dotenv'` | Confira se o terminal está em `backend` e execute `npm.cmd install` nessa pasta. |
| `ER_ACCESS_DENIED_ERROR` | Revise `DB_USER` e `DB_PASSWORD` no `.env`, sem compartilhar a senha. Reinicie o backend após alterar o arquivo. |
| `ER_BAD_DB_ERROR` | Confira `DB_NAME` e se o banco existe. Use `Back.sql` somente para instalar um banco novo. |
| `ECONNREFUSED` ao acessar o MySQL | Verifique o serviço MySQL e os valores de `DB_HOST` e `DB_PORT`. |
| Coluna ou tabela ausente | Execute `check:db` e revise a estrutura. Preserve os dados e planeje uma migração; não recrie o banco para eliminar o erro. |
| A tela não conecta ao servidor | Confira se o backend está rodando e se o navegador está no endereço exibido no terminal. |
| Avisos sobre `AUTO_INCREMENT` ou `ENUM` no VSCode | Verifique se a análise está configurada para MySQL, em vez de SQL Server. |

Se o projeto estiver no mesmo caminho usado no desenvolvimento, o início no Windows é:

```powershell
cd "C:\Users\User\Downloads\pronto-socorro\pronto-socorro\backend"
npm.cmd start
```

Em outro computador, adapte esse caminho.

## Limitações e próximos passos

- O login de profissionais recebe perfil e senha, sem identificação individual por usuário ou e-mail.
- As rotas da API ainda não têm autenticação e autorização de sessão; o login da tela não protege diretamente o acesso às rotas.
- O paciente acessa por CPF, sem senha ou segundo fator, e a listagem da API retorna todos os atendimentos.
- A interface apresenta quatro níveis de urgência, enquanto o banco possui cinco classificações.
- Antes de utilizar dados reais ou disponibilizar a aplicação para outras pessoas, implementar controle de acesso por perfil e paciente, validações adicionais, proteção das credenciais de demonstração e uma política de backup.

Para a apresentação acadêmica, utilize dados fictícios e mantenha a aplicação no ambiente local.
