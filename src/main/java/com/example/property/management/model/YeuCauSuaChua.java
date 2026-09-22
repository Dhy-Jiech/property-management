package com.example.property.management.model;

import com.example.property.management.model.enums.LoaiYeuCauSuaChua;
import com.example.property.management.model.enums.TrangThaiSuaChua;

import java.time.LocalDateTime;

public class YeuCauSuaChua {
    private int id;
    private int sinhVienId;
    private int phongId;
    private int taiSanId;
    private LoaiYeuCauSuaChua loaiYeuCau;
    private String noiDung;
    private TrangThaiSuaChua trangThai;
    private String phanHoi;
    private LocalDateTime thoiGian;

    // Joint objects
    private SinhVien sinhVien;
    private Phong phong;
    private TaiSan taiSan;

    public YeuCauSuaChua() {
    }

    public YeuCauSuaChua(int id, int sinhVienId, int phongId, int taiSanId, LoaiYeuCauSuaChua loaiYeuCau,
            String noiDung, TrangThaiSuaChua trangThai, String phanHoi, LocalDateTime thoiGian, SinhVien sinhVien,
            Phong phong, TaiSan taiSan) {
        this.id = id;
        this.sinhVienId = sinhVienId;
        this.phongId = phongId;
        this.taiSanId = taiSanId;
        this.loaiYeuCau = loaiYeuCau;
        this.noiDung = noiDung;
        this.trangThai = trangThai;
        this.phanHoi = phanHoi;
        this.thoiGian = thoiGian;
        this.sinhVien = sinhVien;
        this.phong = phong;
        this.taiSan = taiSan;
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

    public int getPhongId() {
        return phongId;
    }

    public void setPhongId(int phongId) {
        this.phongId = phongId;
    }

    public int getTaiSanId() {
        return taiSanId;
    }

    public void setTaiSanId(int taiSanId) {
        this.taiSanId = taiSanId;
    }

    public LoaiYeuCauSuaChua getLoaiYeuCau() {
        return loaiYeuCau;
    }

    public void setLoaiYeuCau(LoaiYeuCauSuaChua loaiYeuCau) {
        this.loaiYeuCau = loaiYeuCau;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public TrangThaiSuaChua getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiSuaChua trangThai) {
        this.trangThai = trangThai;
    }

    public String getPhanHoi() {
        return phanHoi;
    }

    public void setPhanHoi(String phanHoi) {
        this.phanHoi = phanHoi;
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

    public Phong getPhong() {
        return phong;
    }

    public void setPhong(Phong phong) {
        this.phong = phong;
    }

    public TaiSan getTaiSan() {
        return taiSan;
    }

    public void setTaiSan(TaiSan taiSan) {
        this.taiSan = taiSan;
    }

    public static YeuCauSuaChuaBuilder builder() {
        return new YeuCauSuaChuaBuilder();
    }

    public static class YeuCauSuaChuaBuilder {
        private int id;
        private int sinhVienId;
        private int phongId;
        private int taiSanId;
        private LoaiYeuCauSuaChua loaiYeuCau;
        private String noiDung;
        private TrangThaiSuaChua trangThai;
        private String phanHoi;
        private LocalDateTime thoiGian;
        private SinhVien sinhVien;
        private Phong phong;
        private TaiSan taiSan;

        public YeuCauSuaChuaBuilder id(int id) {
            this.id = id;
            return this;
        }

        public YeuCauSuaChuaBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public YeuCauSuaChuaBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public YeuCauSuaChuaBuilder taiSanId(int taiSanId) {
            this.taiSanId = taiSanId;
            return this;
        }

        public YeuCauSuaChuaBuilder loaiYeuCau(LoaiYeuCauSuaChua loaiYeuCau) {
            this.loaiYeuCau = loaiYeuCau;
            return this;
        }

        public YeuCauSuaChuaBuilder noiDung(String noiDung) {
            this.noiDung = noiDung;
            return this;
        }

        public YeuCauSuaChuaBuilder trangThai(TrangThaiSuaChua trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public YeuCauSuaChuaBuilder phanHoi(String phanHoi) {
            this.phanHoi = phanHoi;
            return this;
        }

        public YeuCauSuaChuaBuilder thoiGian(LocalDateTime thoiGian) {
            this.thoiGian = thoiGian;
            return this;
        }

        public YeuCauSuaChuaBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public YeuCauSuaChuaBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public YeuCauSuaChuaBuilder taiSan(TaiSan taiSan) {
            this.taiSan = taiSan;
            return this;
        }

        public YeuCauSuaChua build() {
            return new YeuCauSuaChua(id, sinhVienId, phongId, taiSanId, loaiYeuCau, noiDung, trangThai, phanHoi,
                    thoiGian, sinhVien, phong, taiSan);
        }
    }
}
