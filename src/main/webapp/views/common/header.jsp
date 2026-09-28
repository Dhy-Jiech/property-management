<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>
<%
    TaiKhoan currentUser = (TaiKhoan) session.getAttribute("user");
    String active = request.getParameter("active");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Hệ Thống Quản Lý Ký Túc Xá" %></title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary:        #6366f1;
            --primary-dark:   #4f46e5;
            --primary-soft:   #eef2ff;
            --success:        #10b981;
            --warning:        #f59e0b;
            --danger:         #ef4444;
            --info:           #06b6d4;

            /* Đã đổi nền sidebar sang trắng */
            --sidebar-bg:     #ffffff; 
            --sidebar-hover:  #f8fafc;
            --sidebar-active: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);

            --body-bg:        #f5f7fb;
            --card-bg:        #ffffff;
            --text-main:      #1e293b;
            --text-muted:     #64748b;
            --border-soft:    #e2e8f0;

            --shadow-sm: 0 1px 2px rgba(15, 23, 42, 0.04);
            --shadow-md: 0 4px 16px rgba(15, 23, 42, 0.06);
            --shadow-lg: 0 12px 32px rgba(15, 23, 42, 0.08);

            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; }

        body {
            background-color: var(--body-bg);
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: var(--text-main);
            font-size: 14.5px;
            -webkit-font-smoothing: antialiased;
        }

        /* ---------- SCROLLBAR ---------- */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* ---------- TOP NAVBAR ---------- */
        .topbar {
            background: rgba(11, 18, 32, 0.92);
            backdrop-filter: saturate(180%) blur(12px);
            -webkit-backdrop-filter: saturate(180%) blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
            height: 62px;
            padding: 0 20px;
            z-index: 1030;
        }

        .brand-badge {
            width: 38px; height: 38px;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            border-radius: 11px;
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 1rem;
            box-shadow: 0 6px 16px rgba(99, 102, 241, 0.45);
        }

        .brand-text { font-weight: 800; font-size: 1rem; letter-spacing: -0.02em; color: #f8fafc; }
        .brand-sub { font-size: 0.68rem; color: #64748b; font-weight: 500; letter-spacing: 0.08em; text-transform: uppercase; }

        .topbar .user-toggle {
            display: flex; align-items: center; gap: 10px;
            padding: 6px 12px 6px 6px; border-radius: 999px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.06);
            color: #f1f5f9 !important; text-decoration: none;
            transition: all 0.2s ease;
        }
        .topbar .user-toggle:hover { background: rgba(255, 255, 255, 0.08); border-color: rgba(99, 102, 241, 0.4); }

        .avatar-circle {
            width: 32px; height: 32px; border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 0.85rem; font-weight: 700;
        }

        .role-pill {
            font-size: 0.68rem; padding: 3px 9px; border-radius: 999px;
            font-weight: 700; letter-spacing: 0.03em;
            background: rgba(99, 102, 241, 0.18); color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        /* ---------- LAYOUT ---------- */
        .app-shell { display: flex; min-height: calc(100vh - 62px); }

        /* ---------- SIDEBAR (ĐÃ CHUYỂN SANG NỀN TRẮNG) ---------- */
        .sidebar {
            width: 250px;
            flex-shrink: 0;
            background: var(--sidebar-bg); /* Nền trắng */
            border-right: 1px solid var(--border-soft); /* Viền xám nhẹ */
            padding: 18px 12px;
            position: sticky;
            top: 62px;
            height: calc(100vh - 62px);
            overflow-y: auto;
        }

        .sidebar-section {
            font-size: 0.66rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: #94a3b8; /* Màu xám nhẹ cho tiêu đề nhóm */
            font-weight: 700;
            padding: 14px 14px 6px;
        }

        .sidebar .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 14px;
            margin: 2px 0;
            border-radius: 10px;
            color: #475569; /* Chữ màu xám đậm để dễ đọc trên nền trắng */
            font-size: 0.885rem;
            font-weight: 500;
            transition: all 0.18s ease;
            position: relative;
        }

        /* YÊU CẦU: Các kí hiệu (icon) đồng đều màu xám nhẹ */
        .sidebar .nav-link i.nav-icon {
            width: 20px;
            text-align: center;
            font-size: 0.95rem;
            color: #94a3b8; /* Màu xám nhẹ đồng đều */
            transition: color 0.18s ease;
        }

        .sidebar .nav-link:hover {
            color: var(--primary); /* Chữ chuyển màu tím khi hover */
            background: var(--sidebar-hover); /* Nền xám cực nhẹ khi hover */
        }

        /* Icon chuyển màu tím khi hover */
        .sidebar .nav-link:hover i.nav-icon {
            color: var(--primary);
        }

        .sidebar .nav-link.active {
            background: var(--sidebar-active);
            color: #fff;
            box-shadow: 0 6px 18px rgba(99, 102, 241, 0.35);
        }

        /* Khi active, icon chuyển sang màu trắng để nổi bật */
        .sidebar .nav-link.active i.nav-icon {
            color: #ffffff;
            opacity: 1;
        }

        .sidebar .nav-link.active::before {
            content: "";
            position: absolute;
            left: -12px; top: 50%;
            transform: translateY(-50%);
            width: 3px; height: 20px;
            background: var(--primary);
            border-radius: 2px;
        }

        /* ---------- MAIN ---------- */
        .main-content { flex: 1; padding: 28px 32px; min-width: 0; }

        /* ---------- CARD ---------- */
        .card {
            border: 1px solid var(--border-soft);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            background: var(--card-bg);
            transition: box-shadow 0.2s ease, transform 0.2s ease;
        }
        .card:hover { box-shadow: var(--shadow-md); }
        .card-header { background: transparent; border-bottom: 1px solid var(--border-soft); padding: 16px 20px; font-weight: 700; }

        /* ---------- TABLE ---------- */
        .table-responsive { border-radius: var(--radius-md); overflow: hidden; }
        .table { margin-bottom: 0; }
        .table thead th {
            background: #f8fafc; color: #475569; font-weight: 700;
            font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.06em;
            padding: 13px 16px; border-bottom: 1px solid var(--border-soft);
        }
        .table tbody td { padding: 14px 16px; vertical-align: middle; font-size: 0.9rem; border-bottom: 1px solid #f1f5f9; }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr { transition: background 0.15s; }
        .table tbody tr:hover { background: #fafbff; }

        /* ---------- BADGES ---------- */
        .badge { padding: 5px 11px; font-weight: 600; border-radius: 999px; font-size: 0.72rem; letter-spacing: 0.02em; }

        /* ---------- BUTTONS ---------- */
        .btn { border-radius: var(--radius-sm); font-weight: 600; font-size: 0.885rem; transition: all 0.18s ease; }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border: none; box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 6px 18px rgba(99, 102, 241, 0.4); filter: brightness(1.05); }

        /* ---------- ALERTS ---------- */
        .alert { border-radius: var(--radius-md); border: none; box-shadow: var(--shadow-sm); padding: 14px 18px; font-size: 0.9rem; }

        /* ---------- ANIMATIONS ---------- */
        @keyframes fadeUp { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }
        .animate-in { animation: fadeUp 0.35s ease both; }

        /* ---------- RESPONSIVE ---------- */
        @media (max-width: 991.98px) {
            .sidebar {
                position: fixed; left: 0; top: 62px;
                transform: translateX(-100%);
                transition: transform 0.28s ease;
                z-index: 1040; height: calc(100vh - 62px);
                box-shadow: 12px 0 40px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ hơn cho nền trắng */
            }
            .sidebar.show { transform: translateX(0); }
            .main-content { padding: 20px 16px; }
        }
    </style>
</head>
<body>

<!-- ==================== TOP NAVBAR ==================== -->
<nav class="topbar d-flex align-items-center justify-content-between sticky-top">
    <div class="d-flex align-items-center gap-3">
        <button class="btn btn-sm text-white d-lg-none p-1" id="sidebarToggle" type="button">
            <i class="fa-solid fa-bars fa-lg"></i>
        </button>
        <a class="d-flex align-items-center gap-2 text-decoration-none" href="${pageContext.request.contextPath}/dashboard">
            <div class="brand-badge"><i class="fa-solid fa-building-user"></i></div>
            <div class="d-none d-sm-block">
                <div class="brand-text">DORM PROPERTY</div>
                <div class="brand-sub">Management System</div>
            </div>
        </a>
    </div>

    <div class="d-flex align-items-center gap-2">
        <% if (currentUser != null) { %>
            <div class="dropdown">
                <a class="user-toggle dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                    <span class="avatar-circle"><%= currentUser.getUsername().substring(0,1).toUpperCase() %></span>
                    <span class="d-none d-md-inline fw-semibold small"><%= currentUser.getUsername() %></span>
                    <span class="role-pill d-none d-md-inline"><%= currentUser.getVaiTro() %></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 p-2" style="border-radius: 12px; min-width: 220px;">
                    <li class="px-3 py-2">
                        <div class="fw-bold text-dark"><%= currentUser.getUsername() %></div>
                        <div class="small text-muted"><%= currentUser.getVaiTro() %></div>
                    </li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><a class="dropdown-item py-2 rounded-2" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-id-card me-2 text-primary"></i>Hồ sơ cá nhân</a></li>
                    <li><a class="dropdown-item py-2 rounded-2" href="${pageContext.request.contextPath}/doi-mat-khau"><i class="fa-solid fa-key me-2 text-warning"></i>Đổi mật khẩu</a></li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><a class="dropdown-item py-2 rounded-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        <% } else { %>
            <a class="btn btn-outline-light btn-sm px-3" href="${pageContext.request.contextPath}/login">
                <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
            </a>
        <% } %>
    </div>
</nav>

<div class="app-shell">
    <!-- ==================== SIDEBAR ==================== -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-section">Tổng quan</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "dashboard".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/dashboard">
                    <i class="fa-solid fa-chart-line nav-icon"></i> Dashboard
                </a>
            </li>
        </ul>

        <% if (currentUser != null && (currentUser.getVaiTro() == VaiTro.ADMIN || currentUser.getVaiTro() == VaiTro.QUAN_LY)) { %>
        <div class="sidebar-section">Quản trị hệ thống</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "taikhoan".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/taikhoan">
                    <i class="fa-solid fa-users-gear nav-icon"></i> Quản lý Tài khoản
                </a>
            </li>
        </ul>
        <% } %>

        <% if (currentUser != null && (currentUser.getVaiTro() == VaiTro.ADMIN || currentUser.getVaiTro() == VaiTro.QUAN_LY)) { %>
        <div class="sidebar-section">Nghiệp vụ</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "sinhvien".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/sinhvien">
                    <i class="fa-solid fa-user-graduate nav-icon"></i> Quản lý Sinh viên
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= "hopdong".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/hopdong">
                    <i class="fa-solid fa-file-contract nav-icon"></i> Quản lý Hợp đồng
                </a>
            </li>
        </ul>
        <% } else if (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) { %>
        <div class="sidebar-section">Nghiệp vụ</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "hopdong".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/hopdong">
                    <i class="fa-solid fa-file-contract nav-icon"></i> Hợp đồng của tôi
                </a>
            </li>
        </ul>
        <% } %>

        <div class="sidebar-section">Ký túc xá</div>
        <ul class="nav flex-column">
            <% if (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) { %>
                <li class="nav-item">
                    <a class="nav-link <%= "phongcuatoi".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/phong?action=mine">
                        <i class="fa-solid fa-house-user nav-icon"></i> Phòng của tôi
                    </a>
                </li>
                <% } %>

            <li class="nav-item">
                <a class="nav-link <%= "phong".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/phong">
                    <i class="fa-solid fa-door-open nav-icon"></i>
                    <%= (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) ? "Xem Phòng Trống" : "Quản lý Phòng" %>
                </a>
            </li>

            <% if (currentUser != null && currentUser.getVaiTro() != VaiTro.SINH_VIEN) { %>
            <li class="nav-item">
                <a class="nav-link <%= "diennuoc".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/dien-nuoc">
                    <i class="fa-solid fa-bolt nav-icon"></i> Nhập Điện & Nước
                </a>
            </li>
            <% } %>

            <li class="nav-item">
                <a class="nav-link <%= "hoadon".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/hoadon">
                    <i class="fa-solid fa-file-invoice-dollar nav-icon"></i>
                    <%= (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) ? "Hóa đơn & Thanh toán" : "Hóa đơn & Tiền phòng" %>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link <%= "dangky".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/dangky">
                    <i class="fa-solid fa-clipboard-check nav-icon"></i>
                    <%= (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) ? "Đăng ký / Đổi phòng" : "Duyệt Đăng ký" %>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link <%= "suachua".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/suachua">
                    <i class="fa-solid fa-wrench nav-icon"></i>
                    <%= (currentUser != null && currentUser.getVaiTro() == VaiTro.SINH_VIEN) ? "Báo hỏng & Sửa chữa" : "Yêu cầu Sửa chữa" %>
                </a>
            </li>

            <% if (currentUser != null && currentUser.getVaiTro() != VaiTro.SINH_VIEN) { %>
            <li class="nav-item">
                <a class="nav-link <%= "taisan".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/taisan">
                    <i class="fa-solid fa-boxes-stacked nav-icon"></i> Quản lý Tài sản
                </a>
            </li>
            <% } %>
            <li class="nav-item">
                <a class="nav-link <%= "lichsuphong".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/lich-su-phong">
                    <i class="fa-solid fa-clock-rotate-left nav-icon"></i> Lịch Sử Phòng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= "thongbao".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/thong-bao">
                    <i class="fa-solid fa-bell nav-icon"></i> Thông Báo
                </a>
            </li>
        </ul>

        <% if (currentUser != null && (currentUser.getVaiTro() == VaiTro.ADMIN || currentUser.getVaiTro() == VaiTro.QUAN_LY)) { %>
        <div class="sidebar-section">Cấu hình</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "khutoatang".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/khu">
                    <i class="fa-solid fa-building nav-icon"></i> Khu / Tòa / Tầng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= "khoanphi".equals(active) ? "active" : "" %>" href="${pageContext.request.contextPath}/khoan-phi">
                    <i class="fa-solid fa-tags nav-icon"></i> Khoản Phí
                </a>
            </li>
        </ul>
        <% } %>
    </aside>

    <!-- ==================== MAIN CONTENT ==================== -->
    <main class="main-content">

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show animate-in d-flex align-items-center" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2 fa-lg"></i>
                <div><%= request.getAttribute("errorMessage") %></div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success alert-dismissible fade show animate-in d-flex align-items-center" role="alert">
                <i class="fa-solid fa-circle-check me-2 fa-lg"></i>
                <div><%= request.getAttribute("successMessage") %></div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
            </div>
        <% } %>