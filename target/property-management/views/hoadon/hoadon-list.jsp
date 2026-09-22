<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.HoaDon" %>
<%@ page import="com.example.property.management.model.enums.TrangThaiHoaDon" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Hóa Đơn & Điện Nước</h2>
            <p class="text-muted small">Danh sách hóa đơn thanh toán hàng tháng của sinh viên.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/hoadon?action=new" class="btn btn-primary">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Tạo Hóa Đơn Mới
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
                            <th>Kỳ thanh toán</th>
                            <th>Tền phòng</th>
                            <th>Tiền điện</th>
                            <th>Tiền nước</th>
                            <th>Phí dịch vụ</th>
                            <th>Tổng tiền</th>
                            <th>Hạn TT</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<HoaDon> list = (List<HoaDon>) request.getAttribute("hoaDonList");
                            if (list != null && !list.isEmpty()) {
                                for (HoaDon hd : list) {
                        %>
                        <tr>
                            <td class="ps-3 fw-bold text-primary"><%= hd.getMaHoaDon() %></td>
                            <td><%= hd.getSinhVien() != null ? hd.getSinhVien().getHoTen() : ("SV ID: " + hd.getSinhVienId()) %></td>
                            <td><%= hd.getKyThanhToan() != null ? hd.getKyThanhToan() : "-" %></td>
                            <td><%= String.format("%,.0f", hd.getTienPhong()) %></td>
                            <td><%= String.format("%,.0f", hd.getTienDien()) %></td>
                            <td><%= String.format("%,.0f", hd.getTienNuoc()) %></td>
                            <td><%= String.format("%,.0f", hd.getTongPhi()) %></td>
                            <td class="fw-bold text-danger"><%= String.format("%,.0f VNĐ", hd.getTongTien()) %></td>
                            <td><%= hd.getHanThanhToan() != null ? hd.getHanThanhToan() : "-" %></td>
                            <td>
                                <span class="badge <%= hd.getTrangThai() == TrangThaiHoaDon.DA_THANH_TOAN ? "bg-success" : "bg-warning text-dark" %>">
                                    <%= hd.getTrangThai() %>
                                </span>
                            </td>
                            <td class="text-end pe-3">
                                <% if (hd.getTrangThai() == TrangThaiHoaDon.CHUA_THANH_TOAN) { %>
                                    <a href="${pageContext.request.contextPath}/hoadon?action=pay&id=<%= hd.getId() %>" class="btn btn-sm btn-outline-success" onclick="return confirm('Xác nhận hóa đơn này đã được thanh toán?');">
                                        <i class="fa-solid fa-check me-1"></i>Xác nhận thanh toán
                                    </a>
                                <% } else { %>
                                    <span class="text-success small"><i class="fa-solid fa-circle-check me-1"></i>Đã xong</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="11" class="text-center py-4 text-muted">
                                <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                Chưa có hóa đơn nào.
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
