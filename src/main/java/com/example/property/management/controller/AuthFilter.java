package com.example.property.management.controller;

import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.VaiTro;

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

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Allow static resources and public pages
        if (path.startsWith("/login") || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.startsWith("/assets/")
                || path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png")
                || path.endsWith(".jpg") || path.endsWith(".ico") || path.endsWith(".html")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        VaiTro role = user.getVaiTro();
        boolean allowed = checkAccess(path, role);

        if (!allowed) {
            request.getSession().setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng này!");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        chain.doFilter(req, res);
    }

    private boolean checkAccess(String path, VaiTro role) {
        // ADMIN has access everywhere
        if (role == VaiTro.ADMIN)
            return true;

        // Account management: ADMIN, QUAN_LY
        if (path.startsWith("/taikhoan"))
            return role == VaiTro.QUAN_LY;

        // Khu/Toa/Tang management: ADMIN, QUAN_LY
        if (path.startsWith("/khu")) {
            return role == VaiTro.QUAN_LY;
        }

        // Fee management: ADMIN, QUAN_LY
        if (path.startsWith("/khoan-phi")) {
            return role == VaiTro.QUAN_LY;
        }

        // Electricity & water entry: ADMIN, QUAN_LY, NHAN_VIEN
        if (path.startsWith("/dien-nuoc")) {
            return role == VaiTro.QUAN_LY || role == VaiTro.NHAN_VIEN;
        }

        // Contract management: ADMIN, QUAN_LY view/create; NHAN_VIEN view; SINH_VIEN
        // view only
        // (No further restriction needed here – handled by JSP role checks)

        // SINH_VIEN restrictions: cannot access student list, cannot manage assets
        // directly
        if (role == VaiTro.SINH_VIEN) {
            // Students cannot manage other students
            if (path.startsWith("/sinhvien"))
                return false;
            // Students cannot access asset management page
            if (path.startsWith("/taisan"))
                return false;
        }

        return true;
    }

    /**
     * Heuristic: POST method or action=delete/insert/update implies write operation
     */
    private boolean isWriteOperation(String path) {
        // We cannot easily check request method in this helper, so rely on action param
        // check in servlet
        return false; // conservative: allow, let servlet enforce
    }
}
