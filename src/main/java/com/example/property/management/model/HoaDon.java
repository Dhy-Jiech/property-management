package com.example.property.management.model;

import com.example.property.management.model.enums.TrangThaiHoaDon;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class HoaDon {
    private int id;
    private String maHoaDon;
    private int sinhVienId;
    private LocalDate kyThanhToan;
    private BigDecimal tienPhong;
    private BigDecimal tienDien;
    private BigDecimal tienNuoc;
    private BigDecimal tongPhi;
    private BigDecimal tongTien;
    private LocalDate hanThanhToan;
    private Integer soLanNhac;
    private TrangThaiHoaDon trangThai;
    private LocalDateTime createdAt;

    // Joint object
    private SinhVien sinhVien;

    public HoaDon() {
    }

    public HoaDon(int id, String maHoaDon, int sinhVienId, LocalDate kyThanhToan, BigDecimal tienPhong,
            BigDecimal tienDien, BigDecimal tienNuoc, BigDecimal tongPhi, BigDecimal tongTien, LocalDate hanThanhToan,
            Integer soLanNhac, TrangThaiHoaDon trangThai, LocalDateTime createdAt, SinhVien sinhVien) {
        this.id = id;
        this.maHoaDon = maHoaDon;
        this.sinhVienId = sinhVienId;
        this.kyThanhToan = kyThanhToan;
        this.tienPhong = tienPhong;
        this.tienDien = tienDien;
        this.tienNuoc = tienNuoc;
        this.tongPhi = tongPhi;
        this.tongTien = tongTien;
        this.hanThanhToan = hanThanhToan;
        this.soLanNhac = soLanNhac;
        this.trangThai = trangThai;
        this.createdAt = createdAt;
        this.sinhVien = sinhVien;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaHoaDon() {
        return maHoaDon;
    }

    public void setMaHoaDon(String maHoaDon) {
        this.maHoaDon = maHoaDon;
    }

    public int getSinhVienId() {
        return sinhVienId;
    }

    public void setSinhVienId(int sinhVienId) {
        this.sinhVienId = sinhVienId;
    }

    public LocalDate getKyThanhToan() {
        return kyThanhToan;
    }

    public void setKyThanhToan(LocalDate kyThanhToan) {
        this.kyThanhToan = kyThanhToan;
    }

    public BigDecimal getTienPhong() {
        return tienPhong;
    }

    public void setTienPhong(BigDecimal tienPhong) {
        this.tienPhong = tienPhong;
    }

    public BigDecimal getTienDien() {
        return tienDien;
    }

    public void setTienDien(BigDecimal tienDien) {
        this.tienDien = tienDien;
    }

    public BigDecimal getTienNuoc() {
        return tienNuoc;
    }

    public void setTienNuoc(BigDecimal tienNuoc) {
        this.tienNuoc = tienNuoc;
    }

    public BigDecimal getTongPhi() {
        return tongPhi;
    }

    public void setTongPhi(BigDecimal tongPhi) {
        this.tongPhi = tongPhi;
    }

    public BigDecimal getTongTien() {
        return tongTien;
    }

    public void setTongTien(BigDecimal tongTien) {
        this.tongTien = tongTien;
    }

    public LocalDate getHanThanhToan() {
        return hanThanhToan;
    }

    public void setHanThanhToan(LocalDate hanThanhToan) {
        this.hanThanhToan = hanThanhToan;
    }

    public Integer getSoLanNhac() {
        return soLanNhac;
    }

    public void setSoLanNhac(Integer soLanNhac) {
        this.soLanNhac = soLanNhac;
    }

    public TrangThaiHoaDon getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiHoaDon trangThai) {
        this.trangThai = trangThai;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public SinhVien getSinhVien() {
        return sinhVien;
    }

    public void setSinhVien(SinhVien sinhVien) {
        this.sinhVien = sinhVien;
    }

    public static HoaDonBuilder builder() {
        return new HoaDonBuilder();
    }

    public static class HoaDonBuilder {
        private int id;
        private String maHoaDon;
        private int sinhVienId;
        private LocalDate kyThanhToan;
        private BigDecimal tienPhong;
        private BigDecimal tienDien;
        private BigDecimal tienNuoc;
        private BigDecimal tongPhi;
        private BigDecimal tongTien;
        private LocalDate hanThanhToan;
        private Integer soLanNhac;
        private TrangThaiHoaDon trangThai;
        private LocalDateTime createdAt;
        private SinhVien sinhVien;

        public HoaDonBuilder id(int id) {
            this.id = id;
            return this;
        }

        public HoaDonBuilder maHoaDon(String maHoaDon) {
            this.maHoaDon = maHoaDon;
            return this;
        }

        public HoaDonBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public HoaDonBuilder kyThanhToan(LocalDate kyThanhToan) {
            this.kyThanhToan = kyThanhToan;
            return this;
        }

        public HoaDonBuilder tienPhong(BigDecimal tienPhong) {
            this.tienPhong = tienPhong;
            return this;
        }

        public HoaDonBuilder tienDien(BigDecimal tienDien) {
            this.tienDien = tienDien;
            return this;
        }

        public HoaDonBuilder tienNuoc(BigDecimal tienNuoc) {
            this.tienNuoc = tienNuoc;
            return this;
        }

        public HoaDonBuilder tongPhi(BigDecimal tongPhi) {
            this.tongPhi = tongPhi;
            return this;
        }

        public HoaDonBuilder tongTien(BigDecimal tongTien) {
            this.tongTien = tongTien;
            return this;
        }

        public HoaDonBuilder hanThanhToan(LocalDate hanThanhToan) {
            this.hanThanhToan = hanThanhToan;
            return this;
        }

        public HoaDonBuilder soLanNhac(Integer soLanNhac) {
            this.soLanNhac = soLanNhac;
            return this;
        }

        public HoaDonBuilder trangThai(TrangThaiHoaDon trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public HoaDonBuilder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public HoaDonBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public HoaDon build() {
            return new HoaDon(id, maHoaDon, sinhVienId, kyThanhToan, tienPhong, tienDien, tienNuoc, tongPhi, tongTien,
                    hanThanhToan, soLanNhac, trangThai, createdAt, sinhVien);
        }
    }
}
