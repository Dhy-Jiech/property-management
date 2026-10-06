        </main>
    </div>

<!-- Command Palette Modal (Ctrl + K) -->
<div class="modal fade" id="commandModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 520px;">
        <div class="modal-content border shadow-sm" style="border-radius: 4px; background: #FFFFFF;">
            <div class="modal-header border-bottom py-2 px-3" style="background: #F5F4F0;">
                <div class="d-flex align-items-center gap-2 text-muted" style="font-size: 13px; width: 100%;">
                    <i class="ph ph-magnifying-glass"></i>
                    <input type="text" id="commandSearchInput" class="form-control border-0 bg-transparent p-0 shadow-none" placeholder="Gõ lệnh hoặc tìm trang nhanh..." style="font-size: 13px;">
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size: 10px;"></button>
            </div>
            <div class="modal-body p-2" style="max-height: 320px; overflow-y: auto;">
                <div class="label-sm px-2 py-1">Điều hướng nhanh</div>
                <div class="list-group list-group-flush" style="font-size: 13px;">
                    <a href="${pageContext.request.contextPath}/dashboard" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-chart-line-up text-muted"></i> Dashboard tổng quan</div>
                        <span class="kbd-badge">Alt 1</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/phong" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-door text-muted"></i> Quản lý / Xem Phòng</div>
                        <span class="kbd-badge">Alt 2</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/sinhvien" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-student text-muted"></i> Quản lý Sinh viên</div>
                        <span class="kbd-badge">Alt 3</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/khoanphi" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-tag text-muted"></i> Danh mục Khoản phí / Đơn giá</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/dien-nuoc" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-lightning text-muted"></i> Nhập Số Điện Nước</div>
                        <span class="kbd-badge">Alt 4</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/hoadon" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-receipt text-muted"></i> Hóa đơn & Tiền phòng</div>
                        <span class="kbd-badge">Alt 5</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/thong-bao" class="list-group-item list-group-item-action border-0 rounded px-2 py-1.5 d-flex align-items-center justify-content-between">
                        <div><i class="ph ph-bell text-muted"></i> Gửi Thông Báo</div>
                        <span class="kbd-badge">Alt 6</span>
                    </a>
                </div>
            </div>
            <div class="modal-footer border-top py-1.5 px-3" style="background: #F5F4F0; font-size: 11px; color: #666560;">
                <span class="me-3"><kbd class="bg-white border text-dark px-1">↑↓</kbd> để di chuyển</span>
                <span><kbd class="bg-white border text-dark px-1">ESC</kbd> để đóng</span>
            </div>
        </div>
    </div>
</div>

<!-- Reusable Custom Flat Warm-Gray Confirmation Modal -->
<div class="modal fade" id="appConfirmModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 440px;">
        <div class="modal-content border shadow-sm" style="border-radius: 4px; background: #FFFFFF; border-color: #E2E0D8 !important;">
            <div class="modal-header border-bottom py-2.5 px-3" style="background: #F5F4F0;">
                <h6 class="modal-title mb-0 font-sans fw-semibold d-flex align-items-center" id="appConfirmTitle">
                    <i class="ph ph-warning-circle me-2 text-danger fs-5" id="appConfirmIcon"></i>
                    <span id="appConfirmTitleText">Xác nhận thao tác</span>
                </h6>
                <button type="button" class="btn-close py-2" data-bs-dismiss="modal" aria-label="Close" style="font-size: 10px;"></button>
            </div>
            <div class="modal-body p-3 text-dark" style="font-size: 13.5px; line-height: 1.5;" id="appConfirmBody">
                Bạn có chắc chắn muốn thực hiện thao tác này?
            </div>
            <div class="modal-footer border-top py-2 px-3 gap-2" style="background: #F5F4F0;">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="button" class="btn btn-sm btn-danger" id="appConfirmSubmitBtn">
                    <i class="ph ph-check me-1"></i> Đồng ý
                </button>
            </div>
        </div>
    </div>
</div>

