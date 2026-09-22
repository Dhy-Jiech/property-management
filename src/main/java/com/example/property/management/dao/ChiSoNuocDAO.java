package com.example.property.management.dao;

import com.example.property.management.model.ChiSoNuoc;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ChiSoNuocDAO {

    public boolean insert(ChiSoNuoc cn) throws SQLException {
        String sql = "INSERT INTO chi_so_nuoc (phong_id, ky_thang, chi_so_cu, chi_so_moi, don_gia, tien_nuoc) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, cn.getPhongId());
            stmt.setDate(2, cn.getKyThang() != null ? Date.valueOf(cn.getKyThang()) : Date.valueOf(LocalDate.now()));
            stmt.setBigDecimal(3, cn.getChiSoCu());
            stmt.setBigDecimal(4, cn.getChiSoMoi());
            stmt.setBigDecimal(5, cn.getDonGia());
            stmt.setBigDecimal(6, cn.getTienNuoc());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        cn.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public List<ChiSoNuoc> findAll() throws SQLException {
        List<ChiSoNuoc> list = new ArrayList<>();
        String sql = "SELECT c.*, p.ma_phong, p.ten_phong FROM chi_so_nuoc c " +
                "JOIN phong p ON c.phong_id = p.id " +
                "ORDER BY c.ky_thang DESC, c.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ChiSoNuoc c = new ChiSoNuoc();
                c.setId(rs.getInt("id"));
                c.setPhongId(rs.getInt("phong_id"));
                Date d = rs.getDate("ky_thang");
                if (d != null)
                    c.setKyThang(d.toLocalDate());
                c.setChiSoCu(rs.getBigDecimal("chi_so_cu"));
                c.setChiSoMoi(rs.getBigDecimal("chi_so_moi"));
                c.setDonGia(rs.getBigDecimal("don_gia"));
                c.setTienNuoc(rs.getBigDecimal("tien_nuoc"));

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

    public List<ChiSoNuoc> findByPhongId(int phongId) throws SQLException {
        List<ChiSoNuoc> list = new ArrayList<>();
        String sql = "SELECT * FROM chi_so_nuoc WHERE phong_id = ? ORDER BY ky_thang DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, phongId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ChiSoNuoc c = new ChiSoNuoc();
                    c.setId(rs.getInt("id"));
                    c.setPhongId(rs.getInt("phong_id"));
                    Date d = rs.getDate("ky_thang");
                    if (d != null)
                        c.setKyThang(d.toLocalDate());
                    c.setChiSoCu(rs.getBigDecimal("chi_so_cu"));
                    c.setChiSoMoi(rs.getBigDecimal("chi_so_moi"));
                    c.setDonGia(rs.getBigDecimal("don_gia"));
                    c.setTienNuoc(rs.getBigDecimal("tien_nuoc"));
                    list.add(c);
                }
            }
        }
        return list;
    }
}
