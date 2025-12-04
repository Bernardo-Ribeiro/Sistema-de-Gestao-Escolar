package com.sge.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filtro de autenticação que protege todas as páginas
 * exceto login, logout e recursos estáticos
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // URLs públicas que não precisam de autenticação
        boolean isPublicUrl = uri.endsWith("/login") || 
                             uri.endsWith("/login.jsp") ||
                             uri.endsWith("/logout") ||
                             uri.endsWith("/setup-usuarios") || // Página de setup (remover em produção)
                             uri.endsWith("/debug-usuarios") || // Página de debug (remover em produção)
                             uri.contains("/css/") ||
                             uri.contains("/js/") ||
                             uri.contains("/images/") ||
                             uri.contains("/favicon.ico");
        
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("usuarioLogado") != null);
        
        if (isPublicUrl || isLoggedIn) {
            // Permite o acesso
            chain.doFilter(request, response);
        } else {
            // Redireciona para o login
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialização do filtro
    }

    @Override
    public void destroy() {
        // Limpeza do filtro
    }
}
