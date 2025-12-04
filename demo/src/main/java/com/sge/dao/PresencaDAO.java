package com.sge.dao;

import com.sge.model.Presenca;
import com.sge.util.HibernateUtil;
import org.hibernate.Session;
import java.util.List;

public class PresencaDAO extends GenericDAO<Presenca> {

    public PresencaDAO() {
        super(Presenca.class);
    }

    // Buscar presenças por matrícula
    public List<Presenca> buscarPorMatricula(Long matriculaId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Presenca p WHERE p.matricula.id = :matriculaId";
            return session.createQuery(hql, Presenca.class)
                         .setParameter("matriculaId", matriculaId)
                         .list();
        }
    }
    
    // Buscar presenças por aula
    public List<Presenca> buscarPorAula(Long aulaId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Presenca p WHERE p.aula.id = :aulaId";
            return session.createQuery(hql, Presenca.class)
                         .setParameter("aulaId", aulaId)
                         .list();
        }
    }
    
    // Verificar se já existe registro de presença
    public boolean existeRegistro(Long matriculaId, Long aulaId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(p) FROM Presenca p WHERE p.matricula.id = :matriculaId AND p.aula.id = :aulaId";
            Long count = session.createQuery(hql, Long.class)
                               .setParameter("matriculaId", matriculaId)
                               .setParameter("aulaId", aulaId)
                               .uniqueResult();
            return count > 0;
        }
    }
}
