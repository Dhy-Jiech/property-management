<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="dangky" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Tạo Đăng Ký / Đổi Phòng Mới</h2>
            <p class="text-muted small mb-0">Gửi nguyện vọng đăng ký chỗ ở hoặc yêu cầu chuyển đổi sang phòng mới.</p>
        </div>
        <a href="${pageContext.request.contextPath}/dangky" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/dangky" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Sinh Viên <span class="text-danger">*</span></label>
                        <select name="sinhVienId" class="form-select" required>
                            <c:forEach var="sv" items="${sinhVienList}">
                                <option value="${sv.id}">${sv.hoTen} (Mã SV: ${sv.id} - CCCD: ${sv.cccd})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Phòng Nguyện Vọng <span class="text-danger">*</span></label>
                        <select name="phongId" class="form-select" required>
                            <c:forEach var="p" items="${phongList}">
                                <option value="${p.id}">${p.maPhong} - ${p.tenPhong} (Còn trống: ${p.sucChua - p.soNguoiHienTai}/${p.sucChua})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Loại Yêu Cầu <span class="text-danger">*</span></label>
                        <select name="loaiYeuCau" class="form-select" required>
                            <option value="DANG_KY_MOI">Đăng Ký Khởi Tạo Mới</option>
                            <option value="CHUYEN_PHONG">Yêu Cầu Chuyển Đổi Phòng</option>
                            <option value="HUY_PHONG">Yêu Cầu Trả / Hủy Phòng</option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Lý Do / Ghi Chú Nguyện Vọng</label>
                        <textarea name="lyDo" class="form-control" rows="3" placeholder="Nhập chi tiết lý do muốn đổi phòng hoặc yêu cầu bổ sung..."></textarea>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/dangky" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-paper-plane me-1"></i> Gửi Đăng Ký
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
