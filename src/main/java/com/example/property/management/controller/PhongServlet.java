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
import com.example.property.management.model.HopDong;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.TrangThaiHopDong;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.HopDongService;
import jakarta.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;
import com.example.property.management.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/phong")
public class PhongServlet extends HttpServlet {

    private final PhongService phongService = new PhongService();
    private final HopDongService hopDongService = new HopDongService();

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
                case "mine":
                    showMyRooms(request, response);
                    break;
                case "detail":
                    showPhongDetail(request, response);
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
        request.setAttribute("myPhongIds", getMyPhongIds(request));
        request.getRequestDispatcher("/views/phong/phong-list.jsp").forward(request, response);
    }

    private Set<Integer> getMyPhongIds(HttpServletRequest request) {
        Set<Integer> ids = new HashSet<>();
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;

        if (user == null || user.getVaiTro() != VaiTro.SINH_VIEN || user.getSinhVienId() == null) {
            return ids;
        }
        try {
            List<HopDong> contracts = hopDongService.getHopDongBySinhVienId(user.getSinhVienId().intValue());
            for (HopDong hd : contracts) {
                if (hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC) {
                    ids.add(hd.getPhongId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
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

    private void showMyRooms(HttpServletRequest request, HttpServletResponse response) throws Exception {
        TaiKhoan user = getStudentUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/phong");
            return;
        }
        List<HopDong> contracts = getMyContracts(user);
        Map<Integer, Phong> phongMap = new HashMap<>();
        for (HopDong hd : contracts) {
            phongMap.put(hd.getPhongId(), phongService.getPhongById(hd.getPhongId()));
        }
        request.setAttribute("contracts", contracts);
        request.setAttribute("phongMap", phongMap);
        request.setAttribute("pageTitle", "Phòng Của Tôi");
        request.getRequestDispatcher("/views/phong/phong-mine.jsp").forward(request, response);
    }

    private void showPhongDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        TaiKhoan user = getStudentUser(request);

        // Sinh viên chỉ được xem phòng mình có hợp đồng
        HopDong myContract = null;
        if (user != null) {
            for (HopDong hd : getMyContracts(user)) {
                if (hd.getPhongId() == id) {
                    myContract = hd;
                    break;
                }
            }
            if (myContract == null) {
                request.setAttribute("errorMessage", "Bạn không có quyền xem phòng này!");
                showMyRooms(request, response);
                return;
            }
        }

        Phong phong = phongService.getPhongById(id);
        if (phong == null)
            throw new Exception("Phòng không tồn tại!");

        List<Map<String, Object>> roommates = new ArrayList<>();
        List<Map<String, Object>> assets = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT sv.ho_ten, sv.truong, hd.ngay_bat_dau, hd.ngay_ket_thuc " +
                            "FROM hop_dong hd JOIN sinh_vien sv ON sv.id = hd.sinh_vien_id " +
                            "WHERE hd.phong_id = ? AND hd.trang_thai = 'DANG_HIEU_LUC' ORDER BY sv.ho_ten")) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> m = new HashMap<>();
                        m.put("hoTen", rs.getString("ho_ten"));
                        m.put("truong", rs.getString("truong"));
                        roommates.add(m);
                    }
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT ten_tai_san, so_luong, tinh_trang FROM tai_san WHERE phong_id = ?")) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> m = new HashMap<>();
                        m.put("ten", rs.getString("ten_tai_san"));
                        m.put("soLuong", rs.getInt("so_luong"));
                        m.put("tinhTrang", rs.getString("tinh_trang"));
                        assets.add(m);
                    }
                }
            }
        }

        request.setAttribute("phong", phong);
        request.setAttribute("hopDong", myContract); // null nếu là admin/quản lý/nhân viên
        request.setAttribute("roommates", roommates);
        request.setAttribute("assets", assets);
        request.setAttribute("pageTitle", "Chi Tiết Phòng " + phong.getMaPhong());
        request.getRequestDispatcher("/views/phong/phong-detail.jsp").forward(request, response);
    }

    /**
     * Danh sách hợp đồng còn giá trị (chờ ký hoặc đang hiệu lực) của sinh viên đang
     * đăng nhập
     */
    private List<HopDong> getMyContracts(TaiKhoan user) throws Exception {
        List<HopDong> result = new ArrayList<>();
        if (user.getSinhVienId() == null)
            return result;
        for (HopDong hd : hopDongService.getHopDongBySinhVienId(user.getSinhVienId().intValue())) {
            if (hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC
                    || hd.getTrangThai() == TrangThaiHopDong.CHO_HIEU_LUC) {
                result.add(hd);
            }
        }
        return result;
    }

    private TaiKhoan getStudentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        TaiKhoan user = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
        return (user != null && user.getVaiTro() == VaiTro.SINH_VIEN) ? user : null;
    }

}
