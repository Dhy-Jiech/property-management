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

<div class="animate-in">

<% if (isSinhVien) { %>
    <!-- ==================== STUDENT DASHBOARD ==================== -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h1 class="h3 fw-bold mb-1" style="letter-spacing:-0.02em;">Góc Sinh Viên</h1>
            <p class="text-muted small mb-0">
                <i class="fa-regular fa-calendar me-1"></i>
                Chào mừng <span class="fw-semibold text-primary"><%= cu.getUsername() %></span> quay trở lại hệ thống ký túc xá!
            </p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-success">
                <i class="fa-solid fa-credit-card me-1"></i> Hóa đơn của tôi
            </a>
            <a href="${pageContext.request.contextPath}/suachua?action=new" class="btn btn-outline-primary">
                <i class="fa-solid fa-wrench me-1"></i> Báo sự cố / hỏng hóc
            </a>
        </div>
    </div>

    <!-- Stat Cards Student -->
    <div class="row g-3 g-lg-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Phòng hiện tại
                        </div>
                        <h3 class="fw-bold mb-1 mt-2 text-primary" style="font-size: 1.5rem;">${svRoomName}</h3>
                        <c:choose>
                            <c:when test="${svHasRoom}">
                                <span class="badge bg-primary-subtle text-primary">
                                    <i class="fa-solid fa-bed me-1"></i> Đang lưu trú
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary-subtle text-secondary">Chưa có hợp đồng hiệu lực</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #eef2ff, #e0e7ff); color: var(--primary);">
                        <i class="fa-solid fa-door-closed"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--primary);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Hóa đơn chưa thanh toán
                        </div>
                        <h3 class="fw-bold mb-1 mt-2 text-danger" style="font-size: 1.5rem;">${svUnpaidCount} <span class="fs-6 font-normal">hóa đơn</span></h3>
                        <small class="text-muted">Tổng nợ: <strong class="text-danger">${svDebt} ₫</strong></small>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #fee2e2, #fecaca); color: var(--danger);">
                        <i class="fa-solid fa-receipt"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--danger);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Thông báo chưa đọc
                        </div>
                        <h3 class="fw-bold mb-1 mt-2 text-info" style="font-size: 1.5rem;">${svUnreadNotify}</h3>
                        <span class="badge bg-info-subtle text-info">
                            <i class="fa-solid fa-bell me-1"></i> Từ BQL KTX
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #cffafe, #a5f3fc); color: var(--info);">
                        <i class="fa-solid fa-bullhorn"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--info);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Yêu cầu hỏng hóc chờ xử lý
                        </div>
                        <h3 class="fw-bold mb-1 mt-2 text-warning" style="font-size: 1.5rem;">${svPendingRepair}</h3>
                        <span class="badge bg-warning-subtle text-warning">
                            <i class="fa-solid fa-screwdriver-wrench me-1"></i> Đang chờ phản hồi
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #fef3c7, #fde68a); color: var(--warning);">
                        <i class="fa-solid fa-wrench"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--warning);"></div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Student -->
    <div class="row g-3 g-lg-4">
        <div class="col-lg-8">
            <div class="card h-100">
                <div class="card-header fw-bold"><i class="fa-solid fa-bolt text-warning me-2"></i>Thao tác nhanh cho Sinh viên</div>
                <div class="card-body p-3 p-lg-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/hoadon" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #d1fae5, #a7f3d0); color: var(--success);">
                                    <i class="fa-solid fa-file-invoice-dollar"></i>
                                </div>
                                <div class="quick-title">Hóa đơn & Thanh toán</div>
                                <div class="quick-sub">Xem chi tiết & đóng tiền điện nước, phòng</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/dangky" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #eef2ff, #e0e7ff); color: var(--primary);">
                                    <i class="fa-solid fa-clipboard-check"></i>
                                </div>
                                <div class="quick-title">Đăng ký / Đổi phòng</div>
                                <div class="quick-sub">Gửi đơn đăng ký ở mới hoặc chuyển phòng</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/suachua" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #fef3c7, #fde68a); color: var(--warning);">
                                    <i class="fa-solid fa-screwdriver-wrench"></i>
                                </div>
                                <div class="quick-title">Báo hỏng & Sửa chữa</div>
                                <div class="quick-sub">Gửi phản ánh sự cố thiết bị phòng ở</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/thong-bao" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #cffafe, #a5f3fc); color: var(--info);">
                                    <i class="fa-solid fa-bell"></i>
                                </div>
                                <div class="quick-title">Thông báo của tôi</div>
                                <div class="quick-sub">Xem thông báo từ Ban quản lý ký túc xá</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header fw-bold text-danger"><i class="fa-solid fa-circle-exclamation me-2"></i>Nhắc nhở quan trọng</div>
                <div class="card-body p-3 p-lg-4 d-flex flex-column gap-3">
                    <c:choose>
                        <c:when test="${svUnpaidCount > 0}">
                            <a href="${pageContext.request.contextPath}/hoadon" class="attention-item text-decoration-none">
                                <div class="attention-icon"><i class="fa-solid fa-file-invoice-dollar"></i></div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold small text-dark">Bạn có ${svUnpaidCount} hóa đơn chưa thanh toán</div>
                                    <div class="text-muted" style="font-size:0.78rem;">Tổng số tiền: ${svDebt} ₫</div>
                                </div>
                                <span class="btn btn-xs btn-danger">Thanh toán</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-success mb-0 p-3"><i class="fa-solid fa-check-circle me-2"></i>Bạn không có hóa đơn nào quá hạn!</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

