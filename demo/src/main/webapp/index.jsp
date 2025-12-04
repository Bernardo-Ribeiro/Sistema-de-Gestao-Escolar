<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduGestão - Dashboard</title>
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
        </div>

        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="menu-item active">
                <span class="menu-icon">📊</span>
                <span class="menu-text">Dashboard</span>
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
            <a href="${pageContext.request.contextPath}/presencas?action=list" class="menu-item">
                <span class="menu-icon">📋</span>
                <span class="menu-text">Presenças</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <span class="menu-icon">🚪</span>
                <span class="menu-text">Sair</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-left">
                <button class="header-toggle">☰</button>
                <h1 class="header-title">Dashboard</h1>
            </div>
            <div class="header-right">
                <div class="header-user">
                    <img src="https://ui-avatars.com/api/?name=${usuarioNome != null ? usuarioNome : 'User'}&background=0ea5e9&color=fff" alt="User" class="user-avatar">
                    <div class="user-info">
                        <span class="user-name">${usuarioNome != null ? usuarioNome : 'Usuário'}</span>
                        <span class="user-role">Administrador</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="content-wrapper">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h2>Bem-vindo(a), ${usuarioNome != null ? usuarioNome : 'Usuário'}! 👋</h2>
                    <p>Aqui está um resumo das principais informações e atividades do sistema.</p>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div class="stat-card-icon primary">
                            <span>👨‍🎓</span>
                        </div>
                    </div>
                    <div class="stat-card-body">
                        <div class="stat-card-value">${totalAlunos != null ? totalAlunos : 0}</div>
                        <div class="stat-card-label">Total de Alunos</div>
                    </div>
                    <div class="stat-card-footer">
                        <a href="${pageContext.request.contextPath}/alunos?action=list" class="stat-card-link">
                            Ver detalhes →
                        </a>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-card-header">
                        <div class="stat-card-icon success">
                            <span>�</span>
                        </div>
                    </div>
                    <div class="stat-card-body">
                        <div class="stat-card-value">${totalCursos != null ? totalCursos : 0}</div>
                        <div class="stat-card-label">Cursos Ativos</div>
                    </div>
                    <div class="stat-card-footer">
                        <a href="${pageContext.request.contextPath}/cursos?action=list" class="stat-card-link">
                            Ver detalhes →
                        </a>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-card-header">
                        <div class="stat-card-icon warning">
                            <span>�</span>
                        </div>
                    </div>
                    <div class="stat-card-body">
                        <div class="stat-card-value">${totalAulas != null ? totalAulas : 0}</div>
                        <div class="stat-card-label">Aulas Cadastradas</div>
                    </div>
                    <div class="stat-card-footer">
                        <a href="${pageContext.request.contextPath}/aulas?action=list" class="stat-card-link">
                            Ver detalhes →
                        </a>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-card-header">
                        <div class="stat-card-icon danger">
                            <span>✅</span>
                        </div>
                    </div>
                    <div class="stat-card-body">
                        <div class="stat-card-value">${totalMatriculas != null ? totalMatriculas : 0}</div>
                        <div class="stat-card-label">Matrículas Ativas</div>
                    </div>
                    <div class="stat-card-footer">
                        <a href="${pageContext.request.contextPath}/matriculas?action=list" class="stat-card-link">
                            Ver detalhes →
                        </a>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>⚡</span> Ações Rápidas
                    </h2>
                </div>
                <div class="card-body">
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/alunos?action=list" class="btn btn-outline-primary">
                            <span>👨‍🎓</span> Gerenciar Alunos
                        </a>
                        <a href="${pageContext.request.contextPath}/cursos?action=list" class="btn btn-outline-primary">
                            <span>📚</span> Gerenciar Cursos
                        </a>
                        <a href="${pageContext.request.contextPath}/aulas?action=list" class="btn btn-outline-primary">
                            <span>📖</span> Gerenciar Aulas
                        </a>
                        <a href="${pageContext.request.contextPath}/matriculas?action=list" class="btn btn-outline-primary">
                            <span>✅</span> Gerenciar Matrículas
                        </a>
                        <a href="${pageContext.request.contextPath}/presencas?action=list" class="btn btn-outline-primary">
                            <span>📋</span> Registrar Presenças
                        </a>
                    </div>
                </div>
            </div>

            <!-- Recent Activities -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>📊</span> Atividades Recentes
                    </h2>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty ultimosAlunos}">
                            <div class="activity-list">
                                <c:forEach var="aluno" items="${ultimosAlunos}">
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <span>👨‍🎓</span>
                                        </div>
                                        <div class="activity-content">
                                            <p class="activity-text">
                                                Novo aluno cadastrado: <strong>${aluno.nome}</strong>
                                            </p>
                                            <span class="activity-time">Matrícula: ${aluno.matricula}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon">📋</div>
                                <h3 class="empty-state-title">Nenhuma atividade recente</h3>
                                <p class="empty-state-text">As atividades aparecerão aqui conforme você usa o sistema.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Footer -->
            <footer class="content-footer">
                <p>&copy; 2024 EduGestão - Sistema de Gestão Escolar. Todos os direitos reservados.</p>
            </footer>
        </div>
    </main>

    <script>
        // Toggle sidebar on mobile
        document.querySelector('.header-toggle')?.addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('open');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const toggle = document.querySelector('.header-toggle');
            
            if (window.innerWidth <= 768 && 
                sidebar.classList.contains('open') && 
                !sidebar.contains(event.target) && 
                !toggle.contains(event.target)) {
                sidebar.classList.remove('open');
            }
        });
    </script>
</body>
</html>
