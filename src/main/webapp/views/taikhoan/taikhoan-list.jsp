<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h3 class="mb-0">Quản Lý Tài Khoản System</h3>
        <div class="text-muted small">Phân quyền, cấp tài khoản cho Quản lý, Nhân viên và Sinh viên</div>
    </div>
    <a href="${pageContext.request.contextPath}/taikhoan?action=new" class="btn btn-primary btn-sm">
        <i class="ph ph-plus me-2"></i> Cấp Tài Khoản Mới
    </a>
</div>

<div class="card mb-3">
    <div class="card-header d-flex align-items-center justify-content-between">
        <span>Danh Sách Tài Khoản</span>
        <span class="label-sm font-mono">Tổng số: ${taiKhoanList.size()}</span>
    </div>
    <div class="table-responsive" style="border: none; border-radius: 0;">
        <table class="table align-middle">
            <thead>
                <tr>
                    <th style="width: 70px;">ID</th>
                    <th>Tên Đăng Nhập</th>
                    <th style="width: 140px;">Vai Trò</th>
                    <th style="width: 140px;">Trạng Thái</th>
                    <th style="width: 150px;">Sinh Viên Liên Kết</th>
                    <th class="text-end" style="width: 140px;">Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="acc" items="${taiKhoanList}">
                    <tr>
                        <td class="font-mono text-muted">#${acc.id}</td>
                        <td class="fw-semibold">${acc.username}</td>
                        <td>
                            <c:choose>
                                <c:when test="${acc.vaiTro == 'ADMIN'}">
                                    <span class="role-tag" style="color: #A82E2E; border-color: #F8D7DA; background: #FDF2F2;">ADMIN</span>
                                </c:when>
                                <c:when test="${acc.vaiTro == 'QUAN_LY'}">
                                    <span class="role-tag" style="color: #2B4ACB; border-color: #DCE3FA; background: #F0F4FF;">QUẢN LÝ</span>
                                </c:when>
                                <c:when test="${acc.vaiTro == 'NHAN_VIEN'}">
                                    <span class="role-tag" style="color: #3B5268; border-color: #DDE3EA; background: #F4F6F9;">NHÂN VIÊN</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="role-tag">SINH VIÊN</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${acc.trangThai == 'HOAT_DONG'}">
                                    <span class="status-dot-wrapper">
                                        <span class="status-dot dot-active"></span>
                                        Hoạt động
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-dot-wrapper" style="color: #A82E2E;">
                                        <span class="status-dot dot-locked"></span>
                                        Đã khóa
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="font-mono">
                            <c:choose>
                                <c:when test="${acc.sinhVienId != null}">
                                    <span class="text-muted">SV-${acc.sinhVienId}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted" style="opacity: 0.5;">—</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/taikhoan?action=edit&id=${acc.id}" class="btn btn-sm btn-outline-secondary py-0 px-2" title="Chỉnh sửa">
                                <i class="ph ph-pencil-simple"></i>
                            </a>
                            <c:choose>
                                <c:when test="${acc.trangThai == 'HOAT_DONG'}">
                                    <a href="${pageContext.request.contextPath}/taikhoan?action=toggleStatus&id=${acc.id}" class="btn btn-sm btn-outline-secondary py-0 px-2 text-warning" title="Khóa tài khoản" onclick="return confirm('Bạn có chắc chắn muốn khóa tài khoản này?');">
                                        <i class="ph ph-lock"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/taikhoan?action=toggleStatus&id=${acc.id}" class="btn btn-sm btn-outline-secondary py-0 px-2 text-success" title="Mở khóa">
                                        <i class="ph ph-lock-key-open"></i>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${acc.username != 'admin'}">
                                <a href="${pageContext.request.contextPath}/taikhoan?action=delete&id=${acc.id}" class="btn btn-sm btn-outline-secondary py-0 px-2 text-danger" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                    <i class="ph ph-trash"></i>
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
