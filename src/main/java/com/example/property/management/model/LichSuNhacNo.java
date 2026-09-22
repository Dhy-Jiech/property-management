package com.example.property.management.model;

import java.time.LocalDateTime;

public class LichSuNhacNo {
    private int id;
    private int sinhVienId;
    private int hoaDonId;
    private Integer lanNhac;
    private String noiDung;
    private LocalDateTime thoiGian;

    // Joint objects
    private SinhVien sinhVien;
    private HoaDon hoaDon;

    public LichSuNhacNo() {
    }

    public LichSuNhacNo(int id, int sinhVienId, int hoaDonId, Integer lanNhac, String noiDung, LocalDateTime thoiGian,
            SinhVien sinhVien, HoaDon hoaDon) {
        this.id = id;
        this.sinhVienId = sinhVienId;
        this.hoaDonId = hoaDonId;
        this.lanNhac = lanNhac;
        this.noiDung = noiDung;
        this.thoiGian = thoiGian;
        this.sinhVien = sinhVien;
        this.hoaDon = hoaDon;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSinhVienId() {
        return sinhVienId;
    }

    public void setSinhVienId(int sinhVienId) {
        this.sinhVienId = sinhVienId;
    }

    public int getHoaDonId() {
        return hoaDonId;
    }

    public void setHoaDonId(int hoaDonId) {
        this.hoaDonId = hoaDonId;
    }

    public Integer getLanNhac() {
        return lanNhac;
    }

    public void setLanNhac(Integer lanNhac) {
        this.lanNhac = lanNhac;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }

    public SinhVien getSinhVien() {
        return sinhVien;
    }

    public void setSinhVien(SinhVien sinhVien) {
        this.sinhVien = sinhVien;
    }

    public HoaDon getHoaDon() {
        return hoaDon;
    }

    public void setHoaDon(HoaDon hoaDon) {
        this.hoaDon = hoaDon;
    }

    public static LichSuNhacNoBuilder builder() {
        return new LichSuNhacNoBuilder();
    }

    public static class LichSuNhacNoBuilder {
        private int id;
        private int sinhVienId;
        private int hoaDonId;
        private Integer lanNhac;
        private String noiDung;
        private LocalDateTime thoiGian;
        private SinhVien sinhVien;
        private HoaDon hoaDon;

        public LichSuNhacNoBuilder id(int id) {
            this.id = id;
            return this;
        }

        public LichSuNhacNoBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public LichSuNhacNoBuilder hoaDonId(int hoaDonId) {
            this.hoaDonId = hoaDonId;
            return this;
        }

        public LichSuNhacNoBuilder lanNhac(Integer lanNhac) {
            this.lanNhac = lanNhac;
            return this;
        }

        public LichSuNhacNoBuilder noiDung(String noiDung) {
            this.noiDung = noiDung;
            return this;
        }

        public LichSuNhacNoBuilder thoiGian(LocalDateTime thoiGian) {
            this.thoiGian = thoiGian;
            return this;
        }

        public LichSuNhacNoBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public LichSuNhacNoBuilder hoaDon(HoaDon hoaDon) {
            this.hoaDon = hoaDon;
            return this;
        }

        public LichSuNhacNo build() {
            return new LichSuNhacNo(id, sinhVienId, hoaDonId, lanNhac, noiDung, thoiGian, sinhVien, hoaDon);
        }
    }
}
