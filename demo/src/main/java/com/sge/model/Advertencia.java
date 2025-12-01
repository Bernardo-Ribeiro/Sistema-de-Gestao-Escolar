package com.sge.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Advertencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "aluno_id")
    private Aluno aluno;

    private LocalDate data = LocalDate.now();

    private String motivo;

    @Column(length = 2000)
    private String observacoes;

    public Advertencia() {}

    public Advertencia(Aluno aluno, String motivo) {
        this.aluno = aluno;
        this.motivo = motivo;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Aluno getAluno() { return aluno; }
    public void setAluno(Aluno aluno) { this.aluno = aluno; }

    public LocalDate getData() { return data; }
    public void setData(LocalDate data) { this.data = data; }

    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }

    public String getObservacoes() { return observacoes; }
    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }
}
