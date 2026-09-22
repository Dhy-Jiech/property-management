package com.example.property.management.controller;

import com.example.property.management.dao.ChiSoDienDAO;
import com.example.property.management.dao.ChiSoNuocDAO;
import com.example.property.management.model.ChiSoDien;
import com.example.property.management.model.ChiSoNuoc;
import com.example.property.management.service.PhongService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet(name = "ChiSoDienNuocServlet", urlPatterns = { "/dien-nuoc" })
public class ChiSoDienNuocServlet extends HttpServlet {

    private ChiSoDienDAO chiSoDienDAO;
    private ChiSoNuocDAO chiSoNuocDAO;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.chiSoDienDAO = new ChiSoDienDAO();
        this.chiSoNuocDAO = new ChiSoNuocDAO();
        this.phongService = new PhongService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            if ("new".equals(action)) {
                request.setAttribute("phongList", phongService.getAllPhong());
                request.setAttribute("pageTitle", "Nhập Chỉ Số Điện & Nước Hàng Tháng");
                request.getRequestDispatcher("/views/diennuoc/diennuoc-form.jsp").forward(request, response);
            } else {
                request.setAttribute("dienList", chiSoDienDAO.findAll());
                request.setAttribute("nuocList", chiSoNuocDAO.findAll());
                request.setAttribute("pageTitle", "Quản Lý Chỉ Số Điện Nước");
                request.getRequestDispatcher("/views/diennuoc/diennuoc-list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                request.setAttribute("dienList", chiSoDienDAO.findAll());
                request.setAttribute("nuocList", chiSoNuocDAO.findAll());
                request.getRequestDispatcher("/views/diennuoc/diennuoc-list.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int phongId = Integer.parseInt(request.getParameter("phongId"));
            String kyThangStr = request.getParameter("kyThang"); // YYYY-MM
            LocalDate kyThang = LocalDate.parse(kyThangStr + "-01");

            // Điện
            BigDecimal dienCu = new BigDecimal(request.getParameter("chiSoDienCu"));
            BigDecimal dienMoi = new BigDecimal(request.getParameter("chiSoDienMoi"));
            BigDecimal donGiaDien = new BigDecimal(request.getParameter("donGiaDien"));

            if (dienMoi.compareTo(dienCu) < 0) {
                throw new IllegalArgumentException("Chỉ số điện mới không được nhỏ hơn chỉ số cũ!");
            }

            BigDecimal sanLuongDien = dienMoi.subtract(dienCu);
            BigDecimal tienDien = sanLuongDien.multiply(donGiaDien);

            ChiSoDien cd = ChiSoDien.builder()
                    .phongId(phongId)
                    .kyThang(kyThang)
                    .chiSoCu(dienCu)
                    .chiSoMoi(dienMoi)
                    .donGia(donGiaDien)
                    .tienDien(tienDien)
                    .build();

            // Nước
            BigDecimal nuocCu = new BigDecimal(request.getParameter("chiSoNuocCu"));
            BigDecimal nuocMoi = new BigDecimal(request.getParameter("chiSoNuocMoi"));
            BigDecimal donGiaNuoc = new BigDecimal(request.getParameter("donGiaNuoc"));

            if (nuocMoi.compareTo(nuocCu) < 0) {
                throw new IllegalArgumentException("Chỉ số nước mới không được nhỏ hơn chỉ số cũ!");
            }

            BigDecimal sanLuongNuoc = nuocMoi.subtract(nuocCu);
            BigDecimal tienNuoc = sanLuongNuoc.multiply(donGiaNuoc);

            ChiSoNuoc cn = ChiSoNuoc.builder()
                    .phongId(phongId)
                    .kyThang(kyThang)
                    .chiSoCu(nuocCu)
                    .chiSoMoi(nuocMoi)
                    .donGia(donGiaNuoc)
                    .tienNuoc(tienNuoc)
                    .build();

            chiSoDienDAO.insert(cd);
            chiSoNuocDAO.insert(cn);

            response.sendRedirect(request.getContextPath() + "/dien-nuoc?message=Saved");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể lưu chỉ số: " + e.getMessage());
            try {
                request.setAttribute("phongList", phongService.getAllPhong());
                request.setAttribute("pageTitle", "Nhập Chỉ Số Điện & Nước Hàng Tháng");
                request.getRequestDispatcher("/views/diennuoc/diennuoc-form.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
