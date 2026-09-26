<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khutoatang"/>
</jsp:include>

<div class="mb-4">
    <h4 class="fw-bold"><i class="fa-solid fa-building text-primary me-2"></i>${pageTitle}</h4>
</div>

<div class="card animate-in" style="max-width:500px;">
    <div class="card-body p-4">
        <form method="post" action="${pageContext.request.contextPath}/khu">
            <input type="hidden" name="action" value="${khu != null ? 'updateKhu' : 'insertKhu'}"/>
            <c:if test="${khu != null}">
                <input type="hidden" name="id" value="${khu.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mã Khu <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="maKhu" required
                       value="${khu != null ? khu.maKhu : ''}" placeholder="Ví dụ: KHU_A"/>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Tên Khu <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="tenKhu" required
                       value="${khu != null ? khu.tenKhu : ''}" placeholder="Ví dụ: Khu A - Nam"/>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-1"></i> Lưu</button>
                <a href="${pageContext.request.contextPath}/khu" class="btn btn-outline-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
