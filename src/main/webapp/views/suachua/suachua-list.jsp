<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="suachua" />
</jsp:include>

<%
    TaiKhoan u = (TaiKhoan) session.getAttribute("user");
    boolean isSinhVien = (u != null && u.getVaiTro() == VaiTro.SINH_VIEN);
%>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">
                <%= isSinhVien ? "Báo Hỏng & Sửa Chữa Của Tôi" : "Yêu Cầu Sửa Chữa & Khiếu Nại" %>
            </h2>
            <p class="text-muted small mb-0">
                <%= isSinhVien ? "Báo cáo các sự cố thiết bị hỏng hóc trong phòng và theo dõi tiến độ sửa chữa từ ban quản lý." : "Báo cáo hỏng hóc và theo dõi tiến độ xử lý sửa chữa thiết bị." %>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/suachua?action=new" class="btn btn-primary">
            <i class="fa-solid fa-wrench me-1"></i> Gửi Yêu Cầu Mới
        </a>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3 text-center">STT</th>
                            <th>Phòng Báo Sự Cố</th>
                            <th>Nội Dung Sự Cố / Hỏng Hóc</th>
                            <th>Phản Hồi Xử Lý</th>
                            <th class="text-center">Trạng Thái</th>
                            <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                <th class="text-end pe-3">Thao Tác Xử Lý</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="y" items="${suaChuaList}" varStatus="loop">
                            <tr>
                                <td class="ps-3 text-center fw-bold text-secondary">${loop.index + 1}</td>
                                <td><span class="badge bg-secondary fs-6">Phòng #${y.phongId}</span></td>
                                <td class="fw-medium">${y.noiDung}</td>
                                <td class="small text-muted">${y.phanHoi != null ? y.phanHoi : '--'}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${y.trangThai == 'MOI'}">
                                            <span class="badge bg-warning text-dark">Mới Gửi</span>
                                        </c:when>
                                        <c:when test="${y.trangThai == 'DANG_XU_LY'}">
                                            <span class="badge bg-info text-dark">Đang Xử Lý</span>
                                        </c:when>
                                        <c:when test="${y.trangThai == 'DA_XU_LY'}">
                                            <span class="badge bg-success">Đã Hoàn Thành</span>
                                        </c:when>
                                        <c:when test="${y.trangThai == 'TU_CHOI'}">
                                            <span class="badge bg-danger">Từ Chối</span>
                                        </c:when>
                                        <c:otherwise><span class="badge bg-light text-dark">${y.trangThai}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                    <td class="text-end pe-3">
                                        <c:if test="${y.trangThai == 'MOI'}">
                                            <a href="${pageContext.request.contextPath}/suachua?action=update&id=${y.id}&status=DANG_XU_LY" class="btn btn-sm btn-outline-info me-1">
                                                Đang xử lý
                                            </a>
                                        </c:if>
                                        <c:if test="${y.trangThai != 'DA_XU_LY'}">
                                            <a href="${pageContext.request.contextPath}/suachua?action=update&id=${y.id}&status=DA_XU_LY" class="btn btn-sm btn-outline-success">
                                                Hoàn thành
                                            </a>
                                        </c:if>
                                        <c:if test="${y.trangThai == 'DA_XU_LY'}">
                                            <span class="text-success small fw-semibold"><i class="fa-solid fa-circle-check me-1"></i>Đã xong</span>
                                        </c:if>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty suaChuaList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                    Không có yêu cầu sửa chữa nào.
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
