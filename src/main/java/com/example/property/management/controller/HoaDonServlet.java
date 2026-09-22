package com.example.property.management.controller;

import com.example.property.management.model.HoaDon;
import com.example.property.management.model.enums.TrangThaiHoaDon;
import com.example.property.management.service.HoaDonService;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet(name = "HoaDonServlet", urlPatterns = { "/hoadon" })
public class HoaDonServlet extends HttpServlet {

    private HoaDonService hoaDonService;
    private SinhVienService sinhVienService;

    @Override
    public void init() throws ServletException {
        this.hoaDonService = new HoaDonService();
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
                case "pay":
                    markAsPaid(request, response);
                    break;
                default:
                    listHoaDon(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listHoaDon(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            createHoaDon(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tạo hóa đơn: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listHoaDon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("hoaDonList", hoaDonService.getAllHoaDon());
        request.setAttribute("pageTitle", "Quản Lý Hóa Đơn & Điện Nước");
        request.getRequestDispatcher("/views/hoadon/hoadon-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("pageTitle", "Tạo Hóa Đơn Tháng Mới");
        request.getRequestDispatcher("/views/hoadon/hoadon-form.jsp").forward(request, response);
    }

    private void createHoaDon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String maHoaDon = request.getParameter("maHoaDon");
        int sinhVienId = Integer.parseInt(request.getParameter("sinhVienId"));
        LocalDate kyThanhToan = LocalDate.parse(request.getParameter("kyThanhToan") + "-01");
        BigDecimal tienPhong = new BigDecimal(request.getParameter("tienPhong"));
        BigDecimal tienDien = new BigDecimal(request.getParameter("tienDien"));
        BigDecimal tienNuoc = new BigDecimal(request.getParameter("tienNuoc"));
        BigDecimal tongPhi = new BigDecimal(request.getParameter("tongPhi"));
        LocalDate hanThanhToan = LocalDate.parse(request.getParameter("hanThanhToan"));

        HoaDon hd = HoaDon.builder()
                .maHoaDon(maHoaDon)
                .sinhVienId(sinhVienId)
                .kyThanhToan(kyThanhToan)
                .tienPhong(tienPhong)
                .tienDien(tienDien)
                .tienNuoc(tienNuoc)
                .tongPhi(tongPhi)
                .hanThanhToan(hanThanhToan)
                .trangThai(TrangThaiHoaDon.CHUA_THANH_TOAN)
                .build();

        hoaDonService.createHoaDon(hd);
        response.sendRedirect(request.getContextPath() + "/hoadon?message=Created");
    }

    private void markAsPaid(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        hoaDonService.markAsPaid(id);
        response.sendRedirect(request.getContextPath() + "/hoadon?message=Paid");
    }
}
