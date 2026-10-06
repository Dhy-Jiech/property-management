<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khoanphi"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h3 class="mb-0">Danh Mục Khoản Phí & Dịch Vụ</h3>
        <div class="text-muted small">Quản lý đơn giá các dịch vụ ký túc xá (Điện, nước, internet, vệ sinh...)</div>
    </div>
    <a href="${pageContext.request.contextPath}/khoanphi?action=new" class="btn btn-primary btn-sm">
        <i class="ph ph-plus me-2"></i> Thêm Khoản Phí Mới
    </a>
</div>

<c:if test="${not empty param.message}">
    <div class="alert alert-success alert-dismissible fade show border py-2 px-3 mb-3" style="background:#F2F9F4; border-color:#C3E6CB !important; color:#1E7E34; font-size:13px; border-radius:4px;" role="alert">
        <i class="ph ph-check-circle me-2"></i>
        <c:choose>
            <c:when test="${param.message eq 'Saved'}">Lưu khoản phí thành công!</c:when>
            <c:when test="${param.message eq 'Deleted'}">Đã xóa khoản phí khỏi hệ thống.</c:when>
            <c:otherwise>Thao tác thành công!</c:otherwise>
        </c:choose>
        <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<div class="card mb-3">
    <div class="card-header d-flex align-items-center justify-content-between">
        <span>Danh Sách Khoản Phí</span>
        <span class="label-sm font-mono">Tổng số: ${khoanPhiList.size()}</span>
    </div>
    <div class="table-responsive">
        <table class="table align-middle">
            <thead>
                <tr>
                    <th style="width: 70px;">ID</th>
                    <th>Tên Khoản Phí</th>
                    <th style="width: 160px;">Đơn Giá</th>
                    <th style="width: 140px;">Đơn Vị Tính</th>
                    <th style="width: 140px;">Trạng Thái</th>
                    <th class="text-end" style="width: 120px;">Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="kp" items="${khoanPhiList}">
                    <tr>
                        <td class="font-mono text-muted">#${kp.id}</td>
                        <td class="fw-semibold">${kp.tenKhoanPhi}</td>
                        <td class="font-mono fw-semibold text-dark">
                            <fmt:formatNumber value="${kp.donGia}" maxFractionDigits="0" /> ₫
                        </td>
                        <td>
                            <span class="role-tag">${kp.donViTinh}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${kp.trangThai.name() eq 'HOAT_DONG'}">
                                    <span class="status-dot-wrapper">
                                        <span class="status-dot dot-active"></span>
                                        Hoạt động
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-dot-wrapper text-muted">
                                        <span class="status-dot dot-pending"></span>
                                        Tạm dừng
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/khoanphi?action=edit&id=${kp.id}" class="btn btn-sm btn-outline-secondary py-0 px-2" title="Chỉnh sửa">
                                <i class="ph ph-pencil-simple"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/khoanphi?action=delete&id=${kp.id}" class="btn btn-sm btn-outline-secondary py-0 px-2 text-danger" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa khoản phí này?');">
                                <i class="ph ph-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty khoanPhiList}">
                    <tr>
                        <td colspan="6" class="text-center text-muted py-4">Chưa có khoản phí nào được thiết lập.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
