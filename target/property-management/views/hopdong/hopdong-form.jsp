<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%@ page import="com.example.property.management.model.Phong" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hopdong" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Lập Hợp Đồng Mới</h2>
            <p class="text-muted small">Điền các thông tin để lập hợp đồng thuê phòng cho sinh viên.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/hopdong" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/hopdong" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="maHopDong" class="form-label fw-semibold">Mã hợp đồng <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="maHopDong" name="maHopDong" value="HD-<%= System.currentTimeMillis() % 100000 %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="sinhVienId" class="form-label fw-semibold">Sinh viên <span class="text-danger">*</span></label>
                        <select class="form-select" id="sinhVienId" name="sinhVienId" required>
                            <option value="">-- Chọn Sinh Viên --</option>
                            <%
                                List<SinhVien> svList = (List<SinhVien>) request.getAttribute("sinhVienList");
                                if (svList != null) {
                                    for (SinhVien sv : svList) {
                            %>
                            <option value="<%= sv.getId() %>"><%= sv.getHoTen() %> (CCCD: <%= sv.getCccd() != null ? sv.getCccd() : "-" %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="phongId" class="form-label fw-semibold">Phòng <span class="text-danger">*</span></label>
                        <select class="form-select" id="phongId" name="phongId" required>
                            <option value="">-- Chọn Phòng --</option>
                            <%
                                List<Phong> pList = (List<Phong>) request.getAttribute("phongList");
                                if (pList != null) {
                                    for (Phong p : pList) {
                            %>
                            <option value="<%= p.getId() %>"><%= p.getMaPhong() %> - <%= p.getTenPhong() %> (Đang ở: <%= p.getSoNguoiHienTai() %>/<%= p.getSucChua() %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="ngayBatDau" class="form-label fw-semibold">Ngày bắt đầu <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau" value="<%= java.time.LocalDate.now() %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="ngayKetThuc" class="form-label fw-semibold">Ngày kết thúc <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc" value="<%= java.time.LocalDate.now().plusMonths(6) %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="tienPhong" class="form-label fw-semibold">Giá thuê/tháng (VNĐ) <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" id="tienPhong" name="tienPhong" value="1500000" step="10000" required>
                    </div>

                    <div class="col-md-6">
                        <label for="tienDatCoc" class="form-label fw-semibold">Tiền đặt cọc (VNĐ)</label>
                        <input type="number" class="form-control" id="tienDatCoc" name="tienDatCoc" value="1500000" step="10000">
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/hopdong" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-file-contract me-1"></i> Tạo Hợp Đồng
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
