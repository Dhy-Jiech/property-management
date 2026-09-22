package com.example.property.management.model;

import com.example.property.management.model.enums.PhuongThucThanhToan;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ThanhToan {
    private int id;
    private int hoaDonId;
    private BigDecimal soTien;
    private PhuongThucThanhToan phuongThuc;
    private String maGiaoDich;
    private LocalDateTime thoiGian;
    private int nguoiXacNhan;

    // Joint objects
    private HoaDon hoaDon;
    private TaiKhoan taiKhoanNguoiXacNhan;

    public ThanhToan() {
    }

    public ThanhToan(int id, int hoaDonId, BigDecimal soTien, PhuongThucThanhToan phuongThuc, String maGiaoDich,
            LocalDateTime thoiGian, int nguoiXacNhan, HoaDon hoaDon, TaiKhoan taiKhoanNguoiXacNhan) {
        this.id = id;
        this.hoaDonId = hoaDonId;
        this.soTien = soTien;
        this.phuongThuc = phuongThuc;
        this.maGiaoDich = maGiaoDich;
        this.thoiGian = thoiGian;
        this.nguoiXacNhan = nguoiXacNhan;
        this.hoaDon = hoaDon;
        this.taiKhoanNguoiXacNhan = taiKhoanNguoiXacNhan;
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

    public int getNguoiXacNhan() {
        return nguoiXacNhan;
    }

    public void setNguoiXacNhan(int nguoiXacNhan) {
        this.nguoiXacNhan = nguoiXacNhan;
    }

    public HoaDon getHoaDon() {
        return hoaDon;
    }

    public void setHoaDon(HoaDon hoaDon) {
        this.hoaDon = hoaDon;
    }

    public TaiKhoan getTaiKhoanNguoiXacNhan() {
        return taiKhoanNguoiXacNhan;
    }

    public void setTaiKhoanNguoiXacNhan(TaiKhoan taiKhoanNguoiXacNhan) {
        this.taiKhoanNguoiXacNhan = taiKhoanNguoiXacNhan;
    }

    public static ThanhToanBuilder builder() {
        return new ThanhToanBuilder();
    }

    public static class ThanhToanBuilder {
        private int id;
        private int hoaDonId;
        private BigDecimal soTien;
        private PhuongThucThanhToan phuongThuc;
        private String maGiaoDich;
        private LocalDateTime thoiGian;
        private int nguoiXacNhan;
        private HoaDon hoaDon;
        private TaiKhoan taiKhoanNguoiXacNhan;

        public ThanhToanBuilder id(int id) {
            this.id = id;
            return this;
        }

        public ThanhToanBuilder hoaDonId(int hoaDonId) {
            this.hoaDonId = hoaDonId;
            return this;
        }

        public ThanhToanBuilder soTien(BigDecimal soTien) {
            this.soTien = soTien;
            return this;
        }

        public ThanhToanBuilder phuongThuc(PhuongThucThanhToan phuongThuc) {
            this.phuongThuc = phuongThuc;
            return this;
        }

        public ThanhToanBuilder maGiaoDich(String maGiaoDich) {
            this.maGiaoDich = maGiaoDich;
            return this;
        }

        public ThanhToanBuilder thoiGian(LocalDateTime thoiGian) {
            this.thoiGian = thoiGian;
            return this;
        }

        public ThanhToanBuilder nguoiXacNhan(int nguoiXacNhan) {
            this.nguoiXacNhan = nguoiXacNhan;
            return this;
        }

        public ThanhToanBuilder hoaDon(HoaDon hoaDon) {
            this.hoaDon = hoaDon;
            return this;
        }

        public ThanhToanBuilder taiKhoanNguoiXacNhan(TaiKhoan taiKhoanNguoiXacNhan) {
            this.taiKhoanNguoiXacNhan = taiKhoanNguoiXacNhan;
            return this;
        }

        public ThanhToan build() {
            return new ThanhToan(id, hoaDonId, soTien, phuongThuc, maGiaoDich, thoiGian, nguoiXacNhan, hoaDon,
                    taiKhoanNguoiXacNhan);
        }
    }
}
