package com.sge.controller;

import com.sge.dao.CursoDAO;
import com.sge.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cursos")
public class CursoServlet extends HttpServlet {
    
    private CursoDAO cursoDAO = new CursoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listarCursos(request, response);
                break;
            case "new":
                mostrarFormularioNovo(request, response);
                break;
            case "edit":
                mostrarFormularioEdicao(request, response);
                break;
            case "delete":
                deletarCurso(request, response);
                break;
            default:
                listarCursos(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            salvarCurso(request, response);
        } else if ("update".equals(action)) {
            atualizarCurso(request, response);
        }
    }

    private void listarCursos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Curso> cursos = cursoDAO.listarTodos();
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/WEB-INF/views/cursos/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNovo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/cursos/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Curso curso = cursoDAO.buscarPorId(id);
        request.setAttribute("curso", curso);
        request.getRequestDispatcher("/WEB-INF/views/cursos/form.jsp").forward(request, response);
    }

    private void salvarCurso(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        int cargaHoraria = Integer.parseInt(request.getParameter("cargaHoraria"));

        Curso curso = new Curso(nome, descricao, cargaHoraria);
        cursoDAO.salvar(curso);

        response.sendRedirect("cursos?action=list");
    }

    private void atualizarCurso(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        int cargaHoraria = Integer.parseInt(request.getParameter("cargaHoraria"));

        Curso curso = cursoDAO.buscarPorId(id);
        curso.setNome(nome);
        curso.setDescricao(descricao);
        curso.setCargaHoraria(cargaHoraria);

        cursoDAO.atualizar(curso);

        response.sendRedirect("cursos?action=list");
    }

    private void deletarCurso(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        cursoDAO.excluir(id);
        response.sendRedirect("cursos?action=list");
    }
}
