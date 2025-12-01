package com.sge.controller;

import com.sge.dao.AlunoDAO;
import com.sge.model.Aluno;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/alunos")
public class AlunoServlet extends HttpServlet {
    
    private AlunoDAO alunoDAO = new AlunoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listarAlunos(request, response);
                break;
            case "new":
                mostrarFormularioNovo(request, response);
                break;
            case "edit":
                mostrarFormularioEdicao(request, response);
                break;
            case "delete":
                deletarAluno(request, response);
                break;
            default:
                listarAlunos(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            salvarAluno(request, response);
        } else if ("update".equals(action)) {
            atualizarAluno(request, response);
        }
    }

    private void listarAlunos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aluno> alunos = alunoDAO.listarTodos();
        request.setAttribute("alunos", alunos);
        request.getRequestDispatcher("/WEB-INF/views/alunos/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNovo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/alunos/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Aluno aluno = alunoDAO.buscarPorId(id);
        request.setAttribute("aluno", aluno);
        request.getRequestDispatcher("/WEB-INF/views/alunos/form.jsp").forward(request, response);
    }

    private void salvarAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nome = request.getParameter("nome");
        String matricula = request.getParameter("matricula");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");

        Aluno aluno = new Aluno(nome, matricula, email, telefone);
        alunoDAO.salvar(aluno);

        response.sendRedirect("alunos?action=list");
    }

    private void atualizarAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String matricula = request.getParameter("matricula");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");

        Aluno aluno = alunoDAO.buscarPorId(id);
        aluno.setNome(nome);
        aluno.setMatricula(matricula);
        aluno.setEmail(email);
        aluno.setTelefone(telefone);

        alunoDAO.atualizar(aluno);

        response.sendRedirect("alunos?action=list");
    }

    private void deletarAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        alunoDAO.excluir(id);
        response.sendRedirect("alunos?action=list");
    }
}
