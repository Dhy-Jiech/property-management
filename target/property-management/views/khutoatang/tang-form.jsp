<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="khutoatang"/>
</jsp:include>

<div class="mb-4">
    <h4 class="fw-bold"><i class="fa-solid fa-layer-group text-info me-2"></i>${pageTitle}</h4>
</div>

<div class="card animate-in" style="max-width:500px;">
    <div class="card-body p-4">
        <form method="post" action="${pageContext.request.contextPath}/khu">
            <input type="hidden" name="action" value="${tang != null ? 'updateTang' : 'insertTang'}"/>
            <c:if test="${tang != null}">
                <input type="hidden" name="id" value="${tang.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold">Thuộc Tòa <span class="text-danger">*</span></label>
                <select name="toaId" class="form-select" required>
                    <c:forEach var="t" items="${toaList}">
                        <option value="${t.id}" ${(tang != null && tang.toaId eq t.id) ? 'selected' : ''}>${t.tenToa} (${t.maToa})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Số Tầng (số) <span class="text-danger">*</span></label>
                <input type="number" class="form-control" name="soTang" required min="1"
                       value="${tang != null ? tang.soTang : '1'}"/>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Tên Tầng <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="tenTang" required
                       value="${tang != null ? tang.tenTang : ''}" placeholder="Ví dụ: Tầng 1"/>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-info text-white"><i class="fa-solid fa-floppy-disk me-1"></i> Lưu</button>
                <a href="${pageContext.request.contextPath}/khu" class="btn btn-outline-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
