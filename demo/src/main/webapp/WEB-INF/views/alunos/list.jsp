<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Alunos - EduGestão</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <div class="logo-icon-small">🎓</div>
                <h2 class="sidebar-title">EduGestão</h2>
            </div>
            <button class="sidebar-toggle">☰</button>
        </div>

        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="menu-item">
                <span class="menu-icon">📊</span>
                <span class="menu-text">Menu Principal</span>
            </a>
            <a href="${pageContext.request.contextPath}/alunos?action=list" class="menu-item active">
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
        </nav>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/login.jsp" class="menu-item">
                <span class="menu-icon">🚪</span>
                <span class="menu-text">Sair</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-brand">
                <div class="logo-icon-small">🎓</div>
                <h1 class="header-title">EduGestão</h1>
            </div>
            <div class="header-user">
                <img src="https://ui-avatars.com/api/?name=John&background=0ea5e9&color=fff" alt="User" class="user-avatar">
            </div>
        </header>

        <div class="content-wrapper">
            <!-- Page Title -->
            <div class="page-header">
                <h1 class="page-title">Gerenciamento de Alunos</h1>
            </div>

            <!-- Cadastro de Aluno Form -->
            <div class="form-card">
                <h2 class="form-card-title">Cadastro de Aluno</h2>
                
                <form action="${pageContext.request.contextPath}/alunos" method="post" id="formAluno">
                    <input type="hidden" name="action" value="save" id="formAction">
                    <input type="hidden" name="id" value="" id="alunoId">
                    
                    <div class="form-row">
                        <div class="form-col">
                            <label for="nome">Nome do Aluno</label>
                            <input type="text" 
                                   id="nome" 
                                   name="nome" 
                                   class="form-control" 
                                   placeholder="Ex: Maria Santos"
                                   required>
                        </div>
                        <div class="form-col">
                            <label for="matricula">Número de Matrícula</label>
                            <input type="text" 
                                   id="matricula" 
                                   name="matricula" 
                                   class="form-control" 
                                   placeholder="Ex: 2024001"
                                   required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-col">
                            <label for="email">E-mail do Aluno</label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="form-control" 
                                   placeholder="Ex: maria.santos@email.com"
                                   required>
                        </div>
                        <div class="form-col">
                            <label for="telefone">Telefone do Aluno</label>
                            <input type="tel" 
                                   id="telefone" 
                                   name="telefone" 
                                   class="form-control" 
                                   placeholder="Ex: (XX) XXXXX-XXXX">
                        </div>
                    </div>

                    <div class="form-actions-inline">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <button type="button" class="btn btn-secondary" onclick="editarMode()">Editar</button>
                        <button type="button" class="btn btn-danger" onclick="limparForm()">Excluir</button>
                    </div>
                </form>
            </div>

            <!-- Lista de Alunos Registrados -->
            <div class="table-card">
                <h2 class="table-card-title">Alunos Registrados</h2>
                
                <c:if test="${not empty alunos}">
                    <div class="data-table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>NOME</th>
                                    <th>MATRÍCULA</th>
                                    <th>E-MAIL</th>
                                    <th>TELEFONE</th>
                                    <th>AÇÕES</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="aluno" items="${alunos}">
                                    <tr>
                                        <td>${aluno.nome}</td>
                                        <td>${aluno.matricula}</td>
                                        <td>${aluno.email}</td>
                                        <td>${aluno.telefone}</td>
                                        <td class="table-actions">
                                            <button class="icon-btn icon-btn-edit" 
                                                    onclick="carregarAluno(${aluno.id}, '${aluno.nome}', '${aluno.matricula}', '${aluno.email}', '${aluno.telefone}')"
                                                    title="Editar">✏️</button>
                                            <button class="icon-btn icon-btn-delete" 
                                                    onclick="confirmarExclusao(${aluno.id})"
                                                    title="Excluir">🗑️</button>
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
                    </div>
                </c:if>
            </div>
        </div>
    </main>

    <script>
        function carregarAluno(id, nome, matricula, email, telefone) {
            document.getElementById('alunoId').value = id;
            document.getElementById('nome').value = nome;
            document.getElementById('matricula').value = matricula;
            document.getElementById('email').value = email;
            document.getElementById('telefone').value = telefone;
            document.getElementById('formAction').value = 'update';
            
            // Scroll to form
            document.getElementById('formAluno').scrollIntoView({ behavior: 'smooth' });
        }

        function editarMode() {
            const id = document.getElementById('alunoId').value;
            if (!id) {
                alert('Selecione um aluno para editar');
                return;
            }
            document.getElementById('formAction').value = 'update';
            document.getElementById('formAluno').submit();
        }

        function limparForm() {
            const id = document.getElementById('alunoId').value;
            if (id) {
                if (confirm('Deseja realmente excluir este aluno?')) {
                    window.location.href = '${pageContext.request.contextPath}/alunos?action=delete&id=' + id;
                }
            } else {
                document.getElementById('formAluno').reset();
                document.getElementById('alunoId').value = '';
                document.getElementById('formAction').value = 'save';
            }
        }

        function confirmarExclusao(id) {
            if (confirm('Tem certeza que deseja excluir este aluno?')) {
                window.location.href = '${pageContext.request.contextPath}/alunos?action=delete&id=' + id;
            }
        }
    </script>
</body>
</html>
