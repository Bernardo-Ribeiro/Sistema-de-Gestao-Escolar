package com.sge.controller;

import com.sge.dao.MatriculaDAO;
import com.sge.dao.AlunoDAO;
import com.sge.dao.CursoDAO;
import com.sge.model.Matricula;
import com.sge.model.Aluno;
import com.sge.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/matriculas")
public class MatriculaServlet extends HttpServlet {
    
    private MatriculaDAO matriculaDAO = new MatriculaDAO();
    private AlunoDAO alunoDAO = new AlunoDAO();
    private CursoDAO cursoDAO = new CursoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listarMatriculas(request, response);
                break;
            case "new":
                mostrarFormularioNovo(request, response);
                break;
            case "edit":
                mostrarFormularioEdicao(request, response);
                break;
            case "delete":
                deletarMatricula(request, response);
                break;
            default:
                listarMatriculas(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            salvarMatricula(request, response);
        } else if ("update".equals(action)) {
            atualizarMatricula(request, response);
        }
    }

    private void listarMatriculas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Matricula> matriculas = matriculaDAO.listarTodos();
        request.setAttribute("matriculas", matriculas);
        request.getRequestDispatcher("/WEB-INF/views/matriculas/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNovo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aluno> alunos = alunoDAO.listarTodos();
        List<Curso> cursos = cursoDAO.listarTodos();
        request.setAttribute("alunos", alunos);
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/WEB-INF/views/matriculas/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Matricula matricula = matriculaDAO.buscarPorId(id);
        List<Aluno> alunos = alunoDAO.listarTodos();
        List<Curso> cursos = cursoDAO.listarTodos();
        request.setAttribute("matricula", matricula);
        request.setAttribute("alunos", alunos);
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/WEB-INF/views/matriculas/form.jsp").forward(request, response);
    }

    private void salvarMatricula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long alunoId = Long.parseLong(request.getParameter("alunoId"));
        Long cursoId = Long.parseLong(request.getParameter("cursoId"));
        String situacao = request.getParameter("situacao");
        
        String notaStr = request.getParameter("notaFinal");
        String freqStr = request.getParameter("frequencia");

        Aluno aluno = alunoDAO.buscarPorId(alunoId);
        Curso curso = cursoDAO.buscarPorId(cursoId);
        
        Matricula matricula = new Matricula(aluno, curso);
        matricula.setSituacao(situacao != null ? situacao : "CURSANDO");
        
        if (notaStr != null && !notaStr.trim().isEmpty()) {
            matricula.setNotaFinal(Double.parseDouble(notaStr));
        }
        if (freqStr != null && !freqStr.trim().isEmpty()) {
            matricula.setFrequencia(Double.parseDouble(freqStr));
        }

        matriculaDAO.salvar(matricula);

        response.sendRedirect("matriculas?action=list");
    }

    private void atualizarMatricula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Long alunoId = Long.parseLong(request.getParameter("alunoId"));
        Long cursoId = Long.parseLong(request.getParameter("cursoId"));
        String situacao = request.getParameter("situacao");
        
        String notaStr = request.getParameter("notaFinal");
        String freqStr = request.getParameter("frequencia");

        Matricula matricula = matriculaDAO.buscarPorId(id);
        Aluno aluno = alunoDAO.buscarPorId(alunoId);
        Curso curso = cursoDAO.buscarPorId(cursoId);
        
        matricula.setAluno(aluno);
        matricula.setCurso(curso);
        matricula.setSituacao(situacao);
        
        if (notaStr != null && !notaStr.trim().isEmpty()) {
            matricula.setNotaFinal(Double.parseDouble(notaStr));
        }
        if (freqStr != null && !freqStr.trim().isEmpty()) {
            matricula.setFrequencia(Double.parseDouble(freqStr));
        }

        matriculaDAO.atualizar(matricula);

        response.sendRedirect("matriculas?action=list");
    }

    private void deletarMatricula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        matriculaDAO.excluir(id);
        response.sendRedirect("matriculas?action=list");
    }
}
