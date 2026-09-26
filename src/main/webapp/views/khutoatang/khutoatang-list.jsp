<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khutoatang"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-1"><i class="fa-solid fa-building text-primary me-2"></i>Cấu Trúc Tòa Nhà (Khu / Tòa / Tầng)</h4>
        <p class="text-muted small mb-0">Quản lý khu nhà, các tòa nhà và tầng phòng trong ký túc xá</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/khu?action=newKhu" class="btn btn-outline-primary btn-sm">
            <i class="fa-solid fa-plus me-1"></i> Thêm Khu
        </a>
        <a href="${pageContext.request.contextPath}/khu?action=newToa" class="btn btn-outline-success btn-sm">
            <i class="fa-solid fa-plus me-1"></i> Thêm Tòa
        </a>
        <a href="${pageContext.request.contextPath}/khu?action=newTang" class="btn btn-outline-info btn-sm">
            <i class="fa-solid fa-plus me-1"></i> Thêm Tầng
        </a>
    </div>
</div>

<c:if test="${not empty param.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i>
        <c:choose>
            <c:when test="${param.message eq 'Saved'}">Cập nhật thành công!</c:when>
            <c:when test="${param.message eq 'Deleted'}">Đã xóa thành công!</c:when>
            <c:otherwise>Thao tác thành công!</c:otherwise>
        </c:choose>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row g-4">
    <!-- Danh sách Khu -->
    <div class="col-md-4">
        <div class="card h-100 animate-in">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span class="fw-bold text-primary"><i class="fa-solid fa-cubes me-2"></i>Danh Sách Khu</span>
                <a href="${pageContext.request.contextPath}/khu?action=newKhu" class="btn btn-xs btn-primary"><i class="fa-solid fa-plus"></i></a>
            </div>
            <div class="card-body p-0">
                <ul class="list-group list-group-flush">
                    <c:forEach var="k" items="${khuList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>${k.tenKhu}</strong>
                                <span class="badge bg-secondary-subtle text-secondary ms-1">${k.maKhu}</span>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/khu?action=editKhu&id=${k.id}" class="text-primary me-2"><i class="fa-solid fa-pen"></i></a>
                                <a href="${pageContext.request.contextPath}/khu?action=deleteKhu&id=${k.id}" class="text-danger" onclick="return confirm('Xóa khu này?')"><i class="fa-solid fa-trash"></i></a>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty khuList}">
                        <li class="list-group-item text-muted text-center py-3">Chưa có khu nào.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <!-- Danh sách Tòa -->
    <div class="col-md-4">
        <div class="card h-100 animate-in">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span class="fw-bold text-success"><i class="fa-solid fa-building me-2"></i>Danh Sách Tòa</span>
                <a href="${pageContext.request.contextPath}/khu?action=newToa" class="btn btn-xs btn-success text-white"><i class="fa-solid fa-plus"></i></a>
            </div>
            <div class="card-body p-0">
                <ul class="list-group list-group-flush">
                    <c:forEach var="t" items="${toaList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>${t.tenToa}</strong>
                                <small class="text-muted d-block">Mã: ${t.maToa} | Khu: ${t.khu != null ? t.khu.tenKhu : t.khuId}</small>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/khu?action=editToa&id=${t.id}" class="text-primary me-2"><i class="fa-solid fa-pen"></i></a>
                                <a href="${pageContext.request.contextPath}/khu?action=deleteToa&id=${t.id}" class="text-danger" onclick="return confirm('Xóa tòa này?')"><i class="fa-solid fa-trash"></i></a>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty toaList}">
                        <li class="list-group-item text-muted text-center py-3">Chưa có tòa nào.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <!-- Danh sách Tầng -->
    <div class="col-md-4">
        <div class="card h-100 animate-in">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span class="fw-bold text-info"><i class="fa-solid fa-layer-group me-2"></i>Danh Sách Tầng</span>
                <a href="${pageContext.request.contextPath}/khu?action=newTang" class="btn btn-xs btn-info text-white"><i class="fa-solid fa-plus"></i></a>
            </div>
            <div class="card-body p-0">
                <ul class="list-group list-group-flush">
                    <c:forEach var="tg" items="${tangList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>${tg.tenTang}</strong>
                                <small class="text-muted d-block">Tòa: ${tg.toa != null ? tg.toa.tenToa : tg.toaId}</small>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/khu?action=editTang&id=${tg.id}" class="text-primary me-2"><i class="fa-solid fa-pen"></i></a>
                                <a href="${pageContext.request.contextPath}/khu?action=deleteTang&id=${tg.id}" class="text-danger" onclick="return confirm('Xóa tầng này?')"><i class="fa-solid fa-trash"></i></a>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty tangList}">
                        <li class="list-group-item text-muted text-center py-3">Chưa có tầng nào.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
