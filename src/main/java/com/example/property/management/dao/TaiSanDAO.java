package com.example.property.management.dao;

import com.example.property.management.model.TaiSan;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaiSanDAO {

    public List<TaiSan> findAll() throws SQLException {
        List<TaiSan> list = new ArrayList<>();
        String sql = "SELECT t.*, p.ma_phong, p.ten_phong FROM tai_san t " +
                "LEFT JOIN phong p ON t.phong_id = p.id " +
                "ORDER BY t.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToTaiSan(rs));
            }
        }
        return list;
    }

    public boolean insert(TaiSan t) throws SQLException {
        String sql = "INSERT INTO tai_san (ten_tai_san, phong_id, so_luong, tinh_trang) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, t.getTenTaiSan());
            stmt.setInt(2, t.getPhongId());
            stmt.setInt(3, t.getSoLuong() != null ? t.getSoLuong() : 1);
            stmt.setString(4, t.getTinhTrang() != null ? t.getTinhTrang() : "Tot");

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        t.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tai_san WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private TaiSan mapResultSetToTaiSan(ResultSet rs) throws SQLException {
        TaiSan t = new TaiSan();
        t.setId(rs.getInt("id"));
        t.setTenTaiSan(rs.getString("ten_tai_san"));
        t.setPhongId(rs.getInt("phong_id"));
        t.setSoLuong(rs.getInt("so_luong"));
        t.setTinhTrang(rs.getString("tinh_trang"));
        return t;
    }
}
