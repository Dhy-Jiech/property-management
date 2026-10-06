<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.TaiKhoan, com.example.property.management.model.enums.VaiTro" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    TaiKhoan currentUser = (TaiKhoan) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String activeMenu = request.getParameter("active");
    if (activeMenu == null) activeMenu = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Hệ Thống Quản Lý Ký Túc Xá"}</title>
    
    <!-- Google Fonts: Public Sans & IBM Plex Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:ital,wght@0,400;0,500;0,600;1,400&family=Public+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Single Icon Set: Phosphor Icons (Regular 1.5 stroke style) -->
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@phosphor-icons/web@2.1.1/src/regular/style.css">
    <!-- FontAwesome 6 Fallback -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            /* Engineering Design Tokens */
            --bg-warm: #F5F4F0;
            --surface: #FFFFFF;
            --surface-subtle: #EBEAE5;
            --surface-hover: #EFEFEA;
            --text-main: #1C1C1A;
            --text-muted: #666560;
            --border-color: #E2E0D8;
            --accent-cobalt: #2B4ACB;
            --accent-hover: #1E39A8;
            --status-success: #1E7E34;
            --status-danger: #A82E2E;
            --status-warning: #B45309;
            --radius-sm: 4px;
            --font-sans: 'Public Sans', sans-serif;
            --font-mono: 'IBM Plex Mono', monospace;
        }

        body {
            font-family: var(--font-sans);
            background-color: var(--bg-warm);
            color: var(--text-main);
            margin: 0;
            font-size: 13.5px;
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
        }

        /* Typography Helpers */
        .font-mono {
            font-family: var(--font-mono);
            font-variant-numeric: tabular-nums;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: var(--font-sans);
            font-weight: 600;
            color: var(--text-main);
            letter-spacing: -0.01em;
        }
        h3 { font-size: 20px; }
        h4 { font-size: 17px; }
        h5 { font-size: 15px; }

        /* Icon Spacing Requirement (8px exact spacing) */
        i, svg, .ph, [class*="ph-"], [class^="ph-"] {
            margin-right: 8px !important;
            vertical-align: -0.125em;
        }
        .btn i, .btn .ph, .nav-link i, .nav-link .ph, .dropdown-item i, .dropdown-item .ph, .list-group-item i, .list-group-item .ph {
            margin-right: 8px !important;
        }
        .me-1, .me-1\.5, .me-2 {
            margin-right: 8px !important;
        }

        /* Topbar Header */
        .topbar {
            height: 48px;
            background-color: var(--surface);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .topbar-brand {
            font-weight: 700;
            font-size: 14px;
            color: var(--text-main);
            text-decoration: none;
            display: flex;
            align-items: center;
            letter-spacing: -0.01em;
        }

        /* Topbar Right Container Offset (prevents browser translation/extension icon overlap) */
        .topbar-right-actions {
            margin-right: 42px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .command-search-btn {
            background-color: var(--bg-warm);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            padding: 4px 10px;
            font-size: 12px;
            color: var(--text-muted);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: border-color 0.15s ease;
        }
        .command-search-btn:hover {
            border-color: var(--accent-cobalt);
            color: var(--text-main);
        }

        .kbd-badge {
            background-color: var(--surface);
            border: 1px solid var(--border-color);
            border-radius: 3px;
            padding: 1px 5px;
            font-family: var(--font-mono);
            font-size: 10px;
            color: var(--text-main);
        }

        /* Sidebar Navigation */
        .app-layout {
            display: flex;
            min-height: calc(100vh - 48px);
        }

        .sidebar {
            width: 230px;
            background-color: var(--surface);
            border-right: 1px solid var(--border-color);
            padding: 12px 0;
            flex-shrink: 0;
        }

        .sidebar-section {
            padding: 8px 16px 4px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: var(--text-muted);
        }

        .nav-item {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 7px 16px;
            color: var(--text-main);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            border-left: 2px solid transparent;
            transition: background 0.12s ease;
        }

        .nav-link:hover {
            background-color: var(--surface-hover);
            color: var(--text-main);
        }

        .nav-link.active {
            background-color: var(--surface-subtle);
            border-left-color: var(--accent-cobalt);
            color: var(--accent-cobalt);
            font-weight: 600;
        }

        .nav-link.active i, .nav-link.active .ph {
            color: var(--accent-cobalt);
        }

        /* Main Content Panel */
        .main-content {
            flex-grow: 1;
            padding: 20px 24px;
            background-color: var(--bg-warm);
        }

        /* Flat Components */
        .card {
            background-color: var(--surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            box-shadow: none !important;
        }

        .card-header {
            background-color: var(--surface-subtle);
            border-bottom: 1px solid var(--border-color);
            padding: 10px 14px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-main);
        }

        .card-body {
            padding: 14px;
        }

        /* High-Density Data Tables */
        .table {
            color: var(--text-main);
            font-size: 13px;
            border-color: var(--border-color);
            margin-bottom: 0;
        }

        .table > thead {
            background-color: var(--surface-subtle);
        }

        .table > thead > tr > th {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border-color);
            padding: 8px 12px;
            white-space: nowrap;
        }

        .table > tbody > tr {
            height: 36px;
        }

        .table > tbody > tr > td {
            padding: 6px 12px;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .table-hover > tbody > tr:hover {
            background-color: var(--surface-hover);
        }

        /* Status Dot Indicator */
        .status-dot-wrapper {
            display: inline-flex;
            align-items: center;
            font-size: 12px;
            font-weight: 500;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px !important;
            flex-shrink: 0;
        }

        .dot-active { background-color: var(--status-success); }
        .dot-locked { background-color: var(--status-danger); }
        .dot-pending { background-color: var(--status-warning); }

        /* Role Badges */
        .role-tag {
            font-family: var(--font-mono);
            font-size: 11px;
            padding: 2px 6px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-color);
            background-color: var(--surface-subtle);
            color: var(--text-main);
            font-weight: 500;
            display: inline-block;
        }

        /* Buttons */
        .btn {
            font-size: 13px;
            border-radius: var(--radius-sm);
            padding: 5px 12px;
            font-weight: 500;
            box-shadow: none !important;
        }
        .btn-sm {
            font-size: 12px;
            padding: 3px 8px;
        }
        .btn-primary {
            background-color: var(--accent-cobalt);
            border-color: var(--accent-cobalt);
            color: #FFFFFF;
        }
        .btn-primary:hover {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
            color: #FFFFFF;
        }
        .btn-outline-secondary {
            border-color: var(--border-color);
            color: var(--text-main);
            background-color: var(--surface);
        }
        .btn-outline-secondary:hover {
            background-color: var(--surface-hover);
            border-color: var(--border-color);
            color: var(--text-main);
        }

        /* Form Inputs */
        .form-control, .form-select {
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            font-size: 13px;
            padding: 5px 10px;
            background-color: var(--surface);
            color: var(--text-main);
            box-shadow: none !important;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--accent-cobalt);
        }
        .form-label {
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 4px;
            color: var(--text-main);
        }

        /* Metric Strip Bar */
        .metric-strip {
            display: flex;
            background-color: var(--surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            margin-bottom: 16px;
        }
        .metric-item {
            flex: 1;
            padding: 12px 16px;
            border-right: 1px solid var(--border-color);
        }
        .metric-item:last-child {
            border-right: none;
        }
        .metric-label {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: var(--text-muted);
            margin-bottom: 4px;
        }
        .metric-val {
            font-family: var(--font-mono);
            font-size: 20px;
            font-weight: 600;
            color: var(--text-main);
            line-height: 1.2;
        }

        .label-sm {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<!-- Top Navigation Bar -->
<div class="topbar">
    <div class="d-flex align-items-center gap-3">
        <button class="btn btn-sm btn-outline-secondary d-md-none" id="sidebarToggle">
            <i class="ph ph-list"></i>
        </button>
        <a href="${pageContext.request.contextPath}/dashboard" class="topbar-brand">
            <i class="ph ph-buildings me-2 text-dark"></i>
            DORM MANAGEMENT SYSTEM
        </a>
    </div>

    <!-- Topbar Right Actions Container (Offset 42px from right to prevent browser extension overlap) -->
    <div class="topbar-right-actions">
        <!-- Command Search Palette Toggle -->
        <button class="command-search-btn" id="openCommandSearch" type="button">
            <i class="ph ph-magnifying-glass"></i>
            <span>Tìm nhanh / Lệnh...</span>
            <span class="kbd-badge">Ctrl K</span>
        </button>

        <!-- User Profile Dropdown -->
        <div class="dropdown">
            <a href="#" class="text-decoration-none text-dark d-flex align-items-center gap-1 dropdown-toggle" data-bs-toggle="dropdown" style="font-size: 13px;">
                <i class="ph ph-user-circle fs-5 me-1"></i>
                <span class="fw-semibold"><%= currentUser.getUsername() %></span>
                <span class="role-tag ms-1"><%= currentUser.getVaiTro() %></span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-sm border mt-1" style="font-size: 13px; border-radius: 4px;">
                <li>
                    <span class="dropdown-item-text text-muted" style="font-size: 11px;">
                        Tài khoản ID: <strong class="font-mono">#<%= currentUser.getId() %></strong>
                    </span>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
                        <i class="ph ph-sign-out me-2"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="app-layout">
    <!-- Sidebar Navigation Menu -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-section">Tổng quan</div>
        <ul class="nav-item mb-2">
            <li>
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link <%= "dashboard".equals(activeMenu) ? "active" : "" %>">
                    <i class="ph ph-chart-line-up"></i> Dashboard
                </a>
            </li>
        </ul>

        <% if (currentUser.getVaiTro() == VaiTro.ADMIN) { %>
            <div class="sidebar-section">Hệ thống & Cấu hình</div>
            <ul class="nav-item mb-2">
                <li>
                    <a href="${pageContext.request.contextPath}/taikhoan" class="nav-link <%= "taikhoan".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-users-three"></i> Quản lý Tài khoản
                    </a>
                </li>
            </ul>
        <% } %>

        <% if (currentUser.getVaiTro() != VaiTro.SINH_VIEN) { %>
            <div class="sidebar-section">Vận hành KTX</div>
            <ul class="nav-item mb-2">
                <li>
                    <a href="${pageContext.request.contextPath}/phong" class="nav-link <%= "phong".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-door"></i> Quản lý Phòng
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/sinhvien" class="nav-link <%= "sinhvien".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-student"></i> Hồ sơ Sinh viên
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/hopdong" class="nav-link <%= "hopdong".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-file-text"></i> Hợp đồng Lưu trú
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/dangky" class="nav-link <%= "dangky".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-clipboard-text"></i> Đăng ký & Đổi phòng
                    </a>
                </li>
            </ul>

            <div class="sidebar-section">Tài chính & Dịch vụ</div>
            <ul class="nav-item mb-2">
                <li>
                    <a href="${pageContext.request.contextPath}/khoanphi" class="nav-link <%= "khoanphi".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-tag"></i> Danh mục Khoản phí
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/dien-nuoc" class="nav-link <%= "diennuoc".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-lightning"></i> Điện nước Hàng tháng
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/hoadon" class="nav-link <%= "hoadon".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-receipt"></i> Hóa đơn & Tiền phòng
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/suachua" class="nav-link <%= "suachua".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-wrench"></i> Sự cố & Sửa chữa
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/taisan" class="nav-link <%= "taisan".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-package"></i> Tài sản & Thiết bị
                    </a>
                </li>
            </ul>

            <div class="sidebar-section">Báo cáo & Nhãn</div>
            <ul class="nav-item mb-2">
                <li>
                    <a href="${pageContext.request.contextPath}/lich-su-phong" class="nav-link <%= "lichsu".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-clock-counter-clockwise"></i> Nhật ký Lưu trú
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/thong-bao" class="nav-link <%= "thongbao".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-bell"></i> Thông báo Chung
                    </a>
                </li>
            </ul>
        <% } else { %>
            <div class="sidebar-section">Dành cho Sinh viên</div>
            <ul class="nav-item mb-2">
                <li>
                    <a href="${pageContext.request.contextPath}/hoadon" class="nav-link <%= "hoadon".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-receipt"></i> Hóa đơn của tôi
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/dangky" class="nav-link <%= "dangky".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-clipboard-text"></i> Đăng ký / Đổi phòng
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/suachua" class="nav-link <%= "suachua".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-wrench"></i> Báo hỏng thiết bị
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/thong-bao" class="nav-link <%= "thongbao".equals(activeMenu) ? "active" : "" %>">
                        <i class="ph ph-bell"></i> Thông báo
                    </a>
                </li>
            </ul>
        <% } %>
    </div>

    <!-- Main Workspace Content Area -->
    <main class="main-content">
        <c:if test="${not empty sessionScope.flashSuccess}">
            <div class="alert alert-success alert-dismissible fade show border py-2 px-3 mb-3" style="background:#F2F9F4; border-color:#C3E6CB !important; color:#1E7E34; font-size:13px; border-radius:4px;" role="alert">
                <i class="ph ph-check-circle me-2"></i> ${sessionScope.flashSuccess}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("flashSuccess"); %>
        </c:if>
        <c:if test="${not empty sessionScope.flashError}">
            <div class="alert alert-danger alert-dismissible fade show border py-2 px-3 mb-3" style="background:#FDF2F2; border-color:#F8D7DA !important; color:#A82E2E; font-size:13px; border-radius:4px;" role="alert">
                <i class="ph ph-warning-circle me-2"></i> ${sessionScope.flashError}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("flashError"); %>
        </c:if>