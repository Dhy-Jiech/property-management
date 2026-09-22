<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/views/common/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1"><i class="fa-solid fa-bolt text-warning me-2"></i>Quản Lý Chỉ Số Điện & Nước</h3>
        <p class="text-muted small mb-0">Nhập chỉ số điện nước hàng tháng, tự động tính sản lượng tiêu thụ và thành tiền</p>
    </div>
    <a href="${pageContext.request.contextPath}/dien-nuoc?action=new" class="btn btn-warning text-dark fw-bold shadow-sm">
        <i class="fa-solid fa-plus me-2"></i>Nhập Chỉ Số Mới
    </a>
</div>

<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active fw-semibold" id="pills-dien-tab" data-bs-toggle="pill" data-bs-target="#pills-dien" type="button" role="tab">
            <i class="fa-solid fa-plug me-2 text-warning"></i>Chỉ Số Điện (kWh)
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link fw-semibold" id="pills-nuoc-tab" data-bs-toggle="pill" data-bs-target="#pills-nuoc" type="button" role="tab">
            <i class="fa-solid fa-droplet me-2 text-primary"></i>Chỉ Số Nước (m³)
        </button>
    </li>
</ul>

<div class="tab-content" id="pills-tabContent">
    <!-- Điện -->
    <div class="tab-pane fade show active" id="pills-dien" role="tabpanel">
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">Kỳ Tháng</th>
                                <th>Phòng</th>
                                <th>Chỉ Số Cũ</th>
                                <th>Chỉ Số Mới</th>
                                <th>Tiêu Thụ (kWh)</th>
                                <th>Đơn Giá</th>
                                <th class="text-end pe-4">Thành Tiền (VNĐ)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cd" items="${dienList}">
                                <tr>
                                    <td class="ps-4 fw-bold text-primary">${cd.kyThang}</td>
                                    <td class="fw-semibold">${cd.phong.tenPhong} (${cd.phong.maPhong})</td>
                                    <td>${cd.chiSoCu}</td>
                                    <td>${cd.chiSoMoi}</td>
                                    <td><span class="badge bg-warning text-dark">${cd.chiSoMoi - cd.chiSoCu} kWh</span></td>
                                    <td><fmt:formatNumber value="${cd.donGia}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                    <td class="text-end pe-4 fw-bold text-danger">
                                        <fmt:formatNumber value="${cd.tienDien}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty dienList}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">Chưa có chỉ số điện nào được ghi nhận.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Nước -->
    <div class="tab-pane fade" id="pills-nuoc" role="tabpanel">
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">Kỳ Tháng</th>
                                <th>Phòng</th>
                                <th>Chỉ Số Cũ</th>
                                <th>Chỉ Số Mới</th>
                                <th>Tiêu Thụ (m³)</th>
                                <th>Đơn Giá</th>
                                <th class="text-end pe-4">Thành Tiền (VNĐ)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cn" items="${nuocList}">
                                <tr>
                                    <td class="ps-4 fw-bold text-primary">${cn.kyThang}</td>
                                    <td class="fw-semibold">${cn.phong.tenPhong} (${cn.phong.maPhong})</td>
                                    <td>${cn.chiSoCu}</td>
                                    <td>${cn.chiSoMoi}</td>
                                    <td><span class="badge bg-info text-dark">${cn.chiSoMoi - cn.chiSoCu} m³</span></td>
                                    <td><fmt:formatNumber value="${cn.donGia}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                    <td class="text-end pe-4 fw-bold text-danger">
                                        <fmt:formatNumber value="${cn.tienNuoc}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty nuocList}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">Chưa có chỉ số nước nào được ghi nhận.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
