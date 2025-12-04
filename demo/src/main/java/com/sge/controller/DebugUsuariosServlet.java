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
import java.util.List;

/**
 * Servlet para diagnosticar problemas de autenticação
 * Acesse: http://localhost:8080/demo/debug-usuarios
 * 
 * ATENÇÃO: REMOVER EM PRODUÇÃO!
 */
@WebServlet("/debug-usuarios")
public class DebugUsuariosServlet extends HttpServlet {
    
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
        out.println("<title>Debug Usuários - EduGestão</title>");
        out.println("<style>");
        out.println("body { font-family: 'Courier New', monospace; padding: 20px; background: #1e1e1e; color: #d4d4d4; }");
        out.println("h1 { color: #4CAF50; }");
        out.println("h2 { color: #2196F3; margin-top: 30px; }");
        out.println(".success { background: #1a5928; padding: 10px; border-left: 4px solid #4CAF50; margin: 10px 0; }");
        out.println(".error { background: #5e1414; padding: 10px; border-left: 4px solid #f44336; margin: 10px 0; }");
        out.println(".info { background: #1a3a52; padding: 10px; border-left: 4px solid #2196F3; margin: 10px 0; }");
        out.println(".warning { background: #5e4a14; padding: 10px; border-left: 4px solid #ff9800; margin: 10px 0; }");
        out.println("table { width: 100%; border-collapse: collapse; margin: 20px 0; background: #2d2d2d; }");
        out.println("th, td { border: 1px solid #444; padding: 12px; text-align: left; }");
        out.println("th { background: #4CAF50; color: white; }");
        out.println("code { background: #2d2d2d; padding: 2px 6px; color: #ce9178; border-radius: 3px; }");
        out.println(".test-form { background: #2d2d2d; padding: 20px; margin: 20px 0; border-radius: 5px; }");
        out.println("input { padding: 8px; margin: 5px; background: #3c3c3c; border: 1px solid #555; color: #d4d4d4; }");
        out.println("button { padding: 10px 20px; background: #4CAF50; color: white; border: none; cursor: pointer; }");
        out.println("button:hover { background: #45a049; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        out.println("<h1>🔍 Debug de Usuários - Sistema de Autenticação</h1>");
        out.println("<div class='warning'><strong>⚠️ ATENÇÃO:</strong> Esta página contém informações sensíveis. Remova em produção!</div>");
        
        try {
            // 1. Verificar conexão com o banco
            out.println("<h2>1️⃣ Verificação de Conexão</h2>");
            try {
                long total = usuarioDAO.contar();
                out.println("<div class='success'>✓ Conexão com banco de dados OK</div>");
                out.println("<div class='info'>📊 Total de usuários cadastrados: <strong>" + total + "</strong></div>");
            } catch (Exception e) {
                out.println("<div class='error'>✗ ERRO na conexão com banco de dados:<br>" + e.getMessage() + "</div>");
                e.printStackTrace();
            }
            
            // 2. Listar todos os usuários
            out.println("<h2>2️⃣ Usuários Cadastrados</h2>");
            List<Usuario> usuarios = usuarioDAO.listarTodos();
            
            if (usuarios.isEmpty()) {
                out.println("<div class='warning'>⚠️ NENHUM usuário cadastrado! Execute o setup primeiro.</div>");
                out.println("<p><a href='" + request.getContextPath() + "/setup-usuarios' style='color: #4CAF50;'>→ Ir para Setup de Usuários</a></p>");
            } else {
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>ID</th>");
                out.println("<th>Usuário</th>");
                out.println("<th>Senha (Raw)</th>");
                out.println("<th>Nome</th>");
                out.println("<th>Email</th>");
                out.println("<th>Perfil</th>");
                out.println("<th>Ativo</th>");
                out.println("</tr>");
                
                for (Usuario u : usuarios) {
                    out.println("<tr>");
                    out.println("<td>" + u.getId() + "</td>");
                    out.println("<td><code>" + u.getUsuario() + "</code></td>");
                    out.println("<td><code>" + u.getSenha() + "</code></td>");
                    out.println("<td>" + u.getNome() + "</td>");
                    out.println("<td>" + (u.getEmail() != null ? u.getEmail() : "-") + "</td>");
                    out.println("<td>" + (u.getPerfil() != null ? u.getPerfil() : "-") + "</td>");
                    out.println("<td>" + (u.getAtivo() ? "✓ Sim" : "✗ Não") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
            // 3. Teste de autenticação
            out.println("<h2>3️⃣ Testar Autenticação</h2>");
            out.println("<div class='test-form'>");
            out.println("<form method='post' action='" + request.getContextPath() + "/debug-usuarios'>");
            out.println("<label>Usuário:</label><br>");
            out.println("<input type='text' name='testUsuario' placeholder='admin' required><br><br>");
            out.println("<label>Senha:</label><br>");
            out.println("<input type='password' name='testSenha' placeholder='admin123' required><br><br>");
            out.println("<button type='submit'>🔍 Testar Login</button>");
            out.println("</form>");
            out.println("</div>");
            
            // 4. Dicas de solução
            out.println("<h2>4️⃣ Soluções Comuns</h2>");
            out.println("<div class='info'>");
            out.println("<strong>Se o login não funciona, verifique:</strong><br><br>");
            out.println("1️⃣ <strong>Tabela usuario existe?</strong><br>");
            out.println("   → Execute: <code>SHOW TABLES;</code> no MySQL<br><br>");
            out.println("2️⃣ <strong>Há usuários cadastrados?</strong><br>");
            out.println("   → Execute: <code>SELECT * FROM usuario;</code><br><br>");
            out.println("3️⃣ <strong>Senhas corretas?</strong><br>");
            out.println("   → Compare a senha digitada com a senha na tabela acima<br><br>");
            out.println("4️⃣ <strong>Usuário está ativo?</strong><br>");
            out.println("   → Coluna 'ativo' deve estar como TRUE<br><br>");
            out.println("5️⃣ <strong>Espaços em branco?</strong><br>");
            out.println("   → Certifique-se que não há espaços antes/depois da senha<br>");
            out.println("</div>");
            
        } catch (Exception e) {
            out.println("<div class='error'><strong>✗ Erro fatal:</strong><br><pre>");
            e.printStackTrace(out);
            out.println("</pre></div>");
        }
        
        out.println("<div style='margin-top: 30px;'>");
        out.println("<a href='" + request.getContextPath() + "/login' style='color: #4CAF50;'>🔐 Voltar para Login</a> | ");
        out.println("<a href='" + request.getContextPath() + "/setup-usuarios' style='color: #4CAF50;'>⚙️ Setup Usuários</a>");
        out.println("</div>");
        
        out.println("</body>");
        out.println("</html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String testUsuario = request.getParameter("testUsuario");
        String testSenha = request.getParameter("testSenha");
        
        out.println("<!DOCTYPE html>");
        out.println("<html lang='pt-BR'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Resultado do Teste - Debug</title>");
        out.println("<style>");
        out.println("body { font-family: 'Courier New', monospace; padding: 20px; background: #1e1e1e; color: #d4d4d4; }");
        out.println("h1 { color: #4CAF50; }");
        out.println(".success { background: #1a5928; padding: 15px; border-left: 4px solid #4CAF50; margin: 10px 0; }");
        out.println(".error { background: #5e1414; padding: 15px; border-left: 4px solid #f44336; margin: 10px 0; }");
        out.println(".info { background: #1a3a52; padding: 15px; border-left: 4px solid #2196F3; margin: 10px 0; }");
        out.println("code { background: #2d2d2d; padding: 2px 6px; color: #ce9178; }");
        out.println("pre { background: #2d2d2d; padding: 10px; overflow: auto; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        out.println("<h1>🧪 Resultado do Teste de Autenticação</h1>");
        
        out.println("<div class='info'>");
        out.println("<strong>Dados enviados:</strong><br>");
        out.println("Usuário: <code>" + testUsuario + "</code><br>");
        out.println("Senha: <code>" + testSenha + "</code><br>");
        out.println("Tamanho senha: " + testSenha.length() + " caracteres");
        out.println("</div>");
        
        try {
            // Teste 1: Buscar usuário
            out.println("<h2>Teste 1: Buscar Usuário</h2>");
            var usuarioOpt = usuarioDAO.buscarPorUsuario(testUsuario);
            
            if (usuarioOpt.isPresent()) {
                Usuario u = usuarioOpt.get();
                out.println("<div class='success'>✓ Usuário encontrado no banco!</div>");
                out.println("<div class='info'>");
                out.println("<strong>Dados do usuário:</strong><br>");
                out.println("ID: " + u.getId() + "<br>");
                out.println("Usuário: <code>" + u.getUsuario() + "</code><br>");
                out.println("Senha no banco: <code>" + u.getSenha() + "</code><br>");
                out.println("Senha digitada: <code>" + testSenha + "</code><br>");
                out.println("Senhas iguais? " + (u.getSenha().equals(testSenha) ? "<span style='color: #4CAF50;'>✓ SIM</span>" : "<span style='color: #f44336;'>✗ NÃO</span>") + "<br>");
                out.println("Ativo? " + (u.getAtivo() ? "✓ Sim" : "✗ Não"));
                out.println("</div>");
            } else {
                out.println("<div class='error'>✗ Usuário NÃO encontrado no banco!</div>");
                out.println("<div class='info'>Usuários disponíveis: ");
                usuarioDAO.listarTodos().forEach(u -> out.print("<code>" + u.getUsuario() + "</code> "));
                out.println("</div>");
            }
            
            // Teste 2: Autenticar
            out.println("<h2>Teste 2: Autenticação</h2>");
            var authOpt = usuarioDAO.autenticar(testUsuario, testSenha);
            
            if (authOpt.isPresent()) {
                Usuario u = authOpt.get();
                out.println("<div class='success'>");
                out.println("✓ ✓ ✓ AUTENTICAÇÃO BEM-SUCEDIDA! ✓ ✓ ✓<br><br>");
                out.println("<strong>Usuário autenticado:</strong><br>");
                out.println("Nome: " + u.getNome() + "<br>");
                out.println("Perfil: " + u.getPerfil());
                out.println("</div>");
                out.println("<p><a href='" + request.getContextPath() + "/login' style='color: #4CAF50; font-size: 18px;'>→ Ir para Login e testar!</a></p>");
            } else {
                out.println("<div class='error'>");
                out.println("✗ ✗ ✗ AUTENTICAÇÃO FALHOU! ✗ ✗ ✗<br><br>");
                out.println("<strong>Possíveis causas:</strong><br>");
                out.println("1. Senha incorreta (compare acima)<br>");
                out.println("2. Usuário inativo<br>");
                out.println("3. Espaços em branco na senha<br>");
                out.println("4. Problema com encoding de caracteres");
                out.println("</div>");
            }
            
        } catch (Exception e) {
            out.println("<div class='error'><strong>Erro:</strong><br><pre>");
            e.printStackTrace(out);
            out.println("</pre></div>");
        }
        
        out.println("<br><br>");
        out.println("<a href='" + request.getContextPath() + "/debug-usuarios' style='color: #4CAF50;'>← Voltar para Debug</a>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
