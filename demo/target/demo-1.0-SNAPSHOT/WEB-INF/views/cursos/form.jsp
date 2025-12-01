<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${curso != null ? 'Editar' : 'Novo'} Curso - SGE</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>${curso != null ? 'Editar' : 'Novo'} Curso</h1>
            <a href="cursos?action=list" class="btn">← Voltar para Lista</a>
        </header>

        <form method="post" action="cursos">
            <input type="hidden" name="action" value="${curso != null ? 'update' : 'save'}">
            <c:if test="${curso != null}">
                <input type="hidden" name="id" value="${curso.id}">
            </c:if>

            <div class="form-group">
                <label for="nome">Nome do Curso:</label>
                <input type="text" id="nome" name="nome" value="${curso.nome}" required>
            </div>

            <div class="form-group">
                <label for="descricao">Descrição:</label>
                <textarea id="descricao" name="descricao" required>${curso.descricao}</textarea>
            </div>

            <div class="form-group">
                <label for="cargaHoraria">Carga Horária (horas):</label>
                <input type="number" id="cargaHoraria" name="cargaHoraria" value="${curso.cargaHoraria}" min="1" required>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-success">Salvar</button>
                <a href="cursos?action=list" class="btn">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
