<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EduGestão</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <!-- Logo e Título -->
            <div class="login-header">
                <div class="login-logo">
                    <div class="logo-icon">🎓</div>
                    <h1 class="logo-text">EduGestão</h1>
                </div>
                <h2 class="login-title">Bem-vindo de volta!</h2>
                <p class="login-subtitle">Faça login para acessar o painel de gestão.</p>
            </div>

            <!-- Mensagem de Erro -->
            <c:if test="${not empty erro}">
                <div class="alert alert-danger">
                    <strong>⚠️ Erro:</strong> ${erro}
                </div>
            </c:if>

            <!-- Mensagem de Sucesso (logout) -->
            <c:if test="${not empty sucesso}">
                <div class="alert alert-success">
                    <strong>✓</strong> ${sucesso}
                </div>
            </c:if>

            <!-- Formulário de Login -->
            <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
                <div class="form-group">
                    <label for="usuario">Usuário</label>
                    <input type="text" 
                           id="usuario" 
                           name="usuario" 
                           class="form-control" 
                           placeholder="Seu e-mail ou nome de usuário"
                           value="${usuario != null ? usuario : ''}"
                           required>
                </div>

                <div class="form-group">
                    <label for="senha">Senha</label>
                    <input type="password" 
                           id="senha" 
                           name="senha" 
                           class="form-control" 
                           placeholder="Sua senha"
                           required>
                </div>

                <button type="submit" class="btn btn-login">Entrar</button>

                <div class="login-links">
                    <a href="${pageContext.request.contextPath}/recuperar-senha" class="link-primary">Esqueceu a senha?</a>
                </div>

                <div class="login-footer">
                    <span>Não tem uma conta?</span>
                    <a href="${pageContext.request.contextPath}/criar-conta" class="link-primary">Criar Conta</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
