package com.example.property.management.model;

import com.example.property.management.model.enums.PhuongThucThanhToan;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Simplified ThanhToan model – nguoiXacNhan stored as username string
 * to decouple from tai_khoan FK and simplify DAO queries.
 */
public class ThanhToan {
    private int id;
    private int hoaDonId;
    private BigDecimal soTien;
    private PhuongThucThanhToan phuongThuc;
    private String maGiaoDich;
    private LocalDateTime thoiGian;
    private String nguoiXacNhan; // username string

    public ThanhToan() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHoaDonId() {
        return hoaDonId;
    }

    public void setHoaDonId(int hoaDonId) {
        this.hoaDonId = hoaDonId;
    }

    public BigDecimal getSoTien() {
        return soTien;
    }

    public void setSoTien(BigDecimal soTien) {
        this.soTien = soTien;
    }

    public PhuongThucThanhToan getPhuongThuc() {
        return phuongThuc;
    }

    public void setPhuongThuc(PhuongThucThanhToan phuongThuc) {
        this.phuongThuc = phuongThuc;
    }

    public String getMaGiaoDich() {
        return maGiaoDich;
    }

    public void setMaGiaoDich(String maGiaoDich) {
        this.maGiaoDich = maGiaoDich;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }

    public String getNguoiXacNhan() {
        return nguoiXacNhan;
    }

    public void setNguoiXacNhan(String nguoiXacNhan) {
        this.nguoiXacNhan = nguoiXacNhan;
    }
}
