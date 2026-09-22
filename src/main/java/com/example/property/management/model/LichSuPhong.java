package com.example.property.management.model;

import java.time.LocalDateTime;

public class LichSuPhong {
    private int id;
    private int sinhVienId;
    private int phongCu;
    private int phongMoi;
    private LocalDateTime thoiGian;
    private String lyDo;
    private int nguoiXuLy;

    // Joint objects
    private SinhVien sinhVien;
    private Phong objPhongCu;
    private Phong objPhongMoi;
    private TaiKhoan taiKhoanNguoiXuLy;

    public LichSuPhong() {
    }

    public LichSuPhong(int id, int sinhVienId, int phongCu, int phongMoi, LocalDateTime thoiGian, String lyDo,
            int nguoiXuLy, SinhVien sinhVien, Phong objPhongCu, Phong objPhongMoi, TaiKhoan taiKhoanNguoiXuLy) {
        this.id = id;
        this.sinhVienId = sinhVienId;
        this.phongCu = phongCu;
        this.phongMoi = phongMoi;
        this.thoiGian = thoiGian;
        this.lyDo = lyDo;
        this.nguoiXuLy = nguoiXuLy;
        this.sinhVien = sinhVien;
        this.objPhongCu = objPhongCu;
        this.objPhongMoi = objPhongMoi;
        this.taiKhoanNguoiXuLy = taiKhoanNguoiXuLy;
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

    public int getPhongCu() {
        return phongCu;
    }

    public void setPhongCu(int phongCu) {
        this.phongCu = phongCu;
    }

    public int getPhongMoi() {
        return phongMoi;
    }

    public void setPhongMoi(int phongMoi) {
        this.phongMoi = phongMoi;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public int getNguoiXuLy() {
        return nguoiXuLy;
    }

    public void setNguoiXuLy(int nguoiXuLy) {
        this.nguoiXuLy = nguoiXuLy;
    }

    public SinhVien getSinhVien() {
        return sinhVien;
    }

    public void setSinhVien(SinhVien sinhVien) {
        this.sinhVien = sinhVien;
    }

    public Phong getObjPhongCu() {
        return objPhongCu;
    }

    public void setObjPhongCu(Phong objPhongCu) {
        this.objPhongCu = objPhongCu;
    }

    public Phong getObjPhongMoi() {
        return objPhongMoi;
    }

    public void setObjPhongMoi(Phong objPhongMoi) {
        this.objPhongMoi = objPhongMoi;
    }

    public TaiKhoan getTaiKhoanNguoiXuLy() {
        return taiKhoanNguoiXuLy;
    }

    public void setTaiKhoanNguoiXuLy(TaiKhoan taiKhoanNguoiXuLy) {
        this.taiKhoanNguoiXuLy = taiKhoanNguoiXuLy;
    }

    public static LichSuPhongBuilder builder() {
        return new LichSuPhongBuilder();
    }

    public static class LichSuPhongBuilder {
        private int id;
        private int sinhVienId;
        private int phongCu;
        private int phongMoi;
        private LocalDateTime thoiGian;
        private String lyDo;
        private int nguoiXuLy;
        private SinhVien sinhVien;
        private Phong objPhongCu;
        private Phong objPhongMoi;
        private TaiKhoan taiKhoanNguoiXuLy;

        public LichSuPhongBuilder id(int id) {
            this.id = id;
            return this;
        }

        public LichSuPhongBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public LichSuPhongBuilder phongCu(int phongCu) {
            this.phongCu = phongCu;
            return this;
        }

        public LichSuPhongBuilder phongMoi(int phongMoi) {
            this.phongMoi = phongMoi;
            return this;
        }

        public LichSuPhongBuilder thoiGian(LocalDateTime thoiGian) {
            this.thoiGian = thoiGian;
            return this;
        }

        public LichSuPhongBuilder lyDo(String lyDo) {
            this.lyDo = lyDo;
            return this;
        }

        public LichSuPhongBuilder nguoiXuLy(int nguoiXuLy) {
            this.nguoiXuLy = nguoiXuLy;
            return this;
        }

        public LichSuPhongBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public LichSuPhongBuilder objPhongCu(Phong objPhongCu) {
            this.objPhongCu = objPhongCu;
            return this;
        }

        public LichSuPhongBuilder objPhongMoi(Phong objPhongMoi) {
            this.objPhongMoi = objPhongMoi;
            return this;
        }

        public LichSuPhongBuilder taiKhoanNguoiXuLy(TaiKhoan taiKhoanNguoiXuLy) {
            this.taiKhoanNguoiXuLy = taiKhoanNguoiXuLy;
            return this;
        }

        public LichSuPhong build() {
            return new LichSuPhong(id, sinhVienId, phongCu, phongMoi, thoiGian, lyDo, nguoiXuLy, sinhVien, objPhongCu,
                    objPhongMoi, taiKhoanNguoiXuLy);
        }
    }
}