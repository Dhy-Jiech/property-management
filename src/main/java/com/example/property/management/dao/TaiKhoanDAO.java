package com.example.property.management.dao;

import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.TrangThaiTaiKhoan;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaiKhoanDAO {

    public TaiKhoanDAO() {
        autoSeedAdmin();
    }

    private void autoSeedAdmin() {
        String checkSql = "SELECT COUNT(*) FROM tai_khoan WHERE username = ?";
        String insertSql = "INSERT INTO tai_khoan (username, password_hash, vai_tro, trang_thai, sinh_vien_id) VALUES (?, ?, ?, 'HOAT_DONG', ?)";

        String[][] seedAccounts = {
                { "admin", "admin123", "ADMIN", null },
                { "quanly", "quanly123", "QUAN_LY", null },
                { "nhanvien", "nhanvien123", "NHAN_VIEN", null },
                { "sinhvien", "sinhvien123", "SINH_VIEN", "1" }
        };

        try (Connection conn = DBConnection.getConnection()) {
            for (String[] acc : seedAccounts) {
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, acc[0]);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next() && rs.getInt(1) == 0) {
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                                insertStmt.setString(1, acc[0]);
                                insertStmt.setString(2, acc[1]);
                                insertStmt.setString(3, acc[2]);
                                if (acc[3] != null) {
                                    insertStmt.setLong(4, Long.parseLong(acc[3]));
                                } else {
                                    insertStmt.setNull(4, Types.BIGINT);
                                }
                                insertStmt.executeUpdate();
                                System.out.println("Auto-seeded account: " + acc[0] + " (" + acc[2] + ")");
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Auto-seed error (table might not exist yet): " + e.getMessage());
        }
    }

    public TaiKhoan findById(int id) throws SQLException {
        String sql = "SELECT * FROM tai_khoan WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTaiKhoan(rs);
                }
            }
        }
        return null;
    }

    public TaiKhoan findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM tai_khoan WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTaiKhoan(rs);
                }
            }
        }
        return null;
    }

    public TaiKhoan authenticate(String username, String password) throws SQLException {
        TaiKhoan user = findByUsername(username);
        if (user != null && user.getTrangThai() == TrangThaiTaiKhoan.HOAT_DONG) {
            if (password.equals(user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }

    public boolean insert(TaiKhoan account) throws SQLException {
        String sql = "INSERT INTO tai_khoan (username, password_hash, vai_tro, trang_thai, sinh_vien_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, account.getUsername());
            stmt.setString(2, account.getPasswordHash());
            stmt.setString(3, account.getVaiTro() != null ? account.getVaiTro().name() : VaiTro.SINH_VIEN.name());
            stmt.setString(4, account.getTrangThai() != null ? account.getTrangThai().name()
                    : TrangThaiTaiKhoan.HOAT_DONG.name());
            if (account.getSinhVienId() != null && account.getSinhVienId() > 0) {
                stmt.setLong(5, account.getSinhVienId());
            } else {
                stmt.setNull(5, Types.BIGINT);
            }
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        account.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public boolean update(TaiKhoan account) throws SQLException {
        String sql = "UPDATE tai_khoan SET vai_tro = ?, trang_thai = ?, sinh_vien_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, account.getVaiTro().name());
            stmt.setString(2, account.getTrangThai().name());
            if (account.getSinhVienId() != null && account.getSinhVienId() > 0) {
                stmt.setLong(3, account.getSinhVienId());
            } else {
                stmt.setNull(3, Types.BIGINT);
            }
            stmt.setInt(4, account.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int id, TrangThaiTaiKhoan status) throws SQLException {
        String sql = "UPDATE tai_khoan SET trang_thai = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status.name());
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updatePassword(int id, String newPasswordHash) throws SQLException {
        String sql = "UPDATE tai_khoan SET password_hash = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPasswordHash);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tai_khoan WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<TaiKhoan> findAll() throws SQLException {
        List<TaiKhoan> list = new ArrayList<>();
        String sql = "SELECT * FROM tai_khoan ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToTaiKhoan(rs));
            }
        }
        return list;
    }

    private TaiKhoan mapResultSetToTaiKhoan(ResultSet rs) throws SQLException {
        TaiKhoan t = new TaiKhoan();
        t.setId(rs.getInt("id"));
        t.setUsername(rs.getString("username"));
        t.setPasswordHash(rs.getString("password_hash"));

        String vaiTroStr = rs.getString("vai_tro");
        if (vaiTroStr != null) {
            try {
                t.setVaiTro(VaiTro.valueOf(vaiTroStr));
            } catch (IllegalArgumentException e) {
                t.setVaiTro(VaiTro.SINH_VIEN);
            }
        }

        String trangThaiStr = rs.getString("trang_thai");
        if (trangThaiStr != null) {
            try {
                t.setTrangThai(TrangThaiTaiKhoan.valueOf(trangThaiStr));
            } catch (IllegalArgumentException e) {
                t.setTrangThai(TrangThaiTaiKhoan.HOAT_DONG);
            }
        }

        long svId = rs.getLong("sinh_vien_id");
        if (!rs.wasNull()) {
            t.setSinhVienId(svId);
        }
        return t;
    }
}
