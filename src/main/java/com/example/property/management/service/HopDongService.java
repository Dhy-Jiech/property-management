package com.example.property.management.service;

import com.example.property.management.dao.HopDongDAO;
import com.example.property.management.dao.PhongDAO;
import com.example.property.management.model.HopDong;
import com.example.property.management.model.Phong;
import com.example.property.management.model.enums.TrangThaiHopDong;
import com.example.property.management.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class HopDongService {

    private final HopDongDAO hopDongDAO;
    private final PhongDAO phongDAO;

    public HopDongService() {
        this.hopDongDAO = new HopDongDAO();
        this.phongDAO = new PhongDAO();
    }

    public List<HopDong> getAllHopDong() throws SQLException {
        return hopDongDAO.findAll();
    }

    public HopDong getHopDongById(int id) throws SQLException {
        return hopDongDAO.findById(id);
    }

    public boolean createHopDong(HopDong hd) throws SQLException {
        if (hd.getMaHopDong() == null || hd.getMaHopDong().trim().isEmpty()) {
            throw new IllegalArgumentException("Mã hợp đồng không được để trống!");
        }

        Phong phong = phongDAO.findById(hd.getPhongId());
        if (phong == null) {
            throw new IllegalArgumentException("Phòng không tồn tại!");
        }

        if (phong.getSoNguoiHienTai() >= phong.getSucChua()) {
            throw new IllegalStateException("Phòng đã đầy! Sức chứa tối đa: " + phong.getSucChua());
        }

        boolean inserted = hopDongDAO.insert(hd);
        if (inserted) {
            // Increase room occupancy
            phong.setSoNguoiHienTai(phong.getSoNguoiHienTai() + 1);
            phongDAO.update(phong);
        }
        return inserted;
    }

    public List<HopDong> getHopDongBySinhVienId(int sinhVienId) throws SQLException {
        return hopDongDAO.findBySinhVienId(sinhVienId);
    }

    public boolean signHopDongByStudent(int id, String chuKyBenB) throws SQLException {
        if (chuKyBenB == null || chuKyBenB.trim().isEmpty()) {
            throw new IllegalArgumentException("Chữ ký sinh viên không được để trống!");
        }
        return hopDongDAO.updateStudentSignature(id, chuKyBenB);
    }

    public void cancelHopDong(int id) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int phongId;
                String trangThaiCu;

                try (PreparedStatement ps = conn.prepareStatement(
                        "SELECT phong_id, trang_thai FROM hop_dong WHERE id = ? FOR UPDATE")) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next())
                            throw new Exception("Hợp đồng không tồn tại!");
                        phongId = rs.getInt("phong_id");
                        trangThaiCu = rs.getString("trang_thai");
                    }
                }

                if ("DA_CHAM_DUT".equals(trangThaiCu) || "HET_HAN".equals(trangThaiCu)) {
                    throw new Exception("Hợp đồng đã chấm dứt hoặc đã hết hạn!");
                }

                try (PreparedStatement ps = conn.prepareStatement(
                        "UPDATE hop_dong SET trang_thai = 'DA_CHAM_DUT' WHERE id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // Chỉ hợp đồng đang hiệu lực mới đã chiếm chỗ trong phòng
                if ("DANG_HIEU_LUC".equals(trangThaiCu)) {
                    try (PreparedStatement ps = conn.prepareStatement(
                            "UPDATE phong SET " +
                                    "so_nguoi_hien_tai = GREATEST(so_nguoi_hien_tai - 1, 0), " +
                                    "trang_thai = CASE WHEN trang_thai = 'BAO_TRI' THEN 'BAO_TRI' " +
                                    "                  WHEN so_nguoi_hien_tai = 0 THEN 'TRONG' " +
                                    "                  ELSE 'DANG_CHO_THUE' END " +
                                    "WHERE id = ?")) {
                        ps.setInt(1, phongId);
                        ps.executeUpdate();
                    }
                }

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }
}
