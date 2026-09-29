<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon" />
</jsp:include>

<c:set var="isSV" value="${sessionScope.user.vaiTro eq 'SINH_VIEN'}" />

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">
                ${isSV ? 'Hóa Đơn & Thanh Toán Của Phòng Tôi' : 'Quản Lý Hóa Đơn Theo Phòng'}
            </h2>
            <p class="text-muted small mb-0">
                ${isSV ? 'Hóa đơn tiền phòng, điện, nước và phí dịch vụ của phòng bạn đang ở.' : 'Hóa đơn hàng tháng của từng phòng.'}
            </p>
        </div>
        <c:if test="${!isSV}">
            <a href="${pageContext.request.contextPath}/hoadon?action=new" class="btn btn-primary">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Tạo Hóa Đơn Mới
            </a>
        </c:if>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3">Mã HĐ</th>
                            <th>Phòng</th>
                            <th>Kỳ</th>
                            <th class="text-end">Tiền phòng</th>
                            <th class="text-end">Tiền điện</th>
                            <th class="text-end">Tiền nước</th>
                            <th class="text-end">Phí dịch vụ</th>
                            <th class="text-end">Tổng tiền</th>
                            <th>Hạn TT</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="h" items="${hoaDonList}">
                            <tr>
                                <td class="ps-3 fw-bold text-primary"><c:out value="${h.maHoaDon}"/></td>
                                <td><c:out value="${h.phong}"/></td>
                                <td>${h.ky}</td>
                                <td class="text-end"><fmt:formatNumber value="${h.tienPhong}" maxFractionDigits="0"/></td>
                                <td class="text-end"><fmt:formatNumber value="${h.tienDien}" maxFractionDigits="0"/></td>
                                <td class="text-end"><fmt:formatNumber value="${h.tienNuoc}" maxFractionDigits="0"/></td>
                                <td class="text-end"><fmt:formatNumber value="${h.tongPhi}" maxFractionDigits="0"/></td>
                                <td class="text-end fw-bold text-danger"><fmt:formatNumber value="${h.tongTien}" maxFractionDigits="0"/> ₫</td>
                                <td>${h.han}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${h.trangThai == 'DA_THANH_TOAN'}"><span class="badge bg-success">Đã thanh toán</span></c:when>
                                        <c:when test="${h.trangThai == 'QUAN_HAN'}"><span class="badge bg-danger">Quá hạn</span></c:when>
                                        <c:otherwise><span class="badge bg-warning text-dark">Chưa thanh toán</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-3">
                                    <c:choose>
                                        <c:when test="${h.trangThai != 'DA_THANH_TOAN'}">
                                            <a href="${pageContext.request.contextPath}/hoadon?action=payDetail&id=${h.id}" class="btn btn-sm btn-outline-success">
                                                <i class="fa-solid fa-credit-card me-1"></i>Thanh toán & Chi tiết
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/hoadon?action=payDetail&id=${h.id}" class="btn btn-sm btn-outline-secondary">
                                                <i class="fa-solid fa-eye me-1"></i>Lịch sử GD
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty hoaDonList}">
                            <tr>
                                <td colspan="11" class="text-center py-4 text-muted">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>Chưa có hóa đơn nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />