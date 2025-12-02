package com.sge.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory;

    static {
        try {
            // Carrega as configurações do arquivo hibernate.cfg.xml
            Configuration configuration = new Configuration().configure();
            configuration.addAnnotatedClass(com.sge.model.Aluno.class);
            configuration.addAnnotatedClass(com.sge.model.Curso.class);
            configuration.addAnnotatedClass(com.sge.model.Aula.class);
            configuration.addAnnotatedClass(com.sge.model.Matricula.class);
            configuration.addAnnotatedClass(com.sge.model.Presenca.class);
            configuration.addAnnotatedClass(com.sge.model.Advertencia.class);
            configuration.addAnnotatedClass(com.sge.model.Usuario.class);
            sessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Falha na criação do SessionFactory." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}