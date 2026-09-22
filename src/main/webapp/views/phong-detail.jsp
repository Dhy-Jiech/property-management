<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phòng</title>
</head>
<body>
    <h1>Chi tiết phòng</h1>

    <c:if test="${empty phong}">
        <p>Không tìm thấy phòng.</p>
    </c:if>

    <table border="1" cellpadding="6" cellspacing="0">
        <tr><th>Mã phòng</th><td>${phong.maPhong}</td></tr>
        <tr><th>Tên phòng</th><td>${phong.tenPhong}</td></tr>
        <tr><th>Loại phòng</th><td>${phong.loaiPhong}</td></tr>
        <tr><th>Sức chứa</th><td>${phong.sucChua}</td></tr>
        <tr><th>Số người hiện tại</th><td>${phong.soNguoiHienTai}</td></tr>
        <tr><th>Giá tháng</th><td>${phong.giaThang}</td></tr>
        <tr><th>Trạng thái</th><td>${phong.trangThai}</td></tr>
    </table>

    <p><a href="phong">&larr; Quay lại danh sách</a></p>
</body>
</html>
