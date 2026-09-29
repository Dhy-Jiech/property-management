package com.example.property.management.service;

import com.example.property.management.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.*;
import java.sql.Date;

public class HoaDonRoomService {

    public static class Fee {
        public String ten;
        public String donVi;
        public BigDecimal donGia;
    }

    public static class Preview {
        public int phongId;
        public String maPhong, tenPhong;
        public BigDecimal tienPhong = BigDecimal.ZERO;
        public boolean coDien, coNuoc;
        public int dienCu, dienMoi, nuocCu, nuocMoi;
        public BigDecimal dienDonGia = BigDecimal.ZERO, nuocDonGia = BigDecimal.ZERO;
        public BigDecimal tienDien = BigDecimal.ZERO, tienNuoc = BigDecimal.ZERO;
        public BigDecimal tongPhi = BigDecimal.ZERO, tongTien = BigDecimal.ZERO;
        public List<Fee> fees = new ArrayList<>();
        public List<String> warnings = new ArrayList<>();

        public boolean canCreate() {
            return warnings.isEmpty();
        }
    }

    /** Tính toàn bộ số liệu hóa đơn của 1 phòng trong 1 kỳ (ky dạng YYYY-MM) */
    public Preview preview(int phongId, String ky) throws Exception {
        if (ky == null || !ky.matches("\\d{4}-\\d{2}"))
            throw new Exception("Kỳ thanh toán không hợp lệ!");
        Preview pv = new Preview();
        pv.phongId = phongId;

        try (Connection conn = DBConnection.getConnection()) {
            // Phòng + tiền phòng
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT ma_phong, ten_phong, gia_thang FROM phong WHERE id = ?")) {
                ps.setInt(1, phongId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next())
                        throw new Exception("Phòng không tồn tại!");
                    pv.maPhong = rs.getString("ma_phong");
                    pv.tenPhong = rs.getString("ten_phong");
                    pv.tienPhong = rs.getBigDecimal("gia_thang");
                }
            }

