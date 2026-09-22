package com.example.property.management.dao;

import com.example.property.management.model.Khu;
import com.example.property.management.model.Tang;
import com.example.property.management.model.Toa;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TangDAO {

    public List<Tang> findAll() throws SQLException {
        ensureDefaultData();
        List<Tang> list = new ArrayList<>();
        String sql = """
                    SELECT t.*, toa.ma_toa, toa.ten_toa, k.id as khu_id, k.ma_khu, k.ten_khu
                    FROM tang t
                    JOIN toa toa ON t.toa_id = toa.id
                    JOIN khu k ON toa.khu_id = k.id
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

                Toa toa = Toa.builder()
                        .id(rs.getInt("toa_id"))
                        .khuId(rs.getInt("khu_id"))
                        .maToa(rs.getString("ma_toa"))
                        .tenToa(rs.getString("ten_toa"))
                        .khu(khu)
                        .build();

                list.add(Tang.builder()
                        .id(rs.getInt("id"))
                        .toaId(rs.getInt("toa_id"))
                        .soTang(rs.getInt("so_tang"))
                        .tenTang(rs.getString("ten_tang"))
                        .toa(toa)
                        .build());
            }
        }
        return list;
    }

    public Tang findById(int id) throws SQLException {
        String sql = """
                    SELECT t.*, toa.ma_toa, toa.ten_toa, k.id as khu_id, k.ma_khu, k.ten_khu
                    FROM tang t
                    JOIN toa toa ON t.toa_id = toa.id
                    JOIN khu k ON toa.khu_id = k.id
                    WHERE t.id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Khu khu = Khu.builder()
                            .id(rs.getInt("khu_id"))
                            .maKhu(rs.getString("ma_khu"))
                            .tenKhu(rs.getString("ten_khu"))
                            .build();

                    Toa toa = Toa.builder()
                            .id(rs.getInt("toa_id"))
                            .khuId(rs.getInt("khu_id"))
                            .maToa(rs.getString("ma_toa"))
                            .tenToa(rs.getString("ten_toa"))
                            .khu(khu)
                            .build();

                    return Tang.builder()
                            .id(rs.getInt("id"))
                            .toaId(rs.getInt("toa_id"))
                            .soTang(rs.getInt("so_tang"))
                            .tenTang(rs.getString("ten_tang"))
                            .toa(toa)
                            .build();
                }
            }
        }
        return null;
    }

    public boolean insert(Tang tang) throws SQLException {
        String sql = "INSERT INTO tang (toa_id, so_tang, ten_tang) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tang.getToaId());
            ps.setInt(2, tang.getSoTang());
            ps.setString(3, tang.getTenTang());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Tang tang) throws SQLException {
        String sql = "UPDATE tang SET toa_id = ?, so_tang = ?, ten_tang = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tang.getToaId());
            ps.setInt(2, tang.getSoTang());
            ps.setString(3, tang.getTenTang());
            ps.setInt(4, tang.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tang WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public void ensureDefaultData() {
        try (Connection conn = DBConnection.getConnection()) {
            // Check if tang has any records
            String checkSql = "SELECT COUNT(*) FROM tang";
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(checkSql)) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return; // Data exists
                }
            }

            // Seed default Khu A -> Toa A1 -> Tang 1, 2, 3
            String insertKhu = "INSERT IGNORE INTO khu (id, ma_khu, ten_khu) VALUES (1, 'KHU_A', 'Khu A')";
            String insertToa = "INSERT IGNORE INTO toa (id, khu_id, ma_toa, ten_toa) VALUES (1, 1, 'TOA_A1', 'Tòa A1')";
            String insertTang1 = "INSERT IGNORE INTO tang (id, toa_id, so_tang, ten_tang) VALUES (1, 1, 1, 'Tầng 1')";
            String insertTang2 = "INSERT IGNORE INTO tang (id, toa_id, so_tang, ten_tang) VALUES (2, 1, 2, 'Tầng 2')";
            String insertTang3 = "INSERT IGNORE INTO tang (id, toa_id, so_tang, ten_tang) VALUES (3, 1, 3, 'Tầng 3')";

            try (Statement stmt = conn.createStatement()) {
                stmt.executeUpdate(insertKhu);
                stmt.executeUpdate(insertToa);
                stmt.executeUpdate(insertTang1);
                stmt.executeUpdate(insertTang2);
                stmt.executeUpdate(insertTang3);
            }
        } catch (SQLException e) {
            System.err.println("Warning: Could not seed default location data: " + e.getMessage());
        }
    }
}
