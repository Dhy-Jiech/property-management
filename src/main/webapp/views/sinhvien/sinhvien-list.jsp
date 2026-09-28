<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="sinhvien" />
</jsp:include>

<div class="container-fluid px-4">
    <%-- Header --%>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h4 fw-bold text-dark mb-0">Quản Lý Sinh Viên</h2>
            <p class="text-muted small mb-0">Danh sách sinh viên lưu trú trong ký túc xá.</p>
        </div>
        <a href="${pageContext.request.contextPath}/sinhvien?action=new" class="btn btn-primary btn-sm">
            <i class="fa-solid fa-user-plus me-1"></i> Thêm Sinh Viên
        </a>
    </div>

    <%-- Error / Success messages --%>
    <% String msg = request.getParameter("message"); if (msg != null) { %>
    <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
        <i class="fa-solid fa-check-circle me-1"></i>
        <% if ("AccountCreated".equals(msg)) { %>Tài khoản đã được tạo thành công!
        <% } else { %>Thao tác thành công!<% } %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <%-- Table card --%>
    <div class="card border-0 shadow-sm">
        <div class="table-responsive" style="overflow-x:auto;">
            <table class="table table-hover align-middle mb-0 small" style="min-width:900px;">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3" style="width:50px;">ID</th>
                        <th style="min-width:140px;">Họ và Tên</th>
                        <th style="width:95px;">Ngày sinh</th>
                        <th style="width:70px;">GT</th>
                        <th style="min-width:130px;">CCCD/CMND</th>
                        <th style="width:110px;">SĐT</th>
                        <th style="min-width:130px;">Email</th>
                        <th style="min-width:120px;">Trường</th>
                        <th style="min-width:130px;">Tài Khoản</th>
                        <th class="text-end pe-3" style="width:90px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<SinhVien> list = (List<SinhVien>) request.getAttribute("sinhVienList");
                        Map<Long, TaiKhoan> accountMap = (Map<Long, TaiKhoan>) request.getAttribute("accountMap");
                        if (list != null && !list.isEmpty()) {
                            for (SinhVien sv : list) {
                                TaiKhoan acc = (accountMap != null) ? accountMap.get((long) sv.getId()) : null;
                    %>
                    <tr>
                        <td class="ps-3 fw-bold text-secondary"><%= sv.getId() %></td>
                        <td class="fw-semibold text-primary"><%= sv.getHoTen() %></td>
                        <td class="text-muted"><%= sv.getNgaySinh() != null ? sv.getNgaySinh() : "-" %></td>
                        <td>
                            <span class="badge rounded-pill <%= "Nam".equalsIgnoreCase(sv.getGioiTinh()) ? "bg-info text-dark" : "bg-warning text-dark" %>">
                                <%= sv.getGioiTinh() != null ? sv.getGioiTinh() : "?" %>
                            </span>
                        </td>
                        <td class="text-muted"><%= sv.getCccd() != null ? sv.getCccd() : "-" %></td>
                        <td class="text-muted"><%= sv.getSoDienThoai() != null ? sv.getSoDienThoai() : "-" %></td>
                        <td class="text-muted" style="max-width:150px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                            <%= sv.getEmail() != null ? sv.getEmail() : "-" %>
                        </td>
                        <td class="text-muted" style="max-width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                            <%= sv.getTruong() != null ? sv.getTruong() : "-" %>
                        </td>
                        <td>
                            <% if (acc != null) { %>
                                <span class="badge bg-success">
                                    <i class="fa-solid fa-user-check me-1"></i><%= acc.getUsername() %>
                                </span>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/sinhvien?action=createAccount&id=<%= sv.getId() %>"
                                   class="btn btn-xs btn-outline-success btn-sm py-0 px-2" style="font-size:.78rem;">
                                    <i class="fa-solid fa-key me-1"></i>Cấp TK
                                </a>
                            <% } %>
                        </td>
                        <td class="text-end pe-3">
                            <a href="${pageContext.request.contextPath}/sinhvien?action=edit&id=<%= sv.getId() %>"
                               class="btn btn-sm btn-outline-primary py-0 px-2 me-1" title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/sinhvien?action=delete&id=<%= sv.getId() %>"
                               class="btn btn-sm btn-outline-danger py-0 px-2" title="Xóa"
                               onclick="return confirm('Xóa sinh viên này? Tất cả dữ liệu liên quan sẽ bị xóa!');">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="10" class="text-center py-5 text-muted">
                            <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                            Chưa có sinh viên nào trong hệ thống.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
