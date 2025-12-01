package com.sge.dao;

import com.sge.model.Matricula;
import com.sge.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Hibernate;

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
}
