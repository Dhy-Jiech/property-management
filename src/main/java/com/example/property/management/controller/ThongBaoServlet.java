package com.example.property.management.controller;

import com.example.property.management.dao.ThongBaoDAO;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.ThongBao;
import com.example.property.management.model.enums.VaiTro;
import com.example.property.management.service.PhongService;
import com.example.property.management.model.enums.LoaiPhamVi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "ThongBaoServlet", urlPatterns = { "/thong-bao" })
public class ThongBaoServlet extends HttpServlet {

    private ThongBaoDAO thongBaoDAO;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        this.thongBaoDAO = new ThongBaoDAO();
        this.phongService = new PhongService();
    }

    private TaiKhoan getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
    }

    /** Người được phép gửi thông báo */
    private boolean canSend(TaiKhoan user) {
        return user.getVaiTro() == VaiTro.ADMIN
                || user.getVaiTro() == VaiTro.QUAN_LY
                || user.getVaiTro() == VaiTro.NHAN_VIEN;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TaiKhoan user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String action = request.getParameter("action");
        try {
            if ("markRead".equals(action)) {
                String idStr = request.getParameter("id");
                if ("all".equals(idStr)) {
                    thongBaoDAO.markAllRead(user.getId());
                } else {
                    thongBaoDAO.markAsRead(Integer.parseInt(idStr), user.getId());
                }
                response.sendRedirect(request.getContextPath() + "/thong-bao");
                return;
            }
            showList(request, response, user);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                showList(request, response, user);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TaiKhoan user = getUser(request);
        if (user == null || !canSend(user)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        try {
            String tieuDe = request.getParameter("tieuDe");
            String noiDung = request.getParameter("noiDung");
            if (tieuDe == null || tieuDe.isBlank() || noiDung == null || noiDung.isBlank()) {
                throw new Exception("Vui lòng nhập tiêu đề và nội dung!");
            }

            ThongBao tb = new ThongBao();
            tb.setTieuDe(tieuDe.trim());
            tb.setNoiDung(noiDung.trim());
            tb.setLoai(request.getParameter("loai") != null ? request.getParameter("loai") : "THONG_TIN");
            tb.setNguoiGuiId(user.getId());

            String phamVi = request.getParameter("phamVi");
            if ("PHONG".equals(phamVi)) {
                String p = request.getParameter("phongId");
                if (p == null || p.isBlank())
                    throw new Exception("Vui lòng chọn phòng nhận thông báo!");
                tb.setPhamVi(LoaiPhamVi.PHONG);
                tb.setPhongId(Integer.parseInt(p));
            } else if ("CA_NHAN".equals(phamVi)) {
                String n = request.getParameter("nguoiNhanId");
                if (n == null || n.isBlank())
                    throw new Exception("Vui lòng chọn người nhận!");
                tb.setPhamVi(LoaiPhamVi.CA_NHAN);
                tb.setNguoiNhanId(Integer.parseInt(n));
            } else {
                tb.setPhamVi(LoaiPhamVi.TAT_CA);
            }

            thongBaoDAO.insert(tb);
            response.sendRedirect(request.getContextPath() + "/thong-bao?message=Sent&tab=sent");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không gửi được thông báo: " + e.getMessage());
            try {
                showList(request, response, user);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response, TaiKhoan user)
            throws Exception {
        boolean staff = canSend(user);
        boolean sentTab = staff && "sent".equals(request.getParameter("tab"));

        if (sentTab) {
            // Admin/quản lý xem tất cả thông báo đã gửi, nhân viên chỉ xem của mình
            boolean seeAll = user.getVaiTro() != VaiTro.NHAN_VIEN;
            request.setAttribute("thongBaoList", thongBaoDAO.findSent(seeAll ? null : user.getId()));
        } else {
            request.setAttribute("thongBaoList", thongBaoDAO.findVisibleFor(user.getId()));
        }

        if (staff) {
            request.setAttribute("phongList", phongService.getAllPhong());
            request.setAttribute("accountList", thongBaoDAO.findRecipientAccounts());
        }
        if ("Sent".equals(request.getParameter("message"))) {
            request.setAttribute("successMessage", "Đã gửi thông báo!");
        }
        request.setAttribute("sentTab", sentTab);
        request.setAttribute("isStaff", staff);
        request.setAttribute("unreadCount", thongBaoDAO.countUnread(user.getId()));
        request.setAttribute("pageTitle", "Thông Báo");
        request.getRequestDispatcher("/views/thongbao/thongbao-list.jsp").forward(request, response);
    }
    
}