package com.example.property.management.model;

import java.time.LocalDate;

public class SinhVien {
    private int id;
    private String hoTen;
    private LocalDate ngaySinh;
    private String gioiTinh;
    private String cccd;
    private String soDienThoai;
    private String email;
    private String diaChiQueQuan;
    private String truong;

    public SinhVien() {
    }

    public SinhVien(int id, String hoTen, LocalDate ngaySinh, String gioiTinh, String cccd, String soDienThoai,
            String email, String diaChiQueQuan, String truong) {
        this.id = id;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.cccd = cccd;
        this.soDienThoai = soDienThoai;
        this.email = email;
        this.diaChiQueQuan = diaChiQueQuan;
        this.truong = truong;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public LocalDate getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(LocalDate ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDiaChiQueQuan() {
        return diaChiQueQuan;
    }

    public void setDiaChiQueQuan(String diaChiQueQuan) {
        this.diaChiQueQuan = diaChiQueQuan;
    }

    public String getTruong() {
        return truong;
    }

    public void setTruong(String truong) {
        this.truong = truong;
    }

    public static SinhVienBuilder builder() {
        return new SinhVienBuilder();
    }

    public static class SinhVienBuilder {
        private int id;
        private String hoTen;
        private LocalDate ngaySinh;
        private String gioiTinh;
        private String cccd;
        private String soDienThoai;
        private String email;
        private String diaChiQueQuan;
        private String truong;

        public SinhVienBuilder id(int id) {
            this.id = id;
            return this;
        }

        public SinhVienBuilder hoTen(String hoTen) {
            this.hoTen = hoTen;
            return this;
        }

        public SinhVienBuilder ngaySinh(LocalDate ngaySinh) {
            this.ngaySinh = ngaySinh;
            return this;
        }

        public SinhVienBuilder gioiTinh(String gioiTinh) {
            this.gioiTinh = gioiTinh;
            return this;
        }

        public SinhVienBuilder cccd(String cccd) {
            this.cccd = cccd;
            return this;
        }

        public SinhVienBuilder soDienThoai(String soDienThoai) {
            this.soDienThoai = soDienThoai;
            return this;
        }

        public SinhVienBuilder email(String email) {
            this.email = email;
            return this;
        }

        public SinhVienBuilder diaChiQueQuan(String diaChiQueQuan) {
            this.diaChiQueQuan = diaChiQueQuan;
            return this;
        }

        public SinhVienBuilder truong(String truong) {
            this.truong = truong;
            return this;
        }

        public SinhVien build() {
            return new SinhVien(id, hoTen, ngaySinh, gioiTinh, cccd, soDienThoai, email, diaChiQueQuan, truong);
        }
    }
}