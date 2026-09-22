package com.example.property.management.model;

import com.example.property.management.model.enums.TrangThaiHopDong;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class HopDong {
    private int id;
    private String maHopDong;
    private int sinhVienId;
    private int phongId;
    private LocalDate ngayBatDau;
    private LocalDate ngayKetThuc;
    private BigDecimal tienPhong;
    private BigDecimal tienDatCoc;
    private TrangThaiHopDong trangThai;
    private LocalDateTime createdAt;

    // Joint objects
    private SinhVien sinhVien;
    private Phong phong;

    public HopDong() {
    }

    public HopDong(int id, String maHopDong, int sinhVienId, int phongId, LocalDate ngayBatDau, LocalDate ngayKetThuc,
            BigDecimal tienPhong, BigDecimal tienDatCoc, TrangThaiHopDong trangThai, LocalDateTime createdAt,
            SinhVien sinhVien, Phong phong) {
        this.id = id;
        this.maHopDong = maHopDong;
        this.sinhVienId = sinhVienId;
        this.phongId = phongId;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
        this.tienPhong = tienPhong;
        this.tienDatCoc = tienDatCoc;
        this.trangThai = trangThai;
        this.createdAt = createdAt;
        this.sinhVien = sinhVien;
        this.phong = phong;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaHopDong() {
        return maHopDong;
    }

    public void setMaHopDong(String maHopDong) {
        this.maHopDong = maHopDong;
    }

    public int getSinhVienId() {
        return sinhVienId;
    }

    public void setSinhVienId(int sinhVienId) {
        this.sinhVienId = sinhVienId;
    }

    public int getPhongId() {
        return phongId;
    }

    public void setPhongId(int phongId) {
        this.phongId = phongId;
    }

    public LocalDate getNgayBatDau() {
        return ngayBatDau;
    }

    public void setNgayBatDau(LocalDate ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public LocalDate getNgayKetThuc() {
        return ngayKetThuc;
    }

    public void setNgayKetThuc(LocalDate ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public BigDecimal getTienPhong() {
        return tienPhong;
    }

    public void setTienPhong(BigDecimal tienPhong) {
        this.tienPhong = tienPhong;
    }

    public BigDecimal getTienDatCoc() {
        return tienDatCoc;
    }

    public void setTienDatCoc(BigDecimal tienDatCoc) {
        this.tienDatCoc = tienDatCoc;
    }

    public TrangThaiHopDong getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiHopDong trangThai) {
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

    public Phong getPhong() {
        return phong;
    }

    public void setPhong(Phong phong) {
        this.phong = phong;
    }

    public static HopDongBuilder builder() {
        return new HopDongBuilder();
    }

    public static class HopDongBuilder {
        private int id;
        private String maHopDong;
        private int sinhVienId;
        private int phongId;
        private LocalDate ngayBatDau;
        private LocalDate ngayKetThuc;
        private BigDecimal tienPhong;
        private BigDecimal tienDatCoc;
        private TrangThaiHopDong trangThai;
        private LocalDateTime createdAt;
        private SinhVien sinhVien;
        private Phong phong;

        public HopDongBuilder id(int id) {
            this.id = id;
            return this;
        }

        public HopDongBuilder maHopDong(String maHopDong) {
            this.maHopDong = maHopDong;
            return this;
        }

        public HopDongBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public HopDongBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public HopDongBuilder ngayBatDau(LocalDate ngayBatDau) {
            this.ngayBatDau = ngayBatDau;
            return this;
        }

        public HopDongBuilder ngayKetThuc(LocalDate ngayKetThuc) {
            this.ngayKetThuc = ngayKetThuc;
            return this;
        }

        public HopDongBuilder tienPhong(BigDecimal tienPhong) {
            this.tienPhong = tienPhong;
            return this;
        }

        public HopDongBuilder tienDatCoc(BigDecimal tienDatCoc) {
            this.tienDatCoc = tienDatCoc;
            return this;
        }

        public HopDongBuilder trangThai(TrangThaiHopDong trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public HopDongBuilder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public HopDongBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public HopDongBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public HopDong build() {
            return new HopDong(id, maHopDong, sinhVienId, phongId, ngayBatDau, ngayKetThuc, tienPhong, tienDatCoc,
                    trangThai, createdAt, sinhVien, phong);
        }
    }
}
