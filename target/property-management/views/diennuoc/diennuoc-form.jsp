<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="diennuoc" />
</jsp:include>

<div class="animate-in">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">

            <!-- Header with back button -->
            <div class="d-flex align-items-center mb-4 gap-3">
                <a href="${pageContext.request.contextPath}/dien-nuoc" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i>
                </a>
                <div>
                    <h1 class="h4 fw-bold mb-0" style="letter-spacing:-0.02em;">
                        Nhập Chỉ Số Điện & Nước
                    </h1>
                    <p class="text-muted small mb-0">Ghi nhận chỉ số cho một phòng trong kỳ tháng</p>
                </div>
            </div>

            <div class="card">
                <div class="card-body p-4 p-lg-5">
                    <form action="${pageContext.request.contextPath}/dien-nuoc" method="post">

                        <!-- Room & Period -->
                        <div class="form-section">
                            <div class="form-section-title">
                                <span class="step-number">1</span>
                                Thông tin kỳ ghi
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Chọn Phòng <span class="text-danger">*</span></label>
                                    <select name="phongId" class="form-select form-select-lg" required>
                                        <option value="">-- Chọn phòng --</option>
                                        <c:forEach var="p" items="${phongList}">
                                            <option value="${p.id}">${p.tenPhong} (${p.maPhong}) — ${p.trangThai}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Kỳ Tháng <span class="text-danger">*</span></label>
                                    <input type="month" name="kyThang" class="form-control form-control-lg" value="2026-09" required />
                                </div>
                            </div>
                        </div>

                        <!-- Điện Block -->
                        <div class="meter-block meter-electric">
                            <div class="meter-header">
                                <div class="meter-icon meter-icon-electric">
                                    <i class="fa-solid fa-bolt"></i>
                                </div>
                                <div>
                                    <div class="meter-title">Chỉ Số Điện</div>
                                    <div class="meter-sub">Đơn vị: kWh</div>
                                </div>
                            </div>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số cũ</label>
                                    <input type="number" name="chiSoDienCu" class="form-control" value="0" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số mới</label>
                                    <input type="number" name="chiSoDienMoi" class="form-control" placeholder="Nhập số mới" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Đơn giá (₫/kWh)</label>
                                    <input type="number" name="donGiaDien" class="form-control" value="3500" required />
                                </div>
                            </div>
                        </div>

                        <!-- Nước Block -->
                        <div class="meter-block meter-water">
                            <div class="meter-header">
                                <div class="meter-icon meter-icon-water">
                                    <i class="fa-solid fa-droplet"></i>
                                </div>
                                <div>
                                    <div class="meter-title">Chỉ Số Nước</div>
                                    <div class="meter-sub">Đơn vị: m³</div>
                                </div>
                            </div>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số cũ</label>
                                    <input type="number" name="chiSoNuocCu" class="form-control" value="0" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Chỉ số mới</label>
                                    <input type="number" name="chiSoNuocMoi" class="form-control" placeholder="Nhập số mới" required min="0" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Đơn giá (₫/m³)</label>
                                    <input type="number" name="donGiaNuoc" class="form-control" value="10000" required />
                                </div>
                            </div>
                        </div>

                        <!-- Action -->
                        <div class="d-flex gap-2 justify-content-end mt-4 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/dien-nuoc" class="btn btn-outline-secondary px-4">
                                Hủy
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fa-solid fa-floppy-disk me-2"></i>Lưu Chỉ Số & Tính Tiền
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .btn-back {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: #fff;
        border: 1px solid var(--border-soft);
        color: var(--text-muted);
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.18s ease;
        flex-shrink: 0;
    }
    .btn-back:hover {
        background: var(--primary);
        color: #fff;
        border-color: var(--primary);
        transform: translateX(-2px);
    }

    .form-section {
        margin-bottom: 28px;
    }
    .form-section-title {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 700;
        font-size: 0.95rem;
        margin-bottom: 14px;
        color: var(--text-main);
    }
    .step-number {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background: var(--primary);
        color: #fff;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 0.72rem;
        font-weight: 800;
    }

    /* Meter block */
    .meter-block {
        border-radius: 14px;
        padding: 20px;
        margin-bottom: 18px;
        border: 1.5px solid;
        position: relative;
    }
    .meter-electric {
        background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%);
        border-color: #fde68a;
    }
    .meter-water {
        background: linear-gradient(135deg, #ecfeff 0%, #cffafe 100%);
        border-color: #a5f3fc;
    }

    .meter-header {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 16px;
    }
    .meter-icon {
        width: 42px;
        height: 42px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
        color: #fff;
    }
    .meter-icon-electric {
        background: linear-gradient(135deg, #f59e0b, #d97706);
        box-shadow: 0 6px 14px rgba(245, 158, 11, 0.35);
    }
    .meter-icon-water {
        background: linear-gradient(135deg, #06b6d4, #0891b2);
        box-shadow: 0 6px 14px rgba(6, 182, 212, 0.35);
    }
    .meter-title {
        font-weight: 700;
        font-size: 0.95rem;
        color: #1e293b;
    }
    .meter-sub {
        font-size: 0.78rem;
        color: #64748b;
        margin-top: 1px;
    }

    .form-control, .form-select {
        border-radius: 10px;
        border: 1.5px solid var(--border-soft);
        font-size: 0.9rem;
        padding: 9px 14px;
        transition: all 0.18s ease;
    }
    .form-control:focus, .form-select:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
    }
    .form-select-lg, .form-control-lg {
        padding: 12px 16px;
        font-size: 0.95rem;
    }
</style>

<jsp:include page="/views/common/footer.jsp" />