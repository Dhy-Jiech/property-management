<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="d-flex align-items-center mb-4">
            <a href="${pageContext.request.contextPath}/taikhoan" class="btn btn-outline-secondary btn-sm me-3">
                <i class="fa-solid fa-arrow-left"></i> Quay lại
            </a>
            <h4 class="fw-bold mb-0">
                <c:choose>
                    <c:when test="${account != null}">Chỉnh Sửa Tài Khoản #${account.id}</c:when>
                    <c:otherwise>Cấp Tài Khoản Mới</c:otherwise>
                </c:choose>
            </h4>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/taikhoan" method="post">
                    <input type="hidden" name="action" value="${account != null ? 'update' : 'insert'}" />
                    <c:if test="${account != null}">
                        <input type="hidden" name="id" value="${account.id}" />
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                        <input type="text" name="username" class="form-control" value="${account.username}" ${account != null ? 'readonly' : 'required'} placeholder="nhap_username" />
                        <c:if test="${account != null}">
                            <div class="form-text">Tên đăng nhập không thể thay đổi sau khi tạo.</div>
                        </c:if>
                    </div>

                    <c:if test="${account == null}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu ban đầu" />
                        </div>
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Vai Trò Hệ Thống <span class="text-danger">*</span></label>
                        <select name="vaiTro" class="form-select" required>
                            <option value="ADMIN" ${account.vaiTro == 'ADMIN' ? 'selected' : ''}>Quản trị viên (Admin)</option>
                            <option value="QUAN_LY" ${account.vaiTro == 'QUAN_LY' ? 'selected' : ''}>Quản lý KTX (Manager)</option>
                            <option value="NHAN_VIEN" ${account.vaiTro == 'NHAN_VIEN' ? 'selected' : ''}>Nhân viên (Employee/Staff)</option>
                            <option value="SINH_VIEN" ${account.vaiTro == 'SINH_VIEN' || account == null ? 'selected' : ''}>Sinh viên (Student)</option>
                        </select>
                    </div>

                    <c:if test="${account != null}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Trạng Thái Tài Khoản</label>
                            <select name="trangThai" class="form-select">
                                <option value="HOAT_DONG" ${account.trangThai == 'HOAT_DONG' ? 'selected' : ''}>Hoạt động</option>
                                <option value="DA_KHOA" ${account.trangThai == 'DA_KHOA' ? 'selected' : ''}>Đã khóa</option>
                            </select>
                        </div>
                    </c:if>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Gắn với Hồ Sơ Sinh Viên (Nếu vai trò Sinh viên)</label>
                        <select name="sinhVienId" class="form-select">
                            <option value="">-- Không chọn (Dành cho Admin / Quản lý / Nhân viên) --</option>
                            <c:forEach var="sv" items="${sinhVienList}">
                                <option value="${sv.id}" ${account.sinhVienId == sv.id ? 'selected' : ''}>
                                    #${sv.id} - ${sv.hoTen} (${sv.cccd != null ? sv.cccd : 'SV'})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary py-2 fw-semibold">
                            <i class="fa-solid fa-floppy-disk me-2"></i>Lưu Thông Tin Tài Khoản
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
