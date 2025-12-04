<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Matrículas - EduGestão</title>
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
            <a href="${pageContext.request.contextPath}/matriculas?action=list" class="menu-item active">
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
                <h1 class="page-title">Gerenciamento de Matrículas</h1>
                <a href="${pageContext.request.contextPath}/matriculas?action=new" class="btn btn-primary">+ Nova Matrícula</a>
            </div>

            <div class="card">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Aluno</th>
                                <th>Curso</th>
                                <th>Data Matrícula</th>
                                <th>Nota Final</th>
                                <th>Frequência</th>
                                <th>Situação</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="matricula" items="${matriculas}">
                                <tr>
                                    <td>${matricula.id}</td>
                                    <td>${matricula.aluno.nome}</td>
                                    <td>${matricula.curso.nome}</td>
                                    <!-- LocalDate não é compatível com fmt:formatDate; exibir diretamente ou enviar String formatada -->
                                    <td><c:out value="${matricula.dataMatricula}"/></td>
                                    <td>${matricula.notaFinal != null ? matricula.notaFinal : '-'}</td>
                                    <td>${matricula.frequencia != null ? matricula.frequencia : '-'}%</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${matricula.situacao == 'APROVADO'}">
                                                <span style="color: green;">✓ ${matricula.situacao}</span>
                                            </c:when>
                                            <c:when test="${matricula.situacao == 'REPROVADO'}">
                                                <span style="color: red;">✗ ${matricula.situacao}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: blue;">⏳ ${matricula.situacao}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="table-actions">
                                        <a href="${pageContext.request.contextPath}/matriculas?action=edit&id=${matricula.id}" class="btn btn-sm btn-warning">Editar</a>
                                        <a href="${pageContext.request.contextPath}/matriculas?action=delete&id=${matricula.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Deseja realmente excluir esta matrícula?')">Excluir</a>
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
