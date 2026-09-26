<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.TaiKhoan, com.example.property.management.model.enums.VaiTro" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%   TaiKhoan cu = (TaiKhoan) session.getAttribute("user");
     boolean isAdmin = cu != null && (cu.getVaiTro() == VaiTro.ADMIN || cu.getVaiTro() == VaiTro.QUAN_LY); %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="thongbao"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-1"><i class="fa-solid fa-bell text-primary me-2"></i>Thông Báo</h4>
        <p class="text-muted small mb-0">Tổng số chưa đọc: <strong>${unreadCount}</strong></p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/thong-bao?action=markRead&id=all" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-check-double me-1"></i> Đánh dấu tất cả đã đọc
        </a>
        <% if (isAdmin) { %>
        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#sendModal">
            <i class="fa-solid fa-paper-plane me-1"></i> Gửi thông báo
        </button>
        <% } %>
    </div>
</div>

<div class="card animate-in">
    <div class="card-body p-0">
        <div class="list-group list-group-flush rounded">
            <c:forEach var="tb" items="${thongBaoList}">
                <div class="list-group-item list-group-item-action px-4 py-3 ${!tb.daDoc ? 'fw-semibold bg-primary-subtle' : ''}">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <span class="badge bg-info-subtle text-info me-2">${tb.loai}</span>
                            <span class="${!tb.daDoc ? 'fw-bold' : ''}">${tb.tieuDe}</span>
                            <div class="text-muted small mt-1">${tb.noiDung}</div>
                        </div>
                        <div class="d-flex flex-column align-items-end gap-1 ms-3">
                            <small class="text-muted">${tb.thoiGian}</small>
                            <c:if test="${!tb.daDoc}">
                                <a href="${pageContext.request.contextPath}/thong-bao?action=markRead&id=${tb.id}"
                                   class="btn btn-xs btn-outline-secondary" style="font-size:0.72rem;padding:2px 8px;">
                                    Đã đọc
                                </a>
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

<% if (isAdmin) { %>
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
                        <label class="form-label fw-semibold">Người nhận (để trống = gửi tất cả)</label>
                        <input type="number" class="form-control" name="nguoiNhanId" placeholder="ID tài khoản người nhận"/>
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
<% } %>

<jsp:include page="/views/common/footer.jsp"/>
