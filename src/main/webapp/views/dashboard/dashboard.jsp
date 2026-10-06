<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.TaiKhoan, com.example.property.management.model.enums.VaiTro" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    TaiKhoan cu = (TaiKhoan) session.getAttribute("user");
    boolean isSinhVien = cu != null && cu.getVaiTro() == VaiTro.SINH_VIEN;
%>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div>
<% if (isSinhVien) { %>
    <!-- ==================== STUDENT DASHBOARD ==================== -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="mb-0">Góc Sinh Viên</h3>
            <div class="text-muted small">
                Chào mừng <span class="fw-semibold text-dark"><%= cu != null ? cu.getUsername() : "" %></span> quay trở lại hệ thống ký túc xá
            </div>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary btn-sm">
                <i class="ph ph-receipt me-2"></i> Hóa đơn của tôi
            </a>
            <a href="${pageContext.request.contextPath}/suachua?action=new" class="btn btn-primary btn-sm">
                <i class="ph ph-plus me-2"></i> Báo hỏng / sự cố
            </a>
        </div>
    </div>

    <!-- Metric Strip Student -->
    <div class="metric-strip">
        <div class="metric-item">
            <div class="metric-label">Phòng hiện tại</div>
            <div class="metric-val text-primary" style="font-size: 18px;">${svRoomName}</div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Hóa đơn chưa thanh toán</div>
            <div class="metric-val text-danger">${svUnpaidCount} <span style="font-size: 12px; color: var(--text-muted); font-weight: normal;">hóa đơn</span></div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Tổng nợ tiền phòng/phí</div>
            <div class="metric-val text-danger">${svDebt} <span style="font-size: 12px; font-weight: normal;">₫</span></div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Yêu cầu sửa chữa chờ</div>
            <div class="metric-val text-warning">${svPendingRepair}</div>
        </div>
    </div>

    <!-- Quick Links Student -->
    <div class="row g-3">
        <div class="col-md-8">
            <div class="card h-100">
                <div class="card-header">Danh Mục Thao Tác</div>
                <div class="card-body p-3">
                    <div class="row g-2">
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/hoadon" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="fw-semibold"><i class="ph ph-receipt me-2 text-muted"></i>Hóa Đơn & Thanh Toán</div>
                                <div class="small text-muted" style="font-size: 11px;">Xem chi tiết nợ và thanh toán hóa đơn</div>
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/dangky" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="fw-semibold"><i class="ph ph-clipboard-text me-2 text-muted"></i>Đăng Ký / Đổi Phòng</div>
                                <div class="small text-muted" style="font-size: 11px;">Gửi đơn đăng ký lưu trú mới hoặc đổi phòng</div>
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/suachua" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="fw-semibold"><i class="ph ph-wrench me-2 text-muted"></i>Báo Hỏng & Sửa Chữa</div>
                                <div class="small text-muted" style="font-size: 11px;">Báo cáo sự cố điện nước, thiết bị hư hỏng</div>
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <a href="${pageContext.request.contextPath}/thong-bao" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="fw-semibold"><i class="ph ph-bell me-2 text-muted"></i>Thông Báo Từ BQL</div>
                                <div class="small text-muted" style="font-size: 11px;">Xem thông báo mới nhất từ Ký túc xá</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-header">Nhắc Nhở Hệ Thống</div>
                <div class="card-body p-3">
                    <c:choose>
                        <c:when test="${svUnpaidCount > 0}">
                            <div class="p-2 mb-2 border border-danger rounded" style="background: #FDF2F2;">
                                <div class="fw-semibold text-danger small"><i class="ph ph-warning-circle me-2"></i>Hóa đơn nợ quá hạn</div>
                                <div class="small text-muted" style="font-size: 11px;">Bạn có ${svUnpaidCount} hóa đơn chưa đóng. Nợ: <span class="font-mono text-danger fw-semibold">${svDebt} ₫</span></div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="p-2 border border-success rounded text-success small" style="background: #F2F9F4;">
                                <i class="ph ph-check-circle me-2"></i>Không có hóa đơn nợ quá hạn.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

<% } else { %>

    <!-- ==================== ADMIN / MANAGER DASHBOARD ==================== -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="mb-0">Dashboard Quản Lý KTX</h3>
            <div class="text-muted small">Tổng quan chỉ số vận hành và nghiệp vụ Ký túc xá</div>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/phong" class="btn btn-outline-secondary btn-sm">
                <i class="ph ph-door me-2"></i> Quản lý phòng
            </a>
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-primary btn-sm">
                <i class="ph ph-receipt me-2"></i> Quản lý Hóa đơn
            </a>
        </div>
    </div>

    <!-- Main Metric Strip -->
    <div class="metric-strip">
        <div class="metric-item">
            <div class="metric-label">Tổng số phòng</div>
            <div class="metric-val">${tongSoPhong}</div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Đang ở / Trống</div>
            <div class="metric-val">${phongDaCoNguoi} <span style="font-size: 12px; color: var(--text-muted); font-weight: normal;">/ ${phongTrong} trống</span></div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Tổng sinh viên</div>
            <div class="metric-val">${tongSinhVien}</div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Hợp đồng hiệu lực</div>
            <div class="metric-val">${hopDongHieuLuc} <span style="font-size: 12px; color: var(--status-warning); font-weight: normal;">(${hopDongSapHetHan} sắp hết hạn)</span></div>
        </div>
    </div>

    <!-- Financial & Pending Issues Strip -->
    <div class="metric-strip mb-3">
        <div class="metric-item">
            <div class="metric-label text-danger">Hóa đơn chưa thanh toán</div>
            <div class="metric-val text-danger">${hoaDonChuaThanhToan} <span style="font-size: 12px; font-weight: normal;">hóa đơn</span></div>
            <div class="small text-muted font-mono" style="font-size: 11px;">Tổng công nợ: ${tongCongNo} ₫</div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Đăng ký chờ duyệt</div>
            <div class="metric-val">${dangKyChoDuyet} <span style="font-size: 12px; color: var(--text-muted); font-weight: normal;">yêu cầu</span></div>
            <div class="small text-muted" style="font-size: 11px;">Đăng ký ở mới & đổi phòng</div>
        </div>
        <div class="metric-item">
            <div class="metric-label">Yêu cầu sửa chữa chờ</div>
            <div class="metric-val text-warning">${yeuCauChoXuLy} <span style="font-size: 12px; font-weight: normal;">yêu cầu</span></div>
            <div class="small text-muted" style="font-size: 11px;">Cần nhân viên kiểm tra xử lý</div>
        </div>
    </div>

    <!-- Quick Operations Grid with Visible Keyboard Shortcuts -->
    <div class="row g-3">
        <div class="col-lg-8">
            <div class="card h-100">
                <div class="card-header d-flex align-items-center justify-content-between">
                    <span>Thao Tác Quản Lý Nhanh</span>
                    <span class="label-sm">Phím tắt Alt + 1..6</span>
                </div>
                <div class="card-body p-3">
                    <div class="row g-2">
                        <div class="col-sm-4">
                            <a id="shortcut-alt-1" href="${pageContext.request.contextPath}/phong?action=new" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-plus me-2 text-muted"></i>Thêm Phòng Mới</div>
                                    <span class="kbd-badge">Alt 1</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Cấu hình Khu / Tòa / Tầng</div>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a id="shortcut-alt-2" href="${pageContext.request.contextPath}/sinhvien?action=new" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-user-plus me-2 text-muted"></i>Tiếp Nhận Sinh Viên</div>
                                    <span class="kbd-badge">Alt 2</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Tạo hồ sơ sinh viên mới</div>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a id="shortcut-alt-3" href="${pageContext.request.contextPath}/dien-nuoc" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-lightning me-2 text-muted"></i>Nhập Điện Nước</div>
                                    <span class="kbd-badge">Alt 3</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Chỉ số tiêu thụ hàng tháng</div>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a id="shortcut-alt-4" href="${pageContext.request.contextPath}/hoadon?action=new" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-receipt me-2 text-muted"></i>Tạo Hóa Đơn</div>
                                    <span class="kbd-badge">Alt 4</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Lập hóa đơn tiền phòng/phí</div>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a id="shortcut-alt-5" href="${pageContext.request.contextPath}/thong-bao" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-bell me-2 text-muted"></i>Gửi Thông Báo</div>
                                    <span class="kbd-badge">Alt 5</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Gửi thông báo toàn hệ thống</div>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a id="shortcut-alt-6" href="${pageContext.request.contextPath}/lich-su-phong" class="text-decoration-none text-dark d-block p-2 border rounded" style="background: var(--bg-warm); border-color: var(--border-color) !important;">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="fw-semibold"><i class="ph ph-clock-counter-clockwise me-2 text-muted"></i>Lịch Sử Phòng</div>
                                    <span class="kbd-badge">Alt 6</span>
                                </div>
                                <div class="small text-muted" style="font-size: 11px; margin-top: 2px;">Nhật ký luân chuyển phòng</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header text-danger">Cần Xử Lý Ngay</div>
                <div class="card-body p-3">
                    <div class="list-group list-group-flush" style="font-size: 13px;">
                        <a href="${pageContext.request.contextPath}/hoadon" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center px-0 py-2">
                            <div>
                                <div class="fw-semibold"><i class="ph ph-receipt me-2 text-danger"></i>Hóa đơn nợ quá hạn</div>
                                <div class="small text-muted font-mono" style="font-size: 11px;">Nợ: ${tongCongNo} ₫</div>
                            </div>
                            <span class="font-mono fw-semibold text-danger">${hoaDonChuaThanhToan}</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/dangky" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center px-0 py-2">
                            <div>
                                <div class="fw-semibold"><i class="ph ph-clipboard-text me-2 text-primary"></i>Đăng ký ở / Đổi phòng</div>
                                <div class="small text-muted" style="font-size: 11px;">Cần duyệt đơn</div>
                            </div>
                            <span class="font-mono fw-semibold">${dangKyChoDuyet}</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/suachua" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center px-0 py-2">
                            <div>
                                <div class="fw-semibold"><i class="ph ph-wrench me-2 text-warning"></i>Yêu cầu sửa chữa mới</div>
                                <div class="small text-muted" style="font-size: 11px;">Báo hỏng từ sinh viên</div>
                            </div>
                            <span class="font-mono fw-semibold text-warning">${yeuCauChoXuLy}</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<% } %>
</div>

<script>
    // Alt + 1..6 Keyboard Shortcuts Listener
    document.addEventListener('keydown', function(e) {
        if (e.altKey && !e.ctrlKey && !e.metaKey) {
            const keyNum = parseInt(e.key);
            if (keyNum >= 1 && keyNum <= 6) {
                const link = document.getElementById('shortcut-alt-' + keyNum);
                if (link) {
                    e.preventDefault();
                    window.location.href = link.href;
                }
            }
        }
    });
</script>

<jsp:include page="/views/common/footer.jsp" />