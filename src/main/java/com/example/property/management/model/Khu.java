package com.example.property.management.model;

public class Khu {
    private int id;
    private String maKhu;
    private String tenKhu;

    public Khu() {
    }

    public Khu(int id, String maKhu, String tenKhu) {
        this.id = id;
        this.maKhu = maKhu;
        this.tenKhu = tenKhu;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaKhu() {
        return maKhu;
    }

    public void setMaKhu(String maKhu) {
        this.maKhu = maKhu;
    }

    public String getTenKhu() {
        return tenKhu;
    }

    public void setTenKhu(String tenKhu) {
        this.tenKhu = tenKhu;
    }

    public static KhuBuilder builder() {
        return new KhuBuilder();
    }

    public static class KhuBuilder {
        private int id;
        private String maKhu;
        private String tenKhu;

        public KhuBuilder id(int id) {
            this.id = id;
            return this;
        }

        public KhuBuilder maKhu(String maKhu) {
            this.maKhu = maKhu;
            return this;
        }

        public KhuBuilder tenKhu(String tenKhu) {
            this.tenKhu = tenKhu;
            return this;
        }

        public Khu build() {
            return new Khu(id, maKhu, tenKhu);
        }
    }
}
