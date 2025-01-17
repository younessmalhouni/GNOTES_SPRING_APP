package com.example.GNotesAPP12.Config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import jakarta.servlet.Filter;

import java.io.IOException;
import java.io.PrintWriter;

// AuthenticationFilter.java
@Component
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();
        String path = httpRequest.getRequestURI();

        if (path.contains("/loginPage") || path.contains("/loginUser") || path.contains("/reset") || path.contains("/forgot") ||
                path.contains("/css") || path.contains("/js") || path.contains("/images")) {
            chain.doFilter(request, response);
            return;
        }

        if (session.getAttribute("loggedInUser") == null) {
            httpResponse.sendRedirect("http://localhost:8082/utilisateur/loginPage?error=Veuillez Se Connecter D'abord");
            return;
        }

        chain.doFilter(request, response);
    }
}