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
    <div class="container">
        <header>
            <h1>Lista de Cursos</h1>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn">← Voltar ao Menu</a>
        </header>

        <div style="margin-bottom: 20px;">
            <a href="cursos?action=new" class="btn btn-success">+ Novo Curso</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th>Carga Horária</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="curso" items="${cursos}">
                    <tr>
                        <td>${curso.id}</td>
                        <td>${curso.nome}</td>
                        <td>${curso.descricao}</td>
                        <td>${curso.cargaHoraria}h</td>
                        <td class="actions">
                            <a href="cursos?action=edit&id=${curso.id}" class="btn">Editar</a>
                            <a href="cursos?action=delete&id=${curso.id}" 
                               class="btn btn-danger"
                               onclick="return confirm('Tem certeza que deseja excluir este curso?')">Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
