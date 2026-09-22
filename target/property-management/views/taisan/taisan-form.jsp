<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="taisan" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Thêm Tài Sản / Thiết Bị Mới</h2>
            <p class="text-muted small mb-0">Cấp phát tài sản hoặc trang thiết bị mới vào phòng ở.</p>
        </div>
        <a href="${pageContext.request.contextPath}/taisan" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/taisan" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Tên Tài Sản / Thiết Bị <span class="text-danger">*</span></label>
                        <input type="text" name="tenTaiSan" class="form-control" required placeholder="Ví dụ: Giường tầng, Bàn học, Tủ quần áo, Điều hòa...">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Phòng Trang Bị <span class="text-danger">*</span></label>
                        <select name="phongId" class="form-select" required>
                            <c:forEach var="p" items="${phongList}">
                                <option value="${p.id}">${p.maPhong} - ${p.tenPhong}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Số Lượng <span class="text-danger">*</span></label>
                        <input type="number" name="soLuong" min="1" value="1" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Tình Trạng Thiết Bị</label>
                        <select name="tinhTrang" class="form-select">
                            <option value="Mới">Mới 100%</option>
                            <option value="Tốt" selected>Tốt / Sử dụng bình thường</option>
                            <option value="Cũ">Cũ nhưng sử dụng tốt</option>
                            <option value="Cần bảo trì">Cần bảo trì / sửa chữa</option>
                        </select>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/taisan" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Thông Tin
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
