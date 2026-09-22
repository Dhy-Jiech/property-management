package com.example.property.management.controller;

import com.example.property.management.dao.DangKyPhongDAO;
import com.example.property.management.model.DangKyPhong;
import com.example.property.management.model.enums.LoaiYeuCauDangKy;
import com.example.property.management.model.enums.TrangThaiDangKy;
import com.example.property.management.service.PhongService;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DangKyPhongServlet", urlPatterns = { "/dangky" })
public class DangKyPhongServlet extends HttpServlet {

    private DangKyPhongDAO dangKyDAO;
    private SinhVienService sinhVienService;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.dangKyDAO = new DangKyPhongDAO();
        this.sinhVienService = new SinhVienService();
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
                case "approve":
                    updateStatus(request, response, TrangThaiDangKy.DA_DUYET);
                    break;
                case "reject":
                    updateStatus(request, response, TrangThaiDangKy.TU_CHOI);
                    break;
                default:
                    listDangKy(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listDangKy(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            createDangKy(request, response);
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

    private void listDangKy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("dangKyList", dangKyDAO.findAll());
        request.setAttribute("pageTitle", "Đăng Ký & Đổi Phòng");
        request.getRequestDispatcher("/views/dangky/dangky-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Đăng Ký Khởi Tạo / Đổi Phòng");
        request.getRequestDispatcher("/views/dangky/dangky-form.jsp").forward(request, response);
    }

    private void createDangKy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int sinhVienId = Integer.parseInt(request.getParameter("sinhVienId"));
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        String loaiYeuCauStr = request.getParameter("loaiYeuCau");
        LoaiYeuCauDangKy loaiYeuCau = LoaiYeuCauDangKy.valueOf(loaiYeuCauStr);
        String lyDo = request.getParameter("lyDo");

        DangKyPhong d = DangKyPhong.builder()
                .sinhVienId(sinhVienId)
                .phongId(phongId)
                .loaiYeuCau(loaiYeuCau)
                .lyDo(lyDo)
                .trangThai(TrangThaiDangKy.CHO_DUYET)
                .build();

        dangKyDAO.insert(d);
        response.sendRedirect(request.getContextPath() + "/dangky?message=Submitted");
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response, TrangThaiDangKy status)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        dangKyDAO.updateStatus(id, status);
        response.sendRedirect(request.getContextPath() + "/dangky?message=Updated");
    }
}
