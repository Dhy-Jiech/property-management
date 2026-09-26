package com.example.property.management.dao;

import com.example.property.management.model.YeuCauSuaChua;
import com.example.property.management.model.enums.TrangThaiSuaChua;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class YeuCauSuaChuaDAO {

    public List<YeuCauSuaChua> findAll() throws SQLException {
        List<YeuCauSuaChua> list = new ArrayList<>();
        String sql = "SELECT y.*, p.ma_phong, p.ten_phong FROM yeu_cau_sua_chua y " +
                "LEFT JOIN phong p ON y.phong_id = p.id " +
                "ORDER BY y.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToYeuCau(rs));
            }
        }
        return list;
    }

    public boolean insert(YeuCauSuaChua y) throws SQLException {
        String sql = "INSERT INTO yeu_cau_sua_chua (phong_id, sinh_vien_id, noi_dung, trang_thai) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, y.getPhongId());
            stmt.setInt(2, y.getSinhVienId());
            stmt.setString(3, y.getNoiDung());
            stmt.setString(4, y.getTrangThai() != null ? y.getTrangThai().name() : TrangThaiSuaChua.MOI.name());
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        y.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean updateStatus(int id, TrangThaiSuaChua trangThai) throws SQLException {
        String sql = "UPDATE yeu_cau_sua_chua SET trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trangThai.name());
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateResponse(int id, String phanHoi, TrangThaiSuaChua trangThai) throws SQLException {
        String sql = "UPDATE yeu_cau_sua_chua SET phan_hoi = ?, trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phanHoi);
            stmt.setString(2, trangThai.name());
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private YeuCauSuaChua mapResultSetToYeuCau(ResultSet rs) throws SQLException {
        YeuCauSuaChua y = new YeuCauSuaChua();
        y.setId(rs.getInt("id"));
        y.setPhongId(rs.getInt("phong_id"));
        y.setSinhVienId(rs.getInt("sinh_vien_id"));
        y.setNoiDung(rs.getString("noi_dung"));

        String tt = rs.getString("trang_thai");
        if (tt != null) {
            try {
                y.setTrangThai(TrangThaiSuaChua.valueOf(tt));
            } catch (IllegalArgumentException e) {
                y.setTrangThai(TrangThaiSuaChua.MOI);
            }
        }
        return y;
    }
}
