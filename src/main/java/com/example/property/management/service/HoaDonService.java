package com.example.property.management.service;

import com.example.property.management.dao.HoaDonDAO;
import com.example.property.management.model.HoaDon;
import com.example.property.management.model.enums.TrangThaiHoaDon;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class HoaDonService {

    private final HoaDonDAO hoaDonDAO;

    public HoaDonService() {
        this.hoaDonDAO = new HoaDonDAO();
    }

    public List<HoaDon> getAllHoaDon() throws SQLException {
        return hoaDonDAO.findAll();
    }

    public HoaDon getHoaDonById(int id) throws SQLException {
        return hoaDonDAO.findById(id);
    }

    public boolean createHoaDon(HoaDon hd) throws SQLException {
        if (hd.getMaHoaDon() == null || hd.getMaHoaDon().trim().isEmpty()) {
            throw new IllegalArgumentException("Mã hóa đơn không được để trống!");
        }

        // Calculate total amount
        BigDecimal tPhong = hd.getTienPhong() != null ? hd.getTienPhong() : BigDecimal.ZERO;
        BigDecimal tDien = hd.getTienDien() != null ? hd.getTienDien() : BigDecimal.ZERO;
        BigDecimal tNuoc = hd.getTienNuoc() != null ? hd.getTienNuoc() : BigDecimal.ZERO;
        BigDecimal tPhi = hd.getTongPhi() != null ? hd.getTongPhi() : BigDecimal.ZERO;

        BigDecimal tongTien = tPhong.add(tDien).add(tNuoc).add(tPhi);
        hd.setTongTien(tongTien);

        return hoaDonDAO.insert(hd);
    }

    public boolean markAsPaid(int id) throws SQLException {
        return hoaDonDAO.updateStatus(id, TrangThaiHoaDon.DA_THANH_TOAN);
    }
}
