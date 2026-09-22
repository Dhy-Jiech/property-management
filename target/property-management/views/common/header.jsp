<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.TaiKhoan" %>
<%@ page import="com.example.property.management.model.enums.VaiTro" %>
<%
    TaiKhoan currentUser = (TaiKhoan) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Hệ Thống Quản Lý Ký Túc Xá" %></title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3b82f6;
            --primary-hover: #2563eb;
            --sidebar-bg-start: #0f172a;
            --sidebar-bg-end: #1e293b;
            --body-bg: #f8fafc;
            --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
        }

        body {
            background-color: var(--body-bg);
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: #334155;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.15rem;
            letter-spacing: -0.02em;
            color: #fff !important;
        }

        .sidebar {
            min-height: calc(100vh - 60px);
            background: linear-gradient(180deg, var(--sidebar-bg-start) 0%, var(--sidebar-bg-end) 100%);
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }

        .sidebar .nav-link {
            color: #94a3b8;
            padding: 12px 18px;
            font-size: 0.925rem;
            font-weight: 500;
            border-radius: 10px;
            margin: 4px 12px;
            transition: all 0.2s ease-in-out;
            display: flex;
            align-items: center;
        }

        .sidebar .nav-link:hover {
            color: #f8fafc;
            background-color: rgba(255, 255, 255, 0.08);
            transform: translateX(3px);
        }

        .sidebar .nav-link.active {
            color: #ffffff;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.35);
        }

        .sidebar .nav-link i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        .main-content {
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 14px;
            box-shadow: var(--card-shadow);
        }

        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
        }

        .table thead th {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 16px;
            border-bottom: 1px solid #e2e8f0;
        }

        .table tbody td {
            padding: 14px 16px;
            vertical-align: middle;
            color: #334155;
            font-size: 0.925rem;
            border-bottom: 1px solid #f1f5f9;
        }

        .badge {
            padding: 6px 12px;
            font-weight: 600;
            border-radius: 20px;
            font-size: 0.78rem;
            letter-spacing: 0.02em;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 8px;
            font-weight: 600;
            padding: 8px 18px;
            box-shadow: 0 2px 6px rgba(59, 130, 246, 0.3);
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .btn-outline-primary, .btn-outline-secondary, .btn-outline-danger, .btn-outline-info, .btn-outline-success {
            border-radius: 8px;
            font-weight: 500;
        }
    </style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top py-2 px-3 shadow-sm" style="background-color: #0f172a !important;">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/dashboard">
            <div class="bg-primary text-white rounded-3 p-2 me-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                <i class="fa-solid fa-building-user"></i>
            </div>
            <span>DORM PROPERTY MANAGER</span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <% if (currentUser != null) { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white fw-semibold d-flex align-items-center gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <span class="bg-primary-subtle text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <span><%= currentUser.getUsername() %></span>
                            <span class="badge bg-primary rounded-pill"><%= currentUser.getVaiTro() %></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-id-card me-2 text-primary"></i>Hồ sơ cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="btn btn-outline-light text-white px-3" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Unified Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-0">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa-solid fa-chart-line"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'phong' ? 'active' : ''}" href="${pageContext.request.contextPath}/phong">
                            <i class="fa-solid fa-door-open"></i> Quản lý Phòng
                        </a>
                    </li>
                    <% if (currentUser != null && currentUser.getVaiTro() == VaiTro.ADMIN) { %>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'sinhvien' ? 'active' : ''}" href="${pageContext.request.contextPath}/sinhvien">
                            <i class="fa-solid fa-user-graduate"></i> Quản lý Sinh viên
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'hopdong' ? 'active' : ''}" href="${pageContext.request.contextPath}/hopdong">
                            <i class="fa-solid fa-file-contract"></i> Quản lý Hợp đồng
                        </a>
                    </li>
                    <% } %>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'hoadon' ? 'active' : ''}" href="${pageContext.request.contextPath}/hoadon">
                            <i class="fa-solid fa-file-invoice-dollar"></i> Hóa đơn & Điện nước
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'dangky' ? 'active' : ''}" href="${pageContext.request.contextPath}/dangky">
                            <i class="fa-solid fa-clipboard-check"></i> Đăng ký & Đổi phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'suachua' ? 'active' : ''}" href="${pageContext.request.contextPath}/suachua">
                            <i class="fa-solid fa-wrench"></i> Yêu cầu Sửa chữa
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.active == 'taisan' ? 'active' : ''}" href="${pageContext.request.contextPath}/taisan">
                            <i class="fa-solid fa-boxes-stacked"></i> Quản lý Tài sản
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content Area -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>
                    <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i>
                    <%= request.getAttribute("successMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
