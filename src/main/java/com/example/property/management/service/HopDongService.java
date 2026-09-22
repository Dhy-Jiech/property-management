package com.example.property.management.service;

import com.example.property.management.dao.HopDongDAO;
import com.example.property.management.dao.PhongDAO;
import com.example.property.management.model.HopDong;
import com.example.property.management.model.Phong;
import com.example.property.management.model.enums.TrangThaiHopDong;

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

    public boolean cancelHopDong(int id) throws SQLException {
        HopDong hd = hopDongDAO.findById(id);
        if (hd != null && hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC) {
            boolean updated = hopDongDAO.updateStatus(id, TrangThaiHopDong.DA_CHAM_DUT);
            if (updated) {
                Phong phong = phongDAO.findById(hd.getPhongId());
                if (phong != null && phong.getSoNguoiHienTai() > 0) {
                    phong.setSoNguoiHienTai(phong.getSoNguoiHienTai() - 1);
                    phongDAO.update(phong);
                }
            }
            return updated;
        }
        return false;
    }
}
