<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduGestão - Painel Principal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <div class="logo-icon-small">🎓</div>
                <h2 class="sidebar-title">EduGestão</h2>
            </div>
            <button class="sidebar-toggle">☰</button>
        </div>

        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="menu-item active">
                <span class="menu-icon">📊</span>
                <span class="menu-text">Menu Principal</span>
            </a>
            <a href="${pageContext.request.contextPath}/alunos?action=list" class="menu-item">
                <span class="menu-icon">👨‍🎓</span>
                <span class="menu-text">Alunos</span>
            </a>
            <a href="${pageContext.request.contextPath}/cursos?action=list" class="menu-item">
                <span class="menu-icon">📚</span>
                <span class="menu-text">Cursos</span>
            </a>
            <a href="${pageContext.request.contextPath}/aulas?action=list" class="menu-item">
                <span class="menu-icon">📖</span>
                <span class="menu-text">Aulas</span>
            </a>
            <a href="${pageContext.request.contextPath}/matriculas?action=list" class="menu-item">
                <span class="menu-icon">✅</span>
                <span class="menu-text">Matrículas</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/login.jsp" class="menu-item">
                <span class="menu-icon">🚪</span>
                <span class="menu-text">Sair</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-brand">
                <div class="logo-icon-small">🎓</div>
                <h1 class="header-title">EduGestão</h1>
            </div>
            <div class="header-user">
                <img src="https://ui-avatars.com/api/?name=John&background=0ea5e9&color=fff" alt="User" class="user-avatar">
            </div>
        </header>

        <div class="content-wrapper">
            <!-- Page Title -->
            <div class="page-header">
                <h1 class="page-title">Visão Geral do Painel</h1>
            </div>

            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h2 class="welcome-title">Bem-vindo(a), John!</h2>
                    <p class="welcome-text">Aqui você encontra um resumo rápido das principais informações e acessa as funcionalidades de gestão.</p>
                </div>
                <a href="${pageContext.request.contextPath}/matriculas?action=new" class="btn btn-primary">Gerenciar Matrículas</a>
            </div>

            <!-- Statistics Cards -->
            <section class="stats-section">
                <h3 class="section-title">Estatísticas Rápidas</h3>
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-header">
                            <span class="stat-label">Total de Alunos</span>
                            <span class="stat-icon">👨‍🎓</span>
                        </div>
                        <div class="stat-value">${totalAlunos != null ? totalAlunos : 0}</div>
                        <a href="${pageContext.request.contextPath}/alunos?action=list" class="stat-link">Ver detalhes</a>
                    </div>

                    <div class="stat-box">
                        <div class="stat-header">
                            <span class="stat-label">Cursos Ativos</span>
                            <span class="stat-icon">📚</span>
                        </div>
                        <div class="stat-value">${totalCursos != null ? totalCursos : 0}</div>
                        <a href="${pageContext.request.contextPath}/cursos?action=list" class="stat-link">Ver detalhes</a>
                    </div>

                    <div class="stat-box">
                        <div class="stat-header">
                            <span class="stat-label">Aulas Agendadas</span>
                            <span class="stat-icon">📖</span>
                        </div>
                        <div class="stat-value">${totalMatriculas != null ? totalMatriculas : 0}</div>
                        <a href="${pageContext.request.contextPath}/matriculas?action=list" class="stat-link">Ver detalhes</a>
                    </div>

                    <div class="stat-box">
                        <div class="stat-header">
                            <span class="stat-label">Matrículas Pendentes</span>
                            <span class="stat-icon">✅</span>
                        </div>
                        <div class="stat-value">${totalAdvertencias != null ? totalAdvertencias : 0}</div>
                        <a href="${pageContext.request.contextPath}/advertencias?action=list" class="stat-link">Ver detalhes</a>
                    </div>
                </div>
            </section>

            <!-- Two Column Layout -->
            <div class="two-column-layout">
                <!-- Recent Activities -->
                <section class="activity-section">
                    <h3 class="section-title">Atividades Recentes</h3>
                    <div class="activity-list">
                        <c:choose>
                            <c:when test="${not empty ultimosAlunos}">
                                <c:forEach var="aluno" items="${ultimosAlunos}">
                                    <div class="activity-item">
                                        <span class="activity-icon">👨‍🎓</span>
                                        <div class="activity-content">
                                            <p class="activity-text">Novo aluno cadastrado: <strong>${aluno.nome}</strong></p>
                                            <span class="activity-time">Matrícula: ${aluno.matricula}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="activity-item">
                                    <span class="activity-icon">ℹ️</span>
                                    <div class="activity-content">
                                        <p class="activity-text">Nenhuma atividade recente encontrada.</p>
                                        <span class="activity-time">Cadastre novos alunos para ver atividades aqui.</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <!-- Quick Actions -->
                <section class="quick-actions-section">
                    <h3 class="section-title">Ações Rápidas</h3>
                    <div class="action-list">
                        <a href="${pageContext.request.contextPath}/alunos?action=new" class="action-button">
                            <span class="action-icon">👨‍🎓</span>
                            <span class="action-text">Cadastrar Novo Aluno</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/cursos" class="action-button">
                            <span class="action-icon">📄</span>
                            <span class="action-text">Ver Relatórios de Curso</span>
                        </a>
                    </div>
                </section>
            </div>

            <!-- Footer -->
            <footer class="content-footer">
                <p>© 2025 EduGestão. Todos os direitos reservados.</p>
            </footer>
        </div>
    </main>
</body>
</html>
