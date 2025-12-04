<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${matricula != null ? 'Editar' : 'Nova'} Matrícula - EduGestão</title>
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
                <h1 class="page-title">${matricula != null ? 'Editar' : 'Nova'} Matrícula</h1>
            </div>

            <div class="card">
                <form action="${pageContext.request.contextPath}/matriculas" method="post">
                    <input type="hidden" name="action" value="${matricula != null ? 'update' : 'save'}">
                    <c:if test="${matricula != null}">
                        <input type="hidden" name="id" value="${matricula.id}">
                    </c:if>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="alunoId">Aluno</label>
                            <select id="alunoId" name="alunoId" class="form-control" required>
                                <option value="">Selecione um aluno</option>
                                <c:forEach var="aluno" items="${alunos}">
                                    <option value="${aluno.id}" 
                                            ${matricula != null && matricula.aluno.id == aluno.id ? 'selected' : ''}>
                                        ${aluno.nome} (${aluno.matricula})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="cursoId">Curso</label>
                            <select id="cursoId" name="cursoId" class="form-control" required>
                                <option value="">Selecione um curso</option>
                                <c:forEach var="curso" items="${cursos}">
                                    <option value="${curso.id}" 
                                            ${matricula != null && matricula.curso.id == curso.id ? 'selected' : ''}>
                                        ${curso.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="situacao">Situação</label>
                            <select id="situacao" name="situacao" class="form-control" required>
                                <option value="CURSANDO" ${matricula != null && matricula.situacao == 'CURSANDO' ? 'selected' : ''}>Cursando</option>
                                <option value="APROVADO" ${matricula != null && matricula.situacao == 'APROVADO' ? 'selected' : ''}>Aprovado</option>
                                <option value="REPROVADO" ${matricula != null && matricula.situacao == 'REPROVADO' ? 'selected' : ''}>Reprovado</option>
                                <option value="TRANCADO" ${matricula != null && matricula.situacao == 'TRANCADO' ? 'selected' : ''}>Trancado</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="notaFinal">Nota Final (0-10)</label>
                            <input type="number" id="notaFinal" name="notaFinal" class="form-control" 
                                   value="${matricula != null ? matricula.notaFinal : ''}" 
                                   min="0" max="10" step="0.1">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="frequencia">Frequência (%)</label>
                            <input type="number" id="frequencia" name="frequencia" class="form-control" 
                                   value="${matricula != null ? matricula.frequencia : ''}" 
                                   min="0" max="100" step="0.1">
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/matriculas?action=list" class="btn btn-secondary">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
