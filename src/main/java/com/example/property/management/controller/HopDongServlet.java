package com.example.property.management.controller;

import com.example.property.management.model.HopDong;
import com.example.property.management.model.enums.TrangThaiHopDong;
import com.example.property.management.service.HopDongService;
import com.example.property.management.service.PhongService;
import com.example.property.management.service.SinhVienService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet(name = "HopDongServlet", urlPatterns = { "/hopdong" })
public class HopDongServlet extends HttpServlet {

    private HopDongService hopDongService;
    private SinhVienService sinhVienService;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.hopDongService = new HopDongService();
        this.sinhVienService = new SinhVienService();
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
                case "cancel":
                    cancelHopDong(request, response);
                    break;
                default:
                    listHopDong(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                listHopDong(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            createHopDong(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tạo hợp đồng: " + e.getMessage());
            try {
                showNewForm(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void listHopDong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("hopDongList", hopDongService.getAllHopDong());
        request.setAttribute("pageTitle", "Danh Sách Hợp Đồng");
        request.getRequestDispatcher("/views/hopdong/hopdong-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        request.setAttribute("sinhVienList", sinhVienService.getAllSinhVien());
        request.setAttribute("phongList", phongService.getAllPhong());
        request.setAttribute("pageTitle", "Lập Hợp Đồng Mới");
        request.getRequestDispatcher("/views/hopdong/hopdong-form.jsp").forward(request, response);
    }

    private void createHopDong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String maHopDong = request.getParameter("maHopDong");
        int sinhVienId = Integer.parseInt(request.getParameter("sinhVienId"));
        int phongId = Integer.parseInt(request.getParameter("phongId"));
        LocalDate ngayBatDau = LocalDate.parse(request.getParameter("ngayBatDau"));
        LocalDate ngayKetThuc = LocalDate.parse(request.getParameter("ngayKetThuc"));
        BigDecimal tienPhong = new BigDecimal(request.getParameter("tienPhong"));
        BigDecimal tienDatCoc = new BigDecimal(request.getParameter("tienDatCoc"));

        HopDong hd = HopDong.builder()
                .maHopDong(maHopDong)
                .sinhVienId(sinhVienId)
                .phongId(phongId)
                .ngayBatDau(ngayBatDau)
                .ngayKetThuc(ngayKetThuc)
                .tienPhong(tienPhong)
                .tienDatCoc(tienDatCoc)
                .trangThai(TrangThaiHopDong.DANG_HIEU_LUC)
                .build();

        hopDongService.createHopDong(hd);
        response.sendRedirect(request.getContextPath() + "/hopdong?message=Created");
    }

    private void cancelHopDong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        hopDongService.cancelHopDong(id);
        response.sendRedirect(request.getContextPath() + "/hopdong?message=Cancelled");
    }
}
