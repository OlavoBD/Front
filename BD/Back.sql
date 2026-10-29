CREATE DATABASE pronto_socorro;

USE pronto_socorro;


CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    rg VARCHAR(20) UNIQUE,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    nome_pai VARCHAR(150),
    nome_mae VARCHAR(150),
    telefone VARCHAR(20),
    email VARCHAR(150),
    endereco VARCHAR(200),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE profissionais (
    id_profissional INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    registro_profissional VARCHAR(30),
    tipo_profissional ENUM(
        'RECEPCIONISTA',
        'ENFERMEIRO',
        'MEDICO'
    ) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);




CREATE TABLE status_atendimento (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(200)
);

INSERT INTO status_atendimento (nome, descricao) VALUES
('AGUARDANDO_TRIAGEM', 'Paciente aguardando realização da triagem'),
('AGUARDANDO_MEDICO', 'Paciente aguardando atendimento médico'),
('EM_ATENDIMENTO', 'Paciente está sendo atendido pelo médico'),
('FINALIZADO', 'Atendimento finalizado'),
('CANCELADO', 'Atendimento cancelado');




CREATE TABLE classificacoes_manchester (
    id_classificacao INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    prioridade INT NOT NULL,
    tempo_maximo_minutos INT NOT NULL,
    descricao VARCHAR(255)
);

INSERT INTO classificacoes_manchester
(nome, cor, prioridade, tempo_maximo_minutos, descricao)
VALUES
('Emergente', 'Vermelho', 1, 0,
 'Atendimento imediato'),

('Muito Urgente', 'Laranja', 2, 10,
 'Atendimento em até 10 minutos'),

('Urgente', 'Amarelo', 3, 60,
 'Atendimento em até 60 minutos'),

('Pouco Urgente', 'Verde', 4, 120,
 'Atendimento em até 120 minutos'),

('Não Urgente', 'Azul', 5, 240,
 'Atendimento em até 240 minutos');




CREATE TABLE atendimentos (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,

    numero_atendimento VARCHAR(20) NOT NULL UNIQUE,

    id_paciente INT NOT NULL,

    id_recepcionista INT NULL,
    -- NULL quando o próprio paciente abre o atendimento pela área do paciente

    id_status INT NOT NULL,

    data_hora_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,

    data_hora_confirmacao DATETIME NULL,

    data_hora_saida DATETIME NULL,

    sintomas TEXT,
    -- sintomas relatados na abertura do atendimento (recepção ou paciente)

    observacoes VARCHAR(500),

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente),

    FOREIGN KEY (id_recepcionista)
        REFERENCES profissionais(id_profissional),

    FOREIGN KEY (id_status)
        REFERENCES status_atendimento(id_status)
);




CREATE TABLE triagens (
    id_triagem INT AUTO_INCREMENT PRIMARY KEY,

    id_atendimento INT NOT NULL UNIQUE,

    id_enfermeiro INT NOT NULL,

    pressao_arterial VARCHAR(20),

    temperatura DECIMAL(4,1),

    batimentos_cardiacos INT,

    frequencia_respiratoria INT,

    saturacao_oxigenio INT,

    escala_dor TINYINT,

    queixa_principal TEXT,

    observacoes TEXT,

    id_classificacao INT NOT NULL,

    data_hora_triagem DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_atendimento)
        REFERENCES atendimentos(id_atendimento),

    FOREIGN KEY (id_enfermeiro)
        REFERENCES profissionais(id_profissional),

    FOREIGN KEY (id_classificacao)
        REFERENCES classificacoes_manchester(id_classificacao)
);




CREATE TABLE medicamentos (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,

    nome VARCHAR(150) NOT NULL,

    principio_ativo VARCHAR(150),

    dosagem VARCHAR(50),

    unidade VARCHAR(30),

    fabricante VARCHAR(100),

    ativo BOOLEAN DEFAULT TRUE
);




CREATE TABLE atendimentos_medicos (
    id_atendimento_medico INT AUTO_INCREMENT PRIMARY KEY,

    id_atendimento INT NOT NULL UNIQUE,

    id_medico INT NOT NULL,

    diagnostico TEXT,

    observacoes TEXT,

    conduta_medica TEXT,

    tipo_alta VARCHAR(60),
    -- Ex.: 'Alta médica', 'Alta com retorno ambulatorial', 'Encaminhamento para internação'

    data_hora_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,

    data_hora_fim DATETIME NULL,

    atendimento_confirmado BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (id_atendimento)
        REFERENCES atendimentos(id_atendimento),

    FOREIGN KEY (id_medico)
        REFERENCES profissionais(id_profissional)
);




CREATE TABLE prescricoes (
    id_prescricao INT AUTO_INCREMENT PRIMARY KEY,

    id_atendimento_medico INT NOT NULL,

    id_medicamento INT NOT NULL,

    quantidade INT,

    dosagem VARCHAR(50),

    via_administracao VARCHAR(50),

    frequencia VARCHAR(100),

    duracao VARCHAR(50),

    observacoes VARCHAR(255),

    FOREIGN KEY (id_atendimento_medico)
        REFERENCES atendimentos_medicos(id_atendimento_medico),

    FOREIGN KEY (id_medicamento)
        REFERENCES medicamentos(id_medicamento)
);


-- Os usuários de demonstração (recepção / enfermagem / médico, senha "1234")
-- são criados pelo script backend/seed.js, que grava a senha já em hash
-- (bcrypt). Rode "npm run seed" no backend depois de criar o banco.
