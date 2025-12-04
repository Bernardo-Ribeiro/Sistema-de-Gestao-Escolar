package com.sge.dao;

import com.sge.model.Matricula;
import com.sge.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Hibernate;
import java.util.List;

public class MatriculaDAO extends GenericDAO<Matricula> {
    public MatriculaDAO() {
        super(Matricula.class);
    }
    
    // Busca matrícula com presenças carregadas
    public Matricula buscarComPresencas(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Matricula matricula = session.find(Matricula.class, id);
            if (matricula != null) {
                Hibernate.initialize(matricula.getPresencas());
            }
            return matricula;
        }
    }
    
    // Buscar matrículas por curso
    public List<Matricula> buscarPorCurso(Long cursoId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Matricula m WHERE m.curso.id = :cursoId";
            return session.createQuery(hql, Matricula.class)
                         .setParameter("cursoId", cursoId)
                         .list();
        }
    }
    
    // Buscar matrículas por aluno
    public List<Matricula> buscarPorAluno(Long alunoId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Matricula m WHERE m.aluno.id = :alunoId";
            return session.createQuery(hql, Matricula.class)
                         .setParameter("alunoId", alunoId)
                         .list();
        }
    }
}
