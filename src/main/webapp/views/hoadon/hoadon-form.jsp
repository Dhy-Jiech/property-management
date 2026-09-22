<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Tạo Hóa Đơn Tháng Mới</h2>
            <p class="text-muted small">Điền các chi tiết khoản phí để tạo hóa đơn cho sinh viên.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/hoadon" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="maHoaDon" class="form-label fw-semibold">Mã Hóa Đơn <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="maHoaDon" name="maHoaDon" value="INV-<%= System.currentTimeMillis() % 100000 %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="sinhVienId" class="form-label fw-semibold">Sinh Viên <span class="text-danger">*</span></label>
                        <select class="form-select" id="sinhVienId" name="sinhVienId" required>
                            <option value="">-- Chọn Sinh Viên --</option>
                            <%
                                List<SinhVien> svList = (List<SinhVien>) request.getAttribute("sinhVienList");
                                if (svList != null) {
                                    for (SinhVien sv : svList) {
                            %>
                            <option value="<%= sv.getId() %>"><%= sv.getHoTen() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="kyThanhToan" class="form-label fw-semibold">Kỳ tháng thanh toán <span class="text-danger">*</span></label>
                        <input type="month" class="form-control" id="kyThanhToan" name="kyThanhToan" value="<%= java.time.LocalDate.now().toString().substring(0, 7) %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="hanThanhToan" class="form-label fw-semibold">Hạn thanh toán <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" id="hanThanhToan" name="hanThanhToan" value="<%= java.time.LocalDate.now().plusDays(10) %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="tienPhong" class="form-label fw-semibold">Tiền phòng (VNĐ)</label>
                        <input type="number" class="form-control" id="tienPhong" name="tienPhong" value="1500000" step="1000">
                    </div>

                    <div class="col-md-6">
                        <label for="tienDien" class="form-label fw-semibold">Tiền điện (VNĐ)</label>
                        <input type="number" class="form-control" id="tienDien" name="tienDien" value="150000" step="1000">
                    </div>

                    <div class="col-md-6">
                        <label for="tienNuoc" class="form-label fw-semibold">Tiền nước (VNĐ)</label>
                        <input type="number" class="form-control" id="tienNuoc" name="tienNuoc" value="80000" step="1000">
                    </div>

                    <div class="col-md-6">
                        <label for="tongPhi" class="form-label fw-semibold">Phí dịch vụ khác (Wifi, rác...)</label>
                        <input type="number" class="form-control" id="tongPhi" name="tongPhi" value="50000" step="1000">
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-file-invoice me-1"></i> Tạo Hóa Đơn
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
