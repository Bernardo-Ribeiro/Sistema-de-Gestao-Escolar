<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${curso != null}">Editar Curso</c:when><c:otherwise>Novo Curso</c:otherwise></c:choose> - SGE</title>
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
                <h1 class="card-title">
                    <c:choose>
                        <c:when test="${curso != null}">✏️ Editar Curso</c:when>
                        <c:otherwise>➕ Cadastrar Novo Curso</c:otherwise>
                    </c:choose>
                </h1>
            </div>

            <form action="${pageContext.request.contextPath}/cursos" method="post">
                <c:if test="${curso != null}">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${curso.id}">
                </c:if>
                <c:if test="${curso == null}">
                    <input type="hidden" name="action" value="save">
                </c:if>

                <div class="form-grid">
                    <div class="form-group" style="grid-column: 1 / -1;">
                        <label for="nome">Nome do Curso *</label>
                        <input type="text" 
                               id="nome" 
                               name="nome" 
                               class="form-control" 
                               value="${curso != null ? curso.nome : ''}" 
                               required>
                    </div>

                    <div class="form-group" style="grid-column: 1 / -1;">
                        <label for="descricao">Descrição *</label>
                        <textarea id="descricao" 
                                  name="descricao" 
                                  class="form-control" 
                                  rows="4" 
                                  required>${curso != null ? curso.descricao : ''}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="cargaHoraria">Carga Horária (horas) *</label>
                        <input type="number" 
                               id="cargaHoraria" 
                               name="cargaHoraria" 
                               class="form-control" 
                               value="${curso != null ? curso.cargaHoraria : ''}" 
                               min="1"
                               required>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-secondary">
                        <c:choose>
                            <c:when test="${curso != null}">💾 Salvar Alterações</c:when>
                            <c:otherwise>✅ Cadastrar Curso</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/cursos?action=list" class="btn btn-outline">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
