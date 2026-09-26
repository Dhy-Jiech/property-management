<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="sinhvien" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Sinh Viên</h2>
            <p class="text-muted small">Danh sách sinh viên lưu trú trong ký túc xá.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/sinhvien?action=new" class="btn btn-primary">
                <i class="fa-solid fa-user-plus me-1"></i> Thêm Sinh Viên
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Họ và Tên</th>
                            <th>Ngày sinh</th>
                            <th>Giới tính</th>
                            <th>CCCD / CMND</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Tài Khoản</th>
                            <th class="text-end pe-3">Thao tác</th>
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
                            <td class="ps-3 fw-bold"><%= sv.getId() %></td>
                            <td class="fw-semibold text-primary"><%= sv.getHoTen() %></td>
                            <td><%= sv.getNgaySinh() != null ? sv.getNgaySinh() : "-" %></td>
                            <td>
                                <span class="badge <%= "Nam".equalsIgnoreCase(sv.getGioiTinh()) ? "bg-info text-dark" : "bg-warning text-dark" %>">
                                    <%= sv.getGioiTinh() != null ? sv.getGioiTinh() : "Khác" %>
                                </span>
                            </td>
                            <td><%= sv.getCccd() != null ? sv.getCccd() : "-" %></td>
                            <td><%= sv.getSoDienThoai() != null ? sv.getSoDienThoai() : "-" %></td>
                            <td><%= sv.getEmail() != null ? sv.getEmail() : "-" %></td>
                            <td>
                                <% if (acc != null) { %>
                                    <span class="badge bg-success text-white">
                                        <i class="fa-solid fa-user-check me-1"></i><%= acc.getUsername() %>
                                    </span>
                                <% } else { %>
                                    <a href="${pageContext.request.contextPath}/sinhvien?action=createAccount&id=<%= sv.getId() %>" class="btn btn-sm btn-outline-success">
                                        <i class="fa-solid fa-key me-1"></i>Cấp tài khoản
                                    </a>
                                <% } %>
                            </td>
                            <td class="text-end pe-3">
                                <a href="${pageContext.request.contextPath}/sinhvien?action=edit&id=<%= sv.getId() %>" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/sinhvien?action=delete&id=<%= sv.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên này? Tất cả dữ liệu liên quan sẽ bị xóa sạch.');">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center py-4 text-muted">
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
</div>

<jsp:include page="/views/common/footer.jsp" />
