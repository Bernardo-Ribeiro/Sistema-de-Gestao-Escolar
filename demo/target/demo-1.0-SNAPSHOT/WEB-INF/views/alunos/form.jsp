<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${aluno != null ? 'Editar' : 'Novo'} Aluno - SGE</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>${aluno != null ? 'Editar' : 'Novo'} Aluno</h1>
            <a href="alunos?action=list" class="btn">← Voltar para Lista</a>
        </header>

        <form method="post" action="alunos">
            <input type="hidden" name="action" value="${aluno != null ? 'update' : 'save'}">
            <c:if test="${aluno != null}">
                <input type="hidden" name="id" value="${aluno.id}">
            </c:if>

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${aluno.nome}" required>
            </div>

            <div class="form-group">
                <label for="matricula">Matrícula:</label>
                <input type="text" id="matricula" name="matricula" value="${aluno.matricula}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${aluno.email}">
            </div>

            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" id="telefone" name="telefone" value="${aluno.telefone}">
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-success">Salvar</button>
                <a href="alunos?action=list" class="btn">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
