<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="taisan" />
</jsp:include>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 text-dark fw-bold mb-0">Quản Lý Tài Sản & Trang Thiết Bị</h2>
            <p class="text-muted small mb-0">Danh sách tài sản, thiết bị được trang bị tại các phòng ký túc xá.</p>
        </div>
        <a href="${pageContext.request.contextPath}/taisan?action=new" class="btn btn-primary">
            <i class="fa-solid fa-plus me-1"></i> Thêm Tài Sản Mới
        </a>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3 text-center">STT</th>
                            <th>Tên Tài Sản / Thiết Bị</th>
                            <th>Phòng Trang Bị</th>
                            <th class="text-center">Số Lượng</th>
                            <th>Tình Trạng Thiết Bị</th>
                            <th class="text-end pe-3">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${taiSanList}" varStatus="loop">
                            <tr>
                                <td class="ps-3 text-center fw-bold text-secondary">${loop.index + 1}</td>
                                <td class="fw-semibold text-primary">${t.tenTaiSan}</td>
                                <td><span class="badge bg-secondary fs-6">Phòng #${t.phongId}</span></td>
                                <td class="text-center fw-bold">${t.soLuong}</td>
                                <td>
                                    <span class="badge ${t.tinhTrang == 'Tốt' || t.tinhTrang == 'Mới' ? 'bg-success' : 'bg-warning text-dark'}">
                                        ${not empty t.tinhTrang ? t.tinhTrang : 'Bình thường'}
                                    </span>
                                </td>
                                <td class="text-end pe-3">
                                    <a href="${pageContext.request.contextPath}/taisan?action=delete&id=${t.id}" 
                                       class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa tài sản [${t.tenTaiSan}] không?');" title="Xóa">
                                        <i class="fa-solid fa-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty taiSanList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                    Chưa có dữ liệu tài sản nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
