package com.example.property.management.model;

public class Tang {
    private int id;
    private int toaId;
    private int soTang;
    private String tenTang;
    private Toa toa;

    public Tang() {
    }

    public Tang(int id, int toaId, int soTang, String tenTang, Toa toa) {
        this.id = id;
        this.toaId = toaId;
        this.soTang = soTang;
        this.tenTang = tenTang;
        this.toa = toa;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getToaId() {
        return toaId;
    }

    public void setToaId(int toaId) {
        this.toaId = toaId;
    }

    public int getSoTang() {
        return soTang;
    }

    public void setSoTang(int soTang) {
        this.soTang = soTang;
    }

    public String getTenTang() {
        return tenTang;
    }

    public void setTenTang(String tenTang) {
        this.tenTang = tenTang;
    }

    public Toa getToa() {
        return toa;
    }

    public void setToa(Toa toa) {
        this.toa = toa;
    }

    public static TangBuilder builder() {
        return new TangBuilder();
    }

    public static class TangBuilder {
        private int id;
        private int toaId;
        private int soTang;
        private String tenTang;
        private Toa toa;

        public TangBuilder id(int id) {
            this.id = id;
            return this;
        }

        public TangBuilder toaId(int toaId) {
            this.toaId = toaId;
            return this;
        }

        public TangBuilder soTang(int soTang) {
            this.soTang = soTang;
            return this;
        }

        public TangBuilder tenTang(String tenTang) {
            this.tenTang = tenTang;
            return this;
        }

        public TangBuilder toa(Toa toa) {
            this.toa = toa;
            return this;
        }

        public Tang build() {
            return new Tang(id, toaId, soTang, tenTang, toa);
        }
    }
}
