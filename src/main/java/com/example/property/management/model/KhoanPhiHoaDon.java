package com.example.property.management.model;

import java.math.BigDecimal;

public class KhoanPhiHoaDon {
    private int id;
    private int hoaDonId;
    private int khoanPhiId;
    private BigDecimal soLuong;
    private BigDecimal donGia;
    private BigDecimal thanhTien;

    // Joint objects
    private HoaDon hoaDon;
    private KhoanPhi khoanPhi;

    public KhoanPhiHoaDon() {
    }

    public KhoanPhiHoaDon(int id, int hoaDonId, int khoanPhiId, BigDecimal soLuong, BigDecimal donGia,
            BigDecimal thanhTien, HoaDon hoaDon, KhoanPhi khoanPhi) {
        this.id = id;
        this.hoaDonId = hoaDonId;
        this.khoanPhiId = khoanPhiId;
        this.soLuong = soLuong;
        this.donGia = donGia;
        this.thanhTien = thanhTien;
        this.hoaDon = hoaDon;
        this.khoanPhi = khoanPhi;
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

    public int getKhoanPhiId() {
        return khoanPhiId;
    }

    public void setKhoanPhiId(int khoanPhiId) {
        this.khoanPhiId = khoanPhiId;
    }

    public BigDecimal getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(BigDecimal soLuong) {
        this.soLuong = soLuong;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public BigDecimal getThanhTien() {
        return thanhTien;
    }

    public void setThanhTien(BigDecimal thanhTien) {
        this.thanhTien = thanhTien;
    }

    public HoaDon getHoaDon() {
        return hoaDon;
    }

    public void setHoaDon(HoaDon hoaDon) {
        this.hoaDon = hoaDon;
    }

    public KhoanPhi getKhoanPhi() {
        return khoanPhi;
    }

    public void setKhoanPhi(KhoanPhi khoanPhi) {
        this.khoanPhi = khoanPhi;
    }

    public static KhoanPhiHoaDonBuilder builder() {
        return new KhoanPhiHoaDonBuilder();
    }

    public static class KhoanPhiHoaDonBuilder {
        private int id;
        private int hoaDonId;
        private int khoanPhiId;
        private BigDecimal soLuong;
        private BigDecimal donGia;
        private BigDecimal thanhTien;
        private HoaDon hoaDon;
        private KhoanPhi khoanPhi;

        public KhoanPhiHoaDonBuilder id(int id) {
            this.id = id;
            return this;
        }

        public KhoanPhiHoaDonBuilder hoaDonId(int hoaDonId) {
            this.hoaDonId = hoaDonId;
            return this;
        }

        public KhoanPhiHoaDonBuilder khoanPhiId(int khoanPhiId) {
            this.khoanPhiId = khoanPhiId;
            return this;
        }

        public KhoanPhiHoaDonBuilder soLuong(BigDecimal soLuong) {
            this.soLuong = soLuong;
            return this;
        }

        public KhoanPhiHoaDonBuilder donGia(BigDecimal donGia) {
            this.donGia = donGia;
            return this;
        }

        public KhoanPhiHoaDonBuilder thanhTien(BigDecimal thanhTien) {
            this.thanhTien = thanhTien;
            return this;
        }

        public KhoanPhiHoaDonBuilder hoaDon(HoaDon hoaDon) {
            this.hoaDon = hoaDon;
            return this;
        }

        public KhoanPhiHoaDonBuilder khoanPhi(KhoanPhi khoanPhi) {
            this.khoanPhi = khoanPhi;
            return this;
        }

        public KhoanPhiHoaDon build() {
            return new KhoanPhiHoaDon(id, hoaDonId, khoanPhiId, soLuong, donGia, thanhTien, hoaDon, khoanPhi);
        }
    }
}
