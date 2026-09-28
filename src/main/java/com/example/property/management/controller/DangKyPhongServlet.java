package com.example.property.management.controller;

import com.example.property.management.dao.DangKyPhongDAO;
import com.example.property.management.dao.LichSuPhongDAO;
import com.example.property.management.dao.ThongBaoDAO;
import com.example.property.management.model.DangKyPhong;
import com.example.property.management.model.LichSuPhong;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.ThongBao;
import com.example.property.management.model.enums.LoaiYeuCauDangKy;
import com.example.property.management.model.enums.TrangThaiDangKy;
import com.example.property.management.service.PhongService;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.example.property.management.util.DBConnection;

@WebServlet(name = "DangKyPhongServlet", urlPatterns = { "/dangky" })
public class DangKyPhongServlet extends HttpServlet {

    private DangKyPhongDAO dangKyDAO;
    private SinhVienService sinhVienService;
    private PhongService phongService;
    private LichSuPhongDAO lichSuPhongDAO;
    private ThongBaoDAO thongBaoDAO;

    @Override
    public void init() throws ServletException {
        this.dangKyDAO = new DangKyPhongDAO();
        this.sinhVienService = new SinhVienService();
        this.phongService = new PhongService();
        this.lichSuPhongDAO = new LichSuPhongDAO();
        this.thongBaoDAO = new ThongBaoDAO();
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
                    processApproval(request, response, TrangThaiDangKy.DA_DUYET);
                    break;
                case "reject":
                    processApproval(request, response, TrangThaiDangKy.TU_CHOI);
                    break;
                default:
                    listDangKy(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("pageTitle", "Thông Báo Lỗi");
            request.getRequestDispatcher("/views/dangky/dangky-list.jsp").forward(request, response);
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
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user != null && user.getVaiTro() == com.example.property.management.model.enums.VaiTro.SINH_VIEN) {
            int svId = 0;
            if (user.getSinhVienId() != null) {
                svId = user.getSinhVienId().intValue();
            } else {
                try (Connection conn = DBConnection.getConnection();
                        PreparedStatement stmt = conn
                                .prepareStatement("SELECT id FROM sinh_vien WHERE user_id = ? OR mssv = ?")) {
                    stmt.setInt(1, user.getId());
                    stmt.setString(2, user.getUsername() != null ? user.getUsername() : "");
                    try (java.sql.ResultSet rs = stmt.executeQuery()) {
                        if (rs.next())
                            svId = rs.getInt(1);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            final int filterSvId = svId;
            java.util.List<DangKyPhong> list = new java.util.ArrayList<>(dangKyDAO.findAll());
            if (filterSvId > 0) {
                list.removeIf(d -> d.getSinhVienId() != filterSvId);
            } else {
                list.clear();
            }
            request.setAttribute("dangKyList", list);
        } else {
            request.setAttribute("dangKyList", dangKyDAO.findAll());
        }

        request.setAttribute("pageTitle", "Đăng Ký & Đổi Phòng");
        request.getRequestDispatcher("/views/dangky/dangky-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Đăng Ký / Đổi Phòng");
        request.getRequestDispatcher("/views/dangky/dangky-form.jsp").forward(request, response);
    }

    private void createDangKy(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        int sinhVienId;
        // If SINH_VIEN role, use their own sinhVienId from session
        if (user != null && user.getVaiTro() == com.example.property.management.model.enums.VaiTro.SINH_VIEN
                && user.getSinhVienId() != null) {
            sinhVienId = user.getSinhVienId().intValue();
        } else {
            sinhVienId = Integer.parseInt(request.getParameter("sinhVienId"));
        }

        int phongId = Integer.parseInt(request.getParameter("phongId"));
        LoaiYeuCauDangKy loaiYeuCau = LoaiYeuCauDangKy.valueOf(request.getParameter("loaiYeuCau"));
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

    private void processApproval(HttpServletRequest request, HttpServletResponse response,
            TrangThaiDangKy status) throws Exception {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        int nguoiDuyetId = (user != null) ? user.getId() : 1;
        String nguoiDuyetName = (user != null && user.getUsername() != null) ? user.getUsername() : "system";

        int id = Integer.parseInt(request.getParameter("id"));
        DangKyPhong dk = dangKyDAO.findById(id);

        dangKyDAO.updateStatusWithApprover(id, status, nguoiDuyetId);

        if (dk != null && status == TrangThaiDangKy.DA_DUYET) {
            // Update room occupancy count
            updatePhongSoNguoi(dk.getPhongId(), dk.getLoaiYeuCau());

            // Record room history
            LichSuPhong lsp = new LichSuPhong();
            lsp.setSinhVienId(dk.getSinhVienId());
            if (dk.getLoaiYeuCau() == LoaiYeuCauDangKy.CHUYEN_PHONG) {
                lsp.setPhongCu(null); // previous room can be tracked via history
            }
            lsp.setPhongMoi(dk.getPhongId());
            lsp.setLyDo(dk.getLyDo() != null ? dk.getLyDo() : dk.getLoaiYeuCau().name());
            lsp.setNguoiXuLy(String.valueOf(nguoiDuyetId));
            lichSuPhongDAO.insert(lsp);

            // Send notification to student
            try {
                ThongBao tb = new ThongBao();
                tb.setNguoiNhanId(0); // 0 = broadcast to all; ThongBaoDAO handles NULL in SQL
                tb.setTieuDe("Yêu cầu đăng ký phòng đã được duyệt");
                tb.setNoiDung("Yêu cầu (ID: " + id + ") đã được chấp thuận bởi " + nguoiDuyetName);
                tb.setLoai("DUYET_PHONG");
                thongBaoDAO.insert(tb);
            } catch (Exception e) {
                e.printStackTrace(); // non-critical
            }
        }

        if (dk != null && status == TrangThaiDangKy.DA_DUYET &&
                (dk.getLoaiYeuCau() == LoaiYeuCauDangKy.DANG_KY_MOI
                        || dk.getLoaiYeuCau() == LoaiYeuCauDangKy.CHUYEN_PHONG)) {
            response.sendRedirect(request.getContextPath() + "/hopdong?action=new&sinhVienId=" + dk.getSinhVienId()
                    + "&phongId=" + dk.getPhongId() + "&message=ApprovedAndCreateContract");
        } else {
            response.sendRedirect(request.getContextPath() + "/dangky?message=Updated");
        }
    }

    /** Increment or decrement so_nguoi_hien_tai based on request type */
    private void updatePhongSoNguoi(int phongId, LoaiYeuCauDangKy loai) {
        String sql;
        if (loai == LoaiYeuCauDangKy.HUY_PHONG) {
            sql = "UPDATE phong SET so_nguoi_hien_tai = GREATEST(0, so_nguoi_hien_tai - 1) WHERE id = ?";
        } else {
            // DANG_KY_MOI or CHUYEN_PHONG
            sql = "UPDATE phong SET so_nguoi_hien_tai = so_nguoi_hien_tai + 1 WHERE id = ? AND so_nguoi_hien_tai < suc_chua";
        }
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, phongId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
