<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Presenças - EduGestão</title>
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
            <a href="${pageContext.request.contextPath}/aulas?action=list" class="menu-item">
                <span class="menu-icon">📖</span>
                <span class="menu-text">Aulas</span>
            </a>
            <a href="${pageContext.request.contextPath}/matriculas?action=list" class="menu-item">
                <span class="menu-icon">✅</span>
                <span class="menu-text">Matrículas</span>
            </a>
            <a href="${pageContext.request.contextPath}/presencas?action=list" class="menu-item active">
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
                <h1 class="page-title">Registro de Presenças</h1>
                <a href="${pageContext.request.contextPath}/presencas?action=registrar" class="btn btn-primary">+ Registrar Presença</a>
            </div>

            <div class="card">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Aluno</th>
                                <th>Curso</th>
                                <th>Aula</th>
                                <th>Data</th>
                                <th>Presença</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="presenca" items="${presencas}">
                                <tr>
                                    <td>${presenca.id}</td>
                                    <td>${presenca.matricula.aluno.nome}</td>
                                    <td>${presenca.matricula.curso.nome}</td>
                                    <td>${presenca.aula.titulo}</td>
                                    <td>${presenca.aula.data}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${presenca.presente}">
                                                <span style="color: green;">✓ Presente</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: red;">✗ Ausente</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="table-actions">
                                        <a href="${pageContext.request.contextPath}/presencas?action=delete&id=${presenca.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Deseja realmente excluir este registro?')">Excluir</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
