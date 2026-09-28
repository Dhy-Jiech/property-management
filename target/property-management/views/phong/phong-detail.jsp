<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="isSV" value="${sessionScope.user.vaiTro eq 'SINH_VIEN'}" />
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phongcuatoi" />
</jsp:include>

<div class="animate-in">
    <a href="${pageContext.request.contextPath}/phong${isSV ? '?action=mine' : ''}" class="text-decoration-none small">
        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
    </a>

    <div class="d-flex flex-wrap justify-content-between align-items-center my-3 gap-2">
        <div>
            <h1 class="h3 fw-bold mb-1"><i class="fa-solid fa-door-open text-primary me-2"></i>${phong.tenPhong}</h1>
            <div class="text-muted small">
                Mã phòng: <strong>${phong.maPhong}</strong> ·
                <c:choose>
                    <c:when test="${not empty phong.tang}">
                        ${phong.tang.toa.khu.tenKhu} · ${phong.tang.toa.tenToa} · Tầng ${phong.tang.soTang}
                    </c:when>
                    <c:otherwise>Tầng ${phong.tangId}</c:otherwise>
                </c:choose>
            </div>
        </div>
        <c:if test="${phong.trangThai == 'BAO_TRI'}">
            <span class="badge bg-danger">Đang bảo trì</span>
        </c:if>
    </div>

    <div class="row g-3">
        <!-- Thông tin phòng -->
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header">Thông tin phòng</div>
                <div class="card-body small">
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <span class="text-muted">Loại phòng</span>
                        <strong>
                            <c:choose>
                                <c:when test="${phong.loaiPhong == '_4_NGUOI'}">4 người</c:when>
                                <c:when test="${phong.loaiPhong == '_6_NGUOI'}">6 người</c:when>
                                <c:when test="${phong.loaiPhong == '_8_NGUOI'}">8 người</c:when>
                                <c:otherwise>${phong.loaiPhong}</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <span class="text-muted">Sức chứa</span>
                        <strong>${phong.soNguoiHienTai} / ${phong.sucChua}</strong>
                    </div>
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <span class="text-muted">Giá thuê / tháng</span>
                        <strong class="text-success">
                            <fmt:formatNumber value="${phong.giaThang}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </strong>
                    </div>
                    <c:if test="${not empty hopDong}">
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span class="text-muted">Mã hợp đồng</span>
                            <a href="${pageContext.request.contextPath}/hopdong?action=view&id=${hopDong.id}">
                                <strong>${hopDong.maHopDong}</strong>
                            </a>
                        </div>
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span class="text-muted">Thời hạn</span>
                            <strong>${hopDong.ngayBatDau} → ${hopDong.ngayKetThuc}</strong>
                        </div>
                        <div class="d-flex justify-content-between py-2">
                            <span class="text-muted">Tiền đặt cọc</span>
                            <strong>
                                <fmt:formatNumber value="${hopDong.tienDatCoc}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </strong>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Bạn cùng phòng -->
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header">Người ở cùng phòng (${roommates.size()})</div>
                <ul class="list-group list-group-flush">
                    <c:forEach var="r" items="${roommates}">
                        <li class="list-group-item">
                            <div class="fw-semibold">${r.hoTen}</div>
                            <div class="small text-muted">${r.truong}</div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty roommates}">
                        <li class="list-group-item text-muted small">Chưa có ai ở phòng này.</li>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- Tài sản -->
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header">Tài sản trong phòng</div>
                <ul class="list-group list-group-flush">
                    <c:forEach var="a" items="${assets}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>${a.ten} <span class="text-muted small">× ${a.soLuong}</span></span>
                            <span class="badge ${a.tinhTrang == 'Tốt' ? 'bg-success' : 'bg-warning text-dark'}">${a.tinhTrang}</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty assets}">
                        <li class="list-group-item text-muted small">Chưa có tài sản nào.</li>
                    </c:if>
                </ul>
                <c:if test="${isSV}">
                    <div class="card-body border-top">
                        <a href="${pageContext.request.contextPath}/suachua" class="btn btn-outline-primary btn-sm w-100">
                            <i class="fa-solid fa-wrench me-1"></i>Báo hỏng / Sửa chữa
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />