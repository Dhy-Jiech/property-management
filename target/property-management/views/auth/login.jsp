<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Quản Lý Ký Túc Xá</title>
    
    <!-- Google Fonts: Public Sans & IBM Plex Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:ital,wght@0,400;0,500;0,600;1,400&family=Public+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-warm: #F5F4F0;
            --surface: #FFFFFF;
            --surface-subtle: #EBEAE5;
            --text-main: #1C1C1A;
            --text-muted: #666560;
            --border-color: #E2E0D8;
            --accent-cobalt: #2B4ACB;
            --accent-hover: #1E39A8;
            --status-danger: #A82E2E;
            --radius-sm: 4px;
            --font-sans: 'Public Sans', sans-serif;
            --font-mono: 'IBM Plex Mono', monospace;
        }

        body {
            font-family: var(--font-sans);
            background-color: var(--bg-warm);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }

        .login-card {
            background: var(--surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            width: 100%;
            max-width: 380px;
            box-shadow: none;
        }

        .login-header {
            padding: 24px 24px 16px;
            border-bottom: 1px solid var(--border-color);
            background-color: var(--surface-subtle);
        }

        .login-body {
            padding: 24px;
        }

        .font-mono {
            font-family: var(--font-mono);
        }

        .form-control {
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            font-size: 13px;
            padding: 7px 11px;
            background-color: var(--surface);
            color: var(--text-main);
            box-shadow: none !important;
        }

        .form-control:focus {
            border-color: var(--accent-cobalt);
        }

        .btn-login {
            background-color: var(--accent-cobalt);
            border: 1px solid var(--accent-cobalt);
            border-radius: var(--radius-sm);
            padding: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #FFFFFF;
        }

        .btn-login:hover {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
            color: #FFFFFF;
        }

        .btn-toggle-pass {
            background: var(--surface-subtle);
            border: 1px solid var(--border-color);
            border-left: none;
            color: var(--text-muted);
            font-size: 12px;
            padding: 0 10px;
            border-top-right-radius: var(--radius-sm);
            border-bottom-right-radius: var(--radius-sm);
        }

        .alert-danger {
            background-color: #FDF2F2;
            border: 1px solid #F8D7DA;
            color: var(--status-danger);
            border-radius: var(--radius-sm);
            font-size: 12.5px;
            padding: 8px 12px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header text-center">
        <div class="d-inline-flex align-items-center justify-content-center bg-dark text-white rounded p-2 mb-2" style="width: 32px; height: 32px; font-size: 14px;">
            <i class="fa-solid fa-building"></i>
        </div>
        <h5 class="fw-bold text-dark mb-1" style="font-size: 16px;">DORM PROPERTY MANAGEMENT</h5>
        <p class="text-muted small mb-0" style="font-size: 12px;">Đăng nhập tài khoản hệ thống</p>
    </div>
    
    <div class="login-body">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger mb-3 d-flex align-items-center" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                <div><%= request.getAttribute("errorMessage") %></div>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold small text-dark mb-1">Tên đăng nhập</label>
                <input type="text" class="form-control font-mono" id="username" name="username" 
                       value="${username != null ? username : 'admin'}" 
                       placeholder="Nhập tên đăng nhập" required>
            </div>
            
            <div class="mb-4">
                <label for="password" class="form-label fw-semibold small text-dark mb-1">Mật khẩu</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" 
                           value="admin123" placeholder="Nhập mật khẩu" required style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                    <button type="button" class="btn-toggle-pass" id="togglePassword">
                        <i class="fa-regular fa-eye"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-login w-100 mb-3">
                Đăng Nhập <i class="fa-solid fa-arrow-right ms-1"></i>
            </button>
        </form>

        <div class="p-2 border rounded bg-light text-center" style="border-color: #E2E0D8 !important; font-size: 11px; color: #666560;">
            <span class="fw-semibold">Tài khoản mẫu:</span> <code class="font-mono text-dark">admin</code> / <code class="font-mono text-dark">admin123</code>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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