-- Cria o banco (se ainda não existir)
CREATE DATABASE IF NOT EXISTS sge
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE sge;

-- =====================
-- TABELA: ALUNO
-- =====================
CREATE TABLE IF NOT EXISTS aluno (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    matricula  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100),
    telefone   VARCHAR(30),
    CONSTRAINT uk_aluno_matricula UNIQUE (matricula)
);

-- =====================
-- TABELA: CURSO
-- =====================
CREATE TABLE IF NOT EXISTS curso (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    descricao    VARCHAR(255),
    carga_horaria INT NOT NULL
);

-- =====================
-- TABELA: AULA
-- Cada aula pertence a um curso (1:N)
-- =====================
CREATE TABLE IF NOT EXISTS aula (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo   VARCHAR(150) NOT NULL,
    data     DATE         NOT NULL,
    duracao  INT          NOT NULL,
    curso_id BIGINT       NOT NULL,
    CONSTRAINT fk_aula_curso
        FOREIGN KEY (curso_id) REFERENCES curso(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================
-- TABELA: ALUNO_CURSO (Matrículas) - relação N:N
-- (pode ser descartada se usar só `matricula`, mas deixei aqui)
-- =====================
CREATE TABLE IF NOT EXISTS aluno_curso (
    aluno_id BIGINT NOT NULL,
    curso_id BIGINT NOT NULL,
    data_matricula DATE,
    PRIMARY KEY (aluno_id, curso_id),
    CONSTRAINT fk_ac_aluno
        FOREIGN KEY (aluno_id) REFERENCES aluno(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ac_curso
        FOREIGN KEY (curso_id) REFERENCES curso(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Matrícula com nota/frequência
CREATE TABLE IF NOT EXISTS matricula (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    aluno_id BIGINT NOT NULL,
    curso_id BIGINT NOT NULL,
    data_matricula DATE,
    nota_final DECIMAL(5,2),
    frequencia DECIMAL(5,2),
    situacao VARCHAR(20),
    CONSTRAINT uk_matricula_aluno_curso UNIQUE (aluno_id, curso_id),
    CONSTRAINT fk_matri_aluno
        FOREIGN KEY (aluno_id) REFERENCES aluno(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_matri_curso
        FOREIGN KEY (curso_id) REFERENCES curso(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Advertências do aluno
CREATE TABLE IF NOT EXISTS advertencia (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    aluno_id BIGINT NOT NULL,
    data DATE NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    observacoes TEXT,
    CONSTRAINT fk_adv_aluno
        FOREIGN KEY (aluno_id) REFERENCES aluno(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Registro de presença por aula
CREATE TABLE IF NOT EXISTS presenca (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    matricula_id BIGINT NOT NULL,
    aula_id BIGINT NOT NULL,
    presente BOOLEAN NOT NULL,
    CONSTRAINT fk_presenca_matricula
        FOREIGN KEY (matricula_id) REFERENCES matricula(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_presenca_aula
        FOREIGN KEY (aula_id) REFERENCES aula(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);