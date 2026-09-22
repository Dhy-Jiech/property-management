<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/common/header.jsp" />

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 text-dark fw-bold mb-0">Hồ Sơ Cá Nhân</h2>
    </div>

    <div class="card border-0 shadow-sm col-md-8 mx-auto">
        <div class="card-body p-4">
            <div class="text-center mb-4">
                <i class="fa-solid fa-circle-user text-primary" style="font-size: 80px;"></i>
                <h4 class="mt-2 fw-bold">${user.username}</h4>
                <span class="badge bg-primary fs-6">${user.vaiTro}</span>
            </div>

            <table class="table table-bordered">
                <tr>
                    <th width="30%">Mã tài khoản</th>
                    <td>${user.id}</td>
                </tr>
                <tr>
                    <th>Tên đăng nhập</th>
                    <td>${user.username}</td>
                </tr>
                <tr>
                    <th>Vai trò hệ thống</th>
                    <td><span class="badge bg-info text-dark">${user.vaiTro}</span></td>
                </tr>
                <tr>
                    <th>Trạng thái tài khoản</th>
                    <td><span class="badge bg-success">${user.trangThai}</span></td>
                </tr>
            </table>

            <div class="text-end">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
