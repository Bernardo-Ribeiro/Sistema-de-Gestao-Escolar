<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${aula != null ? 'Editar' : 'Nova'} Aula - EduGestão</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-layout">
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <div class="logo-icon-small">🎓</div>
                <h2 class="sidebar-title">EduGestão</h2>
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="menu-item">
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
            <a href="${pageContext.request.contextPath}/aulas?action=list" class="menu-item active">
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

    <main class="main-content">
        <header class="top-header">
            <div class="header-brand">
                <div class="logo-icon-small">🎓</div>
                <h1 class="header-title">EduGestão</h1>
            </div>
            <div class="header-user">
                <span style="margin-right: 10px; color: #333;">${usuarioNome != null ? usuarioNome : 'Usuário'}</span>
                <img src="https://ui-avatars.com/api/?name=${usuarioNome != null ? usuarioNome : 'User'}&background=0ea5e9&color=fff" alt="User" class="user-avatar">
            </div>
        </header>

        <div class="content-wrapper">
            <div class="page-header">
                <h1 class="page-title">${aula != null ? 'Editar' : 'Nova'} Aula</h1>
            </div>

            <div class="card">
                <form action="${pageContext.request.contextPath}/aulas" method="post">
                    <input type="hidden" name="action" value="${aula != null ? 'update' : 'save'}">
                    <c:if test="${aula != null}">
                        <input type="hidden" name="id" value="${aula.id}">
                    </c:if>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="titulo">Título da Aula</label>
                            <input type="text" id="titulo" name="titulo" class="form-control" 
                                   value="${aula != null ? aula.titulo : ''}" required>
                        </div>

                        <div class="form-group">
                            <label for="cursoId">Curso</label>
                            <select id="cursoId" name="cursoId" class="form-control" required>
                                <option value="">Selecione um curso</option>
                                <c:forEach var="curso" items="${cursos}">
                                    <option value="${curso.id}" 
                                            ${aula != null && aula.curso.id == curso.id ? 'selected' : ''}>
                                        ${curso.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="data">Data</label>
                            <input type="date" id="data" name="data" class="form-control" 
                                   value="${aula != null ? aula.data : ''}" required>
                        </div>

                        <div class="form-group">
                            <label for="duracao">Duração (minutos)</label>
                            <input type="number" id="duracao" name="duracao" class="form-control" 
                                   value="${aula != null ? aula.duracao : ''}" min="1" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/aulas?action=list" class="btn btn-secondary">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
