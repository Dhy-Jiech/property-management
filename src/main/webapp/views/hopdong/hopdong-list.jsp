<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.HopDong" %>
<%@ page import="com.example.property.management.model.enums.TrangThaiHopDong" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hopdong" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Hợp Đồng</h2>
            <p class="text-muted small">Danh sách hợp đồng thuê phòng của sinh viên.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/hopdong?action=new" class="btn btn-primary">
                <i class="fa-solid fa-file-signature me-1"></i> Lập Hợp Đồng Mới
            </a>
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
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Tiền phòng (tháng)</th>
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
                        %>
                        <tr>
                            <td class="ps-3 fw-bold text-primary"><%= hd.getMaHopDong() %></td>
                            <td><%= hd.getSinhVien() != null ? hd.getSinhVien().getHoTen() : ("SV ID: " + hd.getSinhVienId()) %></td>
                            <td><%= hd.getPhong() != null ? (hd.getPhong().getMaPhong() + " - " + hd.getPhong().getTenPhong()) : ("Phong ID: " + hd.getPhongId()) %></td>
                            <td><%= hd.getNgayBatDau() != null ? hd.getNgayBatDau() : "-" %></td>
                            <td><%= hd.getNgayKetThuc() != null ? hd.getNgayKetThuc() : "-" %></td>
                            <td class="fw-semibold text-success"><%= String.format("%,.0f VNĐ", hd.getTienPhong()) %></td>
                            <td class="fw-semibold text-muted"><%= String.format("%,.0f VNĐ", hd.getTienDatCoc()) %></td>
                            <td>
                                <span class="badge <%= hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC ? "bg-success" : "bg-danger" %>">
                                    <%= hd.getTrangThai() %>
                                </span>
                            </td>
                            <td class="text-end pe-3">
                                <% if (hd.getTrangThai() == TrangThaiHopDong.DANG_HIEU_LUC) { %>
                                    <a href="${pageContext.request.contextPath}/hopdong?action=cancel&id=<%= hd.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn hủy hợp đồng này?');">
                                        <i class="fa-solid fa-ban me-1"></i>Hủy HĐ
                                    </a>
                                <% } else { %>
                                    <span class="text-muted small">Đã chấm dứt</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center py-4 text-muted">
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
