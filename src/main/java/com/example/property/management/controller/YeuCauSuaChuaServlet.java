package com.example.property.management.controller;

import com.example.property.management.dao.YeuCauSuaChuaDAO;
import com.example.property.management.model.YeuCauSuaChua;
import com.example.property.management.model.enums.TrangThaiSuaChua;
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
            try {
                listSuaChua(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            createSuaChua(request, response);
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
            throws ServletException, IOException, Exception {
        request.setAttribute("suaChuaList", suachuaDAO.findAll());
        request.setAttribute("pageTitle", "Yêu Cầu Sửa Chữa");
        request.getRequestDispatcher("/views/suachua/suachua-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Gửi Yêu Cầu Sửa Chữa");
        request.getRequestDispatcher("/views/suachua/suachua-form.jsp").forward(request, response);
    }

    private void createSuaChua(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        String noiDung = request.getParameter("noiDung");

        YeuCauSuaChua y = YeuCauSuaChua.builder()
                .phongId(phongId)
                .noiDung(noiDung)
                .trangThai(TrangThaiSuaChua.MOI)
                .build();

        suachuaDAO.insert(y);
        response.sendRedirect(request.getContextPath() + "/suachua?message=Created");
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String statusStr = request.getParameter("status");
        TrangThaiSuaChua status = TrangThaiSuaChua.valueOf(statusStr);
        suachuaDAO.updateStatus(id, status);
        response.sendRedirect(request.getContextPath() + "/suachua?message=Updated");
    }
}
