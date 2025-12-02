package com.sge.controller;

import com.sge.dao.AlunoDAO;
import com.sge.dao.CursoDAO;
import com.sge.dao.MatriculaDAO;
import com.sge.dao.AdvertenciaDAO;
import com.sge.model.Aluno;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/dashboard"})
public class DashboardServlet extends HttpServlet {
    
    private AlunoDAO alunoDAO = new AlunoDAO();
    private CursoDAO cursoDAO = new CursoDAO();
    private MatriculaDAO matriculaDAO = new MatriculaDAO();
    private AdvertenciaDAO advertenciaDAO = new AdvertenciaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Buscar estatísticas reais do banco de dados
            long totalAlunos = alunoDAO.contar();
            long totalCursos = cursoDAO.contar();
            long totalMatriculas = matriculaDAO.contar();
            long totalAdvertencias = advertenciaDAO.contar();
            
            // Buscar últimos alunos cadastrados para mostrar atividades recentes
            List<Aluno> ultimosAlunos = alunoDAO.buscarUltimos(5);
            
            // Passar os dados para a JSP
            request.setAttribute("totalAlunos", totalAlunos);
            request.setAttribute("totalCursos", totalCursos);
            request.setAttribute("totalMatriculas", totalMatriculas);
            request.setAttribute("totalAdvertencias", totalAdvertencias);
            request.setAttribute("ultimosAlunos", ultimosAlunos);
            
            // Encaminhar para a página JSP
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Em caso de erro, enviar valores zerados
            request.setAttribute("totalAlunos", 0L);
            request.setAttribute("totalCursos", 0L);
            request.setAttribute("totalMatriculas", 0L);
            request.setAttribute("totalAdvertencias", 0L);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
