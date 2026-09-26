<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phong" />
</jsp:include>

<div class="animate-in">
    <div class="row justify-content-center">
        <div class="col-lg-9 col-xl-8">

            <!-- Header -->
            <div class="d-flex align-items-center mb-4 gap-3">
                <a href="${pageContext.request.contextPath}/phong" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i>
                </a>
                <div>
                    <h1 class="h4 fw-bold mb-0" style="letter-spacing:-0.02em;">
                        <c:choose>
                            <c:when test="${not empty phong && phong.id > 0}">Sửa Thông Tin Phòng</c:when>
                            <c:otherwise>Thêm Phòng Mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="text-muted small mb-0">Nhập thông số kỹ thuật và loại phòng</p>
                </div>
            </div>

            <div class="card">
                <div class="card-body p-4 p-lg-5">
                    <form action="${pageContext.request.contextPath}/phong" method="post">
                        <input type="hidden" name="action" value="${not empty phong && phong.id > 0 ? 'update' : 'insert'}">
                        <c:if test="${not empty phong && phong.id > 0}">
                            <input type="hidden" name="id" value="${phong.id}">
                        </c:if>

                        <!-- Section 1: Vị trí -->
                        <div class="form-section">
                            <div class="form-section-title">
                                <span class="section-icon section-icon-location"><i class="fa-solid fa-location-dot"></i></span>
                                Vị trí & Định danh
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Vị Trí Tầng <span class="text-danger">*</span></label>
                                    <c:choose>
                                        <c:when test="${not empty listTang}">
                                            <select name="tangId" class="form-select" required>
                                                <c:forEach var="t" items="${listTang}">
                                                    <option value="${t.id}" ${not empty phong && phong.tangId == t.id ? 'selected' : ''}>
                                                        ${t.toa.khu.tenKhu} → ${t.toa.tenToa} → ${t.tenTang}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="number" name="tangId" class="form-control" value="${not empty phong ? phong.tangId : '1'}" required placeholder="ID Tầng (vd: 1)">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Mã Phòng <span class="text-danger">*</span></label>
                                    <input type="text" name="maPhong" class="form-control" value="${phong.maPhong}"
                                           ${not empty phong && phong.id > 0 ? 'readonly' : 'required'}
                                           placeholder="Ví dụ: P101, P202...">
                                    <c:if test="${not empty phong && phong.id > 0}">
                                        <div class="form-hint"><i class="fa-solid fa-lock"></i> Mã phòng không thể sửa</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Section 2: Thông tin phòng -->
                        <div class="form-section">
                            <div class="form-section-title">
                                <span class="section-icon section-icon-info"><i class="fa-solid fa-circle-info"></i></span>
                                Thông tin phòng
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Tên Phòng <span class="text-danger">*</span></label>
                                    <input type="text" name="tenPhong" class="form-control" value="${phong.tenPhong}" required placeholder="Ví dụ: Phòng A1-101">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Loại Phòng <span class="text-danger">*</span></label>
                                    <select name="loaiPhong" class="form-select" required>
                                        <option value="_4_NGUOI" ${phong.loaiPhong == '_4_NGUOI' ? 'selected' : ''}>Phòng 4 Người</option>
                                        <option value="_6_NGUOI" ${phong.loaiPhong == '_6_NGUOI' ? 'selected' : ''}>Phòng 6 Người</option>
                                        <option value="_8_NGUOI" ${phong.loaiPhong == '_8_NGUOI' ? 'selected' : ''}>Phòng 8 Người</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Giá Thuê (₫/tháng) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">₫</span>
                                        <input type="number" name="giaThang" step="10000" class="form-control"
                                               value="${not empty phong ? phong.giaThang : '1500000'}" required
                                               placeholder="Nhập giá phòng/tháng">
                                    </div>
                                </div>

                                <c:if test="${not empty phong && phong.id > 0}">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Trạng Thái</label>
                                        <select name="trangThai" class="form-select">
                                            <option value="TRONG" ${phong.trangThai == 'TRONG' ? 'selected' : ''}>Trống</option>
                                            <option value="DANG_DAT_COC" ${phong.trangThai == 'DANG_DAT_COC' ? 'selected' : ''}>Đang Đặt Cọc</option>
                                            <option value="DANG_CHO_THUE" ${phong.trangThai == 'DANG_CHO_THUE' ? 'selected' : ''}>Đang Cho Thuê</option>
                                            <option value="BAO_TRI" ${phong.trangThai == 'BAO_TRI' ? 'selected' : ''}>Bảo Trì</option>
                                        </select>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="d-flex gap-2 justify-content-end mt-4 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/phong" class="btn btn-outline-secondary px-4">Hủy</a>
                            <button type="submit" class="btn ${not empty phong && phong.id > 0 ? 'btn-warning text-dark' : 'btn-primary'} px-4">
                                <i class="fa-solid fa-floppy-disk me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty phong && phong.id > 0}">Cập Nhật</c:when>
                                    <c:otherwise>Tạo Phòng</c:otherwise>
                                </c:choose>
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
        width: 40px; height: 40px;
        border-radius: 10px;
        background: #fff;
        border: 1px solid var(--border-soft);
        color: var(--text-muted);
        display: flex; align-items: center; justify-content: center;
        text-decoration: none;
        transition: all 0.18s ease;
        flex-shrink: 0;
    }
    .btn-back:hover {
        background: var(--primary); color: #fff;
        border-color: var(--primary);
        transform: translateX(-2px);
    }

    .form-section {
        padding-bottom: 22px;
        margin-bottom: 22px;
        border-bottom: 1px dashed #e2e8f0;
    }
    .form-section:last-of-type {
        border-bottom: none;
        padding-bottom: 0;
        margin-bottom: 0;
    }
    .form-section-title {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 700;
        font-size: 0.95rem;
        margin-bottom: 16px;
        color: var(--text-main);
    }
    .section-icon {
        width: 30px; height: 30px;
        border-radius: 9px;
        display: inline-flex;
        align-items: center; justify-content: center;
        font-size: 0.82rem;
    }
    .section-icon-location {
        background: var(--primary-soft);
        color: var(--primary);
    }
    .section-icon-info {
        background: #d1fae5;
        color: var(--success);
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
    .form-control[readonly] {
        background: #f8fafc;
        cursor: not-allowed;
    }

    .form-hint {
        font-size: 0.75rem;
        color: var(--text-muted);
        margin-top: 5px;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .input-group-text {
        border-radius: 10px 0 0 10px;
        border: 1.5px solid var(--border-soft);
        border-right: none;
        background: #f8fafc;
        font-weight: 600;
        color: var(--text-muted);
    }
    .input-group .form-control {
        border-radius: 0 10px 10px 0;
    }
</style>

<jsp:include page="/views/common/footer.jsp" />