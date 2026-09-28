package com.example.property.management.dao;

import com.example.property.management.model.DangKyPhong;
import com.example.property.management.model.enums.LoaiYeuCauDangKy;
import com.example.property.management.model.enums.TrangThaiDangKy;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DangKyPhongDAO {

    public List<DangKyPhong> findAll() throws SQLException {
        List<DangKyPhong> list = new ArrayList<>();
        String sql = "SELECT d.*, sv.ho_ten as sv_ho_ten, p.ma_phong, p.ten_phong " +
                "FROM dang_ky_phong d " +
                "LEFT JOIN sinh_vien sv ON d.sinh_vien_id = sv.id " +
                "LEFT JOIN phong p ON d.phong_id = p.id " +
                "ORDER BY d.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToDangKy(rs));
            }
        }
        return list;
    }

    public boolean insert(DangKyPhong d) throws SQLException {
        String sql = "INSERT INTO dang_ky_phong (sinh_vien_id, phong_id, loai_yeu_cau, ly_do, trang_thai) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, d.getSinhVienId());
            stmt.setInt(2, d.getPhongId());
            stmt.setString(3,
                    d.getLoaiYeuCau() != null ? d.getLoaiYeuCau().name() : LoaiYeuCauDangKy.DANG_KY_MOI.name());
            stmt.setString(4, d.getLyDo());
            stmt.setString(5, d.getTrangThai() != null ? d.getTrangThai().name() : TrangThaiDangKy.CHO_DUYET.name());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        d.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public DangKyPhong findById(int id) throws SQLException {
        String sql = "SELECT d.*, sv.ho_ten as sv_ho_ten, p.ma_phong, p.ten_phong " +
                "FROM dang_ky_phong d " +
                "LEFT JOIN sinh_vien sv ON d.sinh_vien_id = sv.id " +
                "LEFT JOIN phong p ON d.phong_id = p.id " +
                "WHERE d.id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return mapResultSetToDangKy(rs);
            }
        }
        return null;
    }

    public boolean updateStatus(int id, TrangThaiDangKy trangThai) throws SQLException {
        String sql = "UPDATE dang_ky_phong SET trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trangThai.name());
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateStatusWithApprover(int id, TrangThaiDangKy trangThai, int nguoiDuyetId) throws SQLException {
        String sql = "UPDATE dang_ky_phong SET trang_thai = ?, nguoi_duyet = ?, thoi_gian_duyet = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trangThai.name());
            stmt.setInt(2, nguoiDuyetId);
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private DangKyPhong mapResultSetToDangKy(ResultSet rs) throws SQLException {
        DangKyPhong d = new DangKyPhong();
        d.setId(rs.getInt("id"));
        d.setSinhVienId(rs.getInt("sinh_vien_id"));
        d.setPhongId(rs.getInt("phong_id"));

        String loaiStr = rs.getString("loai_yeu_cau");
        if (loaiStr != null) {
            try {
                d.setLoaiYeuCau(LoaiYeuCauDangKy.valueOf(loaiStr));
            } catch (IllegalArgumentException e) {
                d.setLoaiYeuCau(LoaiYeuCauDangKy.DANG_KY_MOI);
            }
        }

        d.setLyDo(rs.getString("ly_do"));

        String ttStr = rs.getString("trang_thai");
        if (ttStr != null) {
            try {
                d.setTrangThai(TrangThaiDangKy.valueOf(ttStr));
            } catch (IllegalArgumentException e) {
                d.setTrangThai(TrangThaiDangKy.CHO_DUYET);
            }
        }
        return d;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM dang_ky_phong WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public int deleteOldProcessedRequests() throws SQLException {
        String sql = "DELETE FROM dang_ky_phong WHERE trang_thai IN ('TU_CHOI', 'DA_DUYET')";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            return stmt.executeUpdate();
        }
    }
}
