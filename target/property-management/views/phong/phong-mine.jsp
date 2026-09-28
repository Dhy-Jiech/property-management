<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phongcuatoi" />
</jsp:include>

<div class="animate-in">
    <div class="mb-4">
        <h1 class="h3 fw-bold mb-1"><i class="fa-solid fa-house-user text-primary me-2"></i>Phòng Của Tôi</h1>
        <p class="text-muted small mb-0">Các phòng bạn đang có hợp đồng. Nhấn vào phòng để xem chi tiết.</p>
    </div>

    <c:if test="${empty contracts}">
        <div class="card"><div class="card-body text-center py-5 text-muted">
            <i class="fa-solid fa-folder-open fa-2x mb-3"></i>
            <div class="fw-bold">Bạn chưa thuê phòng nào</div>
            <a href="${pageContext.request.contextPath}/phong" class="btn btn-primary btn-sm mt-3">Xem phòng trống</a>
        </div></div>
    </c:if>

    <div class="row g-3">
        <c:forEach var="hd" items="${contracts}">
            <c:set var="p" value="${phongMap[hd.phongId]}" />
            <div class="col-md-6 col-xl-4">
                <a href="${pageContext.request.contextPath}/phong?action=detail&id=${hd.phongId}"
                   class="text-decoration-none">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-dark fs-6">${p.maPhong}</span>
                                <c:choose>
                                    <c:when test="${hd.trangThai == 'DANG_HIEU_LUC'}">
                                        <span class="badge bg-success">Đang thuê</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">Chờ ký / hiệu lực</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="fw-bold text-dark mb-1">${p.tenPhong}</div>
                            <div class="small text-muted mb-3">
                                <c:choose>
                                    <c:when test="${not empty p.tang}">
                                        ${p.tang.toa.khu.tenKhu} · ${p.tang.toa.tenToa} · Tầng ${p.tang.soTang}
                                    </c:when>
                                    <c:otherwise>Tầng ${p.tangId}</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="d-flex justify-content-between small">
                                <span class="text-muted">Hợp đồng</span>
                                <span class="fw-semibold text-dark">${hd.maHopDong}</span>
                            </div>
                            <div class="d-flex justify-content-between small">
                                <span class="text-muted">Thời hạn</span>
                                <span class="fw-semibold text-dark">${hd.ngayBatDau} → ${hd.ngayKetThuc}</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />