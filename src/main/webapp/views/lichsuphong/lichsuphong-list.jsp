<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="lichsuphong"/>
</jsp:include>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-1"><i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>Lịch Sử Thuê & Đổi Phòng</h4>
        <p class="text-muted small mb-0">Theo dõi quá trình chuyển phòng và ở ký túc xá của sinh viên</p>
    </div>
</div>

<div class="card animate-in">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Thời Gian</th>
                        <th>Sinh Viên</th>
                        <th>Phòng Cũ</th>
                        <th>Phòng Mới</th>
                        <th>Lý Do</th>
                        <th>Người Xử Lý</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ls" items="${lichSuList}" varStatus="st">
                        <tr>
                            <td>${st.count}</td>
                            <td class="text-muted small">${ls.thoiGian}</td>
                            <td class="fw-semibold text-primary">${ls.tenSinhVien} (ID: ${ls.sinhVienId})</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty ls.maPhongCu}">
                                        <span class="badge bg-secondary-subtle text-secondary">${ls.maPhongCu}</span>
                                    </c:when>
                                    <c:otherwise><span class="text-muted fs-7">--</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty ls.maPhongMoi}">
                                        <span class="badge bg-success-subtle text-success">${ls.maPhongMoi}</span>
                                    </c:when>
                                    <c:otherwise><span class="text-muted fs-7">--</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${ls.lyDo}</td>
                            <td><span class="badge bg-info-subtle text-info">${ls.nguoiXuLy != null ? ls.nguoiXuLy : 'Hệ thống'}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty lichSuList}">
                        <tr><td colspan="7" class="text-center text-muted py-4">Chưa có lịch sử phòng nào.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