<footer class="text-muted text-center py-2" style="border-top: 1px solid #E2E0D8; background-color: #F5F4F0; font-size: 12px;">
    <div class="container">
        <span>&copy; 2026 Dormitory Property Management System. Built with Jakarta EE.</span>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Sidebar toggle for mobile view
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('show');
        });
    }

    // Command Search (Ctrl + K) Modal logic
    const openBtn = document.getElementById('openCommandSearch');
    const commandModalEl = document.getElementById('commandModal');
    let commandModal = null;
    if (commandModalEl) {
        commandModal = new bootstrap.Modal(commandModalEl);
    }
    if (openBtn && commandModal) {
        openBtn.addEventListener('click', () => commandModal.show());
    }
    document.addEventListener('keydown', (e) => {
        if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') {
            e.preventDefault();
            if (commandModal) {
                commandModal.show();
            }
        }
    });

    // Quick filter inside Command Search
    const searchInput = document.getElementById('commandSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase().trim();
            const items = document.querySelectorAll('#commandModal .list-group-item');
            items.forEach(item => {
                const text = item.textContent.toLowerCase();
                item.style.display = text.includes(query) ? 'flex' : 'none';
            });
        });
    }

    // ==========================================
    // Custom Flat Confirmation Modal System
    // ==========================================
    const confirmModalEl = document.getElementById('appConfirmModal');
    let appConfirmBsModal = null;
    let confirmCallback = null;

    if (confirmModalEl) {
        appConfirmBsModal = new bootstrap.Modal(confirmModalEl);
    }

    /**
     * Display Custom Flat Confirmation Dialog
     * @param {Object} opts { title, message, btnText, btnClass, iconClass, onConfirm }
     */
    window.showAppConfirm = function(opts) {
        if (!appConfirmBsModal) return;
        
        const titleText = opts.title || 'Xác nhận thao tác';
        const bodyText = opts.message || 'Bạn có chắc chắn muốn thực hiện thao tác này?';
        const btnText = opts.btnText || 'Xác nhận';
        const btnClass = opts.btnClass || 'btn-danger';
        const iconClass = opts.iconClass || 'ph ph-warning-circle text-danger';

        document.getElementById('appConfirmTitleText').innerText = titleText;
        document.getElementById('appConfirmBody').innerText = bodyText;
        
        const iconEl = document.getElementById('appConfirmIcon');
        if (iconEl) {
            iconEl.className = iconClass + ' me-2 fs-5';
        }

        const submitBtn = document.getElementById('appConfirmSubmitBtn');
        if (submitBtn) {
            submitBtn.className = 'btn btn-sm ' + btnClass;
            submitBtn.innerHTML = '<i class="ph ph-check me-1"></i> ' + btnText;
        }

        confirmCallback = opts.onConfirm || null;
        appConfirmBsModal.show();
    };

    const confirmSubmitBtn = document.getElementById('appConfirmSubmitBtn');
    if (confirmSubmitBtn) {
        confirmSubmitBtn.addEventListener('click', function() {
            if (appConfirmBsModal) {
                appConfirmBsModal.hide();
            }
            if (typeof confirmCallback === 'function') {
                const cb = confirmCallback;
                confirmCallback = null;
                cb();
            }
        });
    }

    // Intercept clicks on links or forms with legacy confirm() or data-confirm
    document.addEventListener('click', function(e) {
        const target = e.target.closest('a[data-confirm], button[data-confirm], a[onclick*="confirm"], button[onclick*="confirm"]');
        if (!target) return;

        // Extract confirm message
        let confirmMsg = target.getAttribute('data-confirm');
        let onclickAttr = target.getAttribute('onclick');

        if (!confirmMsg && onclickAttr && onclickAttr.includes('confirm(')) {
            const match = onclickAttr.match(/confirm\(['"](.*?)['"]\)/);
            if (match && match[1]) {
                confirmMsg = match[1];
            }
        }

        if (confirmMsg) {
            e.preventDefault();
            e.stopPropagation();

            const isDelete = confirmMsg.toLowerCase().includes('xóa');
            const isLock = confirmMsg.toLowerCase().includes('khóa');
            
            let title = 'Xác Nhận Thao Tác';
            let btnText = 'Đồng Ý';
            let btnClass = 'btn-primary';
            let iconClass = 'ph ph-question text-primary';

            if (isDelete) {
                title = 'Xác Nhận Xóa Dữ Liệu';
                btnText = 'Xóa Ngay';
                btnClass = 'btn-danger';
                iconClass = 'ph ph-trash text-danger';
            } else if (isLock) {
                title = 'Xác Nhận Thay Đổi Trạng Thái';
                btnText = 'Thực Hiện';
                btnClass = 'btn-warning';
                iconClass = 'ph ph-lock text-warning';
            }

            window.showAppConfirm({
                title: title,
                message: confirmMsg,
                btnText: btnText,
                btnClass: btnClass,
                iconClass: iconClass,
                onConfirm: function() {
                    if (target.tagName.toLowerCase() === 'a') {
                        window.location.href = target.href;
                    } else if (target.form) {
                        target.form.submit();
                    }
                }
            });
            return false;
        }
    }, true);
</script>
</body>
</html>
