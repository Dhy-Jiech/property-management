<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khoanphi"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h3 class="mb-0">${pageTitle}</h3>
        <div class="text-muted small">Thiết lập chi tiết tên khoản phí, đơn giá và đơn vị tính</div>
    </div>
    <a href="${pageContext.request.contextPath}/khoanphi" class="btn btn-outline-secondary btn-sm">
        <i class="ph ph-arrow-left me-2"></i> Quay Lại Danh Sách
    </a>
</div>

<div class="card" style="max-width: 600px;">
    <div class="card-header">
        <i class="ph ph-tag me-2"></i>Thông Tin Khoản Phí
    </div>
    <div class="card-body p-3">
        <form method="post" action="${pageContext.request.contextPath}/khoanphi">
            <input type="hidden" name="action" value="${khoanPhi != null ? 'update' : 'insert'}"/>
            <c:if test="${khoanPhi != null}">
                <input type="hidden" name="id" value="${khoanPhi.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label">Tên Khoản Phí <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="tenKhoanPhi" required
                       value="${khoanPhi != null ? khoanPhi.tenKhoanPhi : ''}"
                       placeholder="Ví dụ: Tiền Internet, Vệ sinh, Gửi xe..."/>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-7">
                    <label class="form-label">Đơn Giá (₫) <span class="text-danger">*</span></label>
                    <div class="input-group input-group-sm">
                        <input type="number" class="form-control font-mono" name="donGia" required min="0" step="1000"
                               value="${khoanPhi != null ? khoanPhi.donGia : ''}"
                               placeholder="Ví dụ: 100000"/>
                        <span class="input-group-text font-mono" style="border-color: var(--border-color); background: var(--surface-subtle);">₫</span>
                    </div>
                </div>
                <div class="col-md-5">
                    <label class="form-label">Đơn Vị Tính</label>
                    <input type="text" class="form-control" name="donViTinh"
                           value="${khoanPhi != null ? khoanPhi.donViTinh : 'Tháng'}"
                           placeholder="Tháng / Người / Chiếc"/>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Trạng Thái</label>
                <select name="trangThai" class="form-select">
                    <option value="HOAT_DONG" ${(khoanPhi == null || khoanPhi.trangThai.name() eq 'HOAT_DONG') ? 'selected' : ''}>Hoạt động</option>
                    <option value="TAM_DUNG" ${(khoanPhi != null && khoanPhi.trangThai.name() eq 'TAM_DUNG') ? 'selected' : ''}>Tạm dừng</option>
                </select>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="ph ph-floppy-disk me-2"></i> Lưu Khoản Phí
                </button>
                <a href="${pageContext.request.contextPath}/khoanphi" class="btn btn-outline-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
