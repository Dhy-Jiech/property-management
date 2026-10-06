package com.example.property.management.controller;

import com.example.property.management.dao.KhoanPhiDAO;
import com.example.property.management.model.KhoanPhi;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.TrangThaiKhoanPhi;
import com.example.property.management.model.enums.VaiTro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "KhoanPhiServlet", urlPatterns = { "/khoanphi", "/khoan-phi" })
public class KhoanPhiServlet extends HttpServlet {

    private KhoanPhiDAO khoanPhiDAO;

    @Override
    public void init() throws ServletException {
        this.khoanPhiDAO = new KhoanPhiDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Allow all staff, managers, and admins
        if (!hasAccess(request)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        String action = request.getParameter("action");
        if (action == null)
            action = "list";
        try {
            switch (action) {
                case "new":
                    request.setAttribute("pageTitle", "Thêm Khoản Phí Mới");
                    request.getRequestDispatcher("/views/khoanphi/khoanphi-form.jsp").forward(request, response);
                    break;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("khoanPhi", khoanPhiDAO.findById(id));
                    request.setAttribute("pageTitle", "Cập Nhật Khoản Phí");
                    request.getRequestDispatcher("/views/khoanphi/khoanphi-form.jsp").forward(request, response);
                    break;
                case "delete":
                    khoanPhiDAO.delete(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/khoanphi?message=Deleted");
                    break;
                default:
                    request.setAttribute("khoanPhiList", khoanPhiDAO.findAll());
                    request.setAttribute("pageTitle", "Quản Lý Khoản Phí");
                    request.getRequestDispatcher("/views/khoanphi/khoanphi-list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                request.setAttribute("khoanPhiList", khoanPhiDAO.findAll());
                request.setAttribute("pageTitle", "Quản Lý Khoản Phí");
                request.getRequestDispatcher("/views/khoanphi/khoanphi-list.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!hasAccess(request)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        String action = request.getParameter("action");
        try {
            String idStr = request.getParameter("id");
            KhoanPhi kp = new KhoanPhi();
            if (idStr != null && !idStr.isBlank())
                kp.setId(Integer.parseInt(idStr));
            kp.setTenKhoanPhi(request.getParameter("tenKhoanPhi"));
            kp.setDonGia(new BigDecimal(request.getParameter("donGia")));
            kp.setDonViTinh(request.getParameter("donViTinh"));
            String ts = request.getParameter("trangThai");
            kp.setTrangThai(ts != null ? TrangThaiKhoanPhi.valueOf(ts) : TrangThaiKhoanPhi.HOAT_DONG);

            if ("update".equals(action)) {
                khoanPhiDAO.update(kp);
            } else {
                khoanPhiDAO.insert(kp);
            }
            response.sendRedirect(request.getContextPath() + "/khoanphi?message=Saved");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("pageTitle", "Khoản Phí");
            request.getRequestDispatcher("/views/khoanphi/khoanphi-form.jsp").forward(request, response);
        }
    }

    private boolean hasAccess(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        if (user == null)
            return false;
        return user.getVaiTro() != VaiTro.SINH_VIEN;
    }
}
