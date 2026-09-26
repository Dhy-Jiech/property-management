<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý Ký Túc Xá</title>
    
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Hiệu ứng xuất hiện cho form */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-card {
            background: #ffffff;
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            animation: fadeInUp 0.6s ease-out;
        }

        .login-header {
            padding: 40px 30px 20px;
            text-align: center;
        }

        .icon-wrapper {
            width: 70px;
            height: 70px;
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin: 0 auto 15px auto;
        }

        .login-body {
            padding: 10px 40px 40px;
        }

        .input-group-text {
            background-color: transparent;
            border-right: none;
            color: #6c757d;
        }

        .form-control {
            border-left: none;
            padding-left: 0;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #dee2e6;
        }

        /* Highlight border khi focus input */
        .input-group:focus-within {
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            border-radius: 0.375rem;
        }
        .input-group:focus-within .input-group-text,
        .input-group:focus-within .form-control {
            border-color: #86b7fe;
        }

        .btn-toggle-pass {
            background: transparent;
            border: 1px solid #dee2e6;
            border-left: none;
            color: #6c757d;
            cursor: pointer;
            border-top-right-radius: 0.375rem;
            border-bottom-right-radius: 0.375rem;
            padding: 0.375rem 0.75rem;
        }

        .input-group:focus-within .btn-toggle-pass {
            border-color: #86b7fe;
        }

        .btn-login {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(13, 110, 253, 0.3);
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <div class="icon-wrapper">
            <i class="fa-solid fa-building-user"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">Hệ Thống Quản Lý KTX</h4>
        <p class="text-muted small mb-0">Vui lòng đăng nhập để tiếp tục</p>
    </div>
    
    <div class="login-body">
        <%-- Khối hiển thị lỗi nếu có --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" style="border-radius: 10px;" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                <small><%= request.getAttribute("errorMessage") %></small>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold small text-dark">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" class="form-control" id="username" name="username" 
                           value="${username != null ? username : 'admin'}" 
                           placeholder="Nhập tên đăng nhập" required>
                </div>
            </div>
            
            <div class="mb-4">
                <label for="password" class="form-label fw-semibold small text-dark">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" 
                           value="admin123" placeholder="Nhập mật khẩu" required>
                    <!-- Nút Ẩn/Hiện mật khẩu -->
                    <button type="button" class="btn-toggle-pass" id="togglePassword">
                        <i class="fa-regular fa-eye"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 btn-login text-white">
                Đăng Nhập <i class="fa-solid fa-arrow-right ms-2"></i>
            </button>
        </form>

        <div class="mt-4 text-center">
            <div class="p-3 bg-light" style="border-radius: 10px;">
                <p class="text-muted small mb-1">Tài khoản mặc định:</p>
                <span class="badge bg-secondary">admin</span> / <span class="badge bg-secondary">admin123</span>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Script xử lý nút Ẩn/Hiện mật khẩu
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    const icon = togglePassword.querySelector('i');

    togglePassword.addEventListener('click', function (e) {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        
        if(type === 'text') {
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });
</script>
</body>
</html>