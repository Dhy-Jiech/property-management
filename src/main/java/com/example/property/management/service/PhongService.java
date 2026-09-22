package com.example.property.management.service;

import com.example.property.management.dao.PhongDAO;
import com.example.property.management.dao.TangDAO;
import com.example.property.management.model.Phong;
import com.example.property.management.model.Tang;
import com.example.property.management.model.enums.TrangThaiPhong;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class PhongService {

    private final PhongDAO phongDAO;
    private final TangDAO tangDAO;

    public PhongService() {
        this.phongDAO = new PhongDAO();
        this.tangDAO = new TangDAO();
    }

    public List<Phong> getAllPhong() throws SQLException {
        return phongDAO.findAll();
    }

    public Phong getPhongById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID phòng không hợp lệ");
        }
        return phongDAO.findById(id);
    }

    public List<Phong> getPhongAvailable() throws SQLException {
        return phongDAO.findPhongAvailable();
    }

    public List<Tang> getAllTang() throws SQLException {
        return tangDAO.findAll();
    }

    // Thêm phòng mới (Có validate chống trùng lặp ma_phong & kiểm tra tangId)
    public void createPhong(Phong phong) throws Exception {
        validate(phong);

        // 1. Kiểm tra mã phòng rỗng
        if (phong.getMaPhong() == null || phong.getMaPhong().trim().isEmpty()) {
            throw new Exception("Mã phòng không được để trống!");
        }

        // 2. Kiểm tra tangId có tồn tại trong CSDL không
        tangDAO.ensureDefaultData();
        Tang tang = tangDAO.findById(phong.getTangId());
        if (tang == null) {
            List<Tang> listTang = tangDAO.findAll();
            if (!listTang.isEmpty()) {
                phong.setTangId(listTang.get(0).getId());
            } else {
                throw new Exception("Tầng ID '" + phong.getTangId() + "' không tồn tại trên hệ thống!");
            }
        }

        // 3. Chống lặp dữ liệu: Kiểm tra mã phòng đã tồn tại chưa
        Phong existing = phongDAO.findByMaPhong(phong.getMaPhong().trim());
        if (existing != null) {
            throw new Exception("Mã phòng '" + phong.getMaPhong() + "' đã tồn tại trên hệ thống!");
        }

        // 4. Gán sức chứa mặc định theo Loại phòng
        if (phong.getLoaiPhong() != null) {
            phong.setSucChua(phong.getLoaiPhong().getSucChua());
        }
        phong.setSoNguoiHienTai(0);
        if (phong.getTrangThai() == null) {
            phong.setTrangThai(TrangThaiPhong.TRONG);
        }

        // 5. Lưu vào DB
        boolean success = phongDAO.insert(phong);
        if (!success) {
            throw new Exception("Thêm phòng thất bại, vui lòng thử lại!");
        }
    }

    // Cập nhật thông tin phòng
    public void updatePhong(Phong phong) throws Exception {
        validate(phong);
        Phong existing = phongDAO.findById(phong.getId());
        if (existing == null) {
            throw new Exception("Không tìm thấy phòng cần cập nhật!");
        }

        // Kiểm tra tangId
        tangDAO.ensureDefaultData();
        if (tangDAO.findById(phong.getTangId()) == null) {
            throw new Exception("Tầng ID '" + phong.getTangId() + "' không tồn tại!");
        }

        // Cập nhật sức chứa nếu đổi loại phòng
        if (phong.getLoaiPhong() != null) {
            phong.setSucChua(phong.getLoaiPhong().getSucChua());
        }

        // Kiểm tra số người hiện tại không được vượt quá sức chứa mới
        if (existing.getSoNguoiHienTai() > phong.getSucChua()) {
            throw new Exception("Sức chứa mới (" + phong.getSucChua() + ") nhỏ hơn số người hiện tại đang ở ("
                    + existing.getSoNguoiHienTai() + ")!");
        }

        boolean success = phongDAO.update(phong);
        if (!success) {
            throw new Exception("Cập nhật phòng thất bại!");
        }
    }

    // Xóa phòng
    public void deletePhong(int id) throws Exception {
        Phong existing = phongDAO.findById(id);
        if (existing == null) {
            throw new Exception("Phòng không tồn tại!");
        }

        if (existing.getSoNguoiHienTai() > 0) {
            throw new Exception("Không thể xóa phòng đang có sinh viên ở!");
        }

        boolean success = phongDAO.delete(id);
        if (!success) {
            throw new Exception("Xóa phòng thất bại! Phòng này có thể đang dính dữ liệu hợp đồng/hóa đơn cũ.");
        }
    }

    private void validate(Phong phong) {
        if (phong == null) {
            throw new IllegalArgumentException("Thông tin phòng không được để trống");
        }

        if (phong.getMaPhong() == null || phong.getMaPhong().isBlank()) {
            throw new IllegalArgumentException("Mã phòng không được để trống");
        }

        if (phong.getTenPhong() == null || phong.getTenPhong().isBlank()) {
            throw new IllegalArgumentException("Tên phòng không được để trống");
        }

        if (phong.getSoNguoiHienTai() < 0) {
            throw new IllegalArgumentException("Số người hiện tại không hợp lệ");
        }

        if (phong.getGiaThang() == null || phong.getGiaThang().compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Giá tháng không hợp lệ");
        }

        if (phong.getLoaiPhong() == null) {
            throw new IllegalArgumentException("Loại phòng không được để trống");
        }
    }
}