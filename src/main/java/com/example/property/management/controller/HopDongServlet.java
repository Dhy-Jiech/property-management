package com.example.property.management.controller;

import com.example.property.management.model.HopDong;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.TrangThaiHopDong;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.HopDongService;
import com.example.property.management.service.PhongService;
import com.example.property.management.service.SinhVienService;
import com.example.property.management.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "HopDongServlet", urlPatterns = { "/hopdong" })
public class HopDongServlet extends HttpServlet {

    private HopDongService hopDongService;
    private SinhVienService sinhVienService;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.hopDongService = new HopDongService();
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
                case "sign":
                    showSignForm(request, response);
                    break;
                case "view":
                    viewHopDong(request, response);
                    break;
                case "cancel":
                    cancelHopDong(request, response);
                    break;
                default:
                    listHopDong(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listHopDong(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("submitSign".equals(action)) {
                submitStudentSignature(request, response);
            } else {
                createHopDong(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi xử lý hợp đồng: " + e.getMessage());
            try {
                if ("submitSign".equals(action)) {
                    showSignForm(request, response);
                } else {
                    showNewForm(request, response);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listHopDong(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        List<HopDong> list;
        if (user != null && user.getVaiTro() == VaiTro.SINH_VIEN) {
            int svId = getSinhVienIdForUser(user);
            list = hopDongService.getHopDongBySinhVienId(svId);
        } else {
            list = hopDongService.getAllHopDong();
        }

        request.setAttribute("hopDongList", list);
        request.setAttribute("pageTitle", "Danh Sách Hợp Đồng");
        request.getRequestDispatcher("/views/hopdong/hopdong-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String svIdParam = request.getParameter("sinhVienId");
        String pIdParam = request.getParameter("phongId");

        request.setAttribute("selectedSinhVienId", svIdParam);
        request.setAttribute("selectedPhongId", pIdParam);
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Lập Hợp Đồng Mới");
        request.getRequestDispatcher("/views/hopdong/hopdong-form.jsp").forward(request, response);
    }

    private void showSignForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        HopDong hd = hopDongService.getHopDongById(id);
        if (hd == null) {
            request.setAttribute("errorMessage", "Hợp đồng không tồn tại!");
            listHopDong(request, response);
            return;
        }
        request.setAttribute("hopDong", hd);
        request.setAttribute("pageTitle", "Xem & Ký Hợp Đồng");
        request.getRequestDispatcher("/views/hopdong/hopdong-sign.jsp").forward(request, response);
    }

    private void viewHopDong(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        HopDong hd = hopDongService.getHopDongById(id);
        if (hd == null) {
            request.setAttribute("errorMessage", "Hợp đồng không tồn tại!");
            listHopDong(request, response);
            return;
        }
        request.setAttribute("hopDong", hd);
        request.setAttribute("pageTitle", "Chi Tiết Hợp Đồng");
        request.getRequestDispatcher("/views/hopdong/hopdong-view.jsp").forward(request, response);
    }

    private void createHopDong(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String maHopDong = request.getParameter("maHopDong");
        int sinhVienId = Integer.parseInt(request.getParameter("sinhVienId"));
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        LocalDate ngayBatDau = LocalDate.parse(request.getParameter("ngayBatDau"));
        LocalDate ngayKetThuc = LocalDate.parse(request.getParameter("ngayKetThuc"));
        BigDecimal tienPhong = new BigDecimal(request.getParameter("tienPhong"));
        BigDecimal tienDatCoc = new BigDecimal(request.getParameter("tienDatCoc"));
        String chuKyBenA = request.getParameter("chuKyBenA");

        HopDong hd = HopDong.builder()
                .maHopDong(maHopDong)
                .sinhVienId(sinhVienId)
                .phongId(phongId)
                .ngayBatDau(ngayBatDau)
                .ngayKetThuc(ngayKetThuc)
                .tienPhong(tienPhong)
                .tienDatCoc(tienDatCoc)
                .chuKyBenA(chuKyBenA)
                .trangThai(TrangThaiHopDong.CHO_HIEU_LUC) // Waiting for student digital signature
                .build();

        hopDongService.createHopDong(hd);
        response.sendRedirect(request.getContextPath() + "/hopdong?message=CreatedWaitingSign");
    }

    private void submitStudentSignature(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String chuKyBenB = request.getParameter("chuKyBenB");

        hopDongService.signHopDongByStudent(id, chuKyBenB);
        response.sendRedirect(
                request.getContextPath() + "/hopdong?action=view&id=" + id + "&message=SignedSuccessfully");
    }

    private void cancelHopDong(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        hopDongService.cancelHopDong(id);
        response.sendRedirect(request.getContextPath() + "/hopdong?message=Cancelled");
    }

    private int getSinhVienIdForUser(TaiKhoan user) {
        if (user == null)
            return 0;
        if (user.getSinhVienId() != null)
            return user.getSinhVienId().intValue();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn
                        .prepareStatement("SELECT id FROM sinh_vien WHERE user_id = ? OR mssv = ?")) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, user.getUsername() != null ? user.getUsername() : "");
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
