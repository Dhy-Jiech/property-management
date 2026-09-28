<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.DangKyPhong" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>
<%@ page import="com.example.property.management.model.enums.LoaiYeuCauDangKy" %>
<%@ page import="com.example.property.management.model.enums.TrangThaiDangKy" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="dangky" />
</jsp:include>

<%
    TaiKhoan u = (TaiKhoan) session.getAttribute("user");
    boolean isSinhVien = (u != null && u.getVaiTro() == VaiTro.SINH_VIEN);
    boolean canApprove  = (u != null && (u.getVaiTro() == VaiTro.ADMIN
                                      || u.getVaiTro() == VaiTro.QUAN_LY
                                      || u.getVaiTro() == VaiTro.NHAN_VIEN));
    List<DangKyPhong> dangKyList = (List<DangKyPhong>) request.getAttribute("dangKyList");
%>

<div class="container-fluid px-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h4 fw-bold text-dark mb-0">
                <%= isSinhVien ? "Đăng Ký & Đổi Phòng Của Tôi" : "Quản Lý Đăng Ký & Đổi Phòng" %>
            </h2>
            <p class="text-muted small mb-0">
                <%= isSinhVien ? "Theo dõi các đơn đăng ký ở ký túc xá và yêu cầu chuyển đổi phòng của bạn." : "Danh sách các đơn đăng ký nguyện vọng phòng ở và yêu cầu chuyển đổi phòng." %>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/dangky?action=new" class="btn btn-primary btn-sm">
            <i class="fa-solid fa-plus me-1"></i> Tạo Đăng Ký Mới
        </a>
    </div>

    <%-- Success message --%>
    <% String msg = request.getParameter("message"); if (msg != null) { %>
    <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
        <i class="fa-solid fa-check-circle me-1"></i>
        <% if ("Submitted".equals(msg)) { %>Yêu cầu đã được gửi thành công, chờ duyệt!
        <% } else if ("Updated".equals(msg)) { %>Trạng thái đã được cập nhật!
        <% } else { %>Thao tác thành công!<% } %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="card border-0 shadow-sm">
        <div class="table-responsive" style="overflow-x:auto;">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3" style="width:50px;">#</th>
                        <th>Sinh Viên (ID)</th>
                        <th>Phòng (ID)</th>
                        <th>Loại Yêu Cầu</th>
                        <th>Lý Do / Ghi Chú</th>
                        <th class="text-center">Trạng Thái</th>
                        <% if (canApprove) { %>
                        <th class="text-end pe-3">Phê Duyệt</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (dangKyList != null && !dangKyList.isEmpty()) {
                        int stt = 1;
                        for (DangKyPhong d : dangKyList) {
                            // Loại yêu cầu label
                            String loaiLabel = "-";
                            if (d.getLoaiYeuCau() != null) {
                                switch (d.getLoaiYeuCau()) {
                                    case DANG_KY_MOI:  loaiLabel = "Đăng Ký Mới"; break;
                                    case CHUYEN_PHONG: loaiLabel = "Chuyển Phòng"; break;
                                    case HUY_PHONG:    loaiLabel = "Hủy / Trả Phòng"; break;
                                    default:           loaiLabel = d.getLoaiYeuCau().name();
                                }
                            }
                            // Trạng thái label & badge
                            String ttLabel = "-"; String ttBadge = "bg-secondary";
                            if (d.getTrangThai() != null) {
                                switch (d.getTrangThai()) {
                                    case CHO_DUYET: ttLabel = "Chờ Duyệt"; ttBadge = "bg-warning text-dark"; break;
                                    case DA_DUYET:  ttLabel = "Đã Duyệt";  ttBadge = "bg-success"; break;
                                    case TU_CHOI:   ttLabel = "Từ Chối";   ttBadge = "bg-danger"; break;
                                    default:        ttLabel = d.getTrangThai().name();
                                }
                            }
                %>
                    <tr>
                        <td class="ps-3 fw-bold text-secondary"><%= stt++ %></td>
                        <td><span class="badge bg-secondary">SV #<%= d.getSinhVienId() %></span></td>
                        <td><span class="badge bg-info text-dark">Phòng #<%= d.getPhongId() %></span></td>
                        <td><span class="badge bg-primary"><%= loaiLabel %></span></td>
                        <td class="text-muted small" style="max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                            <%= d.getLyDo() != null && !d.getLyDo().isEmpty() ? d.getLyDo() : "-" %>
                        </td>
                        <td class="text-center">
                            <span class="badge <%= ttBadge %>"><%= ttLabel %></span>
                        </td>
                        <% if (canApprove) { %>
                        <td class="text-end pe-3">
                            <% if (d.getTrangThai() == TrangThaiDangKy.CHO_DUYET) { %>
                                <a href="${pageContext.request.contextPath}/dangky?action=approve&id=<%= d.getId() %>"
                                   class="btn btn-sm btn-outline-success py-0 px-2 me-1">
                                    <i class="fa-solid fa-check me-1"></i>Duyệt
                                </a>
                                <a href="${pageContext.request.contextPath}/dangky?action=reject&id=<%= d.getId() %>"
                                   class="btn btn-sm btn-outline-danger py-0 px-2">
                                    <i class="fa-solid fa-xmark me-1"></i>Từ chối
                                </a>
                            <% } else { %>
                                <span class="text-muted small">Đã xử lý</span>
                            <% } %>
                        </td>
                        <% } %>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="<%= canApprove ? 7 : 6 %>" class="text-center text-muted py-5">
                            <i class="fa-solid fa-folder-open fa-2x d-block mb-2"></i>
                            Chưa có đơn đăng ký / đổi phòng nào.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
