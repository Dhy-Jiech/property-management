package com.example.property.management.dao;

import com.example.property.management.model.Khu;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KhuDAO {
    public List<Khu> findAll() throws SQLException {
        List<Khu> list = new ArrayList<>();
        String sql = "SELECT * FROM khu ORDER BY id ASC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(Khu.builder()
                        .id(rs.getInt("id"))
                        .maKhu(rs.getString("ma_khu"))
                        .tenKhu(rs.getString("ten_khu"))
                        .build());
            }
        }
        return list;
    }

    public Khu findById(int id) throws SQLException {
        String sql = "SELECT * FROM khu WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Khu.builder()
                            .id(rs.getInt("id"))
                            .maKhu(rs.getString("ma_khu"))
                            .tenKhu(rs.getString("ten_khu"))
                            .build();
                }
            }
        }
        return null;
    }

    public boolean insert(Khu khu) throws SQLException {
        String sql = "INSERT INTO khu (ma_khu, ten_khu) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, khu.getMaKhu());
            ps.setString(2, khu.getTenKhu());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Khu khu) throws SQLException {
        String sql = "UPDATE khu SET ma_khu = ?, ten_khu = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, khu.getMaKhu());
            ps.setString(2, khu.getTenKhu());
            ps.setInt(3, khu.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM khu WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
