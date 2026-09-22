package com.example.property.management.model;

import com.example.property.management.model.enums.LoaiYeuCauDangKy;
import com.example.property.management.model.enums.TrangThaiDangKy;

import java.time.LocalDateTime;

public class DangKyPhong {
    private int id;
    private int sinhVienId;
    private int phongId;
    private LoaiYeuCauDangKy loaiYeuCau;
    private LocalDateTime thoiGianDangKy;
    private TrangThaiDangKy trangThai;
    private String lyDo;
    private int nguoiDuyet;
    private LocalDateTime thoiGianDuyet;

    // Joint objects
    private SinhVien sinhVien;
    private Phong phong;
    private TaiKhoan taiKhoanNguoiDuyet;

    public DangKyPhong() {
    }

    public DangKyPhong(int id, int sinhVienId, int phongId, LoaiYeuCauDangKy loaiYeuCau, LocalDateTime thoiGianDangKy,
            TrangThaiDangKy trangThai, String lyDo, int nguoiDuyet, LocalDateTime thoiGianDuyet, SinhVien sinhVien,
            Phong phong, TaiKhoan taiKhoanNguoiDuyet) {
        this.id = id;
        this.sinhVienId = sinhVienId;
        this.phongId = phongId;
        this.loaiYeuCau = loaiYeuCau;
        this.thoiGianDangKy = thoiGianDangKy;
        this.trangThai = trangThai;
        this.lyDo = lyDo;
        this.nguoiDuyet = nguoiDuyet;
        this.thoiGianDuyet = thoiGianDuyet;
        this.sinhVien = sinhVien;
        this.phong = phong;
        this.taiKhoanNguoiDuyet = taiKhoanNguoiDuyet;
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

    public LoaiYeuCauDangKy getLoaiYeuCau() {
        return loaiYeuCau;
    }

    public void setLoaiYeuCau(LoaiYeuCauDangKy loaiYeuCau) {
        this.loaiYeuCau = loaiYeuCau;
    }

    public LocalDateTime getThoiGianDangKy() {
        return thoiGianDangKy;
    }

    public void setThoiGianDangKy(LocalDateTime thoiGianDangKy) {
        this.thoiGianDangKy = thoiGianDangKy;
    }

    public TrangThaiDangKy getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiDangKy trangThai) {
        this.trangThai = trangThai;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public int getNguoiDuyet() {
        return nguoiDuyet;
    }

    public void setNguoiDuyet(int nguoiDuyet) {
        this.nguoiDuyet = nguoiDuyet;
    }

    public LocalDateTime getThoiGianDuyet() {
        return thoiGianDuyet;
    }

    public void setThoiGianDuyet(LocalDateTime thoiGianDuyet) {
        this.thoiGianDuyet = thoiGianDuyet;
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

    public TaiKhoan getTaiKhoanNguoiDuyet() {
        return taiKhoanNguoiDuyet;
    }

    public void setTaiKhoanNguoiDuyet(TaiKhoan taiKhoanNguoiDuyet) {
        this.taiKhoanNguoiDuyet = taiKhoanNguoiDuyet;
    }

    public static DangKyPhongBuilder builder() {
        return new DangKyPhongBuilder();
    }

    public static class DangKyPhongBuilder {
        private int id;
        private int sinhVienId;
        private int phongId;
        private LoaiYeuCauDangKy loaiYeuCau;
        private LocalDateTime thoiGianDangKy;
        private TrangThaiDangKy trangThai;
        private String lyDo;
        private int nguoiDuyet;
        private LocalDateTime thoiGianDuyet;
        private SinhVien sinhVien;
        private Phong phong;
        private TaiKhoan taiKhoanNguoiDuyet;

        public DangKyPhongBuilder id(int id) {
            this.id = id;
            return this;
        }

        public DangKyPhongBuilder sinhVienId(int sinhVienId) {
            this.sinhVienId = sinhVienId;
            return this;
        }

        public DangKyPhongBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public DangKyPhongBuilder loaiYeuCau(LoaiYeuCauDangKy loaiYeuCau) {
            this.loaiYeuCau = loaiYeuCau;
            return this;
        }

        public DangKyPhongBuilder thoiGianDangKy(LocalDateTime thoiGianDangKy) {
            this.thoiGianDangKy = thoiGianDangKy;
            return this;
        }

        public DangKyPhongBuilder trangThai(TrangThaiDangKy trangThai) {
            this.trangThai = trangThai;
            return this;
        }

        public DangKyPhongBuilder lyDo(String lyDo) {
            this.lyDo = lyDo;
            return this;
        }

        public DangKyPhongBuilder nguoiDuyet(int nguoiDuyet) {
            this.nguoiDuyet = nguoiDuyet;
            return this;
        }

        public DangKyPhongBuilder thoiGianDuyet(LocalDateTime thoiGianDuyet) {
            this.thoiGianDuyet = thoiGianDuyet;
            return this;
        }

        public DangKyPhongBuilder sinhVien(SinhVien sinhVien) {
            this.sinhVien = sinhVien;
            return this;
        }

        public DangKyPhongBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public DangKyPhongBuilder taiKhoanNguoiDuyet(TaiKhoan taiKhoanNguoiDuyet) {
            this.taiKhoanNguoiDuyet = taiKhoanNguoiDuyet;
            return this;
        }

        public DangKyPhong build() {
            return new DangKyPhong(id, sinhVienId, phongId, loaiYeuCau, thoiGianDangKy, trangThai, lyDo, nguoiDuyet,
                    thoiGianDuyet, sinhVien, phong, taiKhoanNguoiDuyet);
        }
    }
}