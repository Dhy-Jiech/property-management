package com.example.property.management.model;

public class TaiSan {
    private int id;
    private int phongId;
    private String tenTaiSan;
    private Integer soLuong;
    private String tinhTrang;

    // Joint object
    private Phong phong;

    public TaiSan() {
    }

    public TaiSan(int id, int phongId, String tenTaiSan, Integer soLuong, String tinhTrang, Phong phong) {
        this.id = id;
        this.phongId = phongId;
        this.tenTaiSan = tenTaiSan;
        this.soLuong = soLuong;
        this.tinhTrang = tinhTrang;
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

    public String getTenTaiSan() {
        return tenTaiSan;
    }

    public void setTenTaiSan(String tenTaiSan) {
        this.tenTaiSan = tenTaiSan;
    }

    public Integer getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(Integer soLuong) {
        this.soLuong = soLuong;
    }

    public String getTinhTrang() {
        return tinhTrang;
    }

    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }

    public Phong getPhong() {
        return phong;
    }

    public void setPhong(Phong phong) {
        this.phong = phong;
    }

    public static TaiSanBuilder builder() {
        return new TaiSanBuilder();
    }

    public static class TaiSanBuilder {
        private int id;
        private int phongId;
        private String tenTaiSan;
        private Integer soLuong;
        private String tinhTrang;
        private Phong phong;

        public TaiSanBuilder id(int id) {
            this.id = id;
            return this;
        }

        public TaiSanBuilder phongId(int phongId) {
            this.phongId = phongId;
            return this;
        }

        public TaiSanBuilder tenTaiSan(String tenTaiSan) {
            this.tenTaiSan = tenTaiSan;
            return this;
        }

        public TaiSanBuilder soLuong(Integer soLuong) {
            this.soLuong = soLuong;
            return this;
        }

        public TaiSanBuilder tinhTrang(String tinhTrang) {
            this.tinhTrang = tinhTrang;
            return this;
        }

        public TaiSanBuilder phong(Phong phong) {
            this.phong = phong;
            return this;
        }

        public TaiSan build() {
            return new TaiSan(id, phongId, tenTaiSan, soLuong, tinhTrang, phong);
        }
    }
}
