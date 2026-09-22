package com.example.property.management.dao;

import com.example.property.management.model.SinhVien;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SinhVienDAO {

    public List<SinhVien> findAll() throws SQLException {
        List<SinhVien> list = new ArrayList<>();
        String sql = "SELECT * FROM sinh_vien ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToSinhVien(rs));
            }
        }
        return list;
    }

    public SinhVien findById(int id) throws SQLException {
        String sql = "SELECT * FROM sinh_vien WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSinhVien(rs);
                }
            }
        }
        return null;
    }

    public boolean insert(SinhVien sv) throws SQLException {
        String sql = "INSERT INTO sinh_vien (ho_ten, ngay_sinh, gioi_tinh, cccd, so_dien_thoai, email, dia_chi_que_quan, truong) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, sv.getHoTen());
            stmt.setDate(2, sv.getNgaySinh() != null ? Date.valueOf(sv.getNgaySinh()) : null);
            stmt.setString(3, sv.getGioiTinh());
            stmt.setString(4, sv.getCccd());
            stmt.setString(5, sv.getSoDienThoai());
            stmt.setString(6, sv.getEmail());
            stmt.setString(7, sv.getDiaChiQueQuan());
            stmt.setString(8, sv.getTruong());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        sv.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean update(SinhVien sv) throws SQLException {
        String sql = "UPDATE sinh_vien SET ho_ten = ?, ngay_sinh = ?, gioi_tinh = ?, cccd = ?, so_dien_thoai = ?, email = ?, dia_chi_que_quan = ?, truong = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sv.getHoTen());
            stmt.setDate(2, sv.getNgaySinh() != null ? Date.valueOf(sv.getNgaySinh()) : null);
            stmt.setString(3, sv.getGioiTinh());
            stmt.setString(4, sv.getCccd());
            stmt.setString(5, sv.getSoDienThoai());
            stmt.setString(6, sv.getEmail());
            stmt.setString(7, sv.getDiaChiQueQuan());
            stmt.setString(8, sv.getTruong());
            stmt.setInt(9, sv.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM sinh_vien WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private SinhVien mapResultSetToSinhVien(ResultSet rs) throws SQLException {
        SinhVien sv = new SinhVien();
        sv.setId(rs.getInt("id"));
        sv.setHoTen(rs.getString("ho_ten"));
        Date d = rs.getDate("ngay_sinh");
        if (d != null) {
            sv.setNgaySinh(d.toLocalDate());
        }
        sv.setGioiTinh(rs.getString("gioi_tinh"));
        sv.setCccd(rs.getString("cccd"));
        sv.setSoDienThoai(rs.getString("so_dien_thoai"));
        sv.setEmail(rs.getString("email"));
        sv.setDiaChiQueQuan(rs.getString("dia_chi_que_quan"));
        sv.setTruong(rs.getString("truong"));
        return sv;
    }
}
