package com.example.property.management.controller;

import com.example.property.management.dao.LichSuPhongDAO;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.VaiTro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LichSuPhongServlet", urlPatterns = { "/lich-su-phong" })
public class LichSuPhongServlet extends HttpServlet {

    private LichSuPhongDAO lichSuPhongDAO;

    @Override
    public void init() throws ServletException {
        this.lichSuPhongDAO = new LichSuPhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            boolean isSinhVien = user.getVaiTro() == VaiTro.SINH_VIEN;
            if (isSinhVien && user.getSinhVienId() != null) {
                request.setAttribute("lichSuList", lichSuPhongDAO.findBySinhVienId(user.getSinhVienId().intValue()));
            } else {
                request.setAttribute("lichSuList", lichSuPhongDAO.findAll());
            }
            request.setAttribute("pageTitle", "Lịch Sử Phòng");
            request.getRequestDispatcher("/views/lichsuphong/lichsuphong-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/lichsuphong/lichsuphong-list.jsp").forward(request, response);
        }
    }
}
