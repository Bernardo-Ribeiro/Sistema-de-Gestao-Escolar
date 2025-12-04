<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Presença - EduGestão</title>
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
                <h1 class="page-title">Registrar Presença</h1>
            </div>

            <div class="card">
                <c:choose>
                    <c:when test="${aula != null}">
                        <h2>Aula: ${aula.titulo}</h2>
                        <p>Curso: ${aula.curso.nome} | Data: ${aula.data}</p>
                        
                        <form action="${pageContext.request.contextPath}/presencas" method="post">
                            <input type="hidden" name="action" value="registrarLote">
                            <input type="hidden" name="aulaId" value="${aula.id}">
                            
                            <p><strong>Marque os alunos presentes:</strong></p>
                            
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th width="50">
                                                <input type="checkbox" id="selectAll" 
                                                       onchange="document.querySelectorAll('.checkbox-aluno').forEach(cb => cb.checked = this.checked)">
                                            </th>
                                            <th>Aluno</th>
                                            <th>Matrícula</th>
                                            <th>Situação</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="matricula" items="${matriculas}">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" name="matriculaIds" 
                                                           value="${matricula.id}" 
                                                           class="checkbox-aluno" checked>
                                                </td>
                                                <td>${matricula.aluno.nome}</td>
                                                <td>${matricula.aluno.matricula}</td>
                                                <td>${matricula.situacao}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Salvar Presenças</button>
                                <a href="${pageContext.request.contextPath}/presencas?action=list" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <h2>Selecione uma Aula</h2>
                        <form action="${pageContext.request.contextPath}/presencas" method="get">
                            <input type="hidden" name="action" value="registrar">
                            
                            <div class="form-group">
                                <label for="aulaId">Aula</label>
                                <select id="aulaId" name="aulaId" class="form-control" required>
                                    <option value="">Selecione uma aula</option>
                                    <c:forEach var="aulaItem" items="${aulas}">
                                        <option value="${aulaItem.id}">
                                            ${aulaItem.titulo} - ${aulaItem.curso.nome} (${aulaItem.data})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Continuar</button>
                                <a href="${pageContext.request.contextPath}/presencas?action=list" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</body>
</html>
