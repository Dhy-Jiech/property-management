package com.example.property.management.model;

import java.time.LocalDateTime;

public class ThongBao {
    private int id;
    private Integer nguoiNhanId;
    private String tieuDe;
    private String noiDung;
    private String loai;
    private Boolean daDoc;
    private LocalDateTime thoiGian;

    // Joint object
    private TaiKhoan nguoiNhan;

    public ThongBao() {
    }

    public ThongBao(int id, Integer nguoiNhanId, String tieuDe, String noiDung, String loai, Boolean daDoc,
            LocalDateTime thoiGian, TaiKhoan nguoiNhan) {
        this.id = id;
        this.nguoiNhanId = nguoiNhanId;
        this.tieuDe = tieuDe;
        this.noiDung = noiDung;
        this.loai = loai;
        this.daDoc = daDoc;
        this.thoiGian = thoiGian;
        this.nguoiNhan = nguoiNhan;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getNguoiNhanId() {
        return nguoiNhanId;
    }

    public void setNguoiNhanId(Integer nguoiNhanId) {
        this.nguoiNhanId = nguoiNhanId;
    }

    public String getTieuDe() {
        return tieuDe;
    }

    public void setTieuDe(String tieuDe) {
        this.tieuDe = tieuDe;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public String getLoai() {
        return loai;
    }

    public void setLoai(String loai) {
        this.loai = loai;
    }

    public Boolean getDaDoc() {
        return daDoc;
    }

    public void setDaDoc(Boolean daDoc) {
        this.daDoc = daDoc;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }

    public TaiKhoan getNguoiNhan() {
        return nguoiNhan;
    }

    public void setNguoiNhan(TaiKhoan nguoiNhan) {
        this.nguoiNhan = nguoiNhan;
    }

    public static ThongBaoBuilder builder() {
        return new ThongBaoBuilder();
    }

    public static class ThongBaoBuilder {
        private int id;
        private Integer nguoiNhanId;
        private String tieuDe;
        private String noiDung;
        private String loai;
        private Boolean daDoc;
        private LocalDateTime thoiGian;
        private TaiKhoan nguoiNhan;

        public ThongBaoBuilder id(int id) {
            this.id = id;
            return this;
        }

        public ThongBaoBuilder nguoiNhanId(Integer nguoiNhanId) {
            this.nguoiNhanId = nguoiNhanId;
            return this;
        }

        public ThongBaoBuilder tieuDe(String tieuDe) {
            this.tieuDe = tieuDe;
            return this;
        }

        public ThongBaoBuilder noiDung(String noiDung) {
            this.noiDung = noiDung;
            return this;
        }

        public ThongBaoBuilder loai(String loai) {
            this.loai = loai;
            return this;
        }

        public ThongBaoBuilder daDoc(Boolean daDoc) {
            this.daDoc = daDoc;
            return this;
        }

        public ThongBaoBuilder thoiGian(LocalDateTime thoiGian) {
            this.thoiGian = thoiGian;
            return this;
        }

        public ThongBaoBuilder nguoiNhan(TaiKhoan nguoiNhan) {
            this.nguoiNhan = nguoiNhan;
            return this;
        }

        public ThongBao build() {
            return new ThongBao(id, nguoiNhanId, tieuDe, noiDung, loai, daDoc, thoiGian, nguoiNhan);
        }
    }
}
