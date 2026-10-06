<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon"/>
</jsp:include>

<c:set var="isSV" value="${sessionScope.user.vaiTro eq 'SINH_VIEN'}" />

<div class="mb-4">
    <h4 class="fw-bold">
        <i class="fa-solid fa-file-invoice-dollar text-success me-2"></i>
        ${canPay ? 'Thanh Toán Hóa Đơn' : 'Chi Tiết Hóa Đơn'}: <c:out value="${hoaDon.maHoaDon}"/>
    </h4>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/hoadon">Hóa Đơn</a></li>
            <li class="breadcrumb-item active">${canPay ? 'Thanh Toán' : 'Chi Tiết'}</li>
        </ol>
    </nav>
</div>

<div class="row g-4">
    <!-- Thông tin tiền -->
    <div class="col-md-5">
        <div class="card animate-in h-100">
            <div class="card-header bg-light fw-bold">Thông Tin Hóa Đơn</div>
            <div class="card-body">
                <table class="table table-borderless table-sm mb-0">
                    <tr><td class="text-muted">Mã hóa đơn:</td><td class="fw-bold"><c:out value="${hoaDon.maHoaDon}"/></td></tr>
                    <c:if test="${not empty roomLabel}">
                        <tr><td class="text-muted">Phòng:</td><td><c:out value="${roomLabel}"/></td></tr>
                    </c:if>
                    <tr><td class="text-muted">Kỳ thanh toán:</td><td>${hoaDon.kyThanhToan}</td></tr>
                    <tr><td class="text-muted">Tiền phòng:</td><td><fmt:formatNumber value="${hoaDon.tienPhong}" maxFractionDigits="0"/> ₫</td></tr>
                    <tr><td class="text-muted">Tiền điện:</td><td><fmt:formatNumber value="${hoaDon.tienDien}" maxFractionDigits="0"/> ₫</td></tr>
                    <tr><td class="text-muted">Tiền nước:</td><td><fmt:formatNumber value="${hoaDon.tienNuoc}" maxFractionDigits="0"/> ₫</td></tr>
                    <c:forEach var="ct" items="${chiTietList}">
                        <tr>
                            <td class="text-muted ps-3">+ <c:out value="${ct.ten}"/></td>
                            <td><fmt:formatNumber value="${ct.thanhTien}" maxFractionDigits="0"/> ₫</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty chiTietList}">
                        <tr><td class="text-muted">Phí dịch vụ:</td><td><fmt:formatNumber value="${hoaDon.tongPhi}" maxFractionDigits="0"/> ₫</td></tr>
                    </c:if>
                    <tr class="border-top">
                        <td class="fw-bold fs-6">Tổng tiền:</td>
                        <td class="fw-bold text-danger fs-6"><fmt:formatNumber value="${hoaDon.tongTien}" maxFractionDigits="0"/> ₫</td>
                    </tr>
                    <tr><td class="text-muted">Hạn thanh toán:</td><td>${hoaDon.hanThanhToan}</td></tr>
                    <tr><td class="text-muted">Trạng thái:</td><td>
                        <c:choose>
                            <c:when test="${paid}"><span class="badge bg-success">Đã thanh toán</span></c:when>
                            <c:when test="${pendingCash}"><span class="badge bg-info text-dark">Chờ xác nhận tiền mặt</span></c:when>
                            <c:otherwise><span class="badge bg-warning text-dark">Chưa thanh toán</span></c:otherwise>
                        </c:choose>
                    </td></tr>
                </table>
            </div>
        </div>
    </div>

    <div class="col-md-7">

        <%-- ===== Sinh viên: form thanh toán ===== --%>
        <c:if test="${canPay}">
            <div class="card animate-in mb-4">
                <div class="card-header bg-primary text-white fw-bold">
                    <i class="fa-solid fa-credit-card me-2"></i>Thanh Toán
                </div>
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/hoadon">
                        <input type="hidden" name="action" value="recordPayment"/>
                        <input type="hidden" name="hoaDonId" value="${hoaDon.id}"/>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số tiền cần thanh toán</label>
                            <input type="text" class="form-control bg-light fw-bold text-danger" readonly
                                   value="<fmt:formatNumber value='${hoaDon.tongTien}' maxFractionDigits='0'/> ₫">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Phương thức thanh toán <span class="text-danger">*</span></label>
                            <select name="phuongThuc" id="phuongThuc" class="form-select" required onchange="togglePay()">
                                <option value="CHUYEN_KHOAN">Chuyển khoản / VietQR</option>
                                <option value="TIEN_MAT">Tiền mặt (nhân viên xác nhận)</option>
                            </select>
                        </div>

                        <div id="boxQR" class="text-center mb-3 p-3 border rounded bg-light">
                            <img src="${pageContext.request.contextPath}/assets/img/qr-thanhtoan.png"
                                 alt="QR thanh toán" style="max-width:260px;width:100%;">
                            <div class="small text-muted mt-2">
                                Quét mã để chuyển đúng số tiền. Nội dung chuyển khoản:
                                <strong><c:out value="${hoaDon.maHoaDon}"/></strong>
                            </div>
                        </div>

                        <div id="boxCash" class="alert alert-info d-none">
                            Sau khi gửi, bạn đưa tiền mặt cho nhân viên ký túc xá. Hóa đơn chỉ chuyển sang
                            <strong>Đã thanh toán</strong> khi nhân viên xác nhận đã nhận tiền.
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Mã giao dịch / Ghi chú</label>
                            <input type="text" class="form-control" name="maGiaoDich" maxlength="100"
                                   placeholder="Mã giao dịch ngân hàng (nếu có)"/>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" id="btnPay" class="btn btn-success">
                                <i class="fa-solid fa-check me-1"></i> <span id="btnPayText">Tôi đã chuyển khoản</span>
                            </button>
                            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary">Quay Lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <%-- ===== Sinh viên: đang chờ xác nhận tiền mặt ===== --%>
        <c:if test="${isSV and pendingCash}">
            <div class="alert alert-info animate-in">
                <i class="fa-solid fa-hourglass-half me-2"></i>
                Bạn đã chọn thanh toán tiền mặt. Đang chờ nhân viên xác nhận đã nhận tiền.
            </div>
        </c:if>

        <%-- ===== Nhân sự: xác nhận thu tiền mặt ===== --%>
        <c:if test="${canConfirmCash}">
            <div class="alert alert-warning animate-in d-flex justify-content-between align-items-center">
                <div>
                    <i class="fa-solid fa-hand-holding-dollar me-2"></i>
                    Sinh viên đã chọn <strong>thanh toán tiền mặt</strong>. Xác nhận sau khi đã nhận đủ tiền.
                </div>
                <form method="post" action="${pageContext.request.contextPath}/hoadon" class="ms-3"
                      onsubmit="return confirm('Xác nhận đã thu đủ tiền mặt cho hóa đơn này?');">
                    <input type="hidden" name="action" value="confirmCash"/>
                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}"/>
                    <button type="submit" class="btn btn-success btn-sm text-nowrap">
                        <i class="fa-solid fa-check me-1"></i> Xác nhận đã thu tiền mặt
                    </button>
                </form>
            </div>
        </c:if>

        <%-- ===== Thông tin giao dịch ===== --%>
        <div class="card animate-in">
            <div class="card-header bg-light fw-bold">Thông Tin Thanh Toán</div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-sm table-hover mb-0 align-middle">
                        <thead>
                            <tr>
                                <th>Người gửi</th>
                                <th>ID người gửi</th>
                                <th>Phương thức</th>
                                <th>Ngày GD</th>
                                <th>Mã GD</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tt" items="${thanhToanList}">
                                <tr>
                                    <td class="fw-semibold"><c:out value="${empty tt.nguoiGui ? '--' : tt.nguoiGui}"/></td>
                                    <td>${tt.nguoiGuiId != null ? tt.nguoiGuiId : '--'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${tt.phuongThuc == 'TIEN_MAT'}"><span class="badge bg-secondary-subtle text-secondary-emphasis">Tiền mặt</span></c:when>
                                            <c:otherwise><span class="badge bg-primary-subtle text-primary-emphasis">Chuyển khoản</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small text-muted">${tt.thoiGian}</td>
                                    <td class="small"><c:out value="${empty tt.maGiaoDich ? '--' : tt.maGiaoDich}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${tt.trangThai == 'CHO_XAC_NHAN'}"><span class="badge bg-info text-dark">Chờ xác nhận</span></c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">Đã xác nhận</span>
                                                <c:if test="${not empty tt.nguoiXacNhan}">
                                                    <div class="small text-muted">bởi <c:out value="${tt.nguoiXacNhan}"/></div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty thanhToanList}">
                                <tr><td colspan="6" class="text-center text-muted py-3">Chưa có giao dịch thanh toán nào.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <c:if test="${!canPay}">
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary mt-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay Lại
            </a>
        </c:if>
    </div>
</div>

<c:if test="${canPay}">
<script>
function togglePay() {
    const cash = document.getElementById('phuongThuc').value === 'TIEN_MAT';
    document.getElementById('boxQR').classList.toggle('d-none', cash);
    document.getElementById('boxCash').classList.toggle('d-none', !cash);
    document.getElementById('btnPayText').textContent = cash ? 'Gửi yêu cầu thanh toán tiền mặt' : 'Tôi đã chuyển khoản';
}
togglePay();
</script>
</c:if>

<jsp:include page="/views/common/footer.jsp"/>