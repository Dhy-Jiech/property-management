package com.example.property.management.dao;

import com.example.property.management.model.HopDong;
import com.example.property.management.model.Phong;
import com.example.property.management.model.SinhVien;
import com.example.property.management.model.enums.TrangThaiHopDong;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HopDongDAO {

    public List<HopDong> findAll() throws SQLException {
        List<HopDong> list = new ArrayList<>();
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten, p.ma_phong, p.ten_phong " +
                "FROM hop_dong h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "LEFT JOIN phong p ON h.phong_id = p.id " +
                "ORDER BY h.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToHopDong(rs));
            }
        }
        return list;
    }

    public HopDong findById(int id) throws SQLException {
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten, p.ma_phong, p.ten_phong " +
                "FROM hop_dong h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "LEFT JOIN phong p ON h.phong_id = p.id " +
                "WHERE h.id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHopDong(rs);
                }
            }
        }
        return null;
    }

    public boolean insert(HopDong hd) throws SQLException {
        String sql = "INSERT INTO hop_dong (ma_hop_dong, sinh_vien_id, phong_id, ngay_bat_dau, ngay_ket_thuc, tien_phong, tien_dat_coc, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, hd.getMaHopDong());
            stmt.setInt(2, hd.getSinhVienId());
            stmt.setInt(3, hd.getPhongId());
            stmt.setDate(4, hd.getNgayBatDau() != null ? Date.valueOf(hd.getNgayBatDau()) : null);
            stmt.setDate(5, hd.getNgayKetThuc() != null ? Date.valueOf(hd.getNgayKetThuc()) : null);
            stmt.setBigDecimal(6, hd.getTienPhong());
            stmt.setBigDecimal(7, hd.getTienDatCoc());
            stmt.setString(8,
                    hd.getTrangThai() != null ? hd.getTrangThai().name() : TrangThaiHopDong.DANG_HIEU_LUC.name());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        hd.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean updateStatus(int id, TrangThaiHopDong trangThai) throws SQLException {
        String sql = "UPDATE hop_dong SET trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trangThai.name());
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private HopDong mapResultSetToHopDong(ResultSet rs) throws SQLException {
        HopDong h = new HopDong();
        h.setId(rs.getInt("id"));
        h.setMaHopDong(rs.getString("ma_hop_dong"));
        h.setSinhVienId(rs.getInt("sinh_vien_id"));
        h.setPhongId(rs.getInt("phong_id"));

        Date bd = rs.getDate("ngay_bat_dau");
        if (bd != null)
            h.setNgayBatDau(bd.toLocalDate());

        Date kt = rs.getDate("ngay_ket_thuc");
        if (kt != null)
            h.setNgayKetThuc(kt.toLocalDate());

        h.setTienPhong(rs.getBigDecimal("tien_phong"));
        h.setTienDatCoc(rs.getBigDecimal("tien_dat_coc"));

        String ttStr = rs.getString("trang_thai");
        if (ttStr != null) {
            try {
                h.setTrangThai(TrangThaiHopDong.valueOf(ttStr));
            } catch (IllegalArgumentException e) {
                h.setTrangThai(TrangThaiHopDong.DANG_HIEU_LUC);
            }
        }

        SinhVien sv = new SinhVien();
        sv.setId(h.getSinhVienId());
        sv.setHoTen(rs.getString("sv_ho_ten"));
        h.setSinhVien(sv);

        Phong p = new Phong();
        p.setId(h.getPhongId());
        p.setMaPhong(rs.getString("ma_phong"));
        p.setTenPhong(rs.getString("ten_phong"));
        h.setPhong(p);

        return h;
    }
}
