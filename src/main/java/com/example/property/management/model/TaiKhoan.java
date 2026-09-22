package com.example.property.management.model;

import com.example.property.management.model.enums.TrangThaiTaiKhoan;
import com.example.property.management.model.enums.VaiTro;

public class TaiKhoan {
    private int id;
    private String username;
    private String passwordHash;
    private VaiTro vaiTro;
    private TrangThaiTaiKhoan trangThai;
    private Long sinhVienId;

    // Joint object
    private SinhVien sinhVien;

    public TaiKhoan() {
    }

    public TaiKhoan(int id, String username, String passwordHash, VaiTro vaiTro, TrangThaiTaiKhoan trangThai,
            Long sinhVienId, SinhVien sinhVien) {
        this.id = id;
        this.username = username;
        this.passwordHash = passwordHash;
        this.vaiTro = vaiTro;
        this.trangThai = trangThai;
        this.sinhVienId = sinhVienId;
        this.sinhVien = sinhVien;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public VaiTro getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(VaiTro vaiTro) {
        this.vaiTro = vaiTro;
    }

    public TrangThaiTaiKhoan getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiTaiKhoan trangThai) {
        this.trangThai = trangThai;
    }

    public Long getSinhVienId() {
        return sinhVienId;
    }

    public void setSinhVienId(Long sinhVienId) {
        this.sinhVienId = sinhVienId;
    }

    public SinhVien getSinhVien() {
        return sinhVien;
    }

    public void setSinhVien(SinhVien sinhVien) {
        this.sinhVien = sinhVien;
    }

    public static TaiKhoanBuilder builder() {
        return new TaiKhoanBuilder();
    }

    public static class TaiKhoanBuilder {
        private int id;
        private String username;
        private String passwordHash;
        private VaiTro vaiTro;
        private TrangThaiTaiKhoan trangThai;
        private Long sinhVienId;
        private SinhVien sinhVien;

        public TaiKhoanBuilder id(int id) {
            this.id = id;
            return this;
        }

        public TaiKhoanBuilder username(String username) {
            this.username = username;
            return this;
        }

        public TaiKhoanBuilder passwordHash(String passwordHash) {
            this.passwordHash = passwordHash;
            return this;
        }

        public TaiKhoanBuilder vaiTro(VaiTro vaiTro) {
            this.vaiTro = vaiTro;
            return this;
        }

        public TaiKhoanBuilder trangThai(TrangThaiTaiKhoan trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public TaiKhoanBuilder sinhVienId(Long sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public TaiKhoanBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public TaiKhoan build() {
            return new TaiKhoan(id, username, passwordHash, vaiTro, trangThai, sinhVienId, sinhVien);
        }
    }
}