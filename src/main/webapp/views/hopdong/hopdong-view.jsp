<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.property.management.model.HopDong" %>
<%@ page import="com.example.property.management.model.SinhVien" %>
<%@ page import="com.example.property.management.model.Phong" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<jsp:include page="/views/common/header.jsp">
    <jsp:param name="active" value="hopdong" />
</jsp:include>

<%
    HopDong hd = (HopDong) request.getAttribute("hopDong");
    SinhVien sv = (hd != null) ? hd.getSinhVien() : null;
    Phong p = (hd != null) ? hd.getPhong() : null;
    
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    String ngayBDStr = (hd != null && hd.getNgayBatDau() != null) ? hd.getNgayBatDau().format(fmt) : "..../..../20....";
    String ngayKTStr = (hd != null && hd.getNgayKetThuc() != null) ? hd.getNgayKetThuc().format(fmt) : "..../..../20....";
    
    int todayDay = (hd != null && hd.getCreatedAt() != null) ? hd.getCreatedAt().getDayOfMonth() : java.time.LocalDate.now().getDayOfMonth();
    int todayMonth = (hd != null && hd.getCreatedAt() != null) ? hd.getCreatedAt().getMonthValue() : java.time.LocalDate.now().getMonthValue();
    int todayYear = (hd != null && hd.getCreatedAt() != null) ? hd.getCreatedAt().getYear() : java.time.LocalDate.now().getYear();
%>

