package com.example.property.management.controller;

import com.example.property.management.dao.TaiSanDAO;
import com.example.property.management.model.TaiSan;
import com.example.property.management.service.PhongService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "TaiSanServlet", urlPatterns = { "/taisan" })
public class TaiSanServlet extends HttpServlet {

    private TaiSanDAO taiSanDAO;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.taiSanDAO = new TaiSanDAO();
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
                case "delete":
                    deleteTaiSan(request, response);
                    break;
                default:
                    listTaiSan(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listTaiSan(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            createTaiSan(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể thêm tài sản: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listTaiSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("taiSanList", taiSanDAO.findAll());
        request.setAttribute("pageTitle", "Quản Lý Tài Sản");
        request.getRequestDispatcher("/views/taisan/taisan-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Thêm Tài Sản Mới");
        request.getRequestDispatcher("/views/taisan/taisan-form.jsp").forward(request, response);
    }

    private void createTaiSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String tenTaiSan = request.getParameter("tenTaiSan");
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        String tinhTrang = request.getParameter("tinhTrang");

        TaiSan t = TaiSan.builder()
                .tenTaiSan(tenTaiSan)
                .phongId(phongId)
                .soLuong(soLuong)
                .tinhTrang(tinhTrang)
                .build();

        taiSanDAO.insert(t);
        response.sendRedirect(request.getContextPath() + "/taisan?message=Created");
    }

    private void deleteTaiSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        taiSanDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/taisan?message=Deleted");
    }
}
