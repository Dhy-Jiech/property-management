/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.property.management.dao;

import com.example.property.management.model.Khu;
import com.example.property.management.model.Phong;
import com.example.property.management.model.Tang;
import com.example.property.management.model.Toa;
import com.example.property.management.model.enums.LoaiPhong;
import com.example.property.management.model.enums.TrangThaiPhong;
import com.example.property.management.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhongDAO {
    public List<Phong> findAll() throws SQLException {
        List<Phong> list = new ArrayList<>();
        String sql = """
                    SELECT p.*, t.so_tang, t.ten_tang, toa.ma_toa, toa.ten_toa, k.ma_khu, k.ten_khu
                    FROM phong p
                    JOIN tang t ON p.tang_id = t.id
                    JOIN toa toa ON t.toa_id = toa.id
                    JOIN khu k ON toa.khu_id = k.id
                    ORDER BY p.id DESC
                """;

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToPhongFull(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Phong findById(int id) throws SQLException {
        String sql = "SELECT * FROM phong WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPhong(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Phong findByMaPhong(String maPhong) throws SQLException {
        String sql = "SELECT * FROM phong WHERE ma_phong = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPhong(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Phong> findPhongAvailable() throws SQLException {
        List<Phong> list = new ArrayList<>();
        String sql = "SELECT * FROM phong WHERE trang_thai != 'BAO_TRI' AND so_nguoi_hien_tai < suc_chua";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToPhong(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm phòng mới
    public boolean insert(Phong p) throws SQLException {
        String sql = """
                    INSERT INTO phong (tang_id, ma_phong, ten_phong, loai_phong, suc_chua, so_nguoi_hien_tai, gia_thang, trang_thai)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, p.getTangId());
            ps.setString(2, p.getMaPhong());
            ps.setString(3, p.getTenPhong());
            ps.setString(4, p.getLoaiPhong() != null ? p.getLoaiPhong().getDbValue() : "4_NGUOI");
            ps.setInt(5, p.getSucChua());
            ps.setInt(6, p.getSoNguoiHienTai());
            ps.setBigDecimal(7, p.getGiaThang());
            ps.setString(8, p.getTrangThai() != null ? p.getTrangThai().name() : "TRONG");

            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Phong p) throws SQLException {
        String sql = """
                    UPDATE phong
                    SET tang_id = ?, ten_phong = ?, loai_phong = ?, suc_chua = ?, gia_thang = ?, trang_thai = ?
                    WHERE id = ?
                """;

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, p.getTangId());
            ps.setString(2, p.getTenPhong());
            ps.setString(3, p.getLoaiPhong() != null ? p.getLoaiPhong().getDbValue() : "4_NGUOI");
            ps.setInt(4, p.getSucChua());
            ps.setBigDecimal(5, p.getGiaThang());
            ps.setString(6, p.getTrangThai() != null ? p.getTrangThai().name() : "TRONG");
            ps.setInt(7, p.getId());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM phong WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Phong mapResultSetToPhong(ResultSet rs) throws SQLException {

        Phong phong = new Phong();
        phong.setId(rs.getInt("id"));
        phong.setTangId(rs.getInt("tang_id"));
        phong.setMaPhong(rs.getString("ma_phong"));
        phong.setTenPhong(rs.getString("ten_phong"));
        phong.setLoaiPhong(LoaiPhong.fromString(rs.getString("loai_phong")));
        phong.setSucChua(rs.getInt("suc_chua"));
        phong.setSoNguoiHienTai(rs.getInt("so_nguoi_hien_tai"));
        phong.setGiaThang(rs.getBigDecimal("gia_thang"));
        phong.setTrangThai(TrangThaiPhong.valueOf(rs.getString("trang_thai")));

        return phong;

    }

    private Phong mapResultSetToPhongFull(ResultSet rs) throws SQLException {
        Phong phong = mapResultSetToPhong(rs);

        Khu khu = Khu.builder()
                .maKhu(rs.getString("ma_khu"))
                .tenKhu(rs.getString("ten_khu"))
                .build();

        Toa toa = Toa.builder()
                .maToa(rs.getString("ma_toa"))
                .tenToa(rs.getString("ten_toa"))
                .khu(khu)
                .build();

        Tang tang = Tang.builder()
                .id(rs.getInt("tang_id"))
                .soTang(rs.getInt("so_tang"))
                .tenTang(rs.getString("ten_tang"))
                .toa(toa)
                .build();

        phong.setTang(tang);
        return phong;
    }

}
