package com.sge.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Matricula {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "aluno_id")
    private Aluno aluno;

    @ManyToOne(optional = false)
    @JoinColumn(name = "curso_id")
    private Curso curso;

    @Column(name = "data_matricula")
    private LocalDate dataMatricula = LocalDate.now();

    @Column(name = "nota_final")
    private Double notaFinal;

    private Double frequencia; // porcentagem (0-100)

    private String situacao; // CURSANDO, APROVADO, REPROVADO

    @OneToMany(mappedBy = "matricula", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Presenca> presencas = new ArrayList<>();

    public Matricula() {}

    public Matricula(Aluno aluno, Curso curso) {
        this.aluno = aluno;
        this.curso = curso;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Aluno getAluno() { return aluno; }
    public void setAluno(Aluno aluno) { this.aluno = aluno; }

    public Curso getCurso() { return curso; }
    public void setCurso(Curso curso) { this.curso = curso; }

    public LocalDate getDataMatricula() { return dataMatricula; }
    public void setDataMatricula(LocalDate dataMatricula) { this.dataMatricula = dataMatricula; }

    public Double getNotaFinal() { return notaFinal; }
    public void setNotaFinal(Double notaFinal) { this.notaFinal = notaFinal; }

    public Double getFrequencia() { return frequencia; }
    public void setFrequencia(Double frequencia) { this.frequencia = frequencia; }

    public String getSituacao() { return situacao; }
    public void setSituacao(String situacao) { this.situacao = situacao; }

    public List<Presenca> getPresencas() { return presencas; }
    public void setPresencas(List<Presenca> presencas) { this.presencas = presencas; }
}
