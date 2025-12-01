<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SGE - Sistema de Gestão Escolar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 SGE - Sistema de Gestão Escolar</a>
        <ul class="navbar-menu">
            <li><a href="${pageContext.request.contextPath}/">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/alunos?action=list">Alunos</a></li>
            <li><a href="${pageContext.request.contextPath}/cursos?action=list">Cursos</a></li>
            <li><a href="${pageContext.request.contextPath}/matriculas?action=list">Matrículas</a></li>
        </ul>
    </nav>

    <div class="container">
        <!-- Dashboard Stats -->
        <div class="card">
            <div class="card-header">
                <h1 class="card-title">Dashboard - Visão Geral</h1>
            </div>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-icon">👨‍🎓</div>
                    <div class="stat-card-value">0</div>
                    <div class="stat-card-label">Alunos Matriculados</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">📖</div>
                    <div class="stat-card-value">0</div>
                    <div class="stat-card-label">Cursos Ativos</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">✅</div>
                    <div class="stat-card-value">0</div>
                    <div class="stat-card-label">Matrículas</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">⚠️</div>
                    <div class="stat-card-value">0</div>
                    <div class="stat-card-label">Advertências</div>
                </div>
            </div>
        </div>

        <!-- Ações Rápidas -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Ações Rápidas</h2>
            </div>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-icon">➕</div>
                    <h3 style="margin-bottom: 1rem;">Novo Aluno</h3>
                    <a href="${pageContext.request.contextPath}/alunos?action=new" class="btn btn-primary btn-sm">Cadastrar Aluno</a>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">➕</div>
                    <h3 style="margin-bottom: 1rem;">Novo Curso</h3>
                    <a href="${pageContext.request.contextPath}/cursos?action=new" class="btn btn-secondary btn-sm">Cadastrar Curso</a>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">📝</div>
                    <h3 style="margin-bottom: 1rem;">Nova Matrícula</h3>
                    <a href="${pageContext.request.contextPath}/matriculas?action=new" class="btn btn-primary btn-sm">Matricular Aluno</a>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-icon">📋</div>
                    <h3 style="margin-bottom: 1rem;">Relatórios</h3>
                    <a href="${pageContext.request.contextPath}/relatorios" class="btn btn-outline btn-sm">Ver Relatórios</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
