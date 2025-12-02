<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursos - EduGestão</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .clean-layout {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: #f8f9fa;
            min-height: 100vh;
        }

        .form-section {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .section-subtitle {
            color: #64748b;
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 500;
            color: #334155;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .form-input:focus {
            outline: none;
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
        }

        .form-textarea {
            min-height: 100px;
            resize: vertical;
            font-family: inherit;
        }

        .button-group {
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 0.625rem 1.25rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #0ea5e9;
            color: white;
        }

        .btn-primary:hover {
            background: #0284c7;
        }

        .btn-secondary {
            background: white;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f8fafc;
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
        }

        .table-section {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .search-input {
            padding: 0.5rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 0.875rem;
            width: 250px;
        }

        .search-input:focus {
            outline: none;
            border-color: #0ea5e9;
        }

        .clean-table {
            width: 100%;
            border-collapse: collapse;
        }

        .clean-table thead th {
            text-align: left;
            padding: 0.75rem 1rem;
            font-size: 0.75rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid #e2e8f0;
        }

        .clean-table tbody td {
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.875rem;
            color: #334155;
        }

        .clean-table tbody tr:hover {
            background: #f8fafc;
        }

        .course-name {
            font-weight: 600;
            color: #1e293b;
        }

        .course-hours {
            color: #64748b;
        }

        .action-icons {
            display: flex;
            gap: 0.5rem;
        }

        .icon-button {
            padding: 0.375rem;
            background: transparent;
            border: none;
            cursor: pointer;
            color: #64748b;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .icon-button:hover {
            background: #f1f5f9;
            color: #0ea5e9;
        }

        .icon-button.delete:hover {
            color: #ef4444;
        }

        .pagination {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
            align-items: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #f1f5f9;
        }

        .page-btn {
            padding: 0.5rem 0.75rem;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.875rem;
            color: #64748b;
            transition: all 0.2s;
        }

        .page-btn:hover {
            background: #f8fafc;
            border-color: #0ea5e9;
        }

        .page-btn.active {
            background: #0ea5e9;
            color: white;
            border-color: #0ea5e9;
        }
    </style>
</head>
<body>
    

    <script>
        function carregarCurso(id, nome, descricao, cargaHoraria) {
            document.getElementById('cursoId').value = id;
            document.getElementById('nome').value = nome;
            document.getElementById('descricao').value = descricao;
            document.getElementById('cargaHoraria').value = cargaHoraria;
            document.getElementById('formAction').value = 'update';
            document.getElementById('btnExcluir').style.display = 'inline-block';
            
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function limparForm() {
            document.getElementById('cursoForm').reset();
            document.getElementById('cursoId').value = '';
            document.getElementById('formAction').value = 'save';
            document.getElementById('btnExcluir').style.display = 'none';
        }

        function excluirCurso(id) {
            if (confirm('Tem certeza que deseja excluir este curso?')) {
                window.location.href = '${pageContext.request.contextPath}/cursos?action=delete&id=' + id;
            }
        }

        function confirmarExclusao() {
            const id = document.getElementById('cursoId').value;
            excluirCurso(id);
        }

        document.getElementById('searchInput')?.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.clean-table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
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
            <a href="${pageContext.request.contextPath}/alunos?action=list" class="menu-item">
                <span class="menu-icon">👨‍🎓</span>
                <span class="menu-text">Alunos</span>
            </a>
            <a href="${pageContext.request.contextPath}/cursos?action=list" class="menu-item active">
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

        <div class="clean-layout">
        <!-- Form Section -->
        <div class="form-section">
            <h1 class="section-title">Cadastro de Curso</h1>
            <p class="section-subtitle">Preencha os campos abaixo para cadastrar um novo curso ou editar um existente.</p>
            
            <form id="cursoForm" action="${pageContext.request.contextPath}/cursos" method="post">
                <input type="hidden" name="action" id="formAction" value="save">
                <input type="hidden" name="id" id="cursoId">
                
                <div class="form-group">
                    <label for="nome" class="form-label">Nome do Curso</label>
                    <input type="text" class="form-input" id="nome" name="nome" 
                           placeholder="Nome do Curso" required>
                </div>

                <div class="form-group">
                    <label for="descricao" class="form-label">Descrição</label>
                    <textarea class="form-input form-textarea" id="descricao" name="descricao"
                              placeholder="Descrição detalhada do curso..."></textarea>
                </div>

                <div class="form-group">
                    <label for="cargaHoraria" class="form-label">Carga Horária (horas)</label>
                    <input type="number" class="form-input" id="cargaHoraria" name="cargaHoraria" 
                           placeholder="Ex: 40" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Salvar</button>
                    <button type="button" class="btn btn-secondary" onclick="limparForm()">Limpar Formulário</button>
                    <button type="button" class="btn btn-danger" id="btnExcluir" style="display:none;" onclick="confirmarExclusao()">Excluir Curso</button>
                </div>
            </form>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-header">
                <h2 class="section-title" style="margin: 0;">Cursos Cadastrados</h2>
                <input type="text" class="search-input" id="searchInput" placeholder="🔍 Buscar curso...">
            </div>

            <c:choose>
                <c:when test="${not empty cursos}">
                    <table class="clean-table">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th style="text-align: right;">Carga Horária</th>
                                <th style="text-align: center;">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="curso" items="${cursos}">
                                <tr>
                                    <td class="course-name">${curso.nome}</td>
                                    <td>${curso.descricao}</td>
                                    <td style="text-align: right;" class="course-hours">${curso.cargaHoraria}h</td>
                                    <td style="text-align: center;">
                                        <div class="action-icons">
                                            <button class="icon-button" onclick="carregarCurso(${curso.id}, '${curso.nome}', '${curso.descricao}', ${curso.cargaHoraria})" title="Editar">
                                                📝
                                            </button>
                                            <button class="icon-button delete" onclick="excluirCurso(${curso.id})" title="Excluir">
                                                🗑️
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="pagination">
                        <button class="page-btn">‹ Previous</button>
                        <button class="page-btn active">1</button>
                        <button class="page-btn">2</button>
                        <button class="page-btn">3</button>
                        <button class="page-btn">Next ›</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: #64748b; padding: 2rem;">Nenhum curso cadastrado ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    </main>

    <script>
        function carregarCurso(id, nome, descricao, cargaHoraria) {
            document.getElementById('cursoId').value = id;
            document.getElementById('nome').value = nome;
            document.getElementById('descricao').value = descricao;
            document.getElementById('cargaHoraria').value = cargaHoraria;
            document.getElementById('formAction').value = 'update';
            document.getElementById('btnExcluir').style.display = 'inline-block';
            
            // Scroll to form
            document.querySelector('.form-card').scrollIntoView({ behavior: 'smooth' });
        }

        function limparForm() {
            document.getElementById('cursoForm').reset();
            document.getElementById('cursoId').value = '';
            document.getElementById('formAction').value = 'save';
            document.getElementById('btnExcluir').style.display = 'none';
        }

        function excluirCurso(id) {
            if (confirm('Tem certeza que deseja excluir este curso?')) {
                window.location.href = '${pageContext.request.contextPath}/cursos?action=delete&id=' + id;
            }
        }

        function confirmarExclusao() {
            const id = document.getElementById('cursoId').value;
            excluirCurso(id);
        }

        // Search functionality
        document.getElementById('searchInput')?.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
