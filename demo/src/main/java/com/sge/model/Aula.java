package com.sge.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Aula {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;
    private LocalDate data;
    private int duracao;

    @ManyToOne // N:1 com Curso 
    @JoinColumn(name = "curso_id")
    private Curso curso;

    public Aula() {}

    public Aula(String titulo, LocalDate data, int duracao, Curso curso) {
        this.titulo = titulo;
        this.data = data;
        this.duracao = duracao;
        this.curso = curso;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        this.duracao = duracao;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }
}