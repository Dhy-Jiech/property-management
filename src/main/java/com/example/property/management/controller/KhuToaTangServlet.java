package com.example.property.management.controller;

import com.example.property.management.dao.KhuDAO;
import com.example.property.management.dao.ToaDAO;
import com.example.property.management.dao.TangDAO;
import com.example.property.management.model.Khu;
import com.example.property.management.model.Toa;
import com.example.property.management.model.Tang;
import com.example.property.management.model.TaiKhoan;
import com.example.property.management.model.enums.VaiTro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "KhuToaTangServlet", urlPatterns = { "/khu" })
public class KhuToaTangServlet extends HttpServlet {

    private KhuDAO khuDAO;
    private ToaDAO toaDAO;
    private TangDAO tangDAO;

    @Override
    public void init() throws ServletException {
        khuDAO = new KhuDAO();
        toaDAO = new ToaDAO();
        tangDAO = new TangDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!hasAccess(request)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "newKhu":
                    request.setAttribute("pageTitle", "Thêm Khu Mới");
                    request.getRequestDispatcher("/views/khutoatang/khu-form.jsp").forward(request, response);
                    break;
                case "editKhu": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("khu", khuDAO.findById(id));
                    request.setAttribute("pageTitle", "Sửa Khu");
                    request.getRequestDispatcher("/views/khutoatang/khu-form.jsp").forward(request, response);
                    break;
                }
                case "deleteKhu":
                    khuDAO.delete(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/khu?message=Deleted");
                    break;
                case "newToa":
                    request.setAttribute("khuList", khuDAO.findAll());
                    request.setAttribute("pageTitle", "Thêm Tòa Mới");
                    request.getRequestDispatcher("/views/khutoatang/toa-form.jsp").forward(request, response);
                    break;
                case "editToa": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("toa", toaDAO.findById(id));
                    request.setAttribute("khuList", khuDAO.findAll());
                    request.setAttribute("pageTitle", "Sửa Tòa");
                    request.getRequestDispatcher("/views/khutoatang/toa-form.jsp").forward(request, response);
                    break;
                }
                case "deleteToa":
                    toaDAO.delete(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/khu?message=Deleted");
                    break;
                case "newTang":
                    request.setAttribute("toaList", toaDAO.findAll());
                    request.setAttribute("pageTitle", "Thêm Tầng Mới");
                    request.getRequestDispatcher("/views/khutoatang/tang-form.jsp").forward(request, response);
                    break;
                case "editTang": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("tang", tangDAO.findById(id));
                    request.setAttribute("toaList", toaDAO.findAll());
                    request.setAttribute("pageTitle", "Sửa Tầng");
                    request.getRequestDispatcher("/views/khutoatang/tang-form.jsp").forward(request, response);
                    break;
                }
                case "deleteTang":
                    tangDAO.delete(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/khu?message=Deleted");
                    break;
                default:
                    request.setAttribute("khuList", khuDAO.findAll());
                    request.setAttribute("toaList", toaDAO.findAll());
                    request.setAttribute("tangList", tangDAO.findAll());
                    request.setAttribute("pageTitle", "Quản Lý Khu / Tòa / Tầng");
                    request.getRequestDispatcher("/views/khutoatang/khutoatang-list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            try {
                request.setAttribute("khuList", khuDAO.findAll());
                request.setAttribute("toaList", toaDAO.findAll());
                request.setAttribute("tangList", tangDAO.findAll());
                request.getRequestDispatcher("/views/khutoatang/khutoatang-list.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!hasAccess(request)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        String action = request.getParameter("action");
        try {
            if ("insertKhu".equals(action) || "updateKhu".equals(action)) {
                Khu k = new Khu();
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isBlank())
                    k.setId(Integer.parseInt(idStr));
                k.setMaKhu(request.getParameter("maKhu"));
                k.setTenKhu(request.getParameter("tenKhu"));
                if ("updateKhu".equals(action))
                    khuDAO.update(k);
                else
                    khuDAO.insert(k);
            } else if ("insertToa".equals(action) || "updateToa".equals(action)) {
                Toa t = new Toa();
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isBlank())
                    t.setId(Integer.parseInt(idStr));
                t.setKhuId(Integer.parseInt(request.getParameter("khuId")));
                t.setMaToa(request.getParameter("maToa"));
                t.setTenToa(request.getParameter("tenToa"));
                if ("updateToa".equals(action))
                    toaDAO.update(t);
                else
                    toaDAO.insert(t);
            } else if ("insertTang".equals(action) || "updateTang".equals(action)) {
                Tang t = new Tang();
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isBlank())
                    t.setId(Integer.parseInt(idStr));
                t.setToaId(Integer.parseInt(request.getParameter("toaId")));
                t.setSoTang(Integer.parseInt(request.getParameter("soTang")));
                t.setTenTang(request.getParameter("tenTang"));
                if ("updateTang".equals(action))
                    tangDAO.update(t);
                else
                    tangDAO.insert(t);
            }
            response.sendRedirect(request.getContextPath() + "/khu?message=Saved");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/khu?error=" + e.getMessage());
        }
    }

    private boolean hasAccess(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        return user != null && (user.getVaiTro() == VaiTro.ADMIN || user.getVaiTro() == VaiTro.QUAN_LY);
    }
}
