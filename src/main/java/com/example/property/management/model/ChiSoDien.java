package com.example.property.management.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ChiSoDien {
    private int id;
    private int phongId;
    private LocalDate kyThang;
    private BigDecimal chiSoCu;
    private BigDecimal chiSoMoi;
    private BigDecimal donGia;
    private BigDecimal tienDien;

    // Joint object
    private Phong phong;

    public ChiSoDien() {
    }

    public ChiSoDien(int id, int phongId, LocalDate kyThang, BigDecimal chiSoCu, BigDecimal chiSoMoi, BigDecimal donGia,
            BigDecimal tienDien, Phong phong) {
        this.id = id;
        this.phongId = phongId;
        this.kyThang = kyThang;
        this.chiSoCu = chiSoCu;
        this.chiSoMoi = chiSoMoi;
        this.donGia = donGia;
        this.tienDien = tienDien;
        this.phong = phong;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPhongId() {
        return phongId;
    }

    public void setPhongId(int phongId) {
        this.phongId = phongId;
    }

    public LocalDate getKyThang() {
        return kyThang;
    }

    public void setKyThang(LocalDate kyThang) {
        this.kyThang = kyThang;
    }

    public BigDecimal getChiSoCu() {
        return chiSoCu;
    }

    public void setChiSoCu(BigDecimal chiSoCu) {
        this.chiSoCu = chiSoCu;
    }

    public BigDecimal getChiSoMoi() {
        return chiSoMoi;
    }

    public void setChiSoMoi(BigDecimal chiSoMoi) {
        this.chiSoMoi = chiSoMoi;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public BigDecimal getTienDien() {
        return tienDien;
    }

    public void setTienDien(BigDecimal tienDien) {
        this.tienDien = tienDien;
    }

    public Phong getPhong() {
        return phong;
    }

    public void setPhong(Phong phong) {
        this.phong = phong;
    }

    public static ChiSoDienBuilder builder() {
        return new ChiSoDienBuilder();
    }

    public static class ChiSoDienBuilder {
        private int id;
        private int phongId;
        private LocalDate kyThang;
        private BigDecimal chiSoCu;
        private BigDecimal chiSoMoi;
        private BigDecimal donGia;
        private BigDecimal tienDien;
        private Phong phong;

        public ChiSoDienBuilder id(int id) {
            this.id = id;
            return this;
        }

        public ChiSoDienBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public ChiSoDienBuilder kyThang(LocalDate kyThang) {
            this.kyThang = kyThang;
            return this;
        }

        public ChiSoDienBuilder chiSoCu(BigDecimal chiSoCu) {
            this.chiSoCu = chiSoCu;
            return this;
        }

        public ChiSoDienBuilder chiSoMoi(BigDecimal chiSoMoi) {
            this.chiSoMoi = chiSoMoi;
            return this;
        }

        public ChiSoDienBuilder donGia(BigDecimal donGia) {
            this.donGia = donGia;
            return this;
        }

        public ChiSoDienBuilder tienDien(BigDecimal tienDien) {
            this.tienDien = tienDien;
            return this;
        }

        public ChiSoDienBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public ChiSoDien build() {
            return new ChiSoDien(id, phongId, kyThang, chiSoCu, chiSoMoi, donGia, tienDien, phong);
        }
    }
}
