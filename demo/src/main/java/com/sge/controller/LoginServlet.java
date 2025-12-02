package com.sge.controller;

import com.sge.dao.UsuarioDAO;
import com.sge.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Se já está logado, redireciona para o dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogado") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        // Mostra a página de login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String usuario = request.getParameter("usuario");
        String senha = request.getParameter("senha");
        
        // Validação básica
        if (usuario == null || usuario.trim().isEmpty() || 
            senha == null || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Usuário e senha são obrigatórios!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Tenta autenticar
        Optional<Usuario> usuarioOpt = usuarioDAO.autenticar(usuario.trim(), senha);
        
        if (usuarioOpt.isPresent()) {
            Usuario usuarioLogado = usuarioOpt.get();
            
            // Atualiza último acesso
            usuarioDAO.atualizarUltimoAcesso(usuarioLogado.getId());
            
            // Cria sessão e armazena dados do usuário
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioLogado", usuarioLogado);
            session.setAttribute("usuarioId", usuarioLogado.getId());
            session.setAttribute("usuarioNome", usuarioLogado.getNome());
            session.setAttribute("usuarioPerfil", usuarioLogado.getPerfil());
            session.setMaxInactiveInterval(30 * 60); // 30 minutos
            
            // Redireciona para o dashboard
            response.sendRedirect(request.getContextPath() + "/");
            
        } else {
            // Falha na autenticação
            request.setAttribute("erro", "Usuário ou senha inválidos!");
            request.setAttribute("usuario", usuario); // Mantém o usuário digitado
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
