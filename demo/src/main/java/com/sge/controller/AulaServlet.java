package com.sge.controller;

import com.sge.dao.AulaDAO;
import com.sge.dao.CursoDAO;
import com.sge.model.Aula;
import com.sge.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/aulas")
public class AulaServlet extends HttpServlet {
    
    private AulaDAO aulaDAO = new AulaDAO();
    private CursoDAO cursoDAO = new CursoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listarAulas(request, response);
                break;
            case "new":
                mostrarFormularioNovo(request, response);
                break;
            case "edit":
                mostrarFormularioEdicao(request, response);
                break;
            case "delete":
                deletarAula(request, response);
                break;
            default:
                listarAulas(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            salvarAula(request, response);
        } else if ("update".equals(action)) {
            atualizarAula(request, response);
        }
    }

    private void listarAulas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aula> aulas = aulaDAO.listarTodos();
        request.setAttribute("aulas", aulas);
        request.getRequestDispatcher("/WEB-INF/views/aulas/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNovo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Curso> cursos = cursoDAO.listarTodos();
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/WEB-INF/views/aulas/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Aula aula = aulaDAO.buscarPorId(id);
        List<Curso> cursos = cursoDAO.listarTodos();
        request.setAttribute("aula", aula);
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/WEB-INF/views/aulas/form.jsp").forward(request, response);
    }

    private void salvarAula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String titulo = request.getParameter("titulo");
        String dataStr = request.getParameter("data");
        int duracao = Integer.parseInt(request.getParameter("duracao"));
        Long cursoId = Long.parseLong(request.getParameter("cursoId"));

        Curso curso = cursoDAO.buscarPorId(cursoId);
        LocalDate data = LocalDate.parse(dataStr);
        
        Aula aula = new Aula(titulo, data, duracao, curso);
        aulaDAO.salvar(aula);

        response.sendRedirect("aulas?action=list");
    }

    private void atualizarAula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String dataStr = request.getParameter("data");
        int duracao = Integer.parseInt(request.getParameter("duracao"));
        Long cursoId = Long.parseLong(request.getParameter("cursoId"));

        Aula aula = aulaDAO.buscarPorId(id);
        Curso curso = cursoDAO.buscarPorId(cursoId);
        
        aula.setTitulo(titulo);
        aula.setData(LocalDate.parse(dataStr));
        aula.setDuracao(duracao);
        aula.setCurso(curso);

        aulaDAO.atualizar(aula);

        response.sendRedirect("aulas?action=list");
    }

    private void deletarAula(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        aulaDAO.excluir(id);
        response.sendRedirect("aulas?action=list");
    }
}
