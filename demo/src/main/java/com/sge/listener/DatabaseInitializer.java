package com.sge.listener;

import com.sge.dao.UsuarioDAO;
import com.sge.model.Usuario;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Listener que inicializa o banco de dados na primeira execução
 * Cria automaticamente os usuários padrão se não existirem
 */
@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("========================================");
        System.out.println("🚀 Inicializando Sistema EduGestão...");
        System.out.println("========================================");
        
        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            
            // Verificar se existem usuários
            long totalUsuarios = usuarioDAO.contar();
            
            if (totalUsuarios == 0) {
                System.out.println("⚙️  Nenhum usuário encontrado. Criando usuários padrão...");
                criarUsuariosPadrao(usuarioDAO);
                System.out.println("✅ Usuários padrão criados com sucesso!");
            } else {
                System.out.println("✅ Sistema já possui " + totalUsuarios + " usuário(s) cadastrado(s)");
            }
            
            // Listar usuários disponíveis
            System.out.println("\n📋 Usuários disponíveis para login:");
            usuarioDAO.listarTodos().forEach(usuario -> {
                System.out.println("   👤 " + usuario.getUsuario() + " (" + usuario.getPerfil() + ")");
            });
            
            System.out.println("\n========================================");
            System.out.println("🌐 Sistema pronto para uso!");
            System.out.println("🔗 Acesse: http://localhost:9090/sge/login");
            System.out.println("👤 Login padrão: admin / admin123");
            System.out.println("========================================\n");
            
        } catch (Exception e) {
            System.err.println("❌ ERRO ao inicializar banco de dados:");
            e.printStackTrace();
            System.err.println("\n⚠️  Verifique:");
            System.err.println("   1. MySQL está rodando?");
            System.err.println("   2. Banco 'sge' existe?");
            System.err.println("   3. Credenciais em hibernate.cfg.xml estão corretas?");
            System.err.println("   4. As tabelas foram criadas? (hbm2ddl.auto=update deve criar automaticamente)");
            System.err.println("\n💡 Dica: Acesse /setup-usuarios para criar manualmente");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🛑 Encerrando Sistema EduGestão...");
    }

    /**
     * Cria os usuários padrão do sistema
     */
    private void criarUsuariosPadrao(UsuarioDAO usuarioDAO) {
        try {
            // Usuário Admin
            if (!usuarioDAO.existeUsuario("admin")) {
                Usuario admin = new Usuario(
                    "admin", 
                    "admin123", 
                    "Administrador do Sistema", 
                    "admin@edugestao.com", 
                    "ADMIN"
                );
                usuarioDAO.salvar(admin);
                System.out.println("   ✓ Admin criado - Login: admin / Senha: admin123");
            }
            
            // Usuário Coordenador
            if (!usuarioDAO.existeUsuario("coordenador")) {
                Usuario coordenador = new Usuario(
                    "coordenador", 
                    "coord123", 
                    "Coordenador Pedagógico", 
                    "coordenador@edugestao.com", 
                    "COORDENADOR"
                );
                usuarioDAO.salvar(coordenador);
                System.out.println("   ✓ Coordenador criado - Login: coordenador / Senha: coord123");
            }
            
            // Usuário Secretaria
            if (!usuarioDAO.existeUsuario("secretaria")) {
                Usuario secretaria = new Usuario(
                    "secretaria", 
                    "sec123", 
                    "Secretária Escolar", 
                    "secretaria@edugestao.com", 
                    "SECRETARIA"
                );
                usuarioDAO.salvar(secretaria);
                System.out.println("   ✓ Secretaria criado - Login: secretaria / Senha: sec123");
            }
            
            // Usuário Professor (demo)
            if (!usuarioDAO.existeUsuario("professor")) {
                Usuario professor = new Usuario(
                    "professor", 
                    "prof123", 
                    "Professor Demo", 
                    "professor@edugestao.com", 
                    "PROFESSOR"
                );
                usuarioDAO.salvar(professor);
                System.out.println("   ✓ Professor criado - Login: professor / Senha: prof123");
            }
            
        } catch (Exception e) {
            System.err.println("   ✗ Erro ao criar usuários: " + e.getMessage());
            throw e;
        }
    }
}
