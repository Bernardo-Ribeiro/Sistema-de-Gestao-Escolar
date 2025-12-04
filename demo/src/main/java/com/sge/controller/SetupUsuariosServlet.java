package com.sge.controller;

import com.sge.dao.UsuarioDAO;
import com.sge.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet auxiliar para criar usuários iniciais
 * ATENÇÃO: Remover ou proteger em produção!
 * 
 * Acesse: http://localhost:8080/demo/setup-usuarios
 */
@WebServlet("/setup-usuarios")
public class SetupUsuariosServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html lang='pt-BR'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Setup de Usuários - EduGestão</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }");
        out.println("h1 { color: #4CAF50; }");
        out.println(".success { background: #d4edda; padding: 10px; border-radius: 5px; margin: 10px 0; }");
        out.println(".error { background: #f8d7da; padding: 10px; border-radius: 5px; margin: 10px 0; }");
        out.println(".info { background: #d1ecf1; padding: 10px; border-radius: 5px; margin: 10px 0; }");
        out.println("table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
        out.println("th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }");
        out.println("th { background: #4CAF50; color: white; }");
        out.println(".btn { background: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; ");
        out.println("border-radius: 5px; display: inline-block; margin: 10px 5px; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        out.println("<h1>🔧 Setup de Usuários - EduGestão</h1>");
        out.println("<div class='info'><strong>⚠️ ATENÇÃO:</strong> Esta página deve ser removida ou protegida em produção!</div>");
        
        try {
            // Verifica se já existem usuários
            long totalUsuarios = usuarioDAO.contar();
            
            if (totalUsuarios > 0) {
                out.println("<div class='info'>✓ Sistema já possui " + totalUsuarios + " usuário(s) cadastrado(s).</div>");
            } else {
                out.println("<h2>Criando Usuários Padrão...</h2>");
                
                // Criar usuário Admin
                if (!usuarioDAO.existeUsuario("admin")) {
                    Usuario admin = new Usuario("admin", "admin123", "Administrador do Sistema", 
                                              "admin@edugestao.com", "ADMIN");
                    usuarioDAO.salvar(admin);
                    out.println("<div class='success'>✓ Usuário 'admin' criado com sucesso!</div>");
                }
                
                // Criar usuário Coordenador
                if (!usuarioDAO.existeUsuario("coordenador")) {
                    Usuario coordenador = new Usuario("coordenador", "123456", "Coordenador Pedagógico", 
                                                     "coordenador@edugestao.com", "COORDENADOR");
                    usuarioDAO.salvar(coordenador);
                    out.println("<div class='success'>✓ Usuário 'coordenador' criado com sucesso!</div>");
                }
                
                // Criar usuário Secretaria
                if (!usuarioDAO.existeUsuario("secretaria")) {
                    Usuario secretaria = new Usuario("secretaria", "123456", "Secretária Escolar", 
                                                    "secretaria@edugestao.com", "SECRETARIA");
                    usuarioDAO.salvar(secretaria);
                    out.println("<div class='success'>✓ Usuário 'secretaria' criado com sucesso!</div>");
                }
            }
            
            // Listar todos os usuários
            out.println("<h2>Usuários Cadastrados:</h2>");
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Usuário</th><th>Nome</th><th>Email</th><th>Perfil</th><th>Ativo</th></tr>");
            
            usuarioDAO.listarTodos().forEach(usuario -> {
                out.println("<tr>");
                out.println("<td>" + usuario.getId() + "</td>");
                out.println("<td><strong>" + usuario.getUsuario() + "</strong></td>");
                out.println("<td>" + usuario.getNome() + "</td>");
                out.println("<td>" + usuario.getEmail() + "</td>");
                out.println("<td>" + usuario.getPerfil() + "</td>");
                out.println("<td>" + (usuario.getAtivo() ? "✓ Sim" : "✗ Não") + "</td>");
                out.println("</tr>");
            });
            
            out.println("</table>");
            
            out.println("<h2>Credenciais para Teste:</h2>");
            out.println("<table>");
            out.println("<tr><th>Usuário</th><th>Senha</th><th>Perfil</th></tr>");
            out.println("<tr><td>admin</td><td>admin123</td><td>ADMIN</td></tr>");
            out.println("<tr><td>coordenador</td><td>123456</td><td>COORDENADOR</td></tr>");
            out.println("<tr><td>secretaria</td><td>123456</td><td>SECRETARIA</td></tr>");
            out.println("</table>");
            
        } catch (Exception e) {
            out.println("<div class='error'><strong>✗ Erro:</strong> " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
        
        out.println("<div style='margin-top: 30px;'>");
        out.println("<a href='" + request.getContextPath() + "/login' class='btn'>🔐 Ir para Login</a>");
        out.println("<a href='" + request.getContextPath() + "/' class='btn'>🏠 Ir para Dashboard</a>");
        out.println("</div>");
        
        out.println("<div style='margin-top: 30px; padding: 15px; background: #fff3cd; border-radius: 5px;'>");
        out.println("<strong>⚠️ SEGURANÇA:</strong> ");
        out.println("<ul>");
        out.println("<li>As senhas estão em texto simples apenas para desenvolvimento</li>");
        out.println("<li>Em produção, use criptografia (BCrypt, PBKDF2)</li>");
        out.println("<li>Remova ou proteja esta página em produção</li>");
        out.println("<li>Implemente validação de senha forte</li>");
        out.println("</ul>");
        out.println("</div>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
