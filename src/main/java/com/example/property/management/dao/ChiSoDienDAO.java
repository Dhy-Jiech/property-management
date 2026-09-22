package com.example.property.management.dao;

import com.example.property.management.model.ChiSoDien;
import com.example.property.management.model.ChiSoNuoc;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ChiSoDienDAO {

    public boolean insert(ChiSoDien cd) throws SQLException {
        String sql = "INSERT INTO chi_so_dien (phong_id, ky_thang, chi_so_cu, chi_so_moi, don_gia, tien_dien) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, cd.getPhongId());
            stmt.setDate(2, cd.getKyThang() != null ? Date.valueOf(cd.getKyThang()) : Date.valueOf(LocalDate.now()));
            stmt.setBigDecimal(3, cd.getChiSoCu());
            stmt.setBigDecimal(4, cd.getChiSoMoi());
            stmt.setBigDecimal(5, cd.getDonGia());
            stmt.setBigDecimal(6, cd.getTienDien());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        cd.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public List<ChiSoDien> findAll() throws SQLException {
        List<ChiSoDien> list = new ArrayList<>();
        String sql = "SELECT c.*, p.ma_phong, p.ten_phong FROM chi_so_dien c " +
                "JOIN phong p ON c.phong_id = p.id " +
                "ORDER BY c.ky_thang DESC, c.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ChiSoDien c = new ChiSoDien();
                c.setId(rs.getInt("id"));
                c.setPhongId(rs.getInt("phong_id"));
                Date d = rs.getDate("ky_thang");
                if (d != null)
                    c.setKyThang(d.toLocalDate());
                c.setChiSoCu(rs.getBigDecimal("chi_so_cu"));
                c.setChiSoMoi(rs.getBigDecimal("chi_so_moi"));
                c.setDonGia(rs.getBigDecimal("don_gia"));
                c.setTienDien(rs.getBigDecimal("tien_dien"));

                com.example.property.management.model.Phong p = new com.example.property.management.model.Phong();
                p.setId(rs.getInt("phong_id"));
                p.setMaPhong(rs.getString("ma_phong"));
                p.setTenPhong(rs.getString("ten_phong"));
                c.setPhong(p);

                list.add(c);
            }
        }
        return list;
    }

    public List<ChiSoDien> findByPhongId(int phongId) throws SQLException {
        List<ChiSoDien> list = new ArrayList<>();
        String sql = "SELECT * FROM chi_so_dien WHERE phong_id = ? ORDER BY ky_thang DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, phongId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ChiSoDien c = new ChiSoDien();
                    c.setId(rs.getInt("id"));
                    c.setPhongId(rs.getInt("phong_id"));
                    Date d = rs.getDate("ky_thang");
                    if (d != null)
                        c.setKyThang(d.toLocalDate());
                    c.setChiSoCu(rs.getBigDecimal("chi_so_cu"));
                    c.setChiSoMoi(rs.getBigDecimal("chi_so_moi"));
                    c.setDonGia(rs.getBigDecimal("don_gia"));
                    c.setTienDien(rs.getBigDecimal("tien_dien"));
                    list.add(c);
                }
            }
        }
        return list;
    }
}
