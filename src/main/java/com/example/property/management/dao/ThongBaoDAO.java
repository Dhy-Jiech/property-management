package com.example.property.management.dao;

import com.example.property.management.model.ThongBao;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ThongBaoDAO {

    public List<ThongBao> findAll() throws SQLException {
        List<ThongBao> list = new ArrayList<>();
        String sql = "SELECT id, nguoi_nhan_id, tieu_de, noi_dung, loai, da_doc, thoi_gian " +
                "FROM thong_bao ORDER BY thoi_gian DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next())
                list.add(mapRow(rs));
        }
        return list;
    }

    public List<ThongBao> findByNguoiNhan(int userId) throws SQLException {
        List<ThongBao> list = new ArrayList<>();
        String sql = "SELECT id, nguoi_nhan_id, tieu_de, noi_dung, loai, da_doc, thoi_gian " +
                "FROM thong_bao WHERE nguoi_nhan_id IS NULL OR nguoi_nhan_id = ? " +
                "ORDER BY thoi_gian DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(mapRow(rs));
            }
        }
        return list;
    }

    public int countUnread(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM thong_bao WHERE da_doc = 0 AND (nguoi_nhan_id IS NULL OR nguoi_nhan_id = ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        }
        return 0;
    }

    public void insert(ThongBao tb) throws SQLException {
        String sql = "INSERT INTO thong_bao (nguoi_nhan_id, tieu_de, noi_dung, loai, da_doc) VALUES (?,?,?,?,0)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            Integer nnId = tb.getNguoiNhanId();
            if (nnId != null && nnId > 0)
                stmt.setInt(1, nnId);
            else
                stmt.setNull(1, Types.INTEGER);
            stmt.setString(2, tb.getTieuDe());
            stmt.setString(3, tb.getNoiDung());
            stmt.setString(4, tb.getLoai() != null ? tb.getLoai() : "THONG_TIN");
            stmt.executeUpdate();
        }
    }

    public void markAsRead(int id) throws SQLException {
        String sql = "UPDATE thong_bao SET da_doc = 1 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public void markAllRead(int userId) throws SQLException {
        String sql = "UPDATE thong_bao SET da_doc = 1 WHERE nguoi_nhan_id = ? OR nguoi_nhan_id IS NULL";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }

    private ThongBao mapRow(ResultSet rs) throws SQLException {
        ThongBao tb = new ThongBao();
        tb.setId(rs.getInt("id"));
        int nnId = rs.getInt("nguoi_nhan_id");
        tb.setNguoiNhanId(rs.wasNull() ? null : nnId);
        tb.setTieuDe(rs.getString("tieu_de"));
        tb.setNoiDung(rs.getString("noi_dung"));
        tb.setLoai(rs.getString("loai"));
        tb.setDaDoc(rs.getBoolean("da_doc"));
        Timestamp ts = rs.getTimestamp("thoi_gian");
        if (ts != null)
            tb.setThoiGian(ts.toLocalDateTime());
        return tb;
    }
}
