<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>
        Test Database
    </title>

</head>

<body>

<h1>
    Danh sách phòng
</h1>

<table border="1">

    <thead>

        <tr>
            <th>Mã phòng</th>
        </tr>

    </thead>

    <tbody>

        <c:forEach
                var="phong"
                items="${danhSachPhong}">

            <tr>

                <td>
                    ${phong}
                </td>

            </tr>

        </c:forEach>

    </tbody>

</table>

</body>

</html>