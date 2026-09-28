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
        <div>
            <% if (canApprove) { %>
                <a href="${pageContext.request.contextPath}/dangky?action=clearOld" class="btn btn-outline-danger btn-sm me-2" onclick="return confirm('Bạn có chắc muốn dọn dẹp các yêu cầu cũ/đã xử lý?');">
                    <i class="fa-solid fa-broom me-1"></i> Dọn Đẹp Đơn Cũ
                </a>
            <% } %>
            <a href="${pageContext.request.contextPath}/dangky?action=new" class="btn btn-primary btn-sm">
                <i class="fa-solid fa-plus me-1"></i> Tạo Đăng Ký Mới
            </a>
        </div>
    </div>

    <%-- Success/Alert message --%>
    <% String msg = request.getParameter("message"); if (msg != null) { %>
    <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
        <i class="fa-solid fa-check-circle me-1"></i>
        <% if ("Submitted".equals(msg)) { %>Yêu cầu đã được gửi thành công, chờ duyệt!
        <% } else if ("Updated".equals(msg)) { %>Trạng thái đã được cập nhật!
        <% } else if ("Deleted".equals(msg)) { %>Đã xóa yêu cầu thành công!
        <% } else if ("ClearedOld".equals(msg)) { %>Đã dọn dẹp <%= request.getParameter("count") != null ? request.getParameter("count") : "" %> đơn đăng ký cũ/đã xử lý!
        <% } else { %>Thao tác thành công!<% } %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <!-- Filter & Search Toolbar -->
    <div class="card mb-4 border-0 shadow-sm">
        <div class="card-body p-3">
            <div class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="searchDangKyInput" class="form-control border-start-0" placeholder="Tìm theo ID Sinh viên, ID Phòng, lý do..." onkeyup="filterDangKyTable()">
                    </div>
                </div>
                <div class="col-md-3">
                    <select id="filterLoaiYeuCau" class="form-select form-select-sm" onchange="filterDangKyTable()">
                        <option value="">-- Tất cả loại yêu cầu --</option>
                        <option value="Đăng Ký Mới">Đăng Ký Mới</option>
                        <option value="Chuyển Phòng">Chuyển Phòng</option>
                        <option value="Hủy / Trả Phòng">Hủy / Trả Phòng</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select id="filterTrangThaiDK" class="form-select form-select-sm" onchange="filterDangKyTable()">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="Chờ Duyệt">Chờ Duyệt</option>
                        <option value="Đã Duyệt">Đã Duyệt</option>
                        <option value="Từ Chối">Từ Chối</option>
                    </select>
                </div>
                <div class="col-md-2 text-end">
                    <button type="button" class="btn btn-sm btn-outline-secondary w-100" onclick="resetDangKyFilter()">
                        <i class="fa-solid fa-rotate-left me-1"></i>Đặt lại
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="table-responsive" style="overflow-x:auto;">
            <table class="table table-hover align-middle mb-0" id="dangKyTable">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3" style="width:50px;">#</th>
                        <th>Sinh Viên (ID)</th>
                        <th>Phòng (ID)</th>
                        <th>Loại Yêu Cầu</th>
                        <th>Lý Do / Ghi Chú</th>
                        <th class="text-center">Trạng Thái</th>
                        <th class="text-end pe-3">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (dangKyList != null && !dangKyList.isEmpty()) {
                        int stt = 1;
                        for (DangKyPhong d : dangKyList) {
                            String loaiLabel = "-";
                            if (d.getLoaiYeuCau() != null) {
                                switch (d.getLoaiYeuCau()) {
                                    case DANG_KY_MOI:  loaiLabel = "Đăng Ký Mới"; break;
                                    case CHUYEN_PHONG: loaiLabel = "Chuyển Phòng"; break;
                                    case HUY_PHONG:    loaiLabel = "Hủy / Trả Phòng"; break;
                                    default:           loaiLabel = d.getLoaiYeuCau().name();
                                }
                            }
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
                    <tr class="dangky-row">
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
                        <td class="text-end pe-3">
                            <% if (canApprove && d.getTrangThai() == TrangThaiDangKy.CHO_DUYET) { %>
                                <a href="${pageContext.request.contextPath}/dangky?action=approve&id=<%= d.getId() %>"
                                   class="btn btn-sm btn-outline-success py-0 px-2 me-1">
                                    <i class="fa-solid fa-check me-1"></i>Duyệt
                                </a>
                                <a href="${pageContext.request.contextPath}/dangky?action=reject&id=<%= d.getId() %>"
                                   class="btn btn-sm btn-outline-danger py-0 px-2 me-1">
                                    <i class="fa-solid fa-xmark me-1"></i>Từ chối
                                </a>
                            <% } %>
                            
                            <% if (canApprove || (isSinhVien && d.getTrangThai() == TrangThaiDangKy.CHO_DUYET)) { %>
                                <a href="${pageContext.request.contextPath}/dangky?action=delete&id=<%= d.getId() %>"
                                   class="btn btn-sm btn-outline-secondary py-0 px-2"
                                   onclick="return confirm('Bạn có chắc muốn xóa yêu cầu này?');" title="Xóa yêu cầu">
                                    <i class="fa-solid fa-trash me-1"></i>Xóa
                                </a>
                            <% } %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-5">
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

<script>
function filterDangKyTable() {
    const keyword = document.getElementById('searchDangKyInput').value.toLowerCase().trim();
    const loaiFilter = document.getElementById('filterLoaiYeuCau').value.toLowerCase();
    const trangThaiFilter = document.getElementById('filterTrangThaiDK').value.toLowerCase();
    
    const rows = document.querySelectorAll('.dangky-row');
    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        const matchesKeyword = !keyword || text.includes(keyword);
        const matchesLoai = !loaiFilter || text.includes(loaiFilter);
        const matchesTrangThai = !trangThaiFilter || text.includes(trangThaiFilter);
        
        if (matchesKeyword && matchesLoai && matchesTrangThai) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function resetDangKyFilter() {
    document.getElementById('searchDangKyInput').value = '';
    document.getElementById('filterLoaiYeuCau').value = '';
    document.getElementById('filterTrangThaiDK').value = '';
    filterDangKyTable();
}
</script>

<jsp:include page="/views/common/footer.jsp" />