<style>
@media print {
    body * {
        visibility: hidden;
    }
    #printableContract, #printableContract * {
        visibility: visible;
    }
    #printableContract {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        box-shadow: none !important;
        border: none !important;
    }
    .no-print {
        display: none !important;
    }
}
</style>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3 no-print">
        <h3 class="fw-bold text-dark mb-0"><i class="fa-solid fa-file-contract text-primary me-2"></i> Chi Tiết Hợp Đồng Chi Tiết</h3>
        <div>
            <button onclick="window.print();" class="btn btn-outline-primary me-2">
                <i class="fa-solid fa-print me-1"></i> In / Xuất Hợp Đồng
            </button>
            <a href="${pageContext.request.contextPath}/hopdong" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <!-- Official Printable Contract Paper -->
    <div id="printableContract" class="card shadow border-0 mx-auto p-4 p-md-5 bg-white text-dark" style="max-width: 900px; font-family: 'Times New Roman', Times, serif; line-height: 1.6; font-size: 1.1rem;">
        
        <!-- Header / Quốc hiệu Tiêu ngữ -->
        <div class="text-center mb-4">
            <h4 class="fw-bold text-uppercase mb-1" style="font-size: 1.25rem;">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h4>
            <h5 class="fw-bold mb-2" style="font-size: 1.1rem;">Độc lập - Tự do - Hạnh phúc</h5>
            <div class="mx-auto border-bottom border-dark" style="width: 200px;"></div>
        </div>

        <!-- Title -->
        <div class="text-center my-4">
            <h3 class="fw-bold text-uppercase" style="font-size: 1.5rem;">HỢP ĐỒNG THUÊ NHÀ TRỌ / NHÀ Ở</h3>
            <p class="fst-italic text-muted small">Mã hợp đồng: <strong><%= (hd != null) ? hd.getMaHopDong() : "" %></strong> | Trạng thái: <strong><%= (hd != null) ? hd.getTrangThai() : "" %></strong></p>
            <p class="fst-italic">Hôm nay, ngày <%= todayDay %> tháng <%= todayMonth %> năm <%= todayYear %>, tại Ban quản lý Ký túc xá / Nhà trọ.</p>
        </div>

        <p class="fw-bold mb-2">Chúng tôi gồm có:</p>

        <!-- BÊN A -->
        <div class="mb-3">
            <p class="fw-bold mb-1">BÊN CHO THUÊ (BÊN A):</p>
            <ul class="list-unstyled ps-3 mb-0">
                <li>• Họ và tên: <strong>Ban Quản Lý Ký Túc Xá / Nhà Trọ</strong></li>
                <li>• Số điện thoại: 0988.123.456</li>
                <li>• Địa chỉ: Khu quản lý ký túc xá tập trung</li>
            </ul>
        </div>

        <!-- BÊN B -->
        <div class="mb-4">
            <p class="fw-bold mb-1">BÊN THUÊ (BÊN B):</p>
            <ul class="list-unstyled ps-3 mb-0">
                <li>• Họ và tên: <strong><%= (sv != null && sv.getHoTen() != null) ? sv.getHoTen() : "...................................................." %></strong></li>
                <li>• Năm sinh: <%= (sv != null && sv.getNgaySinh() != null) ? sv.getNgaySinh().getYear() : "............" %></li>
                <li>• CCCD/CMND số: <strong><%= (sv != null && sv.getCccd() != null) ? sv.getCccd() : "............................" %></strong></li>
                <li>• Quê quán / Thường trú: <%= (sv != null && sv.getDiaChiQueQuan() != null) ? sv.getDiaChiQueQuan() : "...................................................." %></li>
                <li>• Số điện thoại: <strong><%= (sv != null && sv.getSoDienThoai() != null) ? sv.getSoDienThoai() : "............................" %></strong></li>
            </ul>
        </div>

        <p class="fst-italic mb-4">Hai bên cùng thống nhất ký kết Hợp đồng thuê nhà với các điều khoản sau:</p>

        <hr class="my-3">

        <!-- ARTICLES -->
        <div class="contract-body text-justify">
            <h5 class="fw-bold mt-3">ĐIỀU 1: ĐỐI TƯỢNG VÀ THỜI HẠN HỢP ĐỒNG</h5>
            <ol>
                <li>Bên A đồng ý cho Bên B thuê phòng trọ/ký túc xá: <strong><%= (p != null) ? p.getMaPhong() + " - " + p.getTenPhong() : "...................." %></strong>.</li>
                <li>Mục đích thuê: Dùng để ở và học tập.</li>
                <li>Thời hạn thuê: Từ ngày <strong><%= ngayBDStr %></strong> đến ngày <strong><%= ngayKTStr %></strong>.</li>
            </ol>

            <h5 class="fw-bold mt-3">ĐIỀU 2: GIÁ THUÊ, TIỀN CỌC VÀ PHƯƠNG THỨC THANH TOÁN</h5>
            <ol>
                <li><strong>Giá thuê nhà:</strong> <strong><%= (hd != null && hd.getTienPhong() != null) ? String.format("%,.0f VNĐ/tháng", hd.getTienPhong()) : ".................... VNĐ/tháng" %></strong>. Giá thuê ổn định trong suốt thời hạn hợp đồng.</li>
                <li><strong>Tiền đặt cọc:</strong> Bên B đặt cọc cho Bên A số tiền là <strong><%= (hd != null && hd.getTienDatCoc() != null) ? String.format("%,.0f VNĐ", hd.getTienDatCoc()) : ".................... VNĐ" %></strong> ngay khi ký hợp đồng. Số tiền này dùng để đảm bảo thực hiện hợp đồng và sẽ được hoàn trả cho Bên B khi hết hạn hợp đồng (sau khi đã trừ các chi phí thanh toán còn tồn đọng nếu có).</li>
                <li><strong>Hình thức thanh toán:</strong> Thanh toán theo định kỳ 01 tháng/lần vào đầu mỗi tháng bằng Tiền mặt hoặc Chuyển khoản.</li>
                <li><strong>Chi phí dịch vụ:</strong> Tiền điện, tiền nước, dịch vụ vệ sinh và Internet tính theo chỉ số sử dụng hàng tháng theo quy định.</li>
            </ol>

            <h5 class="fw-bold mt-3">ĐIỀU 3: TRÁCH NHIỆM CỦA BÊN A</h5>
            <ol>
                <li>Bàn giao nhà và các trang thiết bị gắn liền với nhà đúng tình trạng cho Bên B đúng thời hạn.</li>
                <li>Đảm bảo quyền sử dụng trọn vẹn, hợp pháp của Bên B đối với diện tích thuê.</li>
                <li>Hỗ trợ Bên B hoàn tất các thủ tục đăng ký tạm trú theo quy định của pháp luật.</li>
            </ol>

            <h5 class="fw-bold mt-3">ĐIỀU 4: TRÁCH NHIỆM CỦA BÊN B</h5>
            <ol>
                <li>Thanh toán đầy đủ và đúng hạn tiền thuê nhà cùng các chi phí dịch vụ phát sinh.</li>
                <li>Sử dụng nhà đúng mục đích; có trách nhiệm giữ gìn, bảo quản tài sản, kiến trúc nhà ở.</li>
                <li>Không được tự ý sửa chữa, cải tạo kết cấu nhà khi chưa được sự đồng ý của Bên A.</li>
                <li>Chấp hành các quy định về an ninh trật tự, phòng cháy chữa cháy và quy định chung của ký túc xá/khu dân cư.</li>
                <li>Không được cho thuê lại một phần hoặc toàn bộ căn nhà nếu chưa có sự đồng ý bằng văn bản của Bên A.</li>
            </ol>

            <h5 class="fw-bold mt-3">ĐIỀU 5: ĐƠN PHƯƠNG CHẤM DỨT HỢP ĐỒNG</h5>
            <ol>
                <li>Bên A có quyền đơn phương chấm dứt hợp đồng và không hoàn lại tiền cọc nếu Bên B: chậm thanh toán quá 15 ngày, vi phạm pháp luật, hoặc cố ý hư hỏng tài sản.</li>
                <li>Nếu một trong hai bên muốn chấm dứt hợp đồng trước thời hạn phải thông báo cho bên còn lại biết trước ít nhất 30 ngày.</li>
            </ol>

            <h5 class="fw-bold mt-3">ĐIỀU 6: ĐIỀU KHỎAN CHUNG</h5>
            <ol>
                <li>Hai bên cam kết thực hiện đúng các điều khoản đã ghi trong hợp đồng. Mọi thay đổi phải được lập thành văn bản/phụ lục.</li>
                <li>Hợp đồng này được lập thành 02 (hai) bản có giá trị pháp lý như nhau, mỗi bên giữ 01 bản và có hiệu lực kể từ ngày ký.</li>
            </ol>
        </div>

        <hr class="my-4">

        <!-- SIGNATURE DISPLAY -->
        <div class="row text-center my-3">
            <!-- SIDE A SIGNATURE -->
            <div class="col-6">
                <p class="fw-bold text-uppercase mb-1">ĐẠI DIỆN BÊN A</p>
                <p class="fst-italic text-muted small">(Ký và ghi rõ họ tên)</p>
                <div class="my-2" style="min-height: 120px;">
                    <% if (hd != null && hd.getChuKyBenA() != null && !hd.getChuKyBenA().isEmpty()) { %>
                        <img src="<%= hd.getChuKyBenA() %>" alt="Chữ ký Bên A" style="max-height: 100px; max-width: 100%;" />
                    <% } else { %>
                        <p class="text-muted fst-italic pt-4">(Chữ ký điện tử Hệ thống)</p>
                    <% } %>
                </div>
                <p class="fw-bold text-primary mb-0">Ban Quản Lý</p>
            </div>

            <!-- SIDE B SIGNATURE -->
            <div class="col-6">
                <p class="fw-bold text-uppercase mb-1">ĐẠI DIỆN BÊN B</p>
                <p class="fst-italic text-muted small">(Ký và ghi rõ họ tên)</p>
                <div class="my-2" style="min-height: 120px;">
                    <% if (hd != null && hd.getChuKyBenB() != null && !hd.getChuKyBenB().isEmpty()) { %>
                        <img src="<%= hd.getChuKyBenB() %>" alt="Chữ ký Bên B" style="max-height: 100px; max-width: 100%;" />
                    <% } else { %>
                        <p class="text-danger fst-italic pt-4">(Chưa ký)</p>
                    <% } %>
                </div>
                <p class="fw-bold text-success mb-0"><%= (sv != null && sv.getHoTen() != null) ? sv.getHoTen() : "" %></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
