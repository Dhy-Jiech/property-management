package com.example.property.management.controller;

import com.example.property.management.model.TaiKhoan;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Allow static resources and public login page
        if (path.startsWith("/login") || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.endsWith(".css") || path.endsWith(".js")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Role-based Access Control
        boolean isAllowed = true;
        if (path.startsWith("/taikhoan")) {
            // Account management is strictly for ADMIN
            if (user.getVaiTro() != com.example.property.management.model.enums.VaiTro.ADMIN) {
                isAllowed = false;
            }
        } else if (path.startsWith("/dien-nuoc")) {
            // Electricity & Water meter entry is for ADMIN, QUAN_LY, NHAN_VIEN
            if (user.getVaiTro() == com.example.property.management.model.enums.VaiTro.SINH_VIEN) {
                isAllowed = false;
            }
        }

        if (!isAllowed) {
            request.getSession().setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng này!");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        chain.doFilter(req, res);
    }
}
