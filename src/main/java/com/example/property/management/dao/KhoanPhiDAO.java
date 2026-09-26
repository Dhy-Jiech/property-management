package com.example.property.management.dao;

import com.example.property.management.model.KhoanPhi;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KhoanPhiDAO {

    public List<KhoanPhi> findAll() throws SQLException {
        List<KhoanPhi> list = new ArrayList<>();
        String sql = "SELECT id, ten_khoan_phi, don_gia, don_vi_tinh, trang_thai FROM khoan_phi ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public KhoanPhi findById(int id) throws SQLException {
        String sql = "SELECT id, ten_khoan_phi, don_gia, don_vi_tinh, trang_thai FROM khoan_phi WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return mapRow(rs);
            }
        }
        return null;
    }

    public void insert(KhoanPhi kp) throws SQLException {
        String sql = "INSERT INTO khoan_phi (ten_khoan_phi, don_gia, don_vi_tinh, trang_thai) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, kp.getTenKhoanPhi());
            stmt.setBigDecimal(2, kp.getDonGia());
            stmt.setString(3, kp.getDonViTinh());
            stmt.setString(4, kp.getTrangThai() != null ? kp.getTrangThai().name() : "HOAT_DONG");
            stmt.executeUpdate();
        }
    }

    public void update(KhoanPhi kp) throws SQLException {
        String sql = "UPDATE khoan_phi SET ten_khoan_phi=?, don_gia=?, don_vi_tinh=?, trang_thai=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, kp.getTenKhoanPhi());
            stmt.setBigDecimal(2, kp.getDonGia());
            stmt.setString(3, kp.getDonViTinh());
            stmt.setString(4, kp.getTrangThai() != null ? kp.getTrangThai().name() : "HOAT_DONG");
            stmt.setInt(5, kp.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM khoan_phi WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private KhoanPhi mapRow(ResultSet rs) throws SQLException {
        KhoanPhi kp = new KhoanPhi();
        kp.setId(rs.getInt("id"));
        kp.setTenKhoanPhi(rs.getString("ten_khoan_phi"));
        kp.setDonGia(rs.getBigDecimal("don_gia"));
        kp.setDonViTinh(rs.getString("don_vi_tinh"));
        String ts = rs.getString("trang_thai");
        if (ts != null) {
            try {
                kp.setTrangThai(com.example.property.management.model.enums.TrangThaiKhoanPhi.valueOf(ts));
            } catch (IllegalArgumentException e) {
                kp.setTrangThai(com.example.property.management.model.enums.TrangThaiKhoanPhi.HOAT_DONG);
            }
        }
        return kp;
    }
}
