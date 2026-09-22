<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý Ký Túc Xá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            width: 100%;
            max-width: 420px;
        }
        .login-header {
            background-color: #ffffff;
            padding: 30px 30px 10px;
            text-align: center;
        }
        .login-header i {
            font-size: 50px;
            color: #0d6efd;
        }
        .login-body {
            background-color: #ffffff;
            padding: 20px 30px 30px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <i class="fa-solid fa-building-user mb-2"></i>
        <h4 class="fw-bold text-dark">HỆ THỐNG QUẢN LÝ KTX</h4>
        <p class="text-muted small">Đăng nhập tài khoản của bạn</p>
    </div>
    <div class="login-body">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                <%= request.getAttribute("errorMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" class="form-control" id="username" name="username" value="${username != null ? username : 'admin'}" placeholder="Nhập username" required>
                </div>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label fw-semibold">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" value="admin123" placeholder="Nhập mật khẩu" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
            </button>
        </form>
        <div class="mt-4 text-center">
            <small class="text-muted">Tài khoản mặc định: <b>admin</b> / <b>admin123</b></small>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
