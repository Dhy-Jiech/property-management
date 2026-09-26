package com.example.property.management.model;

import java.time.LocalDateTime;

/**
 * Extended LichSuPhong model that supports nullable room IDs
 * and denormalized display fields for queries with JOINs.
 */
public class LichSuPhong {
    private int id;
    private int sinhVienId;
    private Integer phongCu; // nullable
    private Integer phongMoi; // nullable
    private LocalDateTime thoiGian;
    private String lyDo;
    private String nguoiXuLy; // username string (not FK int)

    // Display fields populated via JOIN
    private String tenSinhVien;
    private String maPhongCu;
    private String maPhongMoi;

    public LichSuPhong() {
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

    public Integer getPhongCu() {
        return phongCu;
    }

    public void setPhongCu(Integer phongCu) {
        this.phongCu = phongCu;
    }

    public Integer getPhongMoi() {
        return phongMoi;
    }

    public void setPhongMoi(Integer phongMoi) {
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

    public String getNguoiXuLy() {
        return nguoiXuLy;
    }

    public void setNguoiXuLy(String nguoiXuLy) {
        this.nguoiXuLy = nguoiXuLy;
    }

    public String getTenSinhVien() {
        return tenSinhVien;
    }

    public void setTenSinhVien(String tenSinhVien) {
        this.tenSinhVien = tenSinhVien;
    }

    public String getMaPhongCu() {
        return maPhongCu;
    }

    public void setMaPhongCu(String maPhongCu) {
        this.maPhongCu = maPhongCu;
    }

    public String getMaPhongMoi() {
        return maPhongMoi;
    }

    public void setMaPhongMoi(String maPhongMoi) {
        this.maPhongMoi = maPhongMoi;
    }
}