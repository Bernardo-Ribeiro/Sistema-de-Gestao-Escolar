<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestão Escolar</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Sistema de Gestão Escolar</h1>
            <p>Bem-vindo ao SGE - Sistema de Gestão Escolar</p>
        </header>

        <nav class="menu">
            <div class="menu-item">
                <h2>Alunos</h2>
                <a href="alunos?action=list" class="btn">Listar Alunos</a>
                <a href="alunos?action=new" class="btn btn-success">Novo Aluno</a>
            </div>
            
            <div class="menu-item">
                <h2>Cursos</h2>
                <a href="cursos?action=list" class="btn">Listar Cursos</a>
                <a href="cursos?action=new" class="btn btn-success">Novo Curso</a>
            </div>
            
            <div class="menu-item">
                <h2>Matrículas</h2>
                <a href="matriculas?action=list" class="btn">Listar Matrículas</a>
                <a href="matriculas?action=new" class="btn btn-success">Nova Matrícula</a>
            </div>
            
            <div class="menu-item">
                <h2>Presenças</h2>
                <a href="presencas?action=list" class="btn">Registrar Presença</a>
            </div>
            
            <div class="menu-item">
                <h2>Advertências</h2>
                <a href="advertencias?action=list" class="btn">Listar Advertências</a>
                <a href="advertencias?action=new" class="btn btn-warning">Nova Advertência</a>
            </div>
        </nav>
    </div>
</body>
</html>
