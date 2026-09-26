<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khoanphi"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-1"><i class="fa-solid fa-tags text-primary me-2"></i>Quản Lý Khoản Phí</h4>
        <p class="text-muted small mb-0">Danh sách các khoản phí dịch vụ (Internet, vệ sinh...)</p>
    </div>
    <a href="${pageContext.request.contextPath}/khoan-phi?action=new" class="btn btn-primary">
        <i class="fa-solid fa-plus me-1"></i> Thêm Khoản Phí
    </a>
</div>

<c:if test="${not empty param.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i>
        <c:choose><c:when test="${param.message eq 'Saved'}">Lưu thành công!</c:when>
            <c:when test="${param.message eq 'Deleted'}">Đã xóa khoản phí.</c:when>
            <c:otherwise>Thao tác thành công!</c:otherwise></c:choose>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="card animate-in">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên khoản phí</th>
                        <th>Đơn giá</th>
                        <th>Đơn vị tính</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="kp" items="${khoanPhiList}" varStatus="st">
                        <tr>
                            <td>${st.count}</td>
                            <td class="fw-semibold">${kp.tenKhoanPhi}</td>
                            <td><span class="text-success fw-semibold">
                                <c:out value="${kp.donGia}"/> ₫
                            </span></td>
                            <td>${kp.donViTinh}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${kp.trangThai.name() eq 'HOAT_DONG'}">
                                        <span class="badge bg-success-subtle text-success">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary-subtle text-secondary">Tạm dừng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/khoan-phi?action=edit&id=${kp.id}"
                                   class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/khoan-phi?action=delete&id=${kp.id}"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Xóa khoản phí này?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty khoanPhiList}">
                        <tr><td colspan="6" class="text-center text-muted py-4">Chưa có khoản phí nào.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="/views/common/footer.jsp"/>
