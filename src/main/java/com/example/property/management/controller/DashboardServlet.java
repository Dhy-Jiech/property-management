package com.example.property.management.controller;

import com.example.property.management.dao.ThongBaoDAO;
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
            // Lấy id sinh viên qua tai_khoan.sinh_vien_id (theo schema thật)
            int svId = countQuery("SELECT COALESCE(sinh_vien_id, 0) FROM tai_khoan WHERE id = ?", user.getId());

            String debtCond = " FROM hoa_don h WHERE h.trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN') AND " +
                    "(h.phong_id IN (SELECT hd.phong_id FROM hop_dong hd WHERE hd.sinh_vien_id = ? AND hd.trang_thai = 'DANG_HIEU_LUC') "
                    +
                    " OR h.sinh_vien_id = ?)";
            int svUnpaidCount = countQuery("SELECT COUNT(*)" + debtCond, svId, svId);
            String svDebt = scalarQuery("SELECT COALESCE(SUM(h.tong_tien),0)" + debtCond, svId, svId);

            int svUnreadNotify = 0;
            try {
                svUnreadNotify = new ThongBaoDAO().countUnread(user.getId());
            } catch (Exception e) {
                e.printStackTrace();
            }

            int svPendingRepair = countQuery(
                    "SELECT COUNT(*) FROM yeu_cau_sua_chua WHERE sinh_vien_id = ? " +
                            "AND trang_thai <> 'DA_XU_LY'",
                    svId);

            String svRoomName = scalarQuery(
                    "SELECT CONCAT(p.ma_phong, ' - ', p.ten_phong) FROM hop_dong h " +
                            "JOIN phong p ON h.phong_id = p.id " +
                            "WHERE h.sinh_vien_id = ? AND h.trang_thai = 'DANG_HIEU_LUC' " +
                            "ORDER BY h.ngay_bat_dau DESC LIMIT 1",
                    svId);
            boolean hasRoom = svRoomName != null;

            request.setAttribute("isStudent", true);
            request.setAttribute("svRoomName", hasRoom ? svRoomName : "Chưa xếp phòng");
            request.setAttribute("svHasRoom", hasRoom);
            request.setAttribute("svUnpaidCount", svUnpaidCount);
            request.setAttribute("svDebt", svDebt != null ? svDebt : "0");
            request.setAttribute("svUnreadNotify", svUnreadNotify);
            request.setAttribute("svPendingRepair", svPendingRepair);
        } else {
            request.setAttribute("isStudent", false);
        }

        // Thống kê phòng: trạng thái tính theo số người / sức chứa
        int tongSoPhong = countQuery("SELECT COUNT(*) FROM phong");
        int phongBaoTri = countQuery("SELECT COUNT(*) FROM phong WHERE trang_thai = 'BAO_TRI'");
        int phongTrong = countQuery(
                "SELECT COUNT(*) FROM phong WHERE trang_thai <> 'BAO_TRI' AND so_nguoi_hien_tai = 0");
        int phongDaCoNguoi = countQuery(
                "SELECT COUNT(*) FROM phong WHERE trang_thai <> 'BAO_TRI' AND so_nguoi_hien_tai > 0");

        // Sinh viên & hợp đồng
        int tongSinhVien = countQuery("SELECT COUNT(*) FROM sinh_vien");
        int hopDongHieuLuc = countQuery("SELECT COUNT(*) FROM hop_dong WHERE trang_thai = 'DANG_HIEU_LUC'");
        int hopDongSapHetHan = countQuery(
                "SELECT COUNT(*) FROM hop_dong WHERE trang_thai = 'DANG_HIEU_LUC' " +
                        "AND ngay_ket_thuc BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)");

        // Hóa đơn / công nợ
        int hoaDonChuaThanhToan = countQuery(
                "SELECT COUNT(*) FROM hoa_don WHERE trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN')");
        int hoaDonQuaHan = countQuery("SELECT COUNT(*) FROM hoa_don WHERE trang_thai = 'QUAN_HAN'");
        String tongCongNo = scalarQuery(
                "SELECT COALESCE(SUM(tong_tien),0) FROM hoa_don WHERE trang_thai IN ('CHUA_THANH_TOAN','QUAN_HAN')");

        // Yêu cầu chờ xử lý
        int yeuCauChoXuLy = countQuery("SELECT COUNT(*) FROM yeu_cau_sua_chua WHERE trang_thai = 'CHO_XU_LY'");
        int dangKyChoDuyet = countQuery("SELECT COUNT(*) FROM dang_ky_phong WHERE trang_thai = 'CHO_DUYET'");

        request.setAttribute("tongSoPhong", tongSoPhong);
        request.setAttribute("phongTrong", phongTrong);
        request.setAttribute("phongDaCoNguoi", phongDaCoNguoi);
        request.setAttribute("phongBaoTri", phongBaoTri);
        request.setAttribute("tongSinhVien", tongSinhVien);
        request.setAttribute("hopDongHieuLuc", hopDongHieuLuc);
        request.setAttribute("hopDongSapHetHan", hopDongSapHetHan);
        request.setAttribute("hoaDonChuaThanhToan", hoaDonChuaThanhToan);
        request.setAttribute("hoaDonQuaHan", hoaDonQuaHan);
        request.setAttribute("tongCongNo", tongCongNo != null ? tongCongNo : "0");
        request.setAttribute("yeuCauChoXuLy", yeuCauChoXuLy);
        request.setAttribute("dangKyChoDuyet", dangKyChoDuyet);

        request.setAttribute("pageTitle", "Dashboard - Tổng Quan");
        request.getRequestDispatcher("/views/dashboard/dashboard.jsp").forward(request, response);
    }

    /** Đếm / lấy 1 số nguyên. params là các tham số ? (kiểu int). Lỗi thì trả 0. */
    private int countQuery(String sql, int... params) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                stmt.setInt(i + 1, params[i]);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Lấy 1 giá trị chuỗi. Không có dòng nào hoặc lỗi thì trả null. */
    private String scalarQuery(String sql, int... params) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                stmt.setInt(i + 1, params[i]);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}