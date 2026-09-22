<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="suachua" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Báo Cáo Yêu Cầu Sửa Chữa</h2>
            <p class="text-muted small mb-0">Gửi thông tin trang thiết bị hư hỏng trong phòng cần ban quản lý sửa chữa.</p>
        </div>
        <a href="${pageContext.request.contextPath}/suachua" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/suachua" method="post">
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Chọn Phòng Báo Sự Cố <span class="text-danger">*</span></label>
                        <select name="phongId" class="form-select" required>
                            <c:forEach var="p" items="${phongList}">
                                <option value="${p.id}">${p.maPhong} - ${p.tenPhong}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Nội Dung Sự Cố / Hỏng Hóc <span class="text-danger">*</span></label>
                        <textarea name="noiDung" class="form-control" rows="4" required placeholder="Mô tả chi tiết vị trí hỏng hóc, thiết bị (ví dụ: Bóng đèn huỳnh quang phòng 101 bị cháy, vòi nước bồn rửa mặt bị rò rỉ...)"></textarea>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/suachua" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-paper-plane me-1"></i> Gửi Yêu Cầu
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
