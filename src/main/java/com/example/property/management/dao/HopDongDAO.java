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

    public HopDongDAO() {
        ensureSchemaColumns();
    }

    private void ensureSchemaColumns() {
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement()) {
            try {
                stmt.executeUpdate("ALTER TABLE hop_dong ADD COLUMN chu_ky_ben_a LONGTEXT NULL");
            } catch (SQLException ignored) {
            }
            try {
                stmt.executeUpdate("ALTER TABLE hop_dong ADD COLUMN chu_ky_ben_b LONGTEXT NULL");
            } catch (SQLException ignored) {
            }
            try {
                stmt.executeUpdate("ALTER TABLE hop_dong ADD COLUMN ngay_ky TIMESTAMP NULL");
            } catch (SQLException ignored) {
            }
        } catch (Exception e) {
            // Ignore schema migration errors if columns exist
        }
    }

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

    public List<HopDong> findBySinhVienId(int sinhVienId) throws SQLException {
        List<HopDong> list = new ArrayList<>();
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten, p.ma_phong, p.ten_phong " +
                "FROM hop_dong h " +
                "LEFT JOIN sinh_vien sv ON h.sinh_vien_id = sv.id " +
                "LEFT JOIN phong p ON h.phong_id = p.id " +
                "WHERE h.sinh_vien_id = ? " +
                "ORDER BY h.id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sinhVienId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToHopDong(rs));
                }
            }
        }
        return list;
    }

    public HopDong findById(int id) throws SQLException {
        String sql = "SELECT h.*, sv.ho_ten as sv_ho_ten, sv.cccd as sv_cccd, sv.ngay_sinh as sv_ngay_sinh, sv.so_dien_thoai as sv_sdt, "
                +
                "p.ma_phong, p.ten_phong, p.gia_phong " +
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
        String sql = "INSERT INTO hop_dong (ma_hop_dong, sinh_vien_id, phong_id, ngay_bat_dau, ngay_ket_thuc, tien_phong, tien_dat_coc, trang_thai, chu_ky_ben_a, chu_ky_ben_b, ngay_ky) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                    hd.getTrangThai() != null ? hd.getTrangThai().name() : TrangThaiHopDong.CHO_HIEU_LUC.name());
            stmt.setString(9, hd.getChuKyBenA());
            stmt.setString(10, hd.getChuKyBenB());
            stmt.setTimestamp(11, hd.getNgayKy() != null ? Timestamp.valueOf(hd.getNgayKy()) : null);

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

    public boolean updateStudentSignature(int id, String chuKyBenB) throws SQLException {
        String sql = "UPDATE hop_dong SET chu_ky_ben_b = ?, trang_thai = ?, ngay_ky = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, chuKyBenB);
            stmt.setString(2, TrangThaiHopDong.DANG_HIEU_LUC.name());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(4, id);
            return stmt.executeUpdate() > 0;
        }
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

        try {
            h.setChuKyBenA(rs.getString("chu_ky_ben_a"));
        } catch (SQLException ignored) {
        }

        try {
            h.setChuKyBenB(rs.getString("chu_ky_ben_b"));
        } catch (SQLException ignored) {
        }

        try {
            Timestamp nk = rs.getTimestamp("ngay_ky");
            if (nk != null)
                h.setNgayKy(nk.toLocalDateTime());
        } catch (SQLException ignored) {
        }

        SinhVien sv = new SinhVien();
        sv.setId(h.getSinhVienId());
        sv.setHoTen(rs.getString("sv_ho_ten"));
        try {
            sv.setCccd(rs.getString("sv_cccd"));
        } catch (SQLException ignored) {
        }
        try {
            sv.setSoDienThoai(rs.getString("sv_sdt"));
        } catch (SQLException ignored) {
        }
        try {
            Date svNs = rs.getDate("sv_ngay_sinh");
            if (svNs != null)
                sv.setNgaySinh(svNs.toLocalDate());
        } catch (SQLException ignored) {
        }
        h.setSinhVien(sv);

        Phong p = new Phong();
        p.setId(h.getPhongId());
        p.setMaPhong(rs.getString("ma_phong"));
        p.setTenPhong(rs.getString("ten_phong"));
        try {
            p.setGiaThang(rs.getBigDecimal("gia_phong"));
        } catch (SQLException ignored) {
        }
        h.setPhong(p);

        return h;
    }
}
