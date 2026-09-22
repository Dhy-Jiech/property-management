<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp" />

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="d-flex align-items-center mb-4">
            <a href="${pageContext.request.contextPath}/dien-nuoc" class="btn btn-outline-secondary btn-sm me-3">
                <i class="fa-solid fa-arrow-left"></i> Quay lại
            </a>
            <h4 class="fw-bold mb-0"><i class="fa-solid fa-calculator text-warning me-2"></i>Nhập Chỉ Số Điện & Nước Theo Phòng</h4>
        </div>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/dien-nuoc" method="post">
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Chọn Phòng <span class="text-danger">*</span></label>
                            <select name="phongId" class="form-select" required>
                                <option value="">-- Chọn phòng --</option>
                                <c:forEach var="p" items="${phongList}">
                                    <option value="${p.id}">${p.tenPhong} (${p.maPhong}) - ${p.trangThai}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Kỳ Tháng (Tháng / Năm) <span class="text-danger">*</span></label>
                            <input type="month" name="kyThang" class="form-control" value="2026-09" required />
                        </div>
                    </div>

                    <!-- Điện Block -->
                    <div class="card bg-warning-subtle border-warning-subtle mb-4">
                        <div class="card-body p-3">
                            <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-bolt me-2 text-warning"></i>Chỉ Số Điện (kWh)</h6>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số cũ</label>
                                    <input type="number" name="chiSoDienCu" class="form-control" value="0" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số mới</label>
                                    <input type="number" name="chiSoDienMoi" class="form-control" placeholder="Nhập chỉ số mới" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Đơn giá (VNĐ/kWh)</label>
                                    <input type="number" name="donGiaDien" class="form-control" value="3500" required />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Nước Block -->
                    <div class="card bg-info-subtle border-info-subtle mb-4">
                        <div class="card-body p-3">
                            <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-droplet me-2 text-primary"></i>Chỉ Số Nước (m³)</h6>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số cũ</label>
                                    <input type="number" name="chiSoNuocCu" class="form-control" value="0" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số mới</label>
                                    <input type="number" name="chiSoNuocMoi" class="form-control" placeholder="Nhập chỉ số mới" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Đơn giá (VNĐ/m³)</label>
                                    <input type="number" name="donGiaNuoc" class="form-control" value="10000" required />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-warning text-dark py-2 fw-bold shadow-sm">
                            <i class="fa-solid fa-floppy-disk me-2"></i>Lưu Chỉ Số & Tính Tiền
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
