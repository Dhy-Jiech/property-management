<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phong" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">${not empty phong && phong.id > 0 ? 'Sửa Thông Tin Phòng' : 'Thêm Phòng Mới'}</h2>
            <p class="text-muted small mb-0">Nhập các thông tin thông số kỹ thuật và loại phòng.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/phong" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/phong" method="post">
                <input type="hidden" name="action" value="${not empty phong && phong.id > 0 ? 'update' : 'insert'}">
                <c:if test="${not empty phong && phong.id > 0}">
                    <input type="hidden" name="id" value="${phong.id}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Vị Trí Tầng <span class="text-danger">*</span></label>
                        <c:choose>
                            <c:when test="${not empty listTang}">
                                <select name="tangId" class="form-select" required>
                                    <c:forEach var="t" items="${listTang}">
                                        <option value="${t.id}" ${not empty phong && phong.tangId == t.id ? 'selected' : ''}>
                                            ${t.toa.khu.tenKhu} &rarr; ${t.toa.tenToa} &rarr; ${t.tenTang} (Mã Tầng: ${t.id})
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <input type="number" name="tangId" class="form-control" value="${not empty phong ? phong.tangId : '1'}" required placeholder="Nhập ID Tầng (vd: 1)">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mã Phòng <span class="text-danger">*</span></label>
                        <input type="text" name="maPhong" class="form-control" value="${phong.maPhong}" 
                               ${not empty phong && phong.id > 0 ? 'readonly style="background-color: #e9ecef;"' : 'required'} 
                               placeholder="Ví dụ: P101, P202...">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Tên Phòng <span class="text-danger">*</span></label>
                        <input type="text" name="tenPhong" class="form-control" value="${phong.tenPhong}" required placeholder="Ví dụ: Phòng A1-101">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Loại Phòng <span class="text-danger">*</span></label>
                        <select name="loaiPhong" class="form-select" required>
                            <option value="_4_NGUOI" ${phong.loaiPhong == '_4_NGUOI' ? 'selected' : ''}>Phòng 4 Người</option>
                            <option value="_6_NGUOI" ${phong.loaiPhong == '_6_NGUOI' ? 'selected' : ''}>Phòng 6 Người</option>
                            <option value="_8_NGUOI" ${phong.loaiPhong == '_8_NGUOI' ? 'selected' : ''}>Phòng 8 Người</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Giá Tháng (VNĐ) <span class="text-danger">*</span></label>
                        <input type="number" name="giaThang" step="10000" class="form-control" value="${not empty phong ? phong.giaThang : '1500000'}" required placeholder="Nhập giá phòng/tháng">
                    </div>

                    <c:if test="${not empty phong && phong.id > 0}">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Trạng Thái Phòng</label>
                            <select name="trangThai" class="form-select">
                                <option value="TRONG" ${phong.trangThai == 'TRONG' ? 'selected' : ''}>Trống</option>
                                <option value="DANG_DAT_COC" ${phong.trangThai == 'DANG_DAT_COC' ? 'selected' : ''}>Đang Đặt Cọc</option>
                                <option value="DANG_CHO_THUE" ${phong.trangThai == 'DANG_CHO_THUE' ? 'selected' : ''}>Đang Cho Thuê</option>
                                <option value="BAO_TRI" ${phong.trangThai == 'BAO_TRI' ? 'selected' : ''}>Bảo Trì</option>
                            </select>
                        </div>
                    </c:if>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/phong" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn ${not empty phong && phong.id > 0 ? 'btn-warning' : 'btn-primary'} px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Thông Tin
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />