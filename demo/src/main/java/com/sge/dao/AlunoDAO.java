package com.sge.dao;
import com.sge.model.Aluno;
import com.sge.util.HibernateUtil;
import org.hibernate.Session;
import java.util.List;

public class AlunoDAO extends GenericDAO<Aluno> {
    public AlunoDAO() {
        super(Aluno.class);
    }
    
    // Buscar últimos alunos cadastrados
    public List<Aluno> buscarUltimos(int limit) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Aluno a ORDER BY a.id DESC";
            return session.createQuery(hql, Aluno.class)
                         .setMaxResults(limit)
                         .list();
        }
    }
}