package com.example.property.management.dao;

import com.example.property.management.model.Khu;
import com.example.property.management.model.Toa;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ToaDAO {
    public List<Toa> findAll() throws SQLException {
        List<Toa> list = new ArrayList<>();
        String sql = """
                    SELECT t.*, k.ma_khu, k.ten_khu
                    FROM toa t
                    JOIN khu k ON t.khu_id = k.id
                    ORDER BY t.id ASC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Khu khu = Khu.builder()
                        .id(rs.getInt("khu_id"))
                        .maKhu(rs.getString("ma_khu"))
                        .tenKhu(rs.getString("ten_khu"))
                        .build();
                list.add(Toa.builder()
                        .id(rs.getInt("id"))
                        .khuId(rs.getInt("khu_id"))
                        .maToa(rs.getString("ma_toa"))
                        .tenToa(rs.getString("ten_toa"))
                        .khu(khu)
                        .build());
            }
        }
        return list;
    }

    public Toa findById(int id) throws SQLException {
        String sql = "SELECT * FROM toa WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Toa.builder()
                            .id(rs.getInt("id"))
                            .khuId(rs.getInt("khu_id"))
                            .maToa(rs.getString("ma_toa"))
                            .tenToa(rs.getString("ten_toa"))
                            .build();
                }
            }
        }
        return null;
    }

    public boolean insert(Toa toa) throws SQLException {
        String sql = "INSERT INTO toa (khu_id, ma_toa, ten_toa) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toa.getKhuId());
            ps.setString(2, toa.getMaToa());
            ps.setString(3, toa.getTenToa());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Toa toa) throws SQLException {
        String sql = "UPDATE toa SET khu_id = ?, ma_toa = ?, ten_toa = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toa.getKhuId());
            ps.setString(2, toa.getMaToa());
            ps.setString(3, toa.getTenToa());
            ps.setInt(4, toa.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM toa WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
