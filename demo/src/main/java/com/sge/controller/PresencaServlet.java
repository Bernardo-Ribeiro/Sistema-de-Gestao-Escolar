package com.sge.controller;

import com.sge.dao.PresencaDAO;
import com.sge.dao.MatriculaDAO;
import com.sge.dao.AulaDAO;
import com.sge.model.Presenca;
import com.sge.model.Matricula;
import com.sge.model.Aula;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/presencas")
public class PresencaServlet extends HttpServlet {
    
    private PresencaDAO presencaDAO = new PresencaDAO();
    private MatriculaDAO matriculaDAO = new MatriculaDAO();
    private AulaDAO aulaDAO = new AulaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listarPresencas(request, response);
                break;
            case "registrar":
                mostrarFormularioRegistro(request, response);
                break;
            case "delete":
                deletarPresenca(request, response);
                break;
            default:
                listarPresencas(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            salvarPresenca(request, response);
        } else if ("registrarLote".equals(action)) {
            registrarPresencasEmLote(request, response);
        }
    }

    private void listarPresencas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Presenca> presencas = presencaDAO.listarTodos();
        request.setAttribute("presencas", presencas);
        request.getRequestDispatcher("/WEB-INF/views/presencas/list.jsp").forward(request, response);
    }

    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String aulaIdStr = request.getParameter("aulaId");
        
        if (aulaIdStr != null) {
            Long aulaId = Long.parseLong(aulaIdStr);
            Aula aula = aulaDAO.buscarPorId(aulaId);
            List<Matricula> matriculas = matriculaDAO.buscarPorCurso(aula.getCurso().getId());
            request.setAttribute("aula", aula);
            request.setAttribute("matriculas", matriculas);
        } else {
            List<Aula> aulas = aulaDAO.listarTodos();
            request.setAttribute("aulas", aulas);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/presencas/registrar.jsp").forward(request, response);
    }

    private void salvarPresenca(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long matriculaId = Long.parseLong(request.getParameter("matriculaId"));
        Long aulaId = Long.parseLong(request.getParameter("aulaId"));
        boolean presente = Boolean.parseBoolean(request.getParameter("presente"));

        Matricula matricula = matriculaDAO.buscarPorId(matriculaId);
        Aula aula = aulaDAO.buscarPorId(aulaId);
        
        Presenca presenca = new Presenca(matricula, aula, presente);
        presencaDAO.salvar(presenca);

        response.sendRedirect("presencas?action=list");
    }

    private void registrarPresencasEmLote(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long aulaId = Long.parseLong(request.getParameter("aulaId"));
        Aula aula = aulaDAO.buscarPorId(aulaId);
        
        String[] matriculaIds = request.getParameterValues("matriculaIds");
        
        if (matriculaIds != null) {
            for (String matriculaIdStr : matriculaIds) {
                Long matriculaId = Long.parseLong(matriculaIdStr);
                Matricula matricula = matriculaDAO.buscarPorId(matriculaId);
                
                // Verifica se já existe registro para não duplicar
                if (!presencaDAO.existeRegistro(matriculaId, aulaId)) {
                    Presenca presenca = new Presenca(matricula, aula, true);
                    presencaDAO.salvar(presenca);
                }
            }
        }

        response.sendRedirect("presencas?action=list");
    }

    private void deletarPresenca(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        presencaDAO.excluir(id);
        response.sendRedirect("presencas?action=list");
    }
}
