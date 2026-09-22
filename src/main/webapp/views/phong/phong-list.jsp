<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phong" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Phòng Ở</h2>
            <p class="text-muted small mb-0">Danh sách tất cả các phòng thuộc hệ thống ký túc xá.</p>
        </div>
        <a href="${pageContext.request.contextPath}/phong?action=new" class="btn btn-primary">
            <i class="fa-solid fa-plus me-1"></i> Thêm Phòng Mới
        </a>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3 text-center">STT</th>
                            <th>Mã Phòng</th>
                            <th>Tên Phòng</th>
                            <th>Vị trí (Khu/Tòa/Tầng)</th>
                            <th class="text-center">Loại Phòng</th>
                            <th class="text-center">Số Người</th>
                            <th class="text-end">Giá Thuê (VNĐ/Tháng)</th>
                            <th class="text-center">Trạng Thái</th>
                            <th class="text-end pe-3">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${listPhong}" varStatus="loop">
                            <tr>
                                <td class="ps-3 text-center fw-bold text-secondary">${loop.index + 1}</td>
                                <td><span class="badge bg-secondary fs-6">${p.maPhong}</span></td>
                                <td class="fw-semibold text-primary">${p.tenPhong}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.tang}">
                                            ${p.tang.toa.khu.tenKhu} - ${p.tang.toa.tenToa} - Tầng ${p.tang.soTang}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Mã tầng: ${p.tangId}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-info text-dark">
                                        <c:choose>
                                            <c:when test="${p.loaiPhong == '_4_NGUOI'}">4 Người</c:when>
                                            <c:when test="${p.loaiPhong == '_6_NGUOI'}">6 Người</c:when>
                                            <c:when test="${p.loaiPhong == '_8_NGUOI'}">8 Người</c:when>
                                            <c:otherwise>${p.loaiPhong}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="fw-bold ${p.soNguoiHienTai >= p.sucChua ? 'text-danger' : 'text-success'}">
                                        ${p.soNguoiHienTai}
                                    </span> / ${p.sucChua}
                                </td>
                                <td class="text-end fw-bold text-success">
                                    <fmt:formatNumber value="${p.giaThang}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.trangThai == 'TRONG'}">
                                            <span class="badge bg-success">Trống</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'DANG_DAT_COC'}">
                                            <span class="badge bg-warning text-dark">Đang Đặt Cọc</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'DANG_CHO_THUE'}">
                                            <span class="badge bg-primary">Đang Cho Thuê</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'BAO_TRI'}">
                                            <span class="badge bg-danger">Bảo Trì</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-3">
                                    <a href="${pageContext.request.contextPath}/phong?action=edit&id=${p.id}" 
                                       class="btn btn-sm btn-outline-warning me-1" title="Sửa">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/phong?action=delete&id=${p.id}" 
                                       class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa phòng [${p.maPhong}] không?');" title="Xóa">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty listPhong}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                    Chưa có phòng nào trong cơ sở dữ liệu.
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