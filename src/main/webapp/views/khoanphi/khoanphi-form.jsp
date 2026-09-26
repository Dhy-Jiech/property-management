<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khoanphi"/>
</jsp:include>

<div class="mb-4">
    <h4 class="fw-bold"><i class="fa-solid fa-tags text-primary me-2"></i>${pageTitle}</h4>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/khoan-phi">Khoản Phí</a></li>
            <li class="breadcrumb-item active">${khoanPhi != null ? 'Cập nhật' : 'Thêm mới'}</li>
        </ol>
    </nav>
</div>

<div class="card animate-in" style="max-width:600px;">
    <div class="card-body p-4">
        <form method="post" action="${pageContext.request.contextPath}/khoan-phi">
            <input type="hidden" name="action" value="${khoanPhi != null ? 'update' : 'insert'}"/>
            <c:if test="${khoanPhi != null}">
                <input type="hidden" name="id" value="${khoanPhi.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold">Tên khoản phí <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="tenKhoanPhi" required
                       value="${khoanPhi != null ? khoanPhi.tenKhoanPhi : ''}"
                       placeholder="Ví dụ: Internet, Vệ sinh..."/>
            </div>
            <div class="row g-3 mb-3">
                <div class="col-md-7">
                    <label class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" name="donGia" required min="0"
                           value="${khoanPhi != null ? khoanPhi.donGia : ''}"/>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-semibold">Đơn vị tính</label>
                    <input type="text" class="form-control" name="donViTinh"
                           value="${khoanPhi != null ? khoanPhi.donViTinh : 'Tháng'}"
                           placeholder="Tháng / Người / Lần"/>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Trạng thái</label>
                <select name="trangThai" class="form-select">
                    <option value="HOAT_DONG" ${(khoanPhi == null || khoanPhi.trangThai.name() eq 'HOAT_DONG') ? 'selected' : ''}>Hoạt động</option>
                    <option value="TAM_DUNG" ${(khoanPhi != null && khoanPhi.trangThai.name() eq 'TAM_DUNG') ? 'selected' : ''}>Tạm dừng</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fa-solid fa-floppy-disk me-1"></i> Lưu
                </button>
                <a href="${pageContext.request.contextPath}/khoan-phi" class="btn btn-outline-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/views/common/footer.jsp"/>