<% } else { %>

    <!-- ==================== ADMIN / MANAGER DASHBOARD ==================== -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h1 class="h3 fw-bold mb-1" style="letter-spacing:-0.02em;">Dashboard Quản Lý KTX</h1>
            <p class="text-muted small mb-0">
                <i class="fa-regular fa-calendar me-1"></i>
                Chào mừng quay trở lại — <span class="fw-semibold text-primary">Ký túc xá</span>
            </p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/phong" class="btn btn-primary">
                <i class="fa-solid fa-door-open me-1"></i> Quản lý phòng
            </a>
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-success">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Quản lý Hóa đơn
            </a>
        </div>
    </div>

    <!-- Stat Cards Admin/Manager -->
    <div class="row g-3 g-lg-4 mb-3">
        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Tổng số phòng
                        </div>
                        <h2 class="fw-bold mb-1 mt-2" style="color: var(--primary); font-size: 2rem;">${tongSoPhong}</h2>
                        <span class="badge" style="background: var(--primary-soft); color: var(--primary-dark);">
                            <i class="fa-solid fa-layer-group me-1"></i> Tất cả các khu
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #eef2ff, #e0e7ff); color: var(--primary);">
                        <i class="fa-solid fa-door-open"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--primary);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Phòng đang ở / Phòng trống
                        </div>
                        <h2 class="fw-bold mb-1 mt-2" style="color: var(--success); font-size: 2rem;">${phongDaCoNguoi} <span class="fs-6 text-muted">/ ${phongTrong} trống</span></h2>
                        <span class="badge bg-success-subtle text-success">
                            <i class="fa-solid fa-wrench me-1"></i> ${phongBaoTri} bảo trì
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #d1fae5, #a7f3d0); color: var(--success);">
                        <i class="fa-solid fa-bed"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--success);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Tổng sinh viên
                        </div>
                        <h2 class="fw-bold mb-1 mt-2" style="color: var(--info); font-size: 2rem;">${tongSinhVien}</h2>
                        <span class="badge" style="background: #cffafe; color: #0e7490;">
                            <i class="fa-solid fa-users me-1"></i> Đang lưu trú
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #cffafe, #a5f3fc); color: var(--info);">
                        <i class="fa-solid fa-user-graduate"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--info);"></div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-3">
            <div class="card h-100 p-4 position-relative overflow-hidden stat-card">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-muted text-uppercase fw-bold" style="font-size:0.7rem; letter-spacing:0.08em;">
                            Hợp đồng hiệu lực
                        </div>
                        <h2 class="fw-bold mb-1 mt-2" style="color: var(--warning); font-size: 2rem;">${hopDongHieuLuc}</h2>
                        <span class="badge bg-warning-subtle text-warning">
                            <i class="fa-solid fa-clock me-1"></i> ${hopDongSapHetHan} sắp hết hạn
                        </span>
                    </div>
                    <div class="stat-icon" style="background: linear-gradient(135deg, #fef3c7, #fde68a); color: var(--warning);">
                        <i class="fa-solid fa-file-contract"></i>
                    </div>
                </div>
                <div class="stat-bar" style="background: var(--warning);"></div>
            </div>
        </div>
    </div>

    <!-- Stat Cards Row 2 (Financial & Pending) -->
    <div class="row g-3 g-lg-4 mb-4">
        <div class="col-md-6 col-xl-4">
            <div class="card h-100 p-3 bg-white border-start border-4 border-danger">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="text-muted small fw-bold uppercase">Hóa Đơn Nợ & Công Nợ</div>
                        <h4 class="fw-bold text-danger mb-0 mt-1">${hoaDonChuaThanhToan} <span class="fs-6 font-normal">hóa đơn</span></h4>
                        <small class="text-muted">Tổng tiền nợ: <strong class="text-danger">${tongCongNo} ₫</strong></small>
                    </div>
                    <div class="p-3 bg-danger-subtle rounded-3 text-danger"><i class="fa-solid fa-receipt fa-xl"></i></div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-4">
            <div class="card h-100 p-3 bg-white border-start border-4 border-primary">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="text-muted small fw-bold uppercase">Đăng Ký Chờ Duyệt</div>
                        <h4 class="fw-bold text-primary mb-0 mt-1">${dangKyChoDuyet} <span class="fs-6">yêu cầu</span></h4>
                        <small class="text-muted">Đăng ký mới & Đổi phòng</small>
                    </div>
                    <div class="p-3 bg-primary-subtle rounded-3 text-primary"><i class="fa-solid fa-clipboard-question fa-xl"></i></div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-4">
            <div class="card h-100 p-3 bg-white border-start border-4 border-warning">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="text-muted small fw-bold uppercase">Báo Hỏng / Sửa Chữa Mới</div>
                        <h4 class="fw-bold text-warning mb-0 mt-1">${yeuCauChoXuLy} <span class="fs-6">yêu cầu</span></h4>
                        <small class="text-muted">Cần nhân viên kiểm tra & phản hồi</small>
                    </div>
                    <div class="p-3 bg-warning-subtle rounded-3 text-warning"><i class="fa-solid fa-screwdriver-wrench fa-xl"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Admin -->
    <div class="row g-3 g-lg-4">
        <div class="col-lg-8">
            <div class="card h-100">
                <div class="card-header d-flex align-items-center justify-content-between">
                    <h6 class="mb-0 fw-bold">
                        <i class="fa-solid fa-bolt me-2 text-warning"></i> Thao tác quản lý nhanh
                    </h6>
                    <span class="text-muted small">Chọn để bắt đầu</span>
                </div>
                <div class="card-body p-3 p-lg-4">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/phong?action=new" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #eef2ff, #e0e7ff); color: var(--primary);">
                                    <i class="fa-solid fa-plus"></i>
                                </div>
                                <div class="quick-title">Thêm phòng mới</div>
                                <div class="quick-sub">Khu / Tòa / Tầng</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/sinhvien?action=new" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #d1fae5, #a7f3d0); color: var(--success);">
                                    <i class="fa-solid fa-user-plus"></i>
                                </div>
                                <div class="quick-title">Tiếp nhận Sinh viên</div>
                                <div class="quick-sub">Tạo hồ sơ sinh viên</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/dien-nuoc" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #fef3c7, #fde68a); color: var(--warning);">
                                    <i class="fa-solid fa-bolt"></i>
                                </div>
                                <div class="quick-title">Nhập Số Điện Nước</div>
                                <div class="quick-sub">Ghi chỉ số hàng tháng</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/hoadon?action=new" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #dbeafe, #bfdbfe); color: #2563eb;">
                                    <i class="fa-solid fa-receipt"></i>
                                </div>
                                <div class="quick-title">Tạo hóa đơn tháng</div>
                                <div class="quick-sub">Tính tiền điện / nước / phí</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/thong-bao" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #fae8ff, #f5d0fe); color: #c026d3;">
                                    <i class="fa-solid fa-bullhorn"></i>
                                </div>
                                <div class="quick-title">Gửi Thông Báo</div>
                                <div class="quick-sub">Đến sinh viên / toàn KTX</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/lich-su-phong" class="quick-action">
                                <div class="quick-icon" style="background: linear-gradient(135deg, #f1f5f9, #e2e8f0); color: #475569;">
                                    <i class="fa-solid fa-clock-rotate-left"></i>
                                </div>
                                <div class="quick-title">Lịch Sử Phòng</div>
                                <div class="quick-sub">Quá trình lưu trú</div>
                                <i class="fa-solid fa-arrow-right quick-arrow"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header d-flex align-items-center justify-content-between">
                    <h6 class="mb-0 fw-bold">
                        <i class="fa-solid fa-bell me-2 text-danger"></i> Cần xử lý ngay
                    </h6>
                    <span class="badge bg-danger-subtle text-danger">Ưu tiên</span>
                </div>
                <div class="card-body p-3 p-lg-4 d-flex flex-column gap-3">
                    <a href="${pageContext.request.contextPath}/hoadon" class="attention-item text-decoration-none">
                        <div class="attention-icon"><i class="fa-solid fa-file-invoice"></i></div>
                        <div class="flex-grow-1">
                            <div class="fw-semibold small text-dark">Hóa đơn quá hạn / Chưa thanh toán</div>
                            <div class="text-muted" style="font-size:0.78rem;">Tong no: ${tongCongNo} ₫</div>
                        </div>
                        <div class="attention-count">${hoaDonChuaThanhToan}</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/dangky" class="attention-item text-decoration-none" style="background:#eff6ff;border-color:#bfdbfe;">
                        <div class="attention-icon" style="background:#dbeafe;color:#2563eb;"><i class="fa-solid fa-user-plus"></i></div>
                        <div class="flex-grow-1">
                            <div class="fw-semibold small text-dark">Đăng ký phòng chờ duyệt</div>
                            <div class="text-muted" style="font-size:0.78rem;">Yêu cầu mới & Đổi phòng</div>
                        </div>
                        <div class="attention-count" style="color:#2563eb;">${dangKyChoDuyet}</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/suachua" class="attention-item text-decoration-none" style="background:#fffbeb;border-color:#fde68a;">
                        <div class="attention-icon" style="background:#fef3c7;color:#d97706;"><i class="fa-solid fa-wrench"></i></div>
                        <div class="flex-grow-1">
                            <div class="fw-semibold small text-dark">Yêu cầu sửa chữa mới</div>
                            <div class="text-muted" style="font-size:0.78rem;">Báo hỏng từ sinh viên</div>
                        </div>
                        <div class="attention-count" style="color:#d97706;">${yeuCauChoXuLy}</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
