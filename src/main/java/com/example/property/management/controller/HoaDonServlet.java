package com.example.property.management.controller;

import com.example.property.management.dao.ThanhToanDAO;
import com.example.property.management.model.HoaDon;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.ThanhToan;
import com.example.property.management.model.enums.PhuongThucThanhToan;
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
    private ThanhToanDAO thanhToanDAO;

    @Override
    public void init() throws ServletException {
        this.hoaDonService = new HoaDonService();
        this.sinhVienService = new SinhVienService();
        this.thanhToanDAO = new ThanhToanDAO();
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
                case "payDetail":
                    showPayForm(request, response);
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
            request.setAttribute("pageTitle", "Thông Báo Lỗi");
            request.getRequestDispatcher("/views/hoadon/hoadon-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("recordPayment".equals(action)) {
                recordPayment(request, response);
            } else {
                createHoaDon(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listHoaDon(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user != null && user.getVaiTro() == com.example.property.management.model.enums.VaiTro.SINH_VIEN) {
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
                        if (rs.next()) {
                            svId = rs.getInt(1);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            java.util.List<HoaDon> list = (svId > 0)
                    ? new com.example.property.management.dao.HoaDonDAO().findBySinhVienId(svId)
                    : new java.util.ArrayList<>();
            request.setAttribute("hoaDonList", list);
        } else {
            request.setAttribute("hoaDonList", hoaDonService.getAllHoaDon());
        }

        request.setAttribute("pageTitle", "Quản Lý Hóa Đơn");
        request.getRequestDispatcher("/views/hoadon/hoadon-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        if (user != null && user.getVaiTro() == com.example.property.management.model.enums.VaiTro.SINH_VIEN) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("pageTitle", "Tạo Hóa Đơn Mới");
        request.getRequestDispatcher("/views/hoadon/hoadon-form.jsp").forward(request, response);
    }

    private void showPayForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        HoaDon hd = hoaDonService.getHoaDonById(id);
        request.setAttribute("hoaDon", hd);
        request.setAttribute("thanhToanList", thanhToanDAO.findByHoaDonId(id));
        request.setAttribute("pageTitle", "Ghi Nhận Thanh Toán");
        request.getRequestDispatcher("/views/hoadon/thanhtoan-form.jsp").forward(request, response);
    }

    private void createHoaDon(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
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

    private void recordPayment(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        int hoaDonId = Integer.parseInt(request.getParameter("hoaDonId"));
        BigDecimal soTien = new BigDecimal(request.getParameter("soTien"));
        String ptStr = request.getParameter("phuongThuc");
        PhuongThucThanhToan phuongThuc = PhuongThucThanhToan.valueOf(ptStr);
        String maGiaoDich = request.getParameter("maGiaoDich");
        String nguoiXacNhan = (user != null) ? user.getUsername() : "system";

        ThanhToan tt = new ThanhToan();
        tt.setHoaDonId(hoaDonId);
        tt.setSoTien(soTien);
        tt.setPhuongThuc(phuongThuc);
        tt.setMaGiaoDich(maGiaoDich);
        tt.setNguoiXacNhan(nguoiXacNhan);

        thanhToanDAO.insert(tt);
        hoaDonService.markAsPaid(hoaDonId);
        response.sendRedirect(request.getContextPath() + "/hoadon?message=Paid");
    }

    private void markAsPaid(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        hoaDonService.markAsPaid(id);
        response.sendRedirect(request.getContextPath() + "/hoadon?message=Paid");
    }
}
