<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%
    SinhVien sv = (SinhVien) request.getAttribute("sinhVien");
    if (sv == null) sv = new SinhVien();
%>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="sinhvien" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0"><%= sv.getId() > 0 ? "Chỉnh Sửa Sinh Viên" : "Thêm Sinh Viên Mới" %></h2>
            <p class="text-muted small">Điền đầy đủ thông tin sinh viên bên dưới.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/sinhvien" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/sinhvien" method="post">
                <input type="hidden" name="id" value="<%= sv.getId() %>" />

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="hoTen" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="hoTen" name="hoTen" value="<%= sv.getHoTen() != null ? sv.getHoTen() : "" %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="ngaySinh" class="form-label fw-semibold">Ngày sinh</label>
                        <input type="date" class="form-control" id="ngaySinh" name="ngaySinh" value="<%= sv.getNgaySinh() != null ? sv.getNgaySinh() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label for="gioiTinh" class="form-label fw-semibold">Giới tính</label>
                        <select class="form-select" id="gioiTinh" name="gioiTinh">
                            <option value="Nam" <%= "Nam".equalsIgnoreCase(sv.getGioiTinh()) ? "selected" : "" %>>Nam</option>
                            <option value="Nữ" <%= "Nữ".equalsIgnoreCase(sv.getGioiTinh()) ? "selected" : "" %>>Nữ</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="cccd" class="form-label fw-semibold">Số CCCD / CMND</label>
                        <input type="text" class="form-control" id="cccd" name="cccd" value="<%= sv.getCccd() != null ? sv.getCccd() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label for="soDienThoai" class="form-label fw-semibold">Số điện thoại</label>
                        <input type="text" class="form-control" id="soDienThoai" name="soDienThoai" value="<%= sv.getSoDienThoai() != null ? sv.getSoDienThoai() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label for="email" class="form-label fw-semibold">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= sv.getEmail() != null ? sv.getEmail() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label for="truong" class="form-label fw-semibold">Trường học</label>
                        <input type="text" class="form-control" id="truong" name="truong" value="<%= sv.getTruong() != null ? sv.getTruong() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label for="diaChiQueQuan" class="form-label fw-semibold">Quê quán / Địa chỉ</label>
                        <input type="text" class="form-control" id="diaChiQueQuan" name="diaChiQueQuan" value="<%= sv.getDiaChiQueQuan() != null ? sv.getDiaChiQueQuan() : "" %>">
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/sinhvien" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-save me-1"></i> Lưu Sinh Viên
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
