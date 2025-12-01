package com.sge.model;

import jakarta.persistence.*;

@Entity
public class Presenca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "matricula_id")
    private Matricula matricula;

    @ManyToOne(optional = false)
    @JoinColumn(name = "aula_id")
    private Aula aula;

    private boolean presente;

    public Presenca() {}

    public Presenca(Matricula matricula, Aula aula, boolean presente) {
        this.matricula = matricula;
        this.aula = aula;
        this.presente = presente;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Matricula getMatricula() {
        return matricula;
    }

    public void setMatricula(Matricula matricula) {
        this.matricula = matricula;
    }

    public Aula getAula() {
        return aula;
    }

    public void setAula(Aula aula) {
        this.aula = aula;
    }

    public boolean isPresente() {
        return presente;
    }

    public void setPresente(boolean presente) {
        this.presente = presente;
    }
}