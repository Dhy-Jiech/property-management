package com.example.property.management.dao;

import com.example.property.management.model.ThanhToan;
import com.example.property.management.model.enums.PhuongThucThanhToan;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ThanhToanDAO {

    public List<ThanhToan> findByHoaDonId(int hoaDonId) throws SQLException {
        List<ThanhToan> list = new ArrayList<>();
        String sql = "SELECT id, hoa_don_id, so_tien, phuong_thuc, ma_giao_dich, thoi_gian, nguoi_xac_nhan " +
                "FROM thanh_toan WHERE hoa_don_id = ? ORDER BY thoi_gian DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, hoaDonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(mapRow(rs));
            }
        }
        return list;
    }

    public void insert(ThanhToan tt) throws SQLException {
        String sql = "INSERT INTO thanh_toan (hoa_don_id, so_tien, phuong_thuc, ma_giao_dich, nguoi_xac_nhan) " +
                "VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tt.getHoaDonId());
            stmt.setBigDecimal(2, tt.getSoTien());
            stmt.setString(3, tt.getPhuongThuc() != null ? tt.getPhuongThuc().name() : "TIEN_MAT");
            stmt.setString(4, tt.getMaGiaoDich());
            stmt.setString(5, tt.getNguoiXacNhan());
            stmt.executeUpdate();
        }
    }

    private ThanhToan mapRow(ResultSet rs) throws SQLException {
        ThanhToan tt = new ThanhToan();
        tt.setId(rs.getInt("id"));
        tt.setHoaDonId(rs.getInt("hoa_don_id"));
        tt.setSoTien(rs.getBigDecimal("so_tien"));
        String pt = rs.getString("phuong_thuc");
        if (pt != null) {
            try {
                tt.setPhuongThuc(PhuongThucThanhToan.valueOf(pt));
            } catch (Exception e) {
            }
        }
        tt.setMaGiaoDich(rs.getString("ma_giao_dich"));
        Timestamp ts = rs.getTimestamp("thoi_gian");
        if (ts != null)
            tt.setThoiGian(ts.toLocalDateTime());
        tt.setNguoiXacNhan(rs.getString("nguoi_xac_nhan"));
        return tt;
    }
}
