package com.example.property.management.controller;

import com.example.property.management.dao.YeuCauSuaChuaDAO;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.YeuCauSuaChua;
import com.example.property.management.model.enums.TrangThaiSuaChua;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.PhongService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "YeuCauSuaChuaServlet", urlPatterns = { "/suachua" })
public class YeuCauSuaChuaServlet extends HttpServlet {

    private YeuCauSuaChuaDAO suachuaDAO;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.suachuaDAO = new YeuCauSuaChuaDAO();
        this.phongService = new PhongService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "update":
                    updateStatus(request, response);
                    break;
                default:
                    listSuaChua(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("pageTitle", "Thông Báo Lỗi");
            request.getRequestDispatcher("/views/suachua/suachua-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("respond".equals(action)) {
                addResponse(request, response);
            } else {
                createSuaChua(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể gửi yêu cầu: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listSuaChua(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user != null && user.getVaiTro() == VaiTro.SINH_VIEN) {
            int svId = 0;
            if (user.getSinhVienId() != null) {
                svId = user.getSinhVienId().intValue();
            } else {
                try (java.sql.Connection conn = com.example.property.management.util.DBConnection.getConnection();
                        java.sql.PreparedStatement stmt = conn
                                .prepareStatement("SELECT id FROM sinh_vien WHERE user_id = ? OR mssv = ?")) {
                    stmt.setInt(1, user.getId());
                    stmt.setString(2, user.getUsername() != null ? user.getUsername() : "");
                    try (java.sql.ResultSet rs = stmt.executeQuery()) {
                        if (rs.next())
                            svId = rs.getInt(1);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            final int filterSvId = svId;
            java.util.List<YeuCauSuaChua> list = new java.util.ArrayList<>(suachuaDAO.findAll());
            if (filterSvId > 0) {
                list.removeIf(y -> y.getSinhVienId() != filterSvId);
            } else {
                list.clear();
            }
            request.setAttribute("suaChuaList", list);
        } else {
            request.setAttribute("suaChuaList", suachuaDAO.findAll());
        }

        request.setAttribute("pageTitle", "Yêu Cầu Sửa Chữa & Khiếu Nại");
        request.getRequestDispatcher("/views/suachua/suachua-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Gửi Yêu Cầu Sửa Chữa");
        request.getRequestDispatcher("/views/suachua/suachua-form.jsp").forward(request, response);
    }

    private void createSuaChua(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        int phongId = Integer.parseInt(request.getParameter("phongId"));
        String noiDung = request.getParameter("noiDung");

        YeuCauSuaChua y = YeuCauSuaChua.builder()
                .phongId(phongId)
                .noiDung(noiDung)
                .trangThai(TrangThaiSuaChua.MOI)
                .build();

        // Set sinhVienId from session if SINH_VIEN
        if (user != null && user.getVaiTro() == VaiTro.SINH_VIEN && user.getSinhVienId() != null) {
            y.setSinhVienId(user.getSinhVienId().intValue());
        } else {
            String svIdStr = request.getParameter("sinhVienId");
            if (svIdStr != null && !svIdStr.isBlank()) {
                y.setSinhVienId(Integer.parseInt(svIdStr));
            }
        }

        suachuaDAO.insert(y);
        response.sendRedirect(request.getContextPath() + "/suachua?message=Created");
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        TrangThaiSuaChua status = TrangThaiSuaChua.valueOf(request.getParameter("status"));
        suachuaDAO.updateStatus(id, status);
        response.sendRedirect(request.getContextPath() + "/suachua?message=Updated");
    }

    private void addResponse(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String phanHoi = request.getParameter("phanHoi");
        String statusStr = request.getParameter("trangThai");
        TrangThaiSuaChua status = (statusStr != null && !statusStr.isBlank())
                ? TrangThaiSuaChua.valueOf(statusStr)
                : TrangThaiSuaChua.DANG_XU_LY;
        suachuaDAO.updateResponse(id, phanHoi, status);
        response.sendRedirect(request.getContextPath() + "/suachua?message=Responded");
    }
}
