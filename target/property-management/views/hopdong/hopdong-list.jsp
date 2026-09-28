<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.HopDong" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.TrangThaiHopDong" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hopdong" />
</jsp:include>

<%
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");
    boolean isSinhVien = (user != null && user.getVaiTro() == VaiTro.SINH_VIEN);
%>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Hợp Đồng</h2>
            <p class="text-muted small">Danh sách hợp đồng thuê phòng và trạng thái ký điện tử.</p>
        </div>
        <div>
            <% if (!isSinhVien) { %>
            <a href="${pageContext.request.contextPath}/hopdong?action=new" class="btn btn-primary">
                <i class="fa-solid fa-file-signature me-1"></i> Lập Hợp Đồng Mới
            </a>
            <% } %>
        </div>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3">Mã HĐ</th>
                            <th>Sinh Viên</th>
                            <th>Phòng</th>
                            <th>Thời hạn hợp đồng</th>
                            <th>Giá thuê/tháng</th>
                            <th>Tiền đặt cọc</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<HopDong> list = (List<HopDong>) request.getAttribute("hopDongList");
                            if (list != null && !list.isEmpty()) {
                                for (HopDong hd : list) {
                                    String statusBadgeClass = "bg-secondary";
                                    String statusText = hd.getTrangThai() != null ? hd.getTrangThai().name() : "";
                                    
                                    if (hd.getTrangThai() == TrangThaiHopDong.CHO_HIEU_LUC) {
                                        statusBadgeClass = "bg-warning text-dark";
                                        statusText = "Chờ ký hợp đồng";
                                    } else if (hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC) {
                                        statusBadgeClass = "bg-success";
                                        statusText = "Đang hiệu lực";
                                    } else if (hd.getTrangThai() == TrangThaiHopDong.DA_CHAM_DUT) {
                                        statusBadgeClass = "bg-danger";
                                        statusText = "Đã chấm dứt";
                                    }
                        %>
                        <tr>
                            <td class="ps-3 fw-bold text-primary"><%= hd.getMaHopDong() %></td>
                            <td><%= hd.getSinhVien() != null ? hd.getSinhVien().getHoTen() : ("SV ID: " + hd.getSinhVienId()) %></td>
                            <td><%= hd.getPhong() != null ? (hd.getPhong().getMaPhong() + " - " + hd.getPhong().getTenPhong()) : ("Phong ID: " + hd.getPhongId()) %></td>
                            <td>
                                <small class="text-muted"><%= hd.getNgayBatDau() != null ? hd.getNgayBatDau() : "-" %> đến <%= hd.getNgayKetThuc() != null ? hd.getNgayKetThuc() : "-" %></small>
                            </td>
                            <td class="fw-semibold text-success"><%= String.format("%,.0f VNĐ", hd.getTienPhong()) %></td>
                            <td class="fw-semibold text-muted"><%= String.format("%,.0f VNĐ", hd.getTienDatCoc()) %></td>
                            <td>
                                <span class="badge <%= statusBadgeClass %>">
                                    <i class="fa-solid fa-circle-info me-1"></i><%= statusText %>
                                </span>
                            </td>
                            <td class="text-end pe-3">
                                <% if (hd.getTrangThai() == TrangThaiHopDong.CHO_HIEU_LUC) { %>
                                    <% if (isSinhVien || hd.getChuKyBenB() == null || hd.getChuKyBenB().isEmpty()) { %>
                                        <a href="${pageContext.request.contextPath}/hopdong?action=sign&id=<%= hd.getId() %>" class="btn btn-sm btn-success me-1">
                                            <i class="fa-solid fa-pen-nib me-1"></i>Ký Hợp Đồng
                                        </a>
                                    <% } %>
                                <% } %>

                                <a href="${pageContext.request.contextPath}/hopdong?action=view&id=<%= hd.getId() %>" class="btn btn-sm btn-outline-info me-1">
                                    <i class="fa-solid fa-eye me-1"></i>Xem HĐ
                                </a>

                                <% if (!isSinhVien && hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC) { %>
                                    <a href="${pageContext.request.contextPath}/hopdong?action=cancel&id=<%= hd.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn hủy/chấm dứt hợp đồng này?');">
                                        <i class="fa-solid fa-ban me-1"></i>Hủy HĐ
                                    </a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                Chưa có hợp đồng nào.
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
