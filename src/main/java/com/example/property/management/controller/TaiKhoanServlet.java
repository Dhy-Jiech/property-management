package com.example.property.management.controller;

import com.example.property.management.dao.TaiKhoanDAO;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.TrangThaiTaiKhoan;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "TaiKhoanServlet", urlPatterns = { "/taikhoan" })
public class TaiKhoanServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO;
    private SinhVienService sinhVienService;

    @Override
    public void init() throws ServletException {
        this.taiKhoanDAO = new TaiKhoanDAO();
        this.sinhVienService = new SinhVienService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "toggleStatus":
                    toggleStatus(request, response);
                    break;
                case "delete":
                    deleteAccount(request, response);
                    break;
                default:
                    listAccounts(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listAccounts(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("insert".equals(action)) {
                insertAccount(request, response);
            } else if ("update".equals(action)) {
                updateAccount(request, response);
            } else if ("changePassword".equals(action)) {
                changePassword(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi thao tác: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listAccounts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<TaiKhoan> list = taiKhoanDAO.findAll();
        request.setAttribute("taiKhoanList", list);
        request.setAttribute("pageTitle", "Quản Lý Tài Khoản System");
        request.getRequestDispatcher("/views/taikhoan/taikhoan-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("pageTitle", "Cấp Tài Khoản Mới");
        request.getRequestDispatcher("/views/taikhoan/taikhoan-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        TaiKhoan acc = taiKhoanDAO.findById(id);
        request.setAttribute("account", acc);
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("pageTitle", "Cập Nhật Tài Khoản");
        request.getRequestDispatcher("/views/taikhoan/taikhoan-form.jsp").forward(request, response);
    }

    private void insertAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String vaiTroStr = request.getParameter("vaiTro");
        String svIdStr = request.getParameter("sinhVienId");

        VaiTro vaiTro = VaiTro.valueOf(vaiTroStr);
        Long svId = (svIdStr != null && !svIdStr.isBlank()) ? Long.parseLong(svIdStr) : null;

        TaiKhoan acc = TaiKhoan.builder()
                .username(username)
                .passwordHash(password)
                .vaiTro(vaiTro)
                .trangThai(TrangThaiTaiKhoan.HOAT_DONG)
                .sinhVienId(svId)
                .build();

        taiKhoanDAO.insert(acc);
        response.sendRedirect(request.getContextPath() + "/taikhoan?message=Created");
    }

    private void updateAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String vaiTroStr = request.getParameter("vaiTro");
        String trangThaiStr = request.getParameter("trangThai");
        String svIdStr = request.getParameter("sinhVienId");

        TaiKhoan acc = taiKhoanDAO.findById(id);
        if (acc != null) {
            acc.setVaiTro(VaiTro.valueOf(vaiTroStr));
            acc.setTrangThai(TrangThaiTaiKhoan.valueOf(trangThaiStr));
            acc.setSinhVienId((svIdStr != null && !svIdStr.isBlank()) ? Long.parseLong(svIdStr) : null);
            taiKhoanDAO.update(acc);
        }
        response.sendRedirect(request.getContextPath() + "/taikhoan?message=Updated");
    }

    private void toggleStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        TaiKhoan acc = taiKhoanDAO.findById(id);
        if (acc != null) {
            TrangThaiTaiKhoan nextStatus = (acc.getTrangThai() == TrangThaiTaiKhoan.HOAT_DONG)
                    ? TrangThaiTaiKhoan.DA_KHOA
                    : TrangThaiTaiKhoan.HOAT_DONG;
            taiKhoanDAO.updateStatus(id, nextStatus);
        }
        response.sendRedirect(request.getContextPath() + "/taikhoan?message=StatusToggled");
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String newPassword = request.getParameter("newPassword");
        taiKhoanDAO.updatePassword(id, newPassword);
        response.sendRedirect(request.getContextPath() + "/taikhoan?message=PasswordChanged");
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        taiKhoanDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/taikhoan?message=Deleted");
    }
}
