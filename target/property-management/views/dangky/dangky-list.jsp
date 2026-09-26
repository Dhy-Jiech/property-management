<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="dangky" />
</jsp:include>

<%
    TaiKhoan u = (TaiKhoan) session.getAttribute("user");
    boolean isSinhVien = (u != null && u.getVaiTro() == VaiTro.SINH_VIEN);
%>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">
                <%= isSinhVien ? "Đăng Ký & Đổi Phòng Của Tôi" : "Quản Lý Đăng Ký & Đổi Phòng" %>
            </h2>
            <p class="text-muted small mb-0">
                <%= isSinhVien ? "Theo dõi các đơn đăng ký ở ký túc xá và yêu cầu chuyển đổi phòng của bạn." : "Danh sách các đơn đăng ký nguyện vọng phòng ở và yêu cầu chuyển đổi phòng." %>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/dangky?action=new" class="btn btn-primary">
            <i class="fa-solid fa-plus me-1"></i> Tạo Đăng Ký / Đổi Phòng Mới
        </a>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3 text-center">STT</th>
                            <th>Sinh Viên (ID)</th>
                            <th>Phòng Đăng Ký (ID)</th>
                            <th>Loại Yêu Cầu</th>
                            <th>Lý Do / Ghi Chú</th>
                            <th class="text-center">Trạng Thái</th>
                            <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                <th class="text-end pe-3">Phê Duyệt Admin</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${dangKyList}" varStatus="loop">
                            <tr>
                                <td class="ps-3 text-center fw-bold text-secondary">${loop.index + 1}</td>
                                <td><span class="badge bg-secondary fs-6">SV #${d.sinhVienId}</span></td>
                                <td><span class="badge bg-info text-dark fs-6">Phòng #${d.phongId}</span></td>
                                <td>
                                    <span class="badge bg-primary">
                                        <c:choose>
                                            <c:when test="${d.loaiYeuCau == 'DANG_KY_MOI'}">Đăng Ký Mới</c:when>
                                            <c:when test="${d.loaiYeuCau == 'DOI_PHONG'}">Chuyển Đổi Phòng</c:when>
                                            <c:when test="${d.loaiYeuCau == 'TRA_PHONG'}">Trả Phòng</c:when>
                                            <c:otherwise>${d.loaiYeuCau}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>${not empty d.lyDo ? d.lyDo : '-'}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${d.trangThai == 'CHO_DUYET'}">
                                            <span class="badge bg-warning text-dark">Chờ Duyệt</span>
                                        </c:when>
                                        <c:when test="${d.trangThai == 'DA_DUYET'}">
                                            <span class="badge bg-success">Đã Duyệt</span>
                                        </c:when>
                                        <c:when test="${d.trangThai == 'TU_CHOI'}">
                                            <span class="badge bg-danger">Từ Chối</span>
                                        </c:when>
                                        <c:when test="${d.trangThai == 'DA_HUY'}">
                                            <span class="badge bg-secondary">Đã Hủy</span>
                                        </c:when>
                                        <c:otherwise><span class="badge bg-light text-dark">${d.trangThai}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                    <td class="text-end pe-3">
                                        <c:if test="${d.trangThai == 'CHO_DUYET'}">
                                            <a href="${pageContext.request.contextPath}/dangky?action=approve&id=${d.id}" class="btn btn-sm btn-outline-success me-1">
                                                <i class="fa-solid fa-check me-1"></i>Duyệt
                                            </a>
                                            <a href="${pageContext.request.contextPath}/dangky?action=reject&id=${d.id}" class="btn btn-sm btn-outline-danger">
                                                <i class="fa-solid fa-xmark me-1"></i>Từ chối
                                            </a>
                                        </c:if>
                                        <c:if test="${d.trangThai != 'CHO_DUYET'}">
                                            <span class="text-muted small">Đã xử lý</span>
                                        </c:if>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty dangKyList}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                    Chưa có đơn đăng ký / đổi phòng nào.
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
