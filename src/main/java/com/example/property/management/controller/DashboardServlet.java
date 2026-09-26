package com.example.property.management.controller;

import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "DashboardServlet", urlPatterns = { "/dashboard", "/home" })
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user != null && user.getVaiTro() == VaiTro.SINH_VIEN) {
            // Student-specific metrics
            int svId = countQuery("SELECT id FROM sinh_vien WHERE user_id = " + user.getId());
            if (svId == 0) {
                svId = countQuery("SELECT id FROM sinh_vien WHERE mssv = '" + user.getUsername() + "'");
            }

            int svUnpaidCount = countQuery("SELECT COUNT(*) FROM hoa_don WHERE (sinh_vien_id = " + svId
                    + " OR sinh_vien_id = " + user.getId() + ") AND trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN')");
            String svDebt = scalarQuery("SELECT COALESCE(SUM(tong_tien),0) FROM hoa_don WHERE (sinh_vien_id = " + svId
                    + " OR sinh_vien_id = " + user.getId() + ") AND trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN')");
            int svUnreadNotify = countQuery("SELECT COUNT(*) FROM thong_bao WHERE da_doc = 0 AND (nguoi_nhan_id = "
                    + user.getId() + " OR nguoi_nhan_id IS NULL)");
            int svPendingRepair = countQuery("SELECT COUNT(*) FROM yeu_cau_sua_chua WHERE sinh_vien_id = " + svId
                    + " AND trang_thai != 'DA_XU_LY'");
            String svRoomName = scalarQuery(
                    "SELECT p.ten_phong FROM hop_dong h JOIN phong p ON h.phong_id = p.id WHERE h.sinh_vien_id = "
                            + svId + " AND h.trang_thai = 'DANG_HIEU_LUC' LIMIT 1");

            request.setAttribute("isStudent", true);
            request.setAttribute("svRoomName",
                    (svRoomName != null && !svRoomName.equals("0")) ? svRoomName : "Chưa xếp phòng");
            request.setAttribute("svUnpaidCount", svUnpaidCount);
            request.setAttribute("svDebt", svDebt);
            request.setAttribute("svUnreadNotify", svUnreadNotify);
            request.setAttribute("svPendingRepair", svPendingRepair);
        } else {
            request.setAttribute("isStudent", false);
        }

        // General / Admin Metrics
        int tongSoPhong = countQuery("SELECT COUNT(*) FROM phong");
        int phongTrong = countQuery("SELECT COUNT(*) FROM phong WHERE trang_thai = 'TRONG'");
        int phongDangChoThue = countQuery("SELECT COUNT(*) FROM phong WHERE trang_thai = 'DANG_CHO_THUE'");
        int phongBaoTri = countQuery("SELECT COUNT(*) FROM phong WHERE trang_thai = 'BAO_TRI'");

        // Sinh viên & hợp đồng
        int tongSinhVien = countQuery("SELECT COUNT(*) FROM sinh_vien");
        int hopDongHieuLuc = countQuery("SELECT COUNT(*) FROM hop_dong WHERE trang_thai = 'DANG_HIEU_LUC'");
        int hopDongSapHetHan = countQuery(
                "SELECT COUNT(*) FROM hop_dong WHERE trang_thai = 'DANG_HIEU_LUC' " +
                        "AND ngay_ket_thuc BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)");

        // Hóa đơn / công nợ
        int hoaDonChuaThanhToan = countQuery("SELECT COUNT(*) FROM hoa_don WHERE trang_thai = 'CHUA_THANH_TOAN'");
        int hoaDonQuaHan = countQuery("SELECT COUNT(*) FROM hoa_don WHERE trang_thai = 'QUAN_HAN'");
        String tongCongNo = scalarQuery(
                "SELECT COALESCE(SUM(tong_tien),0) FROM hoa_don WHERE trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN')");

        // Yêu cầu chờ xử lý
        int yeuCauChoXuLy = countQuery("SELECT COUNT(*) FROM yeu_cau_sua_chua WHERE trang_thai = 'MOI'");
        int dangKyChoDuyet = countQuery("SELECT COUNT(*) FROM dang_ky_phong WHERE trang_thai = 'CHO_DUYET'");

        request.setAttribute("tongSoPhong", tongSoPhong);
        request.setAttribute("phongTrong", phongTrong);
        request.setAttribute("phongDangChoThue", phongDangChoThue);
        request.setAttribute("phongBaoTri", phongBaoTri);
        request.setAttribute("tongSinhVien", tongSinhVien);
        request.setAttribute("hopDongHieuLuc", hopDongHieuLuc);
        request.setAttribute("hopDongSapHetHan", hopDongSapHetHan);
        request.setAttribute("hoaDonChuaThanhToan", hoaDonChuaThanhToan);
        request.setAttribute("hoaDonQuaHan", hoaDonQuaHan);
        request.setAttribute("tongCongNo", tongCongNo);
        request.setAttribute("yeuCauChoXuLy", yeuCauChoXuLy);
        request.setAttribute("dangKyChoDuyet", dangKyChoDuyet);

        request.setAttribute("pageTitle", "Dashboard - Tổng Quan");
        request.getRequestDispatcher("/views/dashboard/dashboard.jsp").forward(request, response);
    }

    private int countQuery(String sql) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private String scalarQuery(String sql) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next())
                return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "0";
    }
}
