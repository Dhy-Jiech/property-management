<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1"><i class="fa-solid fa-users-gear text-primary me-2"></i>Quản Lý Tài Khoản System</h3>
        <p class="text-muted small mb-0">Phân quyền, cấp tài khoản cho Quản lý, Nhân viên và Sinh viên</p>
    </div>
    <a href="${pageContext.request.contextPath}/taikhoan?action=new" class="btn btn-primary shadow-sm">
        <i class="fa-solid fa-user-plus me-2"></i>Cấp Tài Khoản Mới
    </a>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">ID</th>
                        <th>Tên Đăng Nhập</th>
                        <th>Vai Trò</th>
                        <th>Trạng Thái</th>
                        <th>Sinh Viên Liên Kết</th>
                        <th class="text-end pe-4">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${taiKhoanList}">
                        <tr>
                            <td class="ps-4 fw-semibold text-secondary">#${acc.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary-subtle text-primary rounded-circle p-2 me-2 d-flex align-items-center justify-content-center" style="width: 34px; height: 34px;">
                                        <i class="fa-solid fa-user-lock"></i>
                                    </div>
                                    <span class="fw-bold text-dark">${acc.username}</span>
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.vaiTro == 'ADMIN'}">
                                        <span class="badge bg-danger shadow-sm"><i class="fa-solid fa-shield-halved me-1"></i>Quản trị viên</span>
                                    </c:when>
                                    <c:when test="${acc.vaiTro == 'QUAN_LY'}">
                                        <span class="badge bg-primary shadow-sm"><i class="fa-solid fa-user-tie me-1"></i>Quản lý KTX</span>
                                    </c:when>
                                    <c:when test="${acc.vaiTro == 'NHAN_VIEN'}">
                                        <span class="badge bg-info text-dark shadow-sm"><i class="fa-solid fa-user-gear me-1"></i>Nhân viên</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success shadow-sm"><i class="fa-solid fa-graduation-cap me-1"></i>Sinh viên</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.trangThai == 'HOAT_DONG'}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Đã khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.sinhVienId != null}">
                                        <span class="text-primary fw-medium"><i class="fa-solid fa-link me-1"></i>SV ID: ${acc.sinhVienId}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fs-7">-- Không --</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-4">
                                <a href="${pageContext.request.contextPath}/taikhoan?action=edit&id=${acc.id}" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <c:choose>
                                    <c:when test="${acc.trangThai == 'HOAT_DONG'}">
                                        <a href="${pageContext.request.contextPath}/taikhoan?action=toggleStatus&id=${acc.id}" class="btn btn-sm btn-outline-warning me-1" title="Khóa tài khoản" onclick="return confirm('Bạn có chắc chắn muốn khóa tài khoản này?');">
                                            <i class="fa-solid fa-lock"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/taikhoan?action=toggleStatus&id=${acc.id}" class="btn btn-sm btn-outline-success me-1" title="Mở khóa tài khoản">
                                            <i class="fa-solid fa-lock-open"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${acc.username != 'admin'}">
                                    <a href="${pageContext.request.contextPath}/taikhoan?action=delete&id=${acc.id}" class="btn btn-sm btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
