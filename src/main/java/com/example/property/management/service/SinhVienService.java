package com.example.property.management.service;

import com.example.property.management.dao.SinhVienDAO;
import com.example.property.management.model.SinhVien;

import java.sql.SQLException;
import java.util.List;

public class SinhVienService {

    private final SinhVienDAO sinhVienDAO;

    public SinhVienService() {
        this.sinhVienDAO = new SinhVienDAO();
    }

    public List<SinhVien> getAllSinhVien() throws SQLException {
        return sinhVienDAO.findAll();
    }

    public SinhVien getSinhVienById(int id) throws SQLException {
        return sinhVienDAO.findById(id);
    }

    public boolean saveSinhVien(SinhVien sv) throws SQLException {
        if (sv.getHoTen() == null || sv.getHoTen().trim().isEmpty()) {
            throw new IllegalArgumentException("Họ tên sinh viên không được để trống!");
        }
        if (sv.getId() > 0) {
            return sinhVienDAO.update(sv);
        } else {
            return sinhVienDAO.insert(sv);
        }
    }

    public boolean deleteSinhVien(int id) throws SQLException {
        return sinhVienDAO.delete(id);
    }
}
