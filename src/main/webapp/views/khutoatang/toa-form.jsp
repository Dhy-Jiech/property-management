<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khutoatang"/>
</jsp:include>

<div class="mb-4">
    <h4 class="fw-bold"><i class="fa-solid fa-building text-success me-2"></i>${pageTitle}</h4>
</div>

<div class="card animate-in" style="max-width:500px;">
    <div class="card-body p-4">
        <form method="post" action="${pageContext.request.contextPath}/khu">
            <input type="hidden" name="action" value="${toa != null ? 'updateToa' : 'insertToa'}"/>
            <c:if test="${toa != null}">
                <input type="hidden" name="id" value="${toa.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold">Thuộc Khu <span class="text-danger">*</span></label>
                <select name="khuId" class="form-select" required>
                    <c:forEach var="k" items="${khuList}">
                        <option value="${k.id}" ${(toa != null && toa.khuId eq k.id) ? 'selected' : ''}>${k.tenKhu} (${k.maKhu})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Mã Tòa <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="maToa" required
                       value="${toa != null ? toa.maToa : ''}" placeholder="Ví dụ: TOA_A1"/>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Tên Tòa <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="tenToa" required
                       value="${toa != null ? toa.tenToa : ''}" placeholder="Ví dụ: Tòa A1"/>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success text-white"><i class="fa-solid fa-floppy-disk me-1"></i> Lưu</button>
                <a href="${pageContext.request.contextPath}/khu" class="btn btn-outline-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
