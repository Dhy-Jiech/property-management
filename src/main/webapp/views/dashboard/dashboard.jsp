<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Dashboard Tổng Quan</h2>
            <p class="text-muted small">Chào mừng quay trở lại hệ thống quản lý ký túc xá.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/phong" class="btn btn-primary">
                <i class="fa-solid fa-plus me-1"></i> Quản lý phòng
            </a>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-6 col-xl-3">
            <div class="card card-stat bg-white p-3 border-start border-primary border-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Tổng số phòng</span>
                        <h3 class="fw-bold mb-0 text-primary mt-1">${tongSoPhong}</h3>
                    </div>
                    <div class="bg-primary bg-opacity-10 p-3 rounded-circle text-primary">
                        <i class="fa-solid fa-door-open fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-3">
            <div class="card card-stat bg-white p-3 border-start border-success border-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Phòng đang có người</span>
                        <h3 class="fw-bold mb-0 text-success mt-1">${phongDaCoNguoi}</h3>
                    </div>
                    <div class="bg-success bg-opacity-10 p-3 rounded-circle text-success">
                        <i class="fa-solid fa-user-check fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-3">
            <div class="card card-stat bg-white p-3 border-start border-info border-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Tổng sinh viên</span>
                        <h3 class="fw-bold mb-0 text-info mt-1">${tongSinhVien}</h3>
                    </div>
                    <div class="bg-info bg-opacity-10 p-3 rounded-circle text-info">
                        <i class="fa-solid fa-user-graduate fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-3">
            <div class="card card-stat bg-white p-3 border-start border-warning border-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Hợp đồng hiệu lực</span>
                        <h3 class="fw-bold mb-0 text-warning mt-1">${hopDongHieuLuc}</h3>
                    </div>
                    <div class="bg-warning bg-opacity-10 p-3 rounded-circle text-warning">
                        <i class="fa-solid fa-file-contract fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Shortcuts Card -->
    <div class="row">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="card-title fw-bold mb-0 text-dark"><i class="fa-solid fa-bolt me-2 text-warning"></i>Phím tắt thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/phong?action=new" class="btn btn-outline-primary w-100 p-3 text-start">
                                <i class="fa-solid fa-plus-circle fa-2x mb-2 d-block"></i>
                                <strong>Thêm phòng mới</strong>
                                <div class="small text-muted">Khu / Tòa / Tầng</div>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/sinhvien?action=new" class="btn btn-outline-success w-100 p-3 text-start">
                                <i class="fa-solid fa-user-plus fa-2x mb-2 d-block"></i>
                                <strong>Tiếp nhận Sinh viên</strong>
                                <div class="small text-muted">Tạo hồ sơ sinh viên</div>
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/hoadon?action=new" class="btn btn-outline-warning w-100 p-3 text-start">
                                <i class="fa-solid fa-receipt fa-2x mb-2 d-block"></i>
                                <strong>Tạo hóa đơn tháng</strong>
                                <div class="small text-muted">Tính tiền điện/nước</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="card-title fw-bold mb-0 text-dark"><i class="fa-solid fa-bell me-2 text-danger"></i>Cần chú ý</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between p-3 bg-light rounded mb-2">
                        <div>
                            <span class="fw-semibold">Hóa đơn chờ thanh toán</span>
                            <div class="small text-muted">Cần xác nhận hoặc nhắc nợ</div>
                        </div>
                        <span class="badge bg-danger fs-6">${hoaDonChuaThanhToan}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
