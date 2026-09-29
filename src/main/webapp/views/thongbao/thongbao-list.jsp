<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="thongbao"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h4 class="fw-bold mb-1"><i class="fa-solid fa-bell text-primary me-2"></i>Thông Báo</h4>
        <p class="text-muted small mb-0">Chưa đọc: <strong>${unreadCount}</strong></p>
    </div>
    <div class="d-flex gap-2">
        <c:if test="${!sentTab}">
            <a href="${pageContext.request.contextPath}/thong-bao?action=markRead&id=all" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-check-double me-1"></i> Đánh dấu tất cả đã đọc
            </a>
        </c:if>
        <c:if test="${isStaff}">
            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#sendModal">
                <i class="fa-solid fa-paper-plane me-1"></i> Gửi thông báo
            </button>
        </c:if>
    </div>
</div>

<c:if test="${isStaff}">
    <ul class="nav nav-pills mb-3">
        <li class="nav-item">
            <a class="nav-link ${!sentTab ? 'active' : ''}" href="${pageContext.request.contextPath}/thong-bao">Hộp thư</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${sentTab ? 'active' : ''}" href="${pageContext.request.contextPath}/thong-bao?tab=sent">Đã gửi</a>
        </li>
    </ul>
</c:if>

<div class="card animate-in">
    <div class="card-body p-0">
        <div class="list-group list-group-flush rounded">
            <c:forEach var="tb" items="${thongBaoList}">
                <div class="list-group-item px-4 py-3 ${(!sentTab && !tb.daDoc) ? 'bg-primary-subtle' : ''}">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <span class="badge bg-info-subtle text-info me-1"><c:out value="${tb.loai}"/></span>
                            <c:choose>
                                <c:when test="${tb.phamVi == 'PHONG'}">
                                    <span class="badge bg-warning-subtle text-warning-emphasis me-2">
                                        <i class="fa-solid fa-door-open me-1"></i>Phòng <c:out value="${tb.maPhong}"/>
                                    </span>
                                </c:when>
                                <c:when test="${tb.phamVi == 'CA_NHAN'}">
                                    <span class="badge bg-secondary-subtle text-secondary-emphasis me-2">
                                        <i class="fa-solid fa-user me-1"></i><c:out value="${tb.tenNguoiNhan}"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-success-subtle text-success-emphasis me-2">
                                        <i class="fa-solid fa-users me-1"></i>Tất cả
                                    </span>
                                </c:otherwise>
                            </c:choose>
                            <span class="${(!sentTab && !tb.daDoc) ? 'fw-bold' : ''}"><c:out value="${tb.tieuDe}"/></span>
                            <div class="text-muted small mt-1"><c:out value="${tb.noiDung}"/></div>
                        </div>
                        <div class="d-flex flex-column align-items-end gap-1 ms-3">
                            <small class="text-muted">${tb.thoiGian}</small>
                            <c:if test="${!sentTab && !tb.daDoc}">
                                <a href="${pageContext.request.contextPath}/thong-bao?action=markRead&id=${tb.id}"
                                   class="btn btn-outline-secondary" style="font-size:0.72rem;padding:2px 8px;">Đã đọc</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty thongBaoList}">
                <div class="text-center text-muted py-5">
                    <i class="fa-solid fa-bell-slash fa-2x mb-2"></i><br>Không có thông báo nào.
                </div>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${isStaff}">
<!-- Modal gửi thông báo -->
<div class="modal fade" id="sendModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fa-solid fa-paper-plane me-2"></i>Gửi Thông Báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/thong-bao">
                <div class="modal-body">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Gửi đến</label>
                        <div class="btn-group w-100" role="group">
                            <input type="radio" class="btn-check" name="phamVi" id="pv_all" value="TAT_CA" checked onchange="togglePhamVi()">
                            <label class="btn btn-outline-primary btn-sm" for="pv_all"><i class="fa-solid fa-users me-1"></i>Tất cả</label>

                            <input type="radio" class="btn-check" name="phamVi" id="pv_phong" value="PHONG" onchange="togglePhamVi()">
                            <label class="btn btn-outline-primary btn-sm" for="pv_phong"><i class="fa-solid fa-door-open me-1"></i>Một phòng</label>

                            <input type="radio" class="btn-check" name="phamVi" id="pv_canhan" value="CA_NHAN" onchange="togglePhamVi()">
                            <label class="btn btn-outline-primary btn-sm" for="pv_canhan"><i class="fa-solid fa-user me-1"></i>Một người</label>
                        </div>
                    </div>

                    <div class="mb-3 d-none" id="boxPhong">
                        <label class="form-label fw-semibold">Chọn phòng</label>
                        <select name="phongId" id="selPhong" class="form-select">
                            <option value="">-- Chọn phòng --</option>
                            <c:forEach var="p" items="${phongList}">
                                <option value="${p.id}">${p.maPhong} - ${p.tenPhong} (${p.soNguoiHienTai}/${p.sucChua} người)</option>
                            </c:forEach>
                        </select>
                        <div class="form-text">Chỉ những người đang có hợp đồng hiệu lực trong phòng này mới đọc được.</div>
                    </div>

                    <div class="mb-3 d-none" id="boxCaNhan">
                        <label class="form-label fw-semibold">Chọn người nhận</label>
                        <select name="nguoiNhanId" id="selNguoi" class="form-select">
                            <option value="">-- Chọn người nhận --</option>
                            <c:forEach var="a" items="${accountList}">
                                <option value="${a.id}">
                                    ${a.username}<c:if test="${not empty a.hoTen}"> - ${a.hoTen}</c:if> (${a.vaiTro})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Loại thông báo</label>
                        <select name="loai" class="form-select">
                            <option value="THONG_TIN">Thông tin</option>
                            <option value="CANH_BAO">Cảnh báo</option>
                            <option value="HOP_DONG">Hợp đồng</option>
                            <option value="HOA_DON">Hóa đơn</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="tieuDe" required/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nội dung <span class="text-danger">*</span></label>
                        <textarea class="form-control" name="noiDung" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-paper-plane me-1"></i>Gửi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function togglePhamVi() {
    const v = document.querySelector('input[name="phamVi"]:checked').value;
    const boxPhong = document.getElementById('boxPhong');
    const boxNguoi = document.getElementById('boxCaNhan');
    boxPhong.classList.toggle('d-none', v !== 'PHONG');
    boxNguoi.classList.toggle('d-none', v !== 'CA_NHAN');
    document.getElementById('selPhong').required = (v === 'PHONG');
    document.getElementById('selNguoi').required = (v === 'CA_NHAN');
}
</script>
</c:if>

<jsp:include page="/views/common/footer.jsp"/>