<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="phong" />
</jsp:include>

<div class="animate-in">

    <!-- Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h1 class="h3 fw-bold mb-1" style="letter-spacing:-0.02em;">
                <i class="fa-solid fa-door-open text-primary me-2"></i>Quản Lý Phòng Ở
            </h1>
            <p class="text-muted small mb-0">
                Danh sách tất cả các phòng thuộc hệ thống ký túc xá
            </p>
        </div>
        <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
            <a href="${pageContext.request.contextPath}/phong?action=new" class="btn btn-primary">
                <i class="fa-solid fa-plus me-2"></i>Thêm Phòng Mới
            </a>
        </c:if>
    </div>

    <!-- Summary chips -->
    <div class="d-flex flex-wrap gap-2 mb-4">
        <div class="summary-chip">
            <span class="chip-dot" style="background: var(--primary);"></span>
            Tổng: <strong>${listPhong.size()}</strong>
        </div>
        <div class="summary-chip">
            <span class="chip-dot" style="background: var(--success);"></span>
            Trống
        </div>
        <div class="summary-chip">
            <span class="chip-dot" style="background: var(--primary);"></span>
            Đang thuê
        </div>
        <div class="summary-chip">
            <span class="chip-dot" style="background: var(--warning);"></span>
            Đặt cọc
        </div>
        <div class="summary-chip">
            <span class="chip-dot" style="background: var(--danger);"></span>
            Bảo trì
        </div>
    </div>

    <!-- Table card -->
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-modern align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4 text-center" style="width:60px;">#</th>
                            <th>Mã Phòng</th>
                            <th>Tên Phòng</th>
                            <th>Vị Trí</th>
                            <th class="text-center">Loại</th>
                            <th class="text-center">Sức Chứa</th>
                            <th class="text-end">Giá Thuê</th>
                            <th class="text-center">Trạng Thái</th>
                            <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                <th class="text-end pe-4" style="width:120px;">Thao Tác</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${listPhong}" varStatus="loop">
                            <tr>
                                <td class="ps-4 text-center text-muted fw-semibold">${loop.index + 1}</td>

                                <td>
                                    <span class="ma-phong">${p.maPhong}</span>
                                </td>

                                <td>
                                    <div class="room-name">${p.tenPhong}</div>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.tang}">
                                            <div class="location-cell">
                                                <i class="fa-solid fa-location-dot text-muted"></i>
                                                <span>${p.tang.toa.khu.tenKhu} · ${p.tang.toa.tenToa} · Tầng ${p.tang.soTang}</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted small"><i class="fa-solid fa-hashtag"></i> Tầng ${p.tangId}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center">
                                    <span class="type-badge">
                                        <c:choose>
                                            <c:when test="${p.loaiPhong == '_4_NGUOI'}">4 người</c:when>
                                            <c:when test="${p.loaiPhong == '_6_NGUOI'}">6 người</c:when>
                                            <c:when test="${p.loaiPhong == '_8_NGUOI'}">8 người</c:when>
                                            <c:otherwise>${p.loaiPhong}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <td class="text-center">
                                    <div class="capacity-cell">
                                        <span class="cap-number ${p.soNguoiHienTai >= p.sucChua ? 'text-danger' : 'text-success'}">
                                            ${p.soNguoiHienTai}
                                        </span>
                                        <span class="cap-sep">/</span>
                                        <span class="cap-total">${p.sucChua}</span>
                                    </div>
                                </td>

                                <td class="text-end fw-bold" style="color: var(--success);">
                                    <fmt:formatNumber value="${p.giaThang}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>

                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.trangThai == 'TRONG'}">
                                            <span class="status-badge status-empty"><span class="status-dot"></span>Trống</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'DANG_DAT_COC'}">
                                            <span class="status-badge status-deposit"><span class="status-dot"></span>Đặt cọc</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'DANG_CHO_THUE'}">
                                            <span class="status-badge status-rented"><span class="status-dot"></span>Đang thuê</span>
                                        </c:when>
                                        <c:when test="${p.trangThai == 'BAO_TRI'}">
                                            <span class="status-badge status-maintenance"><span class="status-dot"></span>Bảo trì</span>
                                        </c:when>
                                    </c:choose>
                                </td>

                                <c:if test="${sessionScope.user.vaiTro ne 'SINH_VIEN'}">
                                    <td class="text-end pe-4">
                                        <div class="action-group">
                                            <a href="${pageContext.request.contextPath}/phong?action=edit&id=${p.id}"
                                               class="btn-icon btn-icon-edit" title="Sửa">
                                                <i class="fa-solid fa-pen"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/phong?action=delete&id=${p.id}"
                                               class="btn-icon btn-icon-delete"
                                               onclick="return confirm('Bạn có chắc muốn xóa phòng [${p.maPhong}]?');"
                                               title="Xóa">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listPhong}">
                            <tr>
                                <td colspan="9">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-folder-open"></i>
                                        <div class="empty-title">Chưa có phòng nào</div>
                                        <div class="empty-sub">Bắt đầu bằng cách thêm phòng đầu tiên</div>
                                        <a href="${pageContext.request.contextPath}/phong?action=new" class="btn btn-primary btn-sm mt-3">
                                            <i class="fa-solid fa-plus me-1"></i> Thêm phòng
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<style>
    /* Summary chips */
    .summary-chip {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: #fff;
        padding: 8px 14px;
        border-radius: 10px;
        border: 1px solid var(--border-soft);
        font-size: 0.82rem;
        color: var(--text-muted);
        box-shadow: var(--shadow-sm);
    }
    .summary-chip strong { color: var(--text-main); }
    .chip-dot {
        width: 8px; height: 8px;
        border-radius: 50%;
    }

    /* Table */
    .table-modern thead th {
        background: #f8fafc;
        color: #475569;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.06em;
        padding: 14px 12px;
        border-bottom: 1px solid var(--border-soft);
        white-space: nowrap;
    }
    .table-modern tbody td {
        padding: 14px 12px;
        font-size: 0.9rem;
        border-bottom: 1px solid #f1f5f9;
        vertical-align: middle;
    }
    .table-modern tbody tr:last-child td { border-bottom: none; }
    .table-modern tbody tr { transition: background 0.15s; }
    .table-modern tbody tr:hover { background: #fafbff; }

    /* Ma phong */
    .ma-phong {
        display: inline-block;
        background: linear-gradient(135deg, #1e293b, #334155);
        color: #fff;
        font-weight: 700;
        font-size: 0.78rem;
        padding: 5px 11px;
        border-radius: 7px;
        letter-spacing: 0.03em;
    }

    /* Room name */
    .room-name {
        font-weight: 700;
        color: var(--text-main);
        font-size: 0.92rem;
    }

    /* Location */
    .location-cell {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.85rem;
        color: var(--text-muted);
    }

    /* Type badge */
    .type-badge {
        display: inline-block;
        background: #eff6ff;
        color: #1d4ed8;
        padding: 5px 12px;
        border-radius: 8px;
        font-size: 0.78rem;
        font-weight: 700;
    }

    /* Capacity */
    .capacity-cell {
        display: inline-flex;
        align-items: baseline;
        gap: 3px;
        font-size: 0.95rem;
    }
    .cap-number { font-weight: 800; }
    .cap-sep { color: #cbd5e1; }
    .cap-total { color: var(--text-muted); font-weight: 600; }

    /* Status badge */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 5px 11px;
        border-radius: 999px;
        font-size: 0.75rem;
        font-weight: 700;
    }
    .status-dot {
        width: 6px; height: 6px;
        border-radius: 50%;
        background: currentColor;
    }
    .status-empty       { background: #d1fae5; color: #047857; }
    .status-deposit     { background: #fef3c7; color: #b45309; }
    .status-rented      { background: #e0e7ff; color: #4338ca; }
    .status-maintenance { background: #fee2e2; color: #b91c1c; }

    /* Action buttons */
    .action-group {
        display: inline-flex;
        gap: 6px;
    }
    .btn-icon {
        width: 34px; height: 34px;
        border-radius: 9px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 0.8rem;
        border: 1.5px solid;
        transition: all 0.18s ease;
        text-decoration: none;
    }
    .btn-icon-edit {
        color: var(--warning);
        border-color: #fde68a;
        background: #fffbeb;
    }
    .btn-icon-edit:hover {
        background: var(--warning);
        color: #fff;
        border-color: var(--warning);
        transform: translateY(-1px);
    }
    .btn-icon-delete {
        color: var(--danger);
        border-color: #fecaca;
        background: #fef2f2;
    }
    .btn-icon-delete:hover {
        background: var(--danger);
        color: #fff;
        border-color: var(--danger);
        transform: translateY(-1px);
    }

    /* Empty state */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--text-muted);
    }
    .empty-state > i {
        font-size: 3rem;
        color: #cbd5e1;
        margin-bottom: 16px;
    }
    .empty-title {
        font-weight: 700;
        color: var(--text-main);
        font-size: 1rem;
        margin-bottom: 4px;
    }
    .empty-sub { font-size: 0.85rem; }
</style>

<jsp:include page="/views/common/footer.jsp" />