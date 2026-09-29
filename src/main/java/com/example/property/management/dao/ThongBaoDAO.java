package com.example.property.management.dao;

import com.example.property.management.model.ThongBao;
import com.example.property.management.model.enums.LoaiPhamVi;
import com.example.property.management.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ThongBaoDAO {

    /** Điều kiện "người xem này được đọc thông báo này". Cần truyền 2 tham số: userId, userId */
    private static final String VISIBLE =
        "(tb.pham_vi = 'TAT_CA' " +
        " OR (tb.pham_vi = 'CA_NHAN' AND tb.nguoi_nhan_id = ?) " +
        " OR (tb.pham_vi = 'PHONG' AND EXISTS (" +
        "      SELECT 1 FROM hop_dong hd " +
        "      JOIN tai_khoan tk ON tk.sinh_vien_id = hd.sinh_vien_id " +
        "      WHERE hd.phong_id = tb.phong_id AND hd.trang_thai = 'DANG_HIEU_LUC' AND tk.id = ?)))";

    private static final String SELECT_JOINS =
        " FROM thong_bao tb " +
        " LEFT JOIN phong p ON p.id = tb.phong_id " +
        " LEFT JOIN tai_khoan tkn ON tkn.id = tb.nguoi_nhan_id ";

    /** Hộp thư: các thông báo mà userId được phép đọc */
    public List<ThongBao> findVisibleFor(int userId) throws SQLException {
        String sql = "SELECT tb.*, (d.tai_khoan_id IS NOT NULL) AS da_doc_flag, " +
                     "p.ma_phong, tkn.username AS ten_nguoi_nhan " +
                     SELECT_JOINS +
                     " LEFT JOIN thong_bao_da_doc d ON d.thong_bao_id = tb.id AND d.tai_khoan_id = ? " +
                     " WHERE " + VISIBLE + " ORDER BY tb.thoi_gian DESC, tb.id DESC";
        List<ThongBao> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Tab "Đã gửi". nguoiGuiId = null thì lấy tất cả (dành cho admin/quản lý) */
    public List<ThongBao> findSent(Integer nguoiGuiId) throws SQLException {
        String sql = "SELECT tb.*, 1 AS da_doc_flag, p.ma_phong, tkn.username AS ten_nguoi_nhan " +
                     SELECT_JOINS +
                     (nguoiGuiId != null ? " WHERE tb.nguoi_gui_id = ? " : "") +
                     " ORDER BY tb.thoi_gian DESC, tb.id DESC";
        List<ThongBao> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (nguoiGuiId != null) ps.setInt(1, nguoiGuiId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public int countUnread(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM thong_bao tb " +
                     " LEFT JOIN thong_bao_da_doc d ON d.thong_bao_id = tb.id AND d.tai_khoan_id = ? " +
                     " WHERE d.tai_khoan_id IS NULL AND " + VISIBLE;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    /** Đánh dấu 1 thông báo đã đọc, chỉ khi người này được phép thấy nó */
    public void markAsRead(int thongBaoId, int userId) throws SQLException {
        String sql = "INSERT IGNORE INTO thong_bao_da_doc (thong_bao_id, tai_khoan_id) " +
                     "SELECT tb.id, ? FROM thong_bao tb WHERE tb.id = ? AND " + VISIBLE;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, thongBaoId);
            ps.setInt(3, userId);
            ps.setInt(4, userId);
            ps.executeUpdate();
        }
    }

    public void markAllRead(int userId) throws SQLException {
        String sql = "INSERT IGNORE INTO thong_bao_da_doc (thong_bao_id, tai_khoan_id) " +
                     "SELECT tb.id, ? FROM thong_bao tb WHERE " + VISIBLE;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);
            ps.executeUpdate();
        }
    }

    public void insert(ThongBao tb) throws SQLException {
        // Tương thích code cũ: nếu chưa set phamVi thì suy ra từ nguoiNhanId
        LoaiPhamVi phamVi = tb.getPhamVi();
        if (phamVi == null) {
            phamVi = (tb.getNguoiNhanId() == null) ? LoaiPhamVi.TAT_CA : LoaiPhamVi.CA_NHAN;
        }

        String sql = "INSERT INTO thong_bao (nguoi_nhan_id, phong_id, pham_vi, tieu_de, noi_dung, loai, nguoi_gui_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setObject(1, phamVi == LoaiPhamVi.CA_NHAN ? tb.getNguoiNhanId() : null);
            ps.setObject(2, phamVi == LoaiPhamVi.PHONG ? tb.getPhongId() : null);
            ps.setString(3, phamVi.name());
            ps.setString(4, tb.getTieuDe());
            ps.setString(5, tb.getNoiDung());
            ps.setString(6, tb.getLoai() != null ? tb.getLoai() : "THONG_TIN");
            ps.setObject(7, tb.getNguoiGuiId());
            ps.executeUpdate();
        }
    }

    /** Danh sách tài khoản để chọn "người cụ thể" trong form */
    public List<Map<String, Object>> findRecipientAccounts() throws SQLException {
        String sql = "SELECT tk.id, tk.username, tk.vai_tro, sv.ho_ten " +
                     "FROM tai_khoan tk LEFT JOIN sinh_vien sv ON sv.id = tk.sinh_vien_id " +
                     "WHERE tk.trang_thai = 'HOAT_DONG' ORDER BY tk.vai_tro, tk.username";
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("username", rs.getString("username"));
                m.put("vaiTro", rs.getString("vai_tro"));
                m.put("hoTen", rs.getString("ho_ten"));
                list.add(m);
            }
        }
        return list;
    }

    private ThongBao map(ResultSet rs) throws SQLException {
        ThongBao tb = new ThongBao();
        tb.setId(rs.getInt("id"));
        tb.setNguoiNhanId((Integer) rs.getObject("nguoi_nhan_id"));
        tb.setPhongId((Integer) rs.getObject("phong_id"));
        tb.setNguoiGuiId((Integer) rs.getObject("nguoi_gui_id"));
        String pv = rs.getString("pham_vi");
        tb.setPhamVi(pv != null ? LoaiPhamVi.valueOf(pv) : LoaiPhamVi.TAT_CA);
        tb.setTieuDe(rs.getString("tieu_de"));
        tb.setNoiDung(rs.getString("noi_dung"));
        tb.setLoai(rs.getString("loai"));
        tb.setDaDoc(rs.getBoolean("da_doc_flag"));
        tb.setMaPhong(rs.getString("ma_phong"));
        tb.setTenNguoiNhan(rs.getString("ten_nguoi_nhan"));
        tb.setThoiGian(rs.getTimestamp("thoi_gian").toLocalDateTime()); // chỉnh: đổi theo kiểu của thoiGian trong model
        return tb;
    }
}