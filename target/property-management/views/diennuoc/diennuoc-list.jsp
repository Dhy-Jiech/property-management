<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="diennuoc" />
</jsp:include>

<div class="animate-in">

    <!-- Page Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h1 class="h3 fw-bold mb-1" style="letter-spacing:-0.02em;">
                <i class="fa-solid fa-bolt text-warning me-2"></i>Quản Lý Điện & Nước
            </h1>
            <p class="text-muted small mb-0">
                Nhập chỉ số hàng tháng — hệ thống tự động tính sản lượng và thành tiền
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/dien-nuoc?action=new" class="btn btn-primary">
            <i class="fa-solid fa-plus me-2"></i>Nhập Chỉ Số Mới
        </a>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-pills custom-pills mb-4" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="pills-dien-tab" data-bs-toggle="pill" data-bs-target="#pills-dien" type="button" role="tab">
                <i class="fa-solid fa-plug me-2"></i>Chỉ Số Điện (kWh)
                <span class="pill-count">${dienList.size()}</span>
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-nuoc-tab" data-bs-toggle="pill" data-bs-target="#pills-nuoc" type="button" role="tab">
                <i class="fa-solid fa-droplet me-2"></i>Chỉ Số Nước (m³)
                <span class="pill-count">${nuocList.size()}</span>
            </button>
        </li>
    </ul>

    <div class="tab-content" id="pills-tabContent">

        <!-- ============ ĐIỆN ============ -->
        <div class="tab-pane fade show active" id="pills-dien" role="tabpanel">
            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-modern align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Kỳ Tháng</th>
                                    <th>Phòng</th>
                                    <th class="text-center">Chỉ Số Cũ</th>
                                    <th class="text-center">Chỉ Số Mới</th>
                                    <th class="text-center">Tiêu Thụ</th>
                                    <th class="text-end">Đơn Giá</th>
                                    <th class="text-end pe-4">Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cd" items="${dienList}">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="period-badge">
                                                <i class="fa-regular fa-calendar"></i> ${cd.kyThang}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="room-cell">
                                                <span class="room-icon"><i class="fa-solid fa-door-open"></i></span>
                                                <div>
                                                    <div class="fw-semibold">${cd.phong.tenPhong}</div>
                                                    <div class="small text-muted">${cd.phong.maPhong}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center text-muted">${cd.chiSoCu}</td>
                                        <td class="text-center fw-semibold">${cd.chiSoMoi}</td>
                                        <td class="text-center">
                                            <span class="usage-badge usage-warning">
                                                <i class="fa-solid fa-arrow-trend-up"></i>
                                                ${cd.chiSoMoi - cd.chiSoCu} kWh
                                            </span>
                                        </td>
                                        <td class="text-end text-muted small">
                                            <fmt:formatNumber value="${cd.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                        <td class="text-end pe-4 fw-bold" style="color: var(--danger);">
                                            <fmt:formatNumber value="${cd.tienDien}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty dienList}">
                                    <tr>
                                        <td colspan="7">
                                            <div class="empty-state">
                                                <i class="fa-solid fa-bolt"></i>
                                                <div class="empty-title">Chưa có chỉ số điện nào</div>
                                                <div class="empty-sub">Bắt đầu bằng cách nhập chỉ số cho kỳ này</div>
                                                <a href="${pageContext.request.contextPath}/dien-nuoc?action=new" class="btn btn-primary btn-sm mt-3">
                                                    <i class="fa-solid fa-plus me-1"></i> Nhập chỉ số điện
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

        <!-- ============ NƯỚC ============ -->
        <div class="tab-pane fade" id="pills-nuoc" role="tabpanel">
            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-modern align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Kỳ Tháng</th>
                                    <th>Phòng</th>
                                    <th class="text-center">Chỉ Số Cũ</th>
                                    <th class="text-center">Chỉ Số Mới</th>
                                    <th class="text-center">Tiêu Thụ</th>
                                    <th class="text-end">Đơn Giá</th>
                                    <th class="text-end pe-4">Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cn" items="${nuocList}">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="period-badge">
                                                <i class="fa-regular fa-calendar"></i> ${cn.kyThang}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="room-cell">
                                                <span class="room-icon"><i class="fa-solid fa-door-open"></i></span>
                                                <div>
                                                    <div class="fw-semibold">${cn.phong.tenPhong}</div>
                                                    <div class="small text-muted">${cn.phong.maPhong}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center text-muted">${cn.chiSoCu}</td>
                                        <td class="text-center fw-semibold">${cn.chiSoMoi}</td>
                                        <td class="text-center">
                                            <span class="usage-badge usage-info">
                                                <i class="fa-solid fa-arrow-trend-up"></i>
                                                ${cn.chiSoMoi - cn.chiSoCu} m³
                                            </span>
                                        </td>
                                        <td class="text-end text-muted small">
                                            <fmt:formatNumber value="${cn.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                        <td class="text-end pe-4 fw-bold" style="color: var(--danger);">
                                            <fmt:formatNumber value="${cn.tienNuoc}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty nuocList}">
                                    <tr>
                                        <td colspan="7">
                                            <div class="empty-state">
                                                <i class="fa-solid fa-droplet"></i>
                                                <div class="empty-title">Chưa có chỉ số nước nào</div>
                                                <div class="empty-sub">Bắt đầu bằng cách nhập chỉ số cho kỳ này</div>
                                                <a href="${pageContext.request.contextPath}/dien-nuoc?action=new" class="btn btn-primary btn-sm mt-3">
                                                    <i class="fa-solid fa-plus me-1"></i> Nhập chỉ số nước
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
    </div>
