package com.sge.dao;

import com.sge.model.Presenca;

public class PresencaDAO extends GenericDAO<Presenca> {

    public PresencaDAO() {
        super(Presenca.class);
    }

    // Métodos específicos, se quiser, depois:
    // List<Presenca> buscarPorMatricula(Long matriculaId) { ... }
}