<% } %>

</div>

<style>
    .stat-card { transition: all 0.25s ease; }
    .stat-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); }
    .stat-card .stat-icon {
        width: 52px; height: 52px; border-radius: 14px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.35rem; flex-shrink: 0;
    }
    .stat-card .stat-bar { position: absolute; bottom: 0; left: 0; right: 0; height: 3px; opacity: 0.85; }

    .quick-action {
        display: block; padding: 18px 16px; border: 1.5px solid var(--border-soft);
        border-radius: 14px; text-decoration: none; color: inherit; position: relative;
        transition: all 0.22s ease; background: #fff;
    }
    .quick-action:hover {
        border-color: var(--primary); transform: translateY(-3px);
        box-shadow: 0 12px 28px rgba(99, 102, 241, 0.15); color: inherit;
    }
    .quick-action .quick-icon {
        width: 42px; height: 42px; border-radius: 12px;
        display: flex; align-items: center; justify-content: center; font-size: 1.1rem; margin-bottom: 10px;
    }
    .quick-action .quick-title { font-weight: 700; font-size: 0.88rem; color: #1e293b; margin-bottom: 2px; }
    .quick-action .quick-sub { font-size: 0.76rem; color: #64748b; }
    .quick-action .quick-arrow { position: absolute; top: 18px; right: 16px; color: #cbd5e1; font-size: 0.82rem; transition: all 0.22s ease; }
    .quick-action:hover .quick-arrow { color: var(--primary); transform: translateX(3px); }

    .attention-item {
        display: flex; align-items: center; gap: 14px; padding: 14px;
        background: #fef2f2; border-radius: 12px; border: 1px solid #fecaca; transition: all 0.2s;
    }
    .attention-item:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    .attention-item .attention-icon {
        width: 40px; height: 40px; border-radius: 10px; background: #fee2e2; color: var(--danger);
        display: flex; align-items: center; justify-content: center; font-size: 1rem; flex-shrink: 0;
    }
    .attention-item .attention-count { font-size: 1.3rem; font-weight: 800; color: var(--danger); min-width: 30px; text-align: right; }
</style>

<jsp:include page="/views/common/footer.jsp" />