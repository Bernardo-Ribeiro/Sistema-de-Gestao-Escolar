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
    <div class="container">
        <header>
            <h1>Lista de Alunos</h1>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn">← Voltar ao Menu</a>
        </header>

        <div style="margin-bottom: 20px;">
            <a href="alunos?action=new" class="btn btn-success">+ Novo Aluno</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Matrícula</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="aluno" items="${alunos}">
                    <tr>
                        <td>${aluno.id}</td>
                        <td>${aluno.nome}</td>
                        <td>${aluno.matricula}</td>
                        <td>${aluno.email}</td>
                        <td>${aluno.telefone}</td>
                        <td class="actions">
                            <a href="alunos?action=edit&id=${aluno.id}" class="btn">Editar</a>
                            <a href="alunos?action=delete&id=${aluno.id}" 
                               class="btn btn-danger"
                               onclick="return confirm('Tem certeza que deseja excluir este aluno?')">Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
