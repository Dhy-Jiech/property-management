package com.example.property.management.controller;

import com.example.property.management.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "DashboardServlet", urlPatterns = { "/dashboard", "/home" })
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int tongSoPhong = countQuery("SELECT COUNT(*) FROM phong");
        int phongDaCoNguoi = countQuery("SELECT COUNT(*) FROM phong WHERE so_nguoi_hien_tai > 0");
        int tongSinhVien = countQuery("SELECT COUNT(*) FROM sinh_vien");
        int hopDongHieuLuc = countQuery("SELECT COUNT(*) FROM hop_dong WHERE trang_thai = 'DANG_HIEU_LUC'");
        int hoaDonChuaThanhToan = countQuery("SELECT COUNT(*) FROM hoa_don WHERE trang_thai = 'CHUA_THANH_TOAN'");

        request.setAttribute("tongSoPhong", tongSoPhong);
        request.setAttribute("phongDaCoNguoi", phongDaCoNguoi);
        request.setAttribute("tongSinhVien", tongSinhVien);
        request.setAttribute("hopDongHieuLuc", hopDongHieuLuc);
        request.setAttribute("hoaDonChuaThanhToan", hoaDonChuaThanhToan);

        request.setAttribute("pageTitle", "Dashboard - Tong quan");
        request.getRequestDispatcher("/views/dashboard/dashboard.jsp").forward(request, response);
    }

    private int countQuery(String sql) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
