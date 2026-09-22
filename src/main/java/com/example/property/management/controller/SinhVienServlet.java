package com.example.property.management.controller;

import com.example.property.management.model.SinhVien;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "SinhVienServlet", urlPatterns = { "/sinhvien" })
public class SinhVienServlet extends HttpServlet {

    private SinhVienService sinhVienService;

    @Override
    public void init() throws ServletException {
        this.sinhVienService = new SinhVienService();
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
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteSinhVien(request, response);
                    break;
                default:
                    listSinhVien(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listSinhVien(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            saveSinhVien(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể lưu thông tin sinh viên: " + e.getMessage());
            showNewForm(request, response);
        }
    }

    private void listSinhVien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        List<SinhVien> list = sinhVienService.getAllSinhVien();
        request.setAttribute("sinhVienList", list);
        request.setAttribute("pageTitle", "Danh Sách Sinh Viên");
        request.getRequestDispatcher("/views/sinhvien/sinhvien-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("sinhVien", new SinhVien());
        request.setAttribute("pageTitle", "Thêm Sinh Viên Mới");
        request.getRequestDispatcher("/views/sinhvien/sinhvien-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        SinhVien sv = sinhVienService.getSinhVienById(id);
        request.setAttribute("sinhVien", sv);
        request.setAttribute("pageTitle", "Chỉnh Sửa Sinh Viên");
        request.getRequestDispatcher("/views/sinhvien/sinhvien-form.jsp").forward(request, response);
    }

    private void saveSinhVien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String idStr = request.getParameter("id");
        int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;

        String hoTen = request.getParameter("hoTen");
        String ngaySinhStr = request.getParameter("ngaySinh");
        LocalDate ngaySinh = (ngaySinhStr != null && !ngaySinhStr.isEmpty()) ? LocalDate.parse(ngaySinhStr) : null;
        String gioiTinh = request.getParameter("gioiTinh");
        String cccd = request.getParameter("cccd");
        String soDienThoai = request.getParameter("soDienThoai");
        String email = request.getParameter("email");
        String diaChiQueQuan = request.getParameter("diaChiQueQuan");
        String truong = request.getParameter("truong");

        SinhVien sv = SinhVien.builder()
                .id(id)
                .hoTen(hoTen)
                .ngaySinh(ngaySinh)
                .gioiTinh(gioiTinh)
                .cccd(cccd)
                .soDienThoai(soDienThoai)
                .email(email)
                .diaChiQueQuan(diaChiQueQuan)
                .truong(truong)
                .build();

        sinhVienService.saveSinhVien(sv);
        response.sendRedirect(request.getContextPath() + "/sinhvien?message=Saved");
    }

    private void deleteSinhVien(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        sinhVienService.deleteSinhVien(id);
        response.sendRedirect(request.getContextPath() + "/sinhvien?message=Deleted");
    }
}
