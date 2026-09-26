package com.example.property.management.dao;

import com.example.property.management.model.HoaDon;
import com.example.property.management.model.SinhVien;
import com.example.property.management.model.enums.TrangThaiHoaDon;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HoaDonDAO {

    public List<HoaDon> findAll() throws SQLException {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten FROM hoa_don h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "ORDER BY h.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToHoaDon(rs));
            }
        }
        return list;
    }

    public List<HoaDon> findBySinhVienId(int svId) throws SQLException {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten FROM hoa_don h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "WHERE h.sinh_vien_id = ? " +
                "ORDER BY h.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, svId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToHoaDon(rs));
                }
            }
        }
        return list;
    }

    public HoaDon findById(int id) throws SQLException {
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten FROM hoa_don h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "WHERE h.id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHoaDon(rs);
                }
            }
        }
        return null;
    }

    public boolean insert(HoaDon hd) throws SQLException {
        String sql = "INSERT INTO hoa_don (ma_hoa_don, sinh_vien_id, ky_thanh_toan, tien_phong, tien_dien, tien_nuoc, tong_phi, tong_tien, han_thanh_toan, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, hd.getMaHoaDon());
            stmt.setInt(2, hd.getSinhVienId());
            stmt.setDate(3, hd.getKyThanhToan() != null ? Date.valueOf(hd.getKyThanhToan()) : null);
            stmt.setBigDecimal(4, hd.getTienPhong());
            stmt.setBigDecimal(5, hd.getTienDien());
            stmt.setBigDecimal(6, hd.getTienNuoc());
            stmt.setBigDecimal(7, hd.getTongPhi());
            stmt.setBigDecimal(8, hd.getTongTien());
            stmt.setDate(9, hd.getHanThanhToan() != null ? Date.valueOf(hd.getHanThanhToan()) : null);
            stmt.setString(10,
                    hd.getTrangThai() != null ? hd.getTrangThai().name() : TrangThaiHoaDon.CHUA_THANH_TOAN.name());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        hd.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean updateStatus(int id, TrangThaiHoaDon trangThai) throws SQLException {
        String sql = "UPDATE hoa_don SET trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trangThai.name());
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private HoaDon mapResultSetToHoaDon(ResultSet rs) throws SQLException {
        HoaDon h = new HoaDon();
        h.setId(rs.getInt("id"));
        h.setMaHoaDon(rs.getString("ma_hoa_don"));
        h.setSinhVienId(rs.getInt("sinh_vien_id"));

        Date ky = rs.getDate("ky_thanh_toan");
        if (ky != null)
            h.setKyThanhToan(ky.toLocalDate());

        h.setTienPhong(rs.getBigDecimal("tien_phong"));
        h.setTienDien(rs.getBigDecimal("tien_dien"));
        h.setTienNuoc(rs.getBigDecimal("tien_nuoc"));
        h.setTongPhi(rs.getBigDecimal("tong_phi"));
        h.setTongTien(rs.getBigDecimal("tong_tien"));

        Date han = rs.getDate("han_thanh_toan");
        if (han != null)
            h.setHanThanhToan(han.toLocalDate());

        String tt = rs.getString("trang_thai");
        if (tt != null) {
            try {
                h.setTrangThai(TrangThaiHoaDon.valueOf(tt));
            } catch (IllegalArgumentException e) {
                h.setTrangThai(TrangThaiHoaDon.CHUA_THANH_TOAN);
            }
        }

        SinhVien sv = new SinhVien();
        sv.setId(h.getSinhVienId());
        sv.setHoTen(rs.getString("sv_ho_ten"));
        h.setSinhVien(sv);

        return h;
    }
}
