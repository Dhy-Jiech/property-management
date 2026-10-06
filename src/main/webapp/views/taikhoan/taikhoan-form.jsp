<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-7 col-lg-6">
        <div class="d-flex align-items-center mb-3">
            <a href="${pageContext.request.contextPath}/taikhoan" class="btn btn-outline-secondary btn-sm me-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
            <h4 class="mb-0">
                <c:choose>
                    <c:when test="${account != null}">Chỉnh Sửa Tài Khoản <span class="font-mono">#${account.id}</span></c:when>
                    <c:otherwise>Cấp Tài Khoản Mới</c:otherwise>
                </c:choose>
            </h4>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                Thông Tin Chi Tiết
            </div>
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/taikhoan" method="post">
                    <input type="hidden" name="action" value="${account != null ? 'update' : 'insert'}" />
                    <c:if test="${account != null}">
                        <input type="hidden" name="id" value="${account.id}" />
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                        <input type="text" name="username" class="form-control font-mono" value="${account.username}" ${account != null ? 'readonly' : 'required'} placeholder="nhap_username" />
                        <c:if test="${account != null}">
                            <div class="form-text" style="font-size: 11px;">Tên đăng nhập không thể thay đổi sau khi khởi tạo.</div>
                        </c:if>
                    </div>

                    <c:if test="${account == null}">
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu khởi tạo" />
                        </div>
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">Vai Trò Hệ Thống <span class="text-danger">*</span></label>
                        <select name="vaiTro" class="form-select font-mono" required>
                            <option value="ADMIN" ${account.vaiTro == 'ADMIN' ? 'selected' : ''}>ADMIN - Quản trị hệ thống</option>
                            <option value="QUAN_LY" ${account.vaiTro == 'QUAN_LY' ? 'selected' : ''}>QUAN_LY - Quản lý KTX</option>
                            <option value="NHAN_VIEN" ${account.vaiTro == 'NHAN_VIEN' ? 'selected' : ''}>NHAN_VIEN - Nhân viên vận hành</option>
                            <option value="SINH_VIEN" ${account.vaiTro == 'SINH_VIEN' || account == null ? 'selected' : ''}>SINH_VIEN - Sinh viên lưu trú</option>
                        </select>
                    </div>

                    <c:if test="${account != null}">
                        <div class="mb-3">
                            <label class="form-label">Trạng Thái Tài Khoản</label>
                            <select name="trangThai" class="form-select">
                                <option value="HOAT_DONG" ${account.trangThai == 'HOAT_DONG' ? 'selected' : ''}>HOAT_DONG - Cho phép đăng nhập</option>
                                <option value="DA_KHOA" ${account.trangThai == 'DA_KHOA' ? 'selected' : ''}>DA_KHOA - Khóa quyền đăng nhập</option>
                            </select>
                        </div>
                    </c:if>

                    <div class="mb-4">
                        <label class="form-label">Sinh Viên Liên Kết (Nếu là vai trò Sinh viên)</label>
                        <select name="sinhVienId" class="form-select">
                            <option value="">-- Không chọn (Dành cho Quản trị / Nhân viên) --</option>
                            <c:forEach var="sv" items="${sinhVienList}">
                                <option value="${sv.id}" ${account.sinhVienId == sv.id ? 'selected' : ''}>
                                    #${sv.id} - ${sv.hoTen} (${sv.cccd != null ? sv.cccd : 'SV'})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/taikhoan" class="btn btn-outline-secondary">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Thay Đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
