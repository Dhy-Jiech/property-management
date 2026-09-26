<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon"/>
</jsp:include>

<div class="mb-4">
    <h4 class="fw-bold"><i class="fa-solid fa-file-invoice-dollar text-success me-2"></i>Thanh Toán Hóa Đơn: ${hoaDon.maHoaDon}</h4>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/hoadon">Hóa Đơn</a></li>
            <li class="breadcrumb-item active">Ghi Nhận Thanh Toán</li>
        </ol>
    </nav>
</div>

<div class="row g-4">
    <!-- Thông tin hóa đơn -->
    <div class="col-md-5">
        <div class="card animate-in h-100">
            <div class="card-header bg-light fw-bold">Chi Tiết Hóa Đơn</div>
            <div class="card-body">
                <table class="table table-borderless table-sm mb-0">
                    <tr><td class="text-muted">Mã hóa đơn:</td><td class="fw-bold">${hoaDon.maHoaDon}</td></tr>
                    <tr><td class="text-muted">Kỳ thanh toán:</td><td>${hoaDon.kyThanhToan}</td></tr>
                    <tr><td class="text-muted">Tiền phòng:</td><td>${hoaDon.tienPhong} ₫</td></tr>
                    <tr><td class="text-muted">Tiền điện:</td><td>${hoaDon.tienDien} ₫</td></tr>
                    <tr><td class="text-muted">Tiền nước:</td><td>${hoaDon.tienNuoc} ₫</td></tr>
                    <tr><td class="text-muted">Phí dịch vụ:</td><td>${hoaDon.tongPhi} ₫</td></tr>
                    <tr class="border-top"><td class="fw-bold fs-6">Tổng tiền:</td><td class="fw-bold text-danger fs-6">${hoaDon.tongTien} ₫</td></tr>
                    <tr><td class="text-muted">Hạn thanh toán:</td><td>${hoaDon.hanThanhToan}</td></tr>
                    <tr><td class="text-muted">Trạng thái:</td><td>
                        <c:choose>
                            <c:when test="${hoaDon.trangThai.name() eq 'DA_THANH_TOAN'}">
                                <span class="badge bg-success-subtle text-success">Đã thanh toán</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning-subtle text-warning">Chưa thanh toán</span>
                            </c:otherwise>
                        </c:choose>
                    </td></tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Form ghi nhận & Lịch sử giao dịch -->
    <div class="col-md-7">
        <div class="card animate-in mb-4">
            <div class="card-header bg-primary text-white fw-bold"><i class="fa-solid fa-credit-card me-2"></i>Ghi Nhận Giao Dịch Thanh Toán</div>
            <div class="card-body p-4">
                <form method="post" action="${pageContext.request.contextPath}/hoadon">
                    <input type="hidden" name="action" value="recordPayment"/>
                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}"/>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số tiền thanh toán (VNĐ) <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="soTien" required value="${hoaDon.tongTien}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Phương thức thanh toán <span class="text-danger">*</span></label>
                        <select name="phuongThuc" class="form-select" required>
                            <option value="TIEN_MAT">Tiền mặt</option>
                            <option value="CHUYEN_KHOAN">Chuyển khoản / VNPAY / Momo</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mã giao dịch / Ghi chú</label>
                        <input type="text" class="form-control" name="maGiaoDich" placeholder="Mã giao dịch ngân hàng (nếu có)"/>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success"><i class="fa-solid fa-check me-1"></i> Xác Nhận Thanh Toán</button>
                        <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary">Quay Lại</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Lịch sử giao dịch của hóa đơn này -->
        <div class="card animate-in">
            <div class="card-header bg-light fw-bold">Lịch Sử Ghi Nhận Thanh Toán</div>
            <div class="card-body p-0">
                <table class="table table-sm table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Thời gian</th>
                            <th>Số tiền</th>
                            <th>Phương thức</th>
                            <th>Mã GD</th>
                            <th>Người xác nhận</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tt" items="${thanhToanList}">
                            <tr>
                                <td class="small text-muted">${tt.thoiGian}</td>
                                <td class="fw-semibold text-success">${tt.soTien} ₫</td>
                                <td><span class="badge bg-secondary-subtle text-secondary">${tt.phuongThuc}</span></td>
                                <td class="small">${tt.maGiaoDich != null ? tt.maGiaoDich : '--'}</td>
                                <td class="small fw-semibold">${tt.nguoiXacNhan}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty thanhToanList}">
                            <tr><td colspan="5" class="text-center text-muted py-3">Chưa có giao dịch thanh toán nào được ghi nhận.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
