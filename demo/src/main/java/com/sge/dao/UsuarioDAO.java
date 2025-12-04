package com.sge.dao;

import com.sge.model.Usuario;
import com.sge.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDateTime;
import java.util.Optional;

public class UsuarioDAO extends GenericDAO<Usuario> {
    
    public UsuarioDAO() {
        super(Usuario.class);
    }

    /**
     * Busca um usuário pelo nome de usuário
     */
    public Optional<Usuario> buscarPorUsuario(String usuario) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Usuario u WHERE u.usuario = :usuario";
            Query<Usuario> query = session.createQuery(hql, Usuario.class);
            query.setParameter("usuario", usuario);
            return query.uniqueResultOptional();
        }
    }

    /**
     * Autentica um usuário verificando credenciais
     */
    public Optional<Usuario> autenticar(String usuario, String senha) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Usuario u WHERE u.usuario = :usuario AND u.senha = :senha AND u.ativo = true";
            Query<Usuario> query = session.createQuery(hql, Usuario.class);
            query.setParameter("usuario", usuario);
            query.setParameter("senha", senha);
            return query.uniqueResultOptional();
        }
    }

    /**
     * Verifica se o usuário existe
     */
    public boolean existeUsuario(String usuario) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(u) FROM Usuario u WHERE u.usuario = :usuario";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("usuario", usuario);
            return query.uniqueResult() > 0;
        }
    }

    /**
     * Atualiza o último acesso do usuário
     */
    public void atualizarUltimoAcesso(Long usuarioId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Usuario usuario = session.find(Usuario.class, usuarioId);
            if (usuario != null) {
                usuario.setUltimoAcesso(LocalDateTime.now());
                session.merge(usuario);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    /**
     * Altera a senha do usuário
     */
    public boolean alterarSenha(Long usuarioId, String senhaAtual, String novaSenha) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Usuario usuario = session.find(Usuario.class, usuarioId);
            
            if (usuario != null && usuario.getSenha().equals(senhaAtual)) {
                usuario.setSenha(novaSenha);
                session.merge(usuario);
                transaction.commit();
                return true;
            }
            
            if (transaction != null) transaction.rollback();
            return false;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
}
