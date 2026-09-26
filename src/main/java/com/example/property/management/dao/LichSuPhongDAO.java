package com.example.property.management.dao;

import com.example.property.management.model.LichSuPhong;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LichSuPhongDAO {

    public List<LichSuPhong> findAll() throws SQLException {
        List<LichSuPhong> list = new ArrayList<>();
        String sql = "SELECT l.id, l.sinh_vien_id, sv.ho_ten as ten_sinh_vien, " +
                "l.phong_cu, pc.ma_phong as ma_phong_cu, " +
                "l.phong_moi, pm.ma_phong as ma_phong_moi, " +
                "l.thoi_gian, l.ly_do, l.nguoi_xu_ly " +
                "FROM lich_su_phong l " +
                "JOIN sinh_vien sv ON l.sinh_vien_id = sv.id " +
                "LEFT JOIN phong pc ON l.phong_cu = pc.id " +
                "LEFT JOIN phong pm ON l.phong_moi = pm.id " +
                "ORDER BY l.thoi_gian DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next())
                list.add(mapRow(rs));
        }
        return list;
    }

    public List<LichSuPhong> findBySinhVienId(int svId) throws SQLException {
        List<LichSuPhong> list = new ArrayList<>();
        String sql = "SELECT l.id, l.sinh_vien_id, sv.ho_ten as ten_sinh_vien, " +
                "l.phong_cu, pc.ma_phong as ma_phong_cu, " +
                "l.phong_moi, pm.ma_phong as ma_phong_moi, " +
                "l.thoi_gian, l.ly_do, l.nguoi_xu_ly " +
                "FROM lich_su_phong l " +
                "JOIN sinh_vien sv ON l.sinh_vien_id = sv.id " +
                "LEFT JOIN phong pc ON l.phong_cu = pc.id " +
                "LEFT JOIN phong pm ON l.phong_moi = pm.id " +
                "WHERE l.sinh_vien_id = ? ORDER BY l.thoi_gian DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, svId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next())
                    list.add(mapRow(rs));
            }
        }
        return list;
    }

    public void insert(LichSuPhong lsp) throws SQLException {
        String sql = "INSERT INTO lich_su_phong (sinh_vien_id, phong_cu, phong_moi, ly_do, nguoi_xu_ly) " +
                "VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lsp.getSinhVienId());
            if (lsp.getPhongCu() != null)
                stmt.setInt(2, lsp.getPhongCu());
            else
                stmt.setNull(2, Types.INTEGER);
            if (lsp.getPhongMoi() != null)
                stmt.setInt(3, lsp.getPhongMoi());
            else
                stmt.setNull(3, Types.INTEGER);
            stmt.setString(4, lsp.getLyDo());
            stmt.setString(5, lsp.getNguoiXuLy());
            stmt.executeUpdate();
        }
    }

    private LichSuPhong mapRow(ResultSet rs) throws SQLException {
        LichSuPhong lsp = new LichSuPhong();
        lsp.setId(rs.getInt("id"));
        lsp.setSinhVienId(rs.getInt("sinh_vien_id"));
        lsp.setTenSinhVien(rs.getString("ten_sinh_vien"));
        int pc = rs.getInt("phong_cu");
        lsp.setPhongCu(rs.wasNull() ? null : pc);
        lsp.setMaPhongCu(rs.getString("ma_phong_cu"));
        int pm = rs.getInt("phong_moi");
        lsp.setPhongMoi(rs.wasNull() ? null : pm);
        lsp.setMaPhongMoi(rs.getString("ma_phong_moi"));
        Timestamp ts = rs.getTimestamp("thoi_gian");
        if (ts != null)
            lsp.setThoiGian(ts.toLocalDateTime());
        lsp.setLyDo(rs.getString("ly_do"));
        lsp.setNguoiXuLy(rs.getString("nguoi_xu_ly"));
        return lsp;
    }
}
