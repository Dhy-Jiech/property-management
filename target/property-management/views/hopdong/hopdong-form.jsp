<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%@ page import="com.example.property.management.model.Phong" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hopdong" />
</jsp:include>

<%
    String selSvIdStr = (String) request.getAttribute("selectedSinhVienId");
    String selPIdStr = (String) request.getAttribute("selectedPhongId");
    int selSvId = (selSvIdStr != null && !selSvIdStr.isEmpty()) ? Integer.parseInt(selSvIdStr) : 0;
    int selPId = (selPIdStr != null && !selPIdStr.isEmpty()) ? Integer.parseInt(selPIdStr) : 0;
%>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Lập Hợp Đồng Thỏa Thuận Mới</h2>
            <p class="text-muted small">Điền các thông tin để lập hợp đồng thuê phòng và ký điện tử (Bên A).</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/hopdong" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm col-lg-9 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/hopdong" method="post" id="hopDongForm">
                <input type="hidden" id="chuKyBenA" name="chuKyBenA" value="" />

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="maHopDong" class="form-label fw-semibold">Mã hợp đồng <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="maHopDong" name="maHopDong" value="HD-<%= System.currentTimeMillis() % 100000 %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="sinhVienId" class="form-label fw-semibold">Sinh viên (Bên B) <span class="text-danger">*</span></label>
                        <select class="form-select" id="sinhVienId" name="sinhVienId" required>
                            <option value="">-- Chọn Sinh Viên --</option>
                            <%
                                List<SinhVien> svList = (List<SinhVien>) request.getAttribute("sinhVienList");
                                if (svList != null) {
                                    for (SinhVien sv : svList) {
                                        boolean isSelected = (selSvId > 0 && sv.getId() == selSvId);
                            %>
                            <option value="<%= sv.getId() %>" <%= isSelected ? "selected" : "" %>><%= sv.getHoTen() %> (CCCD: <%= sv.getCccd() != null ? sv.getCccd() : "-" %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="phongId" class="form-label fw-semibold">Phòng thuê <span class="text-danger">*</span></label>
                        <select class="form-select" id="phongId" name="phongId" required>
                            <option value="">-- Chọn Phòng --</option>
                            <%
                                List<Phong> pList = (List<Phong>) request.getAttribute("phongList");
                                if (pList != null) {
                                    for (Phong p : pList) {
                                        boolean isSelected = (selPId > 0 && p.getId() == selPId);
                            %>
                            <option value="<%= p.getId() %>" <%= isSelected ? "selected" : "" %>><%= p.getMaPhong() %> - <%= p.getTenPhong() %> (Giá: <%= String.format("%,.0f VNĐ", p.getGiaThang()) %>)</option>
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

                <!-- Digital Signature Area for Side A (Manager) -->
                <div class="card bg-light border-0 mt-4">
                    <div class="card-body">
                        <h6 class="fw-bold text-dark mb-2">
                            <i class="fa-solid fa-pen-nib text-primary me-1"></i> Chữ ký điện tử Đại diện Bên A (Người quản lý)
                        </h6>
                        <p class="text-muted small mb-2">Ký trực tiếp bằng chuột hoặc màn hình cảm ứng vào ô bên dưới:</p>
                        <div class="d-inline-block border rounded bg-white p-1">
                            <canvas id="canvasBenA" width="450" height="150" class="border rounded cursor-crosshair"></canvas>
                        </div>
                        <div class="mt-2">
                            <button type="button" class="btn btn-sm btn-outline-danger" id="btnClearBenA">
                                <i class="fa-solid fa-eraser me-1"></i> Xóa chữ ký
                            </button>
                            <span class="text-muted small ms-2" id="signStatusA"><i class="fa-solid fa-circle-info"></i> Chưa có chữ ký</span>
                        </div>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/hopdong" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-paper-plane me-1"></i> Tạo Hợp Đồng & Gửi Sinh Viên Ký
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const canvas = document.getElementById('canvasBenA');
    const ctx = canvas.getContext('2d');
    const btnClear = document.getElementById('btnClearBenA');
    const hiddenInput = document.getElementById('chuKyBenA');
    const signStatus = document.getElementById('signStatusA');
    const form = document.getElementById('hopDongForm');

    let isDrawing = false;
    let hasSignature = false;

    ctx.lineWidth = 2.5;
    ctx.lineCap = 'round';
    ctx.strokeStyle = '#002b66';

    function getPos(e) {
        const rect = canvas.getBoundingClientRect();
        if (e.touches && e.touches.length > 0) {
            return {
                x: e.touches[0].clientX - rect.left,
                y: e.touches[0].clientY - rect.top
            };
        }
        return {
            x: e.clientX - rect.left,
            y: e.clientY - rect.top
        };
    }

    function startDraw(e) {
        isDrawing = true;
        const pos = getPos(e);
        ctx.beginPath();
        ctx.moveTo(pos.x, pos.y);
        e.preventDefault();
    }

    function draw(e) {
        if (!isDrawing) return;
        const pos = getPos(e);
        ctx.lineTo(pos.x, pos.y);
        ctx.stroke();
        hasSignature = true;
        signStatus.innerHTML = '<span class="text-success fw-bold"><i class="fa-solid fa-check"></i> Đã ký</span>';
        e.preventDefault();
    }

    function stopDraw() {
        isDrawing = false;
    }

    canvas.addEventListener('mousedown', startDraw);
    canvas.addEventListener('mousemove', draw);
    canvas.addEventListener('mouseup', stopDraw);
    canvas.addEventListener('mouseleave', stopDraw);

    canvas.addEventListener('touchstart', startDraw);
    canvas.addEventListener('touchmove', draw);
    canvas.addEventListener('touchend', stopDraw);

    btnClear.addEventListener('click', function() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        hasSignature = false;
        hiddenInput.value = '';
        signStatus.innerHTML = '<span class="text-muted small"><i class="fa-solid fa-circle-info"></i> Chưa có chữ ký</span>';
    });

    form.addEventListener('submit', function(e) {
        if (hasSignature) {
            hiddenInput.value = canvas.toDataURL('image/png');
        }
    });
});
</script>

<jsp:include page="/views/common/footer.jsp" />
