package com.example.property.management.model;

public class Toa {
    private int id;
    private int khuId;
    private String maToa;
    private String tenToa;
    private Khu khu;

    public Toa() {
    }

    public Toa(int id, int khuId, String maToa, String tenToa, Khu khu) {
        this.id = id;
        this.khuId = khuId;
        this.maToa = maToa;
        this.tenToa = tenToa;
        this.khu = khu;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getKhuId() {
        return khuId;
    }

    public void setKhuId(int khuId) {
        this.khuId = khuId;
    }

    public String getMaToa() {
        return maToa;
    }

    public void setMaToa(String maToa) {
        this.maToa = maToa;
    }

    public String getTenToa() {
        return tenToa;
    }

    public void setTenToa(String tenToa) {
        this.tenToa = tenToa;
    }

    public Khu getKhu() {
        return khu;
    }

    public void setKhu(Khu khu) {
        this.khu = khu;
    }

    public static ToaBuilder builder() {
        return new ToaBuilder();
    }

    public static class ToaBuilder {
        private int id;
        private int khuId;
        private String maToa;
        private String tenToa;
        private Khu khu;

        public ToaBuilder id(int id) {
            this.id = id;
            return this;
        }

        public ToaBuilder khuId(int khuId) {
            this.khuId = khuId;
            return this;
        }

        public ToaBuilder maToa(String maToa) {
            this.maToa = maToa;
            return this;
        }

        public ToaBuilder tenToa(String tenToa) {
            this.tenToa = tenToa;
            return this;
        }

        public ToaBuilder khu(Khu khu) {
            this.khu = khu;
            return this;
        }

        public Toa build() {
            return new Toa(id, khuId, maToa, tenToa, khu);
        }
    }
}
