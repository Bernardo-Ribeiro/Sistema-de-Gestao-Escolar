package com.sge;

import com.sge.dao.AlunoDAO;
import com.sge.dao.CursoDAO;
import com.sge.dao.MatriculaDAO;
import com.sge.dao.AdvertenciaDAO;
import com.sge.dao.AulaDAO;
import com.sge.dao.PresencaDAO;
import com.sge.model.Aluno;
import com.sge.model.Curso;
import com.sge.model.Matricula;
import com.sge.model.Advertencia;
import com.sge.model.Aula;
import com.sge.model.Presenca;

import java.time.LocalDate;

public class MainTeste {
    public static void main(String[] args) {

        // DAOs
        AlunoDAO alunoDAO = new AlunoDAO();
        CursoDAO cursoDAO = new CursoDAO();
        AulaDAO aulaDAO = new AulaDAO();
        MatriculaDAO matriculaDAO = new MatriculaDAO();
        AdvertenciaDAO advertenciaDAO = new AdvertenciaDAO();
        PresencaDAO presencaDAO = new PresencaDAO();

        // 1. Criar e salvar um Curso
        Curso cursoJava = new Curso("Java Web", "Desenvolvimento com Spring", 80);
        cursoDAO.salvar(cursoJava);
        System.out.println("Curso salvo com sucesso!");

        // 2. Criar e salvar um Aluno
        Aluno aluno1 = new Aluno("João Silva", "2024001", "joao@gmail.com", "9999-9999");
        alunoDAO.salvar(aluno1);
        System.out.println("Aluno salvo com sucesso!");

        // 3. Criar algumas aulas para o curso
        Aula aula1 = new Aula("Introdução ao Java", LocalDate.now().minusDays(2), 2, cursoJava);
        Aula aula2 = new Aula("POO em Java", LocalDate.now().minusDays(1), 2, cursoJava);
        Aula aula3 = new Aula("Spring Boot", LocalDate.now(), 2, cursoJava);
        aulaDAO.salvar(aula1);
        aulaDAO.salvar(aula2);
        aulaDAO.salvar(aula3);
        System.out.println("Aulas salvas com sucesso!");

        // 4. Criar uma matrícula (Aluno x Curso)
        Matricula matricula = new Matricula(aluno1, cursoJava);
        matriculaDAO.salvar(matricula);
        System.out.println("Matrícula salva com sucesso!");

        // 5. Registrar presenças do aluno nessas aulas
        // Exemplo: presente nas 2 primeiras e falta na terceira
        presencaDAO.salvar(new Presenca(matricula, aula1, true));
        presencaDAO.salvar(new Presenca(matricula, aula2, true));
        presencaDAO.salvar(new Presenca(matricula, aula3, false));
        System.out.println("Presenças registradas com sucesso!");

        // 6. Recalcular frequência com base nas presenças
        matricula = matriculaDAO.buscarComPresencas(matricula.getId()); // busca com presenças já carregadas
        long total = matricula.getPresencas().size();
        long presentes = matricula.getPresencas().stream()
                .filter(Presenca::isPresente)
                .count();

        double freq = total == 0 ? 0.0 : (presentes * 100.0 / total);
        matricula.setFrequencia(freq);
        // Exemplo simples de situação:
        matricula.setSituacao(freq >= 75.0 ? "CURSANDO" : "REPROVADO POR FALTA");
        matriculaDAO.atualizar(matricula);

        System.out.println("Frequência calculada: " + freq + "%");
        System.out.println("Situação da matrícula: " + matricula.getSituacao());

        // 7. Registrar uma advertência para o aluno
        Advertencia advertencia = new Advertencia(aluno1, "Faltas em três aulas seguidas");
        advertencia.setObservacoes("Aluno foi orientado a regularizar a presença.");
        advertenciaDAO.salvar(advertencia);
        System.out.println("Advertência salva com sucesso!");

        // 8. Listar cursos para conferir
        System.out.println("\n--- Lista de Cursos ---");
        cursoDAO.listarTodos().forEach(c -> System.out.println(c.getNome()));
    }
}