<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Alunos - SGE</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 SGE - Sistema de Gestão Escolar</a>
        <ul class="navbar-menu">
            <li><a href="${pageContext.request.contextPath}/">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/alunos?action=list" class="active">Alunos</a></li>
            <li><a href="${pageContext.request.contextPath}/cursos?action=list">Cursos</a></li>
            <li><a href="${pageContext.request.contextPath}/matriculas?action=list">Matrículas</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1 class="card-title">👨‍🎓 Gerenciamento de Alunos</h1>
                <a href="${pageContext.request.contextPath}/alunos?action=new" class="btn btn-primary">➕ Novo Aluno</a>
            </div>

            <c:if test="${not empty alunos}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Matrícula</th>
                                <th>Nome</th>
                                <th>Email</th>
                                <th>Telefone</th>
                                <th class="actions">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="aluno" items="${alunos}">
                                <tr>
                                    <td>${aluno.id}</td>
                                    <td><span class="badge badge-primary">${aluno.matricula}</span></td>
                                    <td>${aluno.nome}</td>
                                    <td>${aluno.email}</td>
                                    <td>${aluno.telefone}</td>
                                    <td class="actions">
                                        <a href="${pageContext.request.contextPath}/alunos?action=edit&id=${aluno.id}" 
                                           class="btn btn-secondary btn-sm">✏️ Editar</a>
                                        <a href="${pageContext.request.contextPath}/alunos?action=delete&id=${aluno.id}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Tem certeza que deseja excluir este aluno?')">🗑️ Excluir</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty alunos}">
                <div class="empty-state">
                    <div class="empty-state-icon">📋</div>
                    <p>Nenhum aluno cadastrado ainda.</p>
                    <a href="${pageContext.request.contextPath}/alunos?action=new" class="btn btn-primary">➕ Cadastrar Primeiro Aluno</a>
                </div>
            </c:if>
        </div>

        <div style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline">← Voltar ao Dashboard</a>
        </div>
    </div>
</body>
</html>
