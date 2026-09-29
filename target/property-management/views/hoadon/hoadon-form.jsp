<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hoadon" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Tạo Hóa Đơn Theo Phòng</h2>
            <p class="text-muted small mb-0">Chọn phòng và kỳ tháng. Điện, nước và các khoản phí được lấy tự động, không chỉnh sửa được.</p>
        </div>
        <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <div class="card border-0 shadow-sm col-lg-8 mx-auto">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/hoadon" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mã hóa đơn <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="maHoaDon"
                               value="INV-<%= System.currentTimeMillis() % 100000 %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Phòng <span class="text-danger">*</span></label>
                        <select class="form-select" id="phongId" name="phongId" required>
                            <option value="">-- Chọn phòng --</option>
                            <c:forEach var="p" items="${phongList}">
                                <option value="${p.id}"><c:out value="${p.maPhong} - ${p.tenPhong}"/> (${p.soNguoiHienTai}/${p.sucChua} người)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Kỳ tháng <span class="text-danger">*</span></label>
                        <input type="month" class="form-control" id="kyThanhToan" name="kyThanhToan"
                               value="<%= java.time.LocalDate.now().toString().substring(0, 7) %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Hạn thanh toán <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" name="hanThanhToan"
                               value="<%= java.time.LocalDate.now().plusDays(10) %>" required>
                    </div>
                </div>

                <div id="warnBox" class="alert alert-warning mt-3 d-none"></div>

                <div id="detailBox" class="d-none mt-4">
                    <h6 class="fw-bold text-uppercase text-muted small">Chi tiết (tự động, không chỉnh sửa)</h6>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Tiền phòng</label>
                            <input type="text" class="form-control bg-light" id="tienPhong" readonly>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Điện</label>
                            <input type="text" class="form-control bg-light" id="dienInfo" readonly>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Tiền điện</label>
                            <input type="text" class="form-control bg-light" id="tienDien" readonly>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Nước</label>
                            <input type="text" class="form-control bg-light" id="nuocInfo" readonly>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Tiền nước</label>
                            <input type="text" class="form-control bg-light" id="tienNuoc" readonly>
                        </div>
                        <div class="col-12" id="feeBox"></div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Tổng cộng</label>
                            <input type="text" class="form-control bg-light fw-bold text-danger fs-5" id="tongTien" readonly>
                        </div>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="${pageContext.request.contextPath}/hoadon" class="btn btn-outline-secondary me-2">Hủy</a>
                    <button type="submit" id="btnSubmit" class="btn btn-primary px-4" disabled>
                        <i class="fa-solid fa-file-invoice me-1"></i> Tạo Hóa Đơn
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const $ = id => document.getElementById(id);
const money = n => Number(n).toLocaleString('vi-VN') + ' ₫';

async function loadPreview() {
    const phong = $('phongId').value, ky = $('kyThanhToan').value;
    $('btnSubmit').disabled = true;
    $('detailBox').classList.add('d-none');
    $('warnBox').classList.add('d-none');
    if (!phong || !ky) return;

    let d;
    try {
        const r = await fetch(ctx + '/hoadon?action=preview&phongId=' + encodeURIComponent(phong) + '&ky=' + encodeURIComponent(ky));
        d = await r.json();
    } catch (e) {
        showWarn(['Không tải được số liệu. Hãy đăng nhập lại hoặc thử lại.']);
        return;
    }
    if (d.error) { showWarn([d.error]); return; }

    $('tienPhong').value = money(d.tienPhong);
    $('dienInfo').value = d.coDien
        ? 'Cũ ' + d.dienCu + ' → Mới ' + d.dienMoi + ' (' + (d.dienMoi - d.dienCu) + ' số × ' + money(d.dienDonGia) + ')'
        : 'Chưa có chỉ số';
    $('tienDien').value = money(d.tienDien);
    $('nuocInfo').value = d.coNuoc
        ? 'Cũ ' + d.nuocCu + ' → Mới ' + d.nuocMoi + ' (' + (d.nuocMoi - d.nuocCu) + ' khối × ' + money(d.nuocDonGia) + ')'
        : 'Chưa có chỉ số';
    $('tienNuoc').value = money(d.tienNuoc);

    // Mỗi khoản phí một ô, tự thêm theo bảng khoan_phi
    const box = $('feeBox');
    box.innerHTML = '';
    d.fees.forEach(f => {
        const wrap = document.createElement('div');
        wrap.className = 'mb-3';
        const lb = document.createElement('label');
        lb.className = 'form-label';
        lb.textContent = f.ten + (f.donVi ? ' (' + f.donVi + ')' : '');
        const inp = document.createElement('input');
        inp.className = 'form-control bg-light';
        inp.readOnly = true;
        inp.value = money(f.donGia);
        wrap.append(lb, inp);
        box.appendChild(wrap);
    });

    $('tongTien').value = money(d.tongTien);
    $('detailBox').classList.remove('d-none');
    if (d.warnings.length) showWarn(d.warnings);
    $('btnSubmit').disabled = !d.canCreate;
}

function showWarn(list) {
    const w = $('warnBox');
    w.textContent = list.join(' ');
    w.classList.remove('d-none');
}

$('phongId').addEventListener('change', loadPreview);
$('kyThanhToan').addEventListener('change', loadPreview);
</script>

<jsp:include page="/views/common/footer.jsp" />