</div>

<style>
    /* Custom Pills */
    .custom-pills {
        background: #fff;
        padding: 6px;
        border-radius: 14px;
        border: 1px solid var(--border-soft);
        display: inline-flex;
        gap: 4px;
        box-shadow: var(--shadow-sm);
    }
    .custom-pills .nav-link {
        border-radius: 10px;
        padding: 10px 18px;
        font-weight: 600;
        font-size: 0.88rem;
        color: var(--text-muted);
        display: flex;
        align-items: center;
        gap: 4px;
        transition: all 0.2s ease;
        border: none;
    }
    .custom-pills .nav-link:hover {
        color: var(--primary);
        background: var(--primary-soft);
    }
    .custom-pills .nav-link.active {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: #fff;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
    }
    .custom-pills .nav-link.active i { color: #fff !important; }
    .pill-count {
        background: rgba(0,0,0,0.08);
        padding: 1px 8px;
        border-radius: 999px;
        font-size: 0.72rem;
        font-weight: 700;
        margin-left: 4px;
    }
    .custom-pills .nav-link.active .pill-count {
        background: rgba(255,255,255,0.25);
    }

    /* Table modern */
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

    /* Period badge */
    .period-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: var(--primary-soft);
        color: var(--primary-dark);
        padding: 5px 12px;
        border-radius: 8px;
        font-weight: 700;
        font-size: 0.82rem;
    }

    /* Room cell */
    .room-cell {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .room-icon {
        width: 36px;
        height: 36px;
        border-radius: 10px;
        background: #f1f5f9;
        color: #64748b;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.85rem;
        flex-shrink: 0;
    }

    /* Usage badge */
    .usage-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 5px 12px;
        border-radius: 999px;
        font-weight: 700;
        font-size: 0.78rem;
    }
    .usage-warning {
        background: #fef3c7;
        color: #b45309;
    }
    .usage-info {
        background: #cffafe;
        color: #0e7490;
    }

    /* Empty state */
    .empty-state {
        text-align: center;
        padding: 50px 20px;
        color: var(--text-muted);
    }
    .empty-state > i {
        font-size: 2.5rem;
        color: #cbd5e1;
        margin-bottom: 14px;
    }
    .empty-title {
        font-weight: 700;
        color: var(--text-main);
        font-size: 0.95rem;
        margin-bottom: 4px;
    }
    .empty-sub { font-size: 0.85rem; }
</style>

<jsp:include page="/views/common/footer.jsp" />