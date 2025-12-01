<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${aluno != null}">Editar Aluno</c:when><c:otherwise>Novo Aluno</c:otherwise></c:choose> - SGE</title>
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
                <h1 class="card-title">
                    <c:choose>
                        <c:when test="${aluno != null}">✏️ Editar Aluno</c:when>
                        <c:otherwise>➕ Cadastrar Novo Aluno</c:otherwise>
                    </c:choose>
                </h1>
            </div>

            <form action="${pageContext.request.contextPath}/alunos" method="post">
                <c:if test="${aluno != null}">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${aluno.id}">
                </c:if>
                <c:if test="${aluno == null}">
                    <input type="hidden" name="action" value="save">
                </c:if>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="matricula">Matrícula *</label>
                        <input type="text" 
                               id="matricula" 
                               name="matricula" 
                               class="form-control" 
                               value="${aluno != null ? aluno.matricula : ''}" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="nome">Nome Completo *</label>
                        <input type="text" 
                               id="nome" 
                               name="nome" 
                               class="form-control" 
                               value="${aluno != null ? aluno.nome : ''}" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" 
                               id="email" 
                               name="email" 
                               class="form-control" 
                               value="${aluno != null ? aluno.email : ''}" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="telefone">Telefone</label>
                        <input type="tel" 
                               id="telefone" 
                               name="telefone" 
                               class="form-control" 
                               value="${aluno != null ? aluno.telefone : ''}"
                               placeholder="(00) 00000-0000">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${aluno != null}">💾 Salvar Alterações</c:when>
                            <c:otherwise>✅ Cadastrar Aluno</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/alunos?action=list" class="btn btn-outline">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
