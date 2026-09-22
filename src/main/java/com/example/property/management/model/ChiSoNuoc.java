package com.example.property.management.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ChiSoNuoc {
    private int id;
    private int phongId;
    private LocalDate kyThang;
    private BigDecimal chiSoCu;
    private BigDecimal chiSoMoi;
    private BigDecimal donGia;
    private BigDecimal tienNuoc;

    // Joint object
    private Phong phong;

    public ChiSoNuoc() {
    }

    public ChiSoNuoc(int id, int phongId, LocalDate kyThang, BigDecimal chiSoCu, BigDecimal chiSoMoi, BigDecimal donGia,
            BigDecimal tienNuoc, Phong phong) {
        this.id = id;
        this.phongId = phongId;
        this.kyThang = kyThang;
        this.chiSoCu = chiSoCu;
        this.chiSoMoi = chiSoMoi;
        this.donGia = donGia;
        this.tienNuoc = tienNuoc;
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

    public BigDecimal getTienNuoc() {
        return tienNuoc;
    }

    public void setTienNuoc(BigDecimal tienNuoc) {
        this.tienNuoc = tienNuoc;
    }

    public Phong getPhong() {
        return phong;
    }

    public void setPhong(Phong phong) {
        this.phong = phong;
    }

    public static ChiSoNuocBuilder builder() {
        return new ChiSoNuocBuilder();
    }

    public static class ChiSoNuocBuilder {
        private int id;
        private int phongId;
        private LocalDate kyThang;
        private BigDecimal chiSoCu;
        private BigDecimal chiSoMoi;
        private BigDecimal donGia;
        private BigDecimal tienNuoc;
        private Phong phong;

        public ChiSoNuocBuilder id(int id) {
            this.id = id;
            return this;
        }

        public ChiSoNuocBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public ChiSoNuocBuilder kyThang(LocalDate kyThang) {
            this.kyThang = kyThang;
            return this;
        }

        public ChiSoNuocBuilder chiSoCu(BigDecimal chiSoCu) {
            this.chiSoCu = chiSoCu;
            return this;
        }

        public ChiSoNuocBuilder chiSoMoi(BigDecimal chiSoMoi) {
            this.chiSoMoi = chiSoMoi;
            return this;
        }

        public ChiSoNuocBuilder donGia(BigDecimal donGia) {
            this.donGia = donGia;
            return this;
        }

        public ChiSoNuocBuilder tienNuoc(BigDecimal tienNuoc) {
            this.tienNuoc = tienNuoc;
            return this;
        }

        public ChiSoNuocBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public ChiSoNuoc build() {
            return new ChiSoNuoc(id, phongId, kyThang, chiSoCu, chiSoMoi, donGia, tienNuoc, phong);
        }
    }
}