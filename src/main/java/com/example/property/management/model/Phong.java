package com.example.property.management.model;

import com.example.property.management.model.enums.LoaiPhong;
import com.example.property.management.model.enums.TrangThaiPhong;
import com.example.property.management.model.Tang;

import java.math.BigDecimal;


public class Phong {
    private int id;
    private int tangId;
    private String maPhong;
    private String tenPhong;
    private LoaiPhong loaiPhong;
    private int sucChua;
    private int soNguoiHienTai;
    private BigDecimal giaThang;
    private TrangThaiPhong trangThai;

    // Đối tượng liên kết để hiển thị thông tin Tầng/Tòa/Khu trên UI JSP
    private Tang tang;
    
    
    public Phong() {
    }

    public Phong(int id, int tangId, String maPhong, String tenPhong, LoaiPhong loaiPhong,
                 int sucChua, int soNguoiHienTai, BigDecimal giaThang, TrangThaiPhong trangThai) {
        this.id = id;
        this.tangId = tangId;
        this.maPhong = maPhong;
        this.tenPhong = tenPhong;
        this.loaiPhong = loaiPhong;
        this.sucChua = sucChua;
        this.soNguoiHienTai = soNguoiHienTai;
        this.giaThang = giaThang;
        this.trangThai = trangThai;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTangId() {
        return tangId;
    }

    public void setTangId(int tangId) {
        this.tangId = tangId;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }

    public String getTenPhong() {
        return tenPhong;
    }

    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }

    public LoaiPhong getLoaiPhong() {
        return loaiPhong;
    }

    public void setLoaiPhong(LoaiPhong loaiPhong) {
        this.loaiPhong = loaiPhong;
    }

    public int getSucChua() {
        return sucChua;
    }

    public void setSucChua(int sucChua) {
        this.sucChua = sucChua;
    }

    public int getSoNguoiHienTai() {
        return soNguoiHienTai;
    }

    public void setSoNguoiHienTai(int soNguoiHienTai) {
        this.soNguoiHienTai = soNguoiHienTai;
    }

    public BigDecimal getGiaThang() {
        return giaThang;
    }

    public void setGiaThang(BigDecimal giaThang) {
        this.giaThang = giaThang;
    }

    public TrangThaiPhong getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(TrangThaiPhong trangThai) {
        this.trangThai = trangThai;
    }
    public Tang getTang(){
        return tang;
}
    public void setTang(Tang tang) {
        this.tang = tang;
    }
            
}