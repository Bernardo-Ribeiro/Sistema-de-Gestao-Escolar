<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        </div>

        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="menu-item">
                <span class="menu-icon">📊</span>
                <span class="menu-text">Dashboard</span>
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
            <a href="${pageContext.request.contextPath}/presencas?action=list" class="menu-item">
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

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-left">
                <button class="header-toggle">☰</button>
                <h1 class="header-title">Gerenciamento de Alunos</h1>
            </div>
            <div class="header-right">
                <div class="header-user">
                    <img src="https://ui-avatars.com/api/?name=${usuarioNome != null ? usuarioNome : 'User'}&background=0ea5e9&color=fff" alt="User" class="user-avatar">
                    <div class="user-info">
                        <span class="user-name">${usuarioNome != null ? usuarioNome : 'Usuário'}</span>
                        <span class="user-role">Administrador</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="content-wrapper">
            <!-- Page Header -->
            <div class="page-header">
                <div class="page-header-left">
                    <h1>Alunos</h1>
                    <div class="page-breadcrumb">
                        <a href="${pageContext.request.contextPath}/" class="breadcrumb-link">Dashboard</a>
                        <span class="breadcrumb-separator">/</span>
                        <span>Alunos</span>
                    </div>
                </div>
                <div class="page-header-right">
                    <button class="btn btn-primary" onclick="resetarFormulario()">
                        <span>+</span> Novo Aluno
                    </button>
                </div>
            </div>

            <!-- Messages -->
            <c:if test="${not empty mensagem}">
                <div class="alert alert-success">
                    <span class="alert-icon">✓</span>
                    <span>${mensagem}</span>
                </div>
            </c:if>
            
            <c:if test="${not empty erro}">
                <div class="alert alert-danger">
                    <span class="alert-icon">✕</span>
                    <span>${erro}</span>
                </div>
            </c:if>

            <!-- Cadastro de Aluno Form -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>📝</span> Cadastro de Aluno
                    </h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/alunos" method="post" id="formAluno">
                        <input type="hidden" name="action" value="save" id="formAction">
                        <input type="hidden" name="id" value="" id="alunoId">
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="nome" class="required">Nome do Aluno</label>
                                <input type="text" 
                                       id="nome" 
                                       name="nome" 
                                       class="form-control" 
                                       placeholder="Ex: Maria Santos"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="matricula" class="required">Número de Matrícula</label>
                                <input type="text" 
                                       id="matricula" 
                                       name="matricula" 
                                       class="form-control" 
                                   placeholder="Ex: 2024001"
                                   required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="email" class="required">E-mail do Aluno</label>
                                <input type="email" 
                                       id="email" 
                                       name="email" 
                                       class="form-control" 
                                       placeholder="Ex: maria.santos@email.com"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="telefone">Telefone do Aluno</label>
                                <input type="tel" 
                                       id="telefone" 
                                       name="telefone" 
                                       class="form-control" 
                                       placeholder="Ex: (XX) XXXXX-XXXX">
                            </div>
                        </div>

                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">
                                <span>💾</span> Salvar
                            </button>
                            <button type="button" class="btn btn-outline" onclick="resetarFormulario()">
                                <span>↻</span> Limpar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Lista de Alunos Registrados -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>📋</span> Alunos Registrados
                    </h2>
                    <div class="card-header-actions">
                        <span class="badge badge-primary">${alunos != null ? alunos.size() : 0} alunos</span>
                    </div>
                </div>
                <div class="card-body">
                    <c:if test="${not empty alunos}">
                        <div class="table-container">
                            <table>
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
                                            <td><strong>${aluno.nome}</strong></td>
                                            <td><span class="badge badge-gray">${aluno.matricula}</span></td>
                                            <td>${aluno.email}</td>
                                            <td>${aluno.telefone}</td>
                                            <td>
                                                <div class="table-actions">
                                                    <button class="btn btn-sm btn-outline-primary" 
                                                            onclick="carregarAluno(${aluno.id}, '${aluno.nome}', '${aluno.matricula}', '${aluno.email}', '${aluno.telefone}')"
                                                            title="Editar">
                                                        ✏️ Editar
                                                    </button>
                                                    <button class="btn btn-sm btn-danger" 
                                                            onclick="confirmarExclusao(${aluno.id})"
                                                            title="Excluir">
                                                        🗑️ Excluir
                                                    </button>
                                                </div>
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
                            <h3 class="empty-state-title">Nenhum aluno cadastrado</h3>
                            <p class="empty-state-text">Clique em "Novo Aluno" para adicionar o primeiro aluno.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Toggle sidebar on mobile
        document.querySelector('.header-toggle')?.addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('open');
        });

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

        function resetarFormulario() {
            document.getElementById('alunoId').value = '';
            document.getElementById('nome').value = '';
            document.getElementById('matricula').value = '';
            document.getElementById('email').value = '';
            document.getElementById('telefone').value = '';
            document.getElementById('formAction').value = 'save';
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(function(alert) {
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.style.display = 'none';
                }, 300);
            });
        }, 5000);
    </script>
</body>
</html>
