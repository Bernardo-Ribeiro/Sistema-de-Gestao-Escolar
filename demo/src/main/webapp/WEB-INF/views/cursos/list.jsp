<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Cursos - SGE</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 SGE - Sistema de Gestão Escolar</a>
        <ul class="navbar-menu">
            <li><a href="${pageContext.request.contextPath}/">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/alunos?action=list">Alunos</a></li>
            <li><a href="${pageContext.request.contextPath}/cursos?action=list" class="active">Cursos</a></li>
            <li><a href="${pageContext.request.contextPath}/matriculas?action=list">Matrículas</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1 class="card-title">📖 Gerenciamento de Cursos</h1>
                <a href="${pageContext.request.contextPath}/cursos?action=new" class="btn btn-secondary">➕ Novo Curso</a>
            </div>

            <c:if test="${not empty cursos}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Carga Horária</th>
                                <th class="actions">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="curso" items="${cursos}">
                                <tr>
                                    <td>${curso.id}</td>
                                    <td><strong>${curso.nome}</strong></td>
                                    <td>${curso.descricao}</td>
                                    <td><span class="badge badge-secondary">${curso.cargaHoraria}h</span></td>
                                    <td class="actions">
                                        <a href="${pageContext.request.contextPath}/cursos?action=edit&id=${curso.id}" 
                                           class="btn btn-secondary btn-sm">✏️ Editar</a>
                                        <a href="${pageContext.request.contextPath}/cursos?action=delete&id=${curso.id}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Tem certeza que deseja excluir este curso?')">🗑️ Excluir</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty cursos}">
                <div class="empty-state">
                    <div class="empty-state-icon">📋</div>
                    <p>Nenhum curso cadastrado ainda.</p>
                    <a href="${pageContext.request.contextPath}/cursos?action=new" class="btn btn-secondary">➕ Cadastrar Primeiro Curso</a>
                </div>
            </c:if>
        </div>

        <div style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline">← Voltar ao Dashboard</a>
        </div>
    </div>
</body>
</html>
