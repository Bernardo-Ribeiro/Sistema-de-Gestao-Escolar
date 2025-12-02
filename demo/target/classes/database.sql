-- Cria o banco (se ainda não existir)
CREATE DATABASE IF NOT EXISTS sge
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE sge;

-- =====================
-- DDL (ordem por dependência)
-- =====================

-- TABELA: CURSO (base para AULA e MATRICULA)
CREATE TABLE IF NOT EXISTS curso (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    descricao    VARCHAR(255),
    carga_horaria INT NOT NULL
);

-- TABELA: ALUNO (base para MATRICULA, ADVERTENCIA)
CREATE TABLE IF NOT EXISTS aluno (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    matricula  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100),
    telefone   VARCHAR(30),
    CONSTRAINT uk_aluno_matricula UNIQUE (matricula)
);

-- TABELA: AULA (depende de CURSO)
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

-- TABELA: ALUNO_CURSO (N:N) — opcional; depende de ALUNO e CURSO
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

-- TABELA: MATRICULA (depende de ALUNO e CURSO)
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

-- TABELA: ADVERTENCIA (depende de ALUNO)
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

-- TABELA: PRESENCA (depende de MATRICULA e AULA)
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

-- TABELA: USUARIO (independente)
CREATE TABLE IF NOT EXISTS usuario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    perfil VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acesso DATETIME,
    CONSTRAINT uk_usuario UNIQUE (usuario)
);

-- =====================
-- SEED DATA (ajustado para corresponder ao esquema)
-- =====================
START TRANSACTION;

-- Usuarios
INSERT INTO usuario (id, usuario, senha, nome, email, perfil, ativo, data_criacao, ultimo_acesso)
VALUES
  (1, 'admin', '$2a$10$Zb9Jb9HshXFakeHashForDemoOnlyxxxxx', 'Administrador', 'admin@edugestao.com', 'ADMIN', 1, NOW(), NOW()),
  (2, 'prof.maria', '$2a$10$Zb9Jb9HshXFakeHashForDemoOnlyxxxxx', 'Maria Silva', 'maria.silva@edugestao.com', 'PROFESSOR', 1, NOW(), NULL),
  (3, 'coord.joao', '$2a$10$Zb9Jb9HshXFakeHashForDemoOnlyxxxxx', 'João Santos', 'joao.santos@edugestao.com', 'COORDENADOR', 1, NOW(), NULL)
ON DUPLICATE KEY UPDATE nome=VALUES(nome);

-- Cursos (nome, descricao, carga_horaria)
INSERT INTO curso (id, nome, descricao, carga_horaria)
VALUES
  (1, 'Desenvolvimento Web com React', 'Fundamentos de React, hooks e ecossistema.', 40),
  (2, 'Introdução à Ciência de Dados', 'Python, pandas, visualização e estatística básica.', 60),
  (3, 'Design Gráfico Essencial', 'Princípios de design, tipografia e cores.', 30),
  (4, 'Gestão de Projetos Ágeis', 'Scrum/Kanban, estimativas e métricas.', 36)
ON DUPLICATE KEY UPDATE descricao=VALUES(descricao), carga_horaria=VALUES(carga_horaria);

-- Alunos (nome, matricula, email, telefone)
INSERT INTO aluno (id, nome, matricula, email, telefone)
VALUES
  (1, 'Maria Silva', '2023001', 'maria.silva@email.com', '(11) 99999-1111'),
  (2, 'João Santos', '2023002', 'joao.santos@email.com', '(11) 99999-2222'),
  (3, 'Ana Oliveira', '2023003', 'ana.oliveira@email.com', '(11) 99999-3333'),
  (4, 'Pedro Souza', '2023004', 'pedro.souza@email.com', '(11) 99999-4444'),
  (5, 'Beatriz Costa', '2023005', 'beatriz.costa@email.com', '(11) 99999-5555')
ON DUPLICATE KEY UPDATE telefone=VALUES(telefone);

-- Aulas (titulo, data, duracao, curso_id)
INSERT INTO aula (id, titulo, data, duracao, curso_id)
VALUES
  (1, 'Introdução ao React Hooks', DATE('2023-10-26'), 90, 1),
  (2, 'Estado e Efeitos no React', DATE('2023-11-02'), 120, 1),
  (3, 'Análise Exploratória de Dados', DATE('2023-11-10'), 180, 2),
  (4, 'Princípios de UX/UI', DATE('2023-11-15'), 90, 3),
  (5, 'Scrum e Kanban', DATE('2023-11-20'), 150, 4)
ON DUPLICATE KEY UPDATE duracao=VALUES(duracao), data=VALUES(data);

-- Matrículas (aluno_id, curso_id, data_matricula, situacao, nota_final, frequencia)
INSERT INTO matricula (id, aluno_id, curso_id, data_matricula, situacao, nota_final, frequencia)
VALUES
  (1, 1, 1, DATE('2023-01-15'), 'ATIVO', NULL, NULL),
  (2, 2, 1, DATE('2023-02-01'), 'PENDENTE', NULL, NULL),
  (3, 3, 2, DATE('2023-03-10'), 'CONCLUIDO', 9.5, 95.0),
  (4, 4, 2, DATE('2023-04-20'), 'ATIVO', NULL, NULL),
  (5, 5, 3, DATE('2023-05-05'), 'CANCELADO', NULL, NULL),
  (6, 1, 4, DATE('2023-06-12'), 'ATIVO', NULL, NULL)
ON DUPLICATE KEY UPDATE situacao=VALUES(situacao), nota_final=VALUES(nota_final), frequencia=VALUES(frequencia);

-- Presenças (matricula_id, aula_id, presente)
INSERT INTO presenca (id, matricula_id, aula_id, presente)
VALUES
  (1, 1, 1, 1),
  (2, 1, 2, 1),
  (3, 3, 3, 1),
  (4, 5, 4, 0),
  (5, 6, 5, 1)
ON DUPLICATE KEY UPDATE presente=VALUES(presente);

-- Advertências (aluno_id, data, motivo)
INSERT INTO advertencia (id, aluno_id, data, motivo, observacoes)
VALUES
  (1, 2, DATE('2023-09-05'), 'Comportamento inadequado em sala', NULL),
  (2, 4, DATE('2023-10-01'), 'Atrasos recorrentes', NULL)
ON DUPLICATE KEY UPDATE motivo=VALUES(motivo);

COMMIT;