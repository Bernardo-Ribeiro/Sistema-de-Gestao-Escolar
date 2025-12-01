package com.sge.dao;
import com.sge.model.Aluno;

public class AlunoDAO extends GenericDAO<Aluno> {
    public AlunoDAO() {
        super(Aluno.class);
    }
    
    // Aqui você pode adicionar métodos específicos futuramente
    // Ex: buscarPorMatricula(String matricula)
}