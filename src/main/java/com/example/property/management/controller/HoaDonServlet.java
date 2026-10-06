package com.example.property.management.controller;

import com.example.property.management.dao.ThanhToanDAO;
import com.example.property.management.model.HoaDon;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.ThanhToan;
import com.example.property.management.model.enums.PhuongThucThanhToan;
import com.example.property.management.model.enums.TrangThaiHoaDon;
import com.example.property.management.service.HoaDonService;
import com.example.property.management.service.SinhVienService;
import com.example.property.management.util.DBConnection;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.HoaDonRoomService;
import com.example.property.management.service.PhongService;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "HoaDonServlet", urlPatterns = { "/hoadon" })
public class HoaDonServlet extends HttpServlet {

    private HoaDonService hoaDonService;
    private SinhVienService sinhVienService;
    private ThanhToanDAO thanhToanDAO;
    private HoaDonRoomService roomService;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.hoaDonService = new HoaDonService();
        this.sinhVienService = new SinhVienService();
        this.thanhToanDAO = new ThanhToanDAO();
        this.roomService = new HoaDonRoomService();
        this.phongService = new PhongService();
    }

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
                case "payDetail":
                    showPayForm(request, response);
                    break;
                case "preview":
                    previewJson(request, response);
                    break;
                default:
                    listHoaDon(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("pageTitle", "Thông Báo Lỗi");
            request.getRequestDispatcher("/views/hoadon/hoadon-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        try {
            if ("recordPayment".equals(action)) {
                recordPayment(request, response);
            } else if ("confirmCash".equals(action)) {
                confirmCash(request, response);
            } else {
                createHoaDon(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            String hid = request.getParameter("hoaDonId");
            if (("recordPayment".equals(action) || "confirmCash".equals(action)) && hid != null) {
                String msg = e.getMessage() != null ? e.getMessage() : "Lỗi xử lý thanh toán";
                response.sendRedirect(request.getContextPath() + "/hoadon?action=payDetail&id=" + hid
                        + "&error=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));
                return;
            }
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private TaiKhoan getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
    }

    private boolean isStaff(TaiKhoan u) {
        return u != null && u.getVaiTro() != VaiTro.SINH_VIEN;
    }

    private void listHoaDon(HttpServletRequest request, HttpServletResponse response) throws Exception {
        TaiKhoan user = getUser(request);
        List<Map<String, Object>> list = (user != null && user.getVaiTro() == VaiTro.SINH_VIEN)
                ? roomService.list(user.getId())
                : roomService.list(null);
        request.setAttribute("hoaDonList", list);
        request.setAttribute("pageTitle", "Quản Lý Hóa Đơn");
        request.getRequestDispatcher("/views/hoadon/hoadon-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (!isStaff(getUser(request))) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Tạo Hóa Đơn Phòng");
        request.getRequestDispatcher("/views/hoadon/hoadon-form.jsp").forward(request, response);
    }

    private void previewJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json;charset=UTF-8");
        if (!isStaff(getUser(request))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"error\":\"Không có quyền\"}");
            return;
        }
        try {
            HoaDonRoomService.Preview p = roomService.preview(
                    Integer.parseInt(request.getParameter("phongId")), request.getParameter("ky"));
            StringBuilder sb = new StringBuilder("{");
            sb.append("\"maPhong\":\"").append(esc(p.maPhong)).append("\",");
            sb.append("\"tienPhong\":").append(p.tienPhong.toPlainString()).append(",");
            sb.append("\"coDien\":").append(p.coDien).append(",\"dienCu\":").append(p.dienCu)
                    .append(",\"dienMoi\":").append(p.dienMoi).append(",\"dienDonGia\":")
                    .append(p.dienDonGia.toPlainString())
                    .append(",\"tienDien\":").append(p.tienDien.toPlainString()).append(",");
            sb.append("\"coNuoc\":").append(p.coNuoc).append(",\"nuocCu\":").append(p.nuocCu)
                    .append(",\"nuocMoi\":").append(p.nuocMoi).append(",\"nuocDonGia\":")
                    .append(p.nuocDonGia.toPlainString())
                    .append(",\"tienNuoc\":").append(p.tienNuoc.toPlainString()).append(",");
            sb.append("\"fees\":[");
            for (int i = 0; i < p.fees.size(); i++) {
                HoaDonRoomService.Fee f = p.fees.get(i);
                if (i > 0)
                    sb.append(",");
                sb.append("{\"ten\":\"").append(esc(f.ten)).append("\",\"donVi\":\"").append(esc(f.donVi))
                        .append("\",\"donGia\":").append(f.donGia.toPlainString()).append("}");
            }
            sb.append("],\"tongPhi\":").append(p.tongPhi.toPlainString());
            sb.append(",\"tongTien\":").append(p.tongTien.toPlainString());
            sb.append(",\"canCreate\":").append(p.canCreate()).append(",\"warnings\":[");
            for (int i = 0; i < p.warnings.size(); i++) {
                if (i > 0)
                    sb.append(",");
                sb.append("\"").append(esc(p.warnings.get(i))).append("\"");
            }
            sb.append("]}");
            response.getWriter().write(sb.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"" + esc(e.getMessage()) + "\"}");
        }
    }

    private String esc(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }

    private void showPayForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        TaiKhoan user = getUser(request);
        boolean isStudent = user != null && user.getVaiTro() == VaiTro.SINH_VIEN;
        if (isStudent && !roomService.studentCanAccess(id, user.getId())) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        HoaDon hd = hoaDonService.getHoaDonById(id);
        if (hd == null)
            throw new Exception("Hóa đơn không tồn tại!");

        boolean paid = hd.getTrangThai() == TrangThaiHoaDon.DA_THANH_TOAN;
        boolean pendingCash = !paid && roomService.hasPendingCash(id);

        request.setAttribute("hoaDon", hd);
        request.setAttribute("paid", paid);
        request.setAttribute("pendingCash", pendingCash);
        request.setAttribute("canPay", isStudent && !paid && !pendingCash); // form thanh toán: chỉ sinh viên
        request.setAttribute("canConfirmCash", !isStudent && pendingCash); // nút xác nhận: chỉ nhân sự
        request.setAttribute("roomLabel", roomService.roomLabel(id));
        request.setAttribute("chiTietList", roomService.details(id));
        request.setAttribute("thanhToanList", roomService.payments(id)); // thay danh sách cũ

        String err = request.getParameter("error");
        if (err != null && !err.isBlank())
            request.setAttribute("errorMessage", err);
        String msg = request.getParameter("message");
        if ("Paid".equals(msg))
            request.setAttribute("successMessage", "Thanh toán thành công! Hóa đơn đã được cập nhật.");
        if ("CashSent".equals(msg))
            request.setAttribute("successMessage",
                    "Đã gửi yêu cầu thanh toán tiền mặt. Vui lòng chờ nhân viên xác nhận.");
        if ("CashConfirmed".equals(msg))
            request.setAttribute("successMessage", "Đã xác nhận thu tiền mặt. Hóa đơn chuyển sang đã thanh toán.");

        request.setAttribute("pageTitle", "Chi Tiết Hóa Đơn");
        request.getRequestDispatcher("/views/hoadon/thanhtoan-form.jsp").forward(request, response);
    }

    private void createHoaDon(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (!isStaff(getUser(request))) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        // Chỉ nhận phòng, kỳ, mã, hạn. Mọi số tiền do server tự tính
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        String ky = request.getParameter("kyThanhToan");
        String maHoaDon = request.getParameter("maHoaDon");
        LocalDate han = LocalDate.parse(request.getParameter("hanThanhToan"));

        roomService.create(phongId, ky, maHoaDon, han);
        response.sendRedirect(request.getContextPath() + "/hoadon?message=Created");
    }

    private void recordPayment(HttpServletRequest request, HttpServletResponse response) throws Exception {
        TaiKhoan user = getUser(request);
        int hoaDonId = Integer.parseInt(request.getParameter("hoaDonId"));
        if (user == null || user.getVaiTro() != VaiTro.SINH_VIEN
                || !roomService.studentCanAccess(hoaDonId, user.getId())) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        String pt = request.getParameter("phuongThuc");
        roomService.studentPay(hoaDonId, user.getId(), user.getUsername(), pt, request.getParameter("maGiaoDich"));

        String msg = "TIEN_MAT".equals(pt) ? "CashSent" : "Paid";
        response.sendRedirect(request.getContextPath() + "/hoadon?action=payDetail&id=" + hoaDonId + "&message=" + msg);
    }

    private void confirmCash(HttpServletRequest request, HttpServletResponse response) throws Exception {
        TaiKhoan user = getUser(request);
        if (!isStaff(user)) {
            response.sendRedirect(request.getContextPath() + "/hoadon?error=AccessDenied");
            return;
        }
        int hoaDonId = Integer.parseInt(request.getParameter("hoaDonId"));
        roomService.confirmCash(hoaDonId, user.getId());
        response.sendRedirect(
                request.getContextPath() + "/hoadon?action=payDetail&id=" + hoaDonId + "&message=CashConfirmed");
    }

}
