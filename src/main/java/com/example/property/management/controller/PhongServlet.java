package com.example.property.management.controller;

import com.example.property.management.model.Phong;
import com.example.property.management.model.Tang;
import com.example.property.management.model.enums.LoaiPhong;
import com.example.property.management.model.enums.TrangThaiPhong;
import com.example.property.management.service.PhongService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/phong")
public class PhongServlet extends HttpServlet {

    private final PhongService phongService = new PhongService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deletePhong(request, response);
                    break;
                default:
                    listPhong(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            try {
                listPhong(request, response);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {
                insertPhong(request, response);
            } else if ("update".equals(action)) {
                updatePhong(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            Phong phong = readPhongFromRequest(request);
            request.setAttribute("phong", phong);
            try {
                request.setAttribute("listTang", phongService.getAllTang());
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("/views/phong/phong-form.jsp").forward(request, response);
        }
    }

    private void listPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Phong> list = phongService.getAllPhong();
        request.setAttribute("listPhong", list);
        request.getRequestDispatcher("/views/phong/phong-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Tang> listTang = phongService.getAllTang();
        request.setAttribute("listTang", listTang);
        request.getRequestDispatcher("/views/phong/phong-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Phong phong = phongService.getPhongById(id);
        List<Tang> listTang = phongService.getAllTang();
        request.setAttribute("phong", phong);
        request.setAttribute("listTang", listTang);
        request.getRequestDispatcher("/views/phong/phong-form.jsp").forward(request, response);
    }

    private void insertPhong(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Phong newPhong = readPhongFromRequest(request);
        phongService.createPhong(newPhong);
        response.sendRedirect(request.getContextPath() + "/phong");
    }

    private void updatePhong(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Phong phong = readPhongFromRequest(request);
        phongService.updatePhong(phong);
        response.sendRedirect(request.getContextPath() + "/phong");
    }

    private void deletePhong(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        phongService.deletePhong(id);
        response.sendRedirect(request.getContextPath() + "/phong");
    }

    private Phong readPhongFromRequest(HttpServletRequest request) {
        Phong phong = new Phong();

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isBlank()) {
            phong.setId(parseIntOrDefault(idParam, 0));
        }

        phong.setTangId(parseIntOrDefault(request.getParameter("tangId"), 1));
        phong.setMaPhong(request.getParameter("maPhong"));
        phong.setTenPhong(request.getParameter("tenPhong"));

        phong.setLoaiPhong(LoaiPhong.fromString(request.getParameter("loaiPhong")));

        phong.setSucChua(parseIntOrDefault(request.getParameter("sucChua"), 0));
        phong.setSoNguoiHienTai(parseIntOrDefault(request.getParameter("soNguoiHienTai"), 0));

        phong.setGiaThang(parseBigDecimalOrDefault(request.getParameter("giaThang"), java.math.BigDecimal.ZERO));

        String trangThaiParam = request.getParameter("trangThai");
        if (trangThaiParam != null && !trangThaiParam.isBlank()) {
            try {
                phong.setTrangThai(TrangThaiPhong.valueOf(trangThaiParam));
            } catch (IllegalArgumentException e) {
                phong.setTrangThai(TrangThaiPhong.TRONG);
            }
        } else {
            phong.setTrangThai(TrangThaiPhong.TRONG);
        }

        return phong;
    }

    private int parseIntOrDefault(String value, int defaultValue) {
        if (value == null || value.isBlank())
            return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private java.math.BigDecimal parseBigDecimalOrDefault(String value, java.math.BigDecimal defaultValue) {
        if (value == null || value.isBlank())
            return defaultValue;
        try {
            return new java.math.BigDecimal(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