            // Điện
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT chi_so_cu, chi_so_moi, don_gia FROM chi_so_dien " +
                            "WHERE phong_id = ? AND DATE_FORMAT(ky_thang, '%Y-%m') = ? ORDER BY id DESC LIMIT 1")) {
                ps.setInt(1, phongId);
                ps.setString(2, ky);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        pv.coDien = true;
                        pv.dienCu = rs.getInt("chi_so_cu");
                        pv.dienMoi = rs.getInt("chi_so_moi");
                        pv.dienDonGia = rs.getBigDecimal("don_gia");
                        pv.tienDien = pv.dienDonGia.multiply(BigDecimal.valueOf(Math.max(pv.dienMoi - pv.dienCu, 0)));
                    } else {
                        pv.warnings.add("Chưa nhập chỉ số điện tháng " + ky + " cho phòng này.");
                    }
                }
            }

            // Nước
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT chi_so_cu, chi_so_moi, don_gia FROM chi_so_nuoc " +
                            "WHERE phong_id = ? AND DATE_FORMAT(ky_thang, '%Y-%m') = ? ORDER BY id DESC LIMIT 1")) {
                ps.setInt(1, phongId);
                ps.setString(2, ky);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        pv.coNuoc = true;
                        pv.nuocCu = rs.getInt("chi_so_cu");
                        pv.nuocMoi = rs.getInt("chi_so_moi");
                        pv.nuocDonGia = rs.getBigDecimal("don_gia");
                        pv.tienNuoc = pv.nuocDonGia.multiply(BigDecimal.valueOf(Math.max(pv.nuocMoi - pv.nuocCu, 0)));
                    } else {
                        pv.warnings.add("Chưa nhập chỉ số nước tháng " + ky + " cho phòng này.");
                    }
                }
            }

            // Các khoản phí đang áp dụng (tự thêm khi có khoản phí mới)
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT ten_khoan_phi, don_gia, don_vi_tinh FROM khoan_phi " +
                            "WHERE trang_thai = 'HOAT_DONG' ORDER BY id");
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Fee f = new Fee();
                    f.ten = rs.getString("ten_khoan_phi");
                    f.donGia = rs.getBigDecimal("don_gia");
                    f.donVi = rs.getString("don_vi_tinh");
                    pv.fees.add(f);
                    pv.tongPhi = pv.tongPhi.add(f.donGia);
                }
            }

            // Đã có hóa đơn kỳ này chưa
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT ma_hoa_don FROM hoa_don WHERE phong_id = ? AND ky_thanh_toan = ? LIMIT 1")) {
                ps.setInt(1, phongId);
                ps.setDate(2, Date.valueOf(LocalDate.parse(ky + "-01")));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        pv.warnings.add("Phòng này đã có hóa đơn kỳ " + ky + " (" + rs.getString(1) + ").");
                    }
                }
            }
        }

        pv.tongTien = pv.tienPhong.add(pv.tienDien).add(pv.tienNuoc).add(pv.tongPhi);
        return pv;
    }

    /** Tạo hóa đơn phòng. Số liệu luôn tính lại ở server, không nhận từ form. */
    public void create(int phongId, String ky, String maHoaDon, LocalDate hanThanhToan) throws Exception {
        if (maHoaDon == null || maHoaDon.isBlank())
            throw new Exception("Vui lòng nhập mã hóa đơn!");
        Preview pv = preview(phongId, ky);
        if (!pv.canCreate())
            throw new Exception(String.join(" ", pv.warnings));

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int hoaDonId;
                try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO hoa_don (ma_hoa_don, sinh_vien_id, phong_id, ky_thanh_toan, tien_phong, " +
                                "tien_dien, tien_nuoc, tong_phi, tong_tien, han_thanh_toan, trang_thai) " +
                                "VALUES (?, NULL, ?, ?, ?, ?, ?, ?, ?, ?, 'CHUA_THANH_TOAN')",
                        Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, maHoaDon.trim());
                    ps.setInt(2, phongId);
                    ps.setDate(3, Date.valueOf(LocalDate.parse(ky + "-01")));
                    ps.setBigDecimal(4, pv.tienPhong);
                    ps.setBigDecimal(5, pv.tienDien);
                    ps.setBigDecimal(6, pv.tienNuoc);
                    ps.setBigDecimal(7, pv.tongPhi);
                    ps.setBigDecimal(8, pv.tongTien);
                    ps.setDate(9, Date.valueOf(hanThanhToan));
                    ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        keys.next();
                        hoaDonId = keys.getInt(1);
                    }
                }
                try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO hoa_don_chi_tiet (hoa_don_id, ten_khoan_phi, don_vi_tinh, thanh_tien) VALUES (?,?,?,?)")) {
                    for (Fee f : pv.fees) {
                        ps.setInt(1, hoaDonId);
                        ps.setString(2, f.ten);
                        ps.setString(3, f.donVi);
                        ps.setBigDecimal(4, f.donGia);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    private static final String STUDENT_COND = "(h.phong_id IN (SELECT hd.phong_id FROM hop_dong hd " +
            "                JOIN tai_khoan tk ON tk.sinh_vien_id = hd.sinh_vien_id " +
            "                WHERE tk.id = ? AND hd.trang_thai = 'DANG_HIEU_LUC') " +
            " OR h.sinh_vien_id = (SELECT sinh_vien_id FROM tai_khoan WHERE id = ?))";

    /**
     * Danh sách hóa đơn. taiKhoanId = null: lấy tất cả (nhân sự); có giá trị: hóa
     * đơn của phòng sinh viên đó
     */
    public List<Map<String, Object>> list(Integer taiKhoanId) throws SQLException {
        String sql = "SELECT h.*, p.ma_phong, p.ten_phong FROM hoa_don h " +
                "LEFT JOIN phong p ON p.id = h.phong_id " +
                (taiKhoanId != null ? "WHERE " + STUDENT_COND : "") +
                " ORDER BY h.ky_thanh_toan DESC, h.id DESC";
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            if (taiKhoanId != null) {
                ps.setInt(1, taiKhoanId);
                ps.setInt(2, taiKhoanId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("id", rs.getInt("id"));
                    m.put("maHoaDon", rs.getString("ma_hoa_don"));
                    m.put("phong", rs.getString("ma_phong") != null
                            ? rs.getString("ma_phong") + " - " + rs.getString("ten_phong")
                            : "(hóa đơn cũ)");
                    m.put("ky", rs.getString("ky_thanh_toan"));
                    m.put("tienPhong", rs.getBigDecimal("tien_phong"));
                    m.put("tienDien", rs.getBigDecimal("tien_dien"));
                    m.put("tienNuoc", rs.getBigDecimal("tien_nuoc"));
                    m.put("tongPhi", rs.getBigDecimal("tong_phi"));
                    m.put("tongTien", rs.getBigDecimal("tong_tien"));
                    m.put("han", rs.getString("han_thanh_toan"));
                    m.put("trangThai", rs.getString("trang_thai"));
                    list.add(m);
                }
            }
        }
        return list;
    }

    /** Sinh viên có được xem/thanh toán hóa đơn này không */
    public boolean studentCanAccess(int hoaDonId, int taiKhoanId) throws SQLException {
        String sql = "SELECT 1 FROM hoa_don h WHERE h.id = ? AND " + STUDENT_COND;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, hoaDonId);
            ps.setInt(2, taiKhoanId);
            ps.setInt(3, taiKhoanId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}