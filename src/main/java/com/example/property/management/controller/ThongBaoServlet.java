package com.example.property.management.controller;

import com.example.property.management.dao.ThongBaoDAO;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.ThongBao;
import com.example.property.management.model.enums.VaiTro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ThongBaoServlet", urlPatterns = { "/thong-bao" })
public class ThongBaoServlet extends HttpServlet {

    private ThongBaoDAO thongBaoDAO;

    @Override
    public void init() throws ServletException {
        this.thongBaoDAO = new ThongBaoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            switch (action) {
                case "markRead": {
                    String idStr = request.getParameter("id");
                    if ("all".equals(idStr)) {
                        thongBaoDAO.markAllRead(user.getId());
                    } else {
                        thongBaoDAO.markAsRead(Integer.parseInt(idStr));
                    }
                    response.sendRedirect(request.getContextPath() + "/thong-bao");
                    break;
                }
                default: {
                    boolean isAdmin = user.getVaiTro() == VaiTro.ADMIN || user.getVaiTro() == VaiTro.QUAN_LY;
                    if (isAdmin) {
                        request.setAttribute("thongBaoList", thongBaoDAO.findAll());
                    } else {
                        request.setAttribute("thongBaoList", thongBaoDAO.findByNguoiNhan(user.getId()));
                    }
                    request.setAttribute("unreadCount", thongBaoDAO.countUnread(user.getId()));
                    request.setAttribute("isAdmin", isAdmin);
                    request.setAttribute("pageTitle", "Thông Báo");
                    request.getRequestDispatcher("/views/thongbao/thongbao-list.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/thongbao/thongbao-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        if (user == null || (user.getVaiTro() != VaiTro.ADMIN && user.getVaiTro() != VaiTro.QUAN_LY)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        try {
            ThongBao tb = new ThongBao();
            String nguoiNhanStr = request.getParameter("nguoiNhanId");
            tb.setNguoiNhanId((nguoiNhanStr == null || nguoiNhanStr.isBlank()) ? null : Integer.parseInt(nguoiNhanStr));
            tb.setTieuDe(request.getParameter("tieuDe"));
            tb.setNoiDung(request.getParameter("noiDung"));
            tb.setLoai(request.getParameter("loai") != null ? request.getParameter("loai") : "THONG_TIN");
            thongBaoDAO.insert(tb);
            response.sendRedirect(request.getContextPath() + "/thong-bao?message=Sent");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/thong-bao?error=" + e.getMessage());
        }
    }
}
