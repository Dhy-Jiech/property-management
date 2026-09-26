package com.example.property.management.controller;

import com.example.property.management.dao.TaiKhoanDAO;
import com.example.property.management.model.TaiKhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = { "/login", "/logout", "/profile" })
public class AuthServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO;

    @Override
    public void init() throws ServletException {
        this.taiKhoanDAO = new TaiKhoanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null)
                session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?message=LoggedOut");
            return;
        }

        if ("/profile".equals(path)) {
            request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân");
            request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
            return;
        }

        // Login page
        request.setAttribute("pageTitle", "Đăng Nhập");
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        // Change password from profile page
        if ("/profile".equals(path)) {
            handleChangePassword(request, response);
            return;
        }

        // Login POST
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            TaiKhoan user = taiKhoanDAO.authenticate(username, password);
            if (user != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("errorMessage", "Tài khoản hoặc mật khẩu không chính xác!");
                request.setAttribute("username", username);
                request.setAttribute("pageTitle", "Đăng Nhập");
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi kết nối CSDL: " + e.getMessage());
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        try {
            // Verify old password
            TaiKhoan check = taiKhoanDAO.authenticate(user.getUsername(), oldPassword);
            if (check == null) {
                request.setAttribute("errorMessage", "Mật khẩu cũ không đúng!");
                request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân");
                request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
                return;
            }
            if (!newPassword.equals(confirmPass)) {
                request.setAttribute("errorMessage", "Mật khẩu mới không khớp!");
                request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân");
                request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
                return;
            }
            taiKhoanDAO.updatePassword(user.getId(), newPassword);
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
            request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân");
            request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân");
            request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
        }
    }
}
