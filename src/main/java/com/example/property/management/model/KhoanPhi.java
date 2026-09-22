package com.example.property.management.model;

import com.example.property.management.model.enums.TrangThaiKhoanPhi;

import java.math.BigDecimal;

public class KhoanPhi {
    private int id;
    private String tenKhoanPhi;
    private BigDecimal donGia;
    private String donViTinh;
    private TrangThaiKhoanPhi trangThai;

    public KhoanPhi() {
    }

    public KhoanPhi(int id, String tenKhoanPhi, BigDecimal donGia, String donViTinh, TrangThaiKhoanPhi trangThai) {
        this.id = id;
        this.tenKhoanPhi = tenKhoanPhi;
        this.donGia = donGia;
        this.donViTinh = donViTinh;
        this.trangThai = trangThai;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenKhoanPhi() {
        return tenKhoanPhi;
    }

    public void setTenKhoanPhi(String tenKhoanPhi) {
        this.tenKhoanPhi = tenKhoanPhi;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public String getDonViTinh() {
        return donViTinh;
    }

    public void setDonViTinh(String donViTinh) {
        this.donViTinh = donViTinh;
    }

    public TrangThaiKhoanPhi getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiKhoanPhi trangThai) {
        this.trangThai = trangThai;
    }

    public static KhoanPhiBuilder builder() {
        return new KhoanPhiBuilder();
    }

    public static class KhoanPhiBuilder {
        private int id;
        private String tenKhoanPhi;
        private BigDecimal donGia;
        private String donViTinh;
        private TrangThaiKhoanPhi trangThai;

        public KhoanPhiBuilder id(int id) {
            this.id = id;
            return this;
        }

        public KhoanPhiBuilder tenKhoanPhi(String tenKhoanPhi) {
            this.tenKhoanPhi = tenKhoanPhi;
            return this;
        }

        public KhoanPhiBuilder donGia(BigDecimal donGia) {
            this.donGia = donGia;
            return this;
        }

        public KhoanPhiBuilder donViTinh(String donViTinh) {
            this.donViTinh = donViTinh;
            return this;
        }

        public KhoanPhiBuilder trangThai(TrangThaiKhoanPhi trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public KhoanPhi build() {
            return new KhoanPhi(id, tenKhoanPhi, donGia, donViTinh, trangThai);
        }
    }
}
