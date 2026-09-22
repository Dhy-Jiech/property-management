TÀI LIỆU ĐẶC TẢ YÊU CẦU PHẦN MỀM
HỆ THỐNG WEB QUẢN LÝ NHÀ Ở SINH VIÊN
Công nghệ: Java Servlet – JSP – JSTL – JDBC – MySQL
Phiên bản tài liệu: 1.0
Dùng cho bài tập môn học, định hướng phát triển thành hệ thống thực tế

1. Giới thiệu
   1.1. Mục đích
   Tài liệu này đặc tả các yêu cầu nghiệp vụ, yêu cầu chức năng, yêu cầu phi chức năng, dữ liệu và các quy tắc xử lý của hệ thống web quản lý nhà ở sinh viên cho thuê. Tài liệu là cơ sở để phân tích, thiết kế cơ sở dữ liệu, lập trình Java Web, kiểm thử và nghiệm thu hệ thống.
   1.2. Phạm vi
   Hệ thống hỗ trợ quản lý khu nhà ở sinh viên theo cấu trúc Khu → Tòa → Tầng → Phòng; quản lý sinh viên, tài khoản, phòng, đăng ký/chuyển/hủy phòng, hợp đồng, đặt cọc, hóa đơn, điện nước, khoản phí, tài sản, yêu cầu sửa chữa/khiếu nại, thông báo, phân quyền, thống kê và xuất báo cáo.
   1.3. Công nghệ bắt buộc
   Java Servlet: xử lý request/response và nghiệp vụ phía server.
   JSP: xây dựng giao diện web.
   JSTL: hiển thị dữ liệu và xử lý logic trình bày trong JSP.
   JDBC: kết nối và thao tác với MySQL.
   MySQL: lưu trữ dữ liệu hệ thống.
   1.4. Đối tượng sử dụng
   Vai trò Mô tả
   Quản trị viên (Admin) :Toàn quyền quản trị hệ thống, tài khoản, phân quyền, cấu hình và dữ liệu.
   Quản lý/KTX :Quản lý sinh viên, phòng, hợp đồng, hóa đơn và các nghiệp vụ được phân quyền.
   Nhân viên :Thực hiện các nghiệp vụ được giao, đặc biệt nhập chỉ số điện/nước và hỗ trợ vận hành.
   Sinh viên :Xem thông tin, theo dõi phòng, đăng ký/chuyển/hủy theo quy định, xem hợp đồng/hóa đơn, thanh toán, gửi yêu cầu/khiếu nại và nhận thông báo.
2. Tổng quan nghiệp vụ
   Hệ thống phục vụ mô hình nhà ở sinh viên cho thuê. Sinh viên mới chưa có tài khoản phải đến trực tiếp để xem phòng, chốt phòng, ký hợp đồng và được cấp tài khoản. Sinh viên đang ở có thể đăng nhập để theo dõi phòng trống và gửi yêu cầu đăng ký/chuyển phòng; yêu cầu phải được quản lý duyệt.
   Phòng có thể thuộc loại 4, 6 hoặc 8 người, nhưng việc ghép người phải tuân theo thỏa thuận của những người đang ở trong phòng.
   Phòng được quản lý theo các trạng thái: Trống, Đang đặt cọc, Đang cho thuê, Bảo trì.
   Sinh viên được phép có nhiều hợp đồng theo các thời kỳ khác nhau.
   Thời gian ở không bị giới hạn cố định; sinh viên có thể tiếp tục ở nếu hợp đồng còn hiệu lực và tuân thủ nội quy.
   Không cho phép đăng ký/chuyển phòng khi sinh viên đang có khoản nợ tiền phòng theo quy định.
   Thông tin lịch sử thay đổi phòng phải được lưu để tra cứu.
3. Quy tắc nghiệp vụ
   Mã Nghiệp vụ Quy tắc
   BR-01 Cấp tài khoản Tài khoản sinh viên do quản lý cung cấp; sinh viên mới chưa được cấp tài khoản không thể tự đăng ký online.
   BR-02 Đăng ký phòng Sinh viên đang ở có thể xem phòng trống và gửi yêu cầu đăng ký/chuyển phòng; yêu cầu cần được quản lý duyệt.
   BR-03 Ưu tiên đăng ký Phòng còn trống được xử lý theo nguyên tắc ai đăng ký trước thì được ưu tiên, đồng thời phải đáp ứng các điều kiện phê duyệt.
   BR-04 Phòng lớn/ở riêng Không tự động ghép sinh viên khác vào phòng đã được sinh viên thuê riêng. Việc ghép người vào phòng đang có người ở cần có sự đồng ý của người đang ở theo quy định.
   BR-05 Hủy phòng Sinh viên được hủy phòng trong khoảng thời gian hủy được quy định sau khi đăng ký.
   BR-06 Chuyển phòng Sinh viên chỉ được yêu cầu chuyển sang phòng còn chỗ và phải qua quy trình duyệt; nếu chuyển vào phòng đang có người thì phải có sự đồng ý của người đang ở.
   BR-07 Cập nhật phòng Khi sinh viên chuyển hoặc hủy phòng, hệ thống phải cập nhật số người và trạng thái phòng phù hợp.
   BR-08 Hợp đồng Mỗi hợp đồng gắn với một sinh viên và một phòng trong một khoảng thời gian; sinh viên có thể có nhiều hợp đồng theo thời gian.
   BR-09 Thanh toán Sinh viên có thể thanh toán theo tháng, 6 tháng hoặc 1 năm.
   BR-10 Cấu thành tiền Hóa đơn có thể gồm tiền phòng, điện, nước và các khoản phí dịch vụ khác.
   BR-11 Điện nước Điện tính theo kWh, nước theo m³; mỗi phòng có đồng hồ riêng; chỉ số được nhập hàng tháng.
   BR-12 Phương thức thanh toán Thanh toán bằng tiền mặt hoặc chuyển khoản. Chuyển khoản có thể được hệ thống ghi nhận; tiền mặt cần quản lý/nhân viên cập nhật.
   BR-13 Quá hạn Hóa đơn có trạng thái Chưa thanh toán, Đã thanh toán hoặc Quá hạn. Hệ thống gửi cảnh báo đối với khoản chưa thanh toán/quá hạn.
   BR-14 Vi phạm thanh toán Sau quá 3 lần nhắc nhở mà vẫn không thanh toán, tài khoản có thể bị khóa và áp dụng quy trình chấm dứt quyền ở/đuổi theo nội quy. Việc này cần được quản lý xác nhận.
   BR-15 Nợ Sinh viên đang có nợ tiền phòng không được đăng ký hoặc chuyển phòng.
   BR-16 Tài sản Tài sản trong phòng được quản lý; sinh viên có thể báo hỏng/mất và theo dõi xử lý.
   BR-17 Yêu cầu/khiếu nại Sinh viên có thể gửi yêu cầu hoặc khiếu nại; quản lý có thể phản hồi và cập nhật trạng thái xử lý.
   BR-18 Hợp đồng sắp hết hạn Hệ thống phải cảnh báo các hợp đồng sắp hết hạn.
   BR-19 Lịch sử Hệ thống phải lưu lịch sử thay đổi phòng của sinh viên.
   BR-20 Tài khoản Hệ thống hỗ trợ đổi mật khẩu, quên mật khẩu và khóa/mở khóa tài khoản.
4. Yêu cầu chức năng
   Mã Chức năng Mô tả
   FR-01 Đăng nhập/đăng xuất Người dùng đăng nhập bằng tài khoản được cấp; hệ thống xác thực và phân quyền.
   FR-02 Đổi/quên mật khẩu Cho phép đổi mật khẩu; hỗ trợ quy trình lấy lại mật khẩu theo cơ chế được cấu hình.
   FR-03 Quản lý tài khoản Admin/quản lý có quyền được phép tạo, khóa, mở khóa và quản lý tài khoản.
   FR-04 Quản lý sinh viên Thêm, xem, cập nhật theo quyền, tìm kiếm và quản lý hồ sơ sinh viên.
   FR-05 Quản lý khu/tòa/tầng Quản lý cấu trúc Khu A → Tòa A1 → Tầng 1 → Phòng A101.
   FR-06 Quản lý phòng Quản lý mã phòng, tên phòng, loại phòng, sức chứa, số người hiện tại, giá tháng và trạng thái.
   FR-07 Theo dõi phòng trống Sinh viên đang ở có thể xem danh sách phòng đang trống và thông tin cơ bản.
   FR-08 Đăng ký phòng Sinh viên gửi yêu cầu đăng ký phòng; hệ thống kiểm tra điều kiện và chuyển trạng thái chờ duyệt.
   FR-09 Duyệt đăng ký Quản lý xem, duyệt hoặc từ chối yêu cầu; hệ thống ghi nhận người duyệt, thời điểm và lý do nếu từ chối.
   FR-10 Hủy phòng Sinh viên gửi yêu cầu hủy trong thời gian được phép; hệ thống cập nhật phòng sau khi hoàn tất.
   FR-11 Chuyển phòng Sinh viên chọn phòng còn chỗ, gửi yêu cầu; hệ thống hỗ trợ thông tin đồng ý của người đang ở nếu cần và quản lý duyệt.
   FR-12 Lịch sử phòng Tra cứu lịch sử các phòng/hợp đồng của sinh viên.
   FR-13 Quản lý hợp đồng Tạo, xem, cập nhật trạng thái hợp đồng; quản lý ngày bắt đầu/kết thúc, tiền phòng, tiền cọc.
   FR-14 Cảnh báo hợp đồng Thông báo hợp đồng sắp hết hạn và hợp đồng hết hạn.
   FR-15 Quản lý chỉ số điện nước Nhân viên/quản lý nhập chỉ số điện nước hàng tháng cho từng phòng; hệ thống lưu chỉ số cũ và mới.
   FR-16 Tính điện nước Tính tiêu thụ = chỉ số mới - chỉ số cũ; tiền điện/nước = sản lượng × đơn giá.
   FR-17 Quản lý khoản phí Cho phép khai báo nhiều khoản phí như Internet, vệ sinh và các khoản phát sinh do đơn vị quản lý thêm.
   FR-18 Lập hóa đơn Tạo hóa đơn từ tiền phòng, điện, nước và các khoản phí; hỗ trợ kỳ thanh toán tháng/6 tháng/năm.
   FR-19 Thanh toán Ghi nhận thanh toán tiền mặt hoặc chuyển khoản; lưu thời gian, số tiền, phương thức và người/xử lý.
   FR-20 Theo dõi công nợ Theo dõi hóa đơn chưa thanh toán, quá hạn, số lần nhắc nhở và công nợ sinh viên.
   FR-21 Nhắc thanh toán Gửi thông báo nhắc thanh toán và lưu lịch sử nhắc.
   FR-22 Quản lý tài sản Quản lý tài sản theo phòng, số lượng, tình trạng và lịch sử.
   FR-23 Báo hỏng/mất Sinh viên gửi yêu cầu báo hỏng/mất tài sản; quản lý/nhân viên tiếp nhận và xử lý.
   FR-24 Yêu cầu/khiếu nại Sinh viên tạo yêu cầu/khiếu nại; quản lý phản hồi và cập nhật trạng thái.
   FR-25 Thông báo Gửi/hiển thị thông báo về phòng, hợp đồng, hóa đơn, công nợ, yêu cầu và các sự kiện liên quan.
   FR-26 Thống kê dashboard Thống kê sinh viên, phòng, tình trạng phòng, doanh thu, tiền chưa thu, hợp đồng hết hạn và nợ xấu.
   FR-27 Báo cáo Xuất dữ liệu báo cáo ra Excel và PDF theo các nhóm nghiệp vụ được phân quyền.
   FR-28 Phân quyền Kiểm soát chức năng và dữ liệu theo vai trò Admin, Quản lý, Nhân viên, Sinh viên.
5. Đặc tả một số Use Case chính
   Mã Use Case Actor Luồng chính
   UC-01 Đăng nhập Người dùng Nhập tài khoản/mật khẩu → hệ thống kiểm tra → xác định vai trò → chuyển đến giao diện phù hợp. Sai thông tin thì thông báo lỗi.
   UC-02 Đăng ký phòng Sinh viên Xem phòng trống → chọn phòng → kiểm tra công nợ/điều kiện → gửi yêu cầu → chờ quản lý duyệt.
   UC-03 Duyệt đăng ký Quản lý Xem yêu cầu → kiểm tra phòng và điều kiện → duyệt/từ chối → ghi nhận kết quả → thông báo sinh viên.
   UC-04 Chuyển phòng Sinh viên + Quản lý Xem phòng trống → chọn phòng → xác nhận điều kiện ghép nếu có → gửi yêu cầu → quản lý duyệt → cập nhật phòng và lịch sử.
   UC-05 Ký hợp đồng Quản lý Chọn sinh viên/phòng → nhập thời hạn, tiền phòng, tiền cọc → tạo hợp đồng → cập nhật trạng thái phòng.
   UC-06 Nhập điện nước Nhân viên/Quản lý Chọn phòng/kỳ → nhập chỉ số mới → kiểm tra chỉ số không nhỏ hơn chỉ số cũ → lưu → tính tiêu thụ.
   UC-07 Thanh toán Sinh viên + Quản lý Sinh viên xem hóa đơn → chọn/thực hiện thanh toán → hệ thống ghi nhận chuyển khoản hoặc quản lý xác nhận tiền mặt → cập nhật hóa đơn.
   UC-08 Báo hỏng tài sản Sinh viên Chọn tài sản → mô tả tình trạng → gửi yêu cầu → nhân viên tiếp nhận → xử lý → cập nhật trạng thái và phản hồi.
   UC-09 Gửi khiếu nại Sinh viên Tạo nội dung → gửi → quản lý tiếp nhận → phản hồi → đóng yêu cầu khi hoàn tất.
   UC-10 Báo cáo thống kê Admin/Quản lý Chọn loại báo cáo → lọc thời gian/đối tượng → hệ thống tổng hợp → xuất Excel/PDF.
6. Dữ liệu cần quản lý
   Đối tượng Dữ liệu chính
   TaiKhoan id, username, password_hash, vai_tro, trang_thai, sinh_vien_id, created_at, updated_at
   SinhVien id, ho_ten, ngay_sinh, gioi_tinh, cccd, so_dien_thoai, email, dia_chi_que_quan, truong
   Khu id, ma_khu, ten_khu
   Toa id, khu_id, ma_toa, ten_toa
   Tang id, toa_id, so_tang/ten_tang
   Phong id, tang_id, ma_phong, ten_phong, loai_phong, suc_chua, so_nguoi_hien_tai, gia_thang, trang_thai
   DangKyPhong id, sinh_vien_id, phong_id, loai_yeu_cau, thoi_gian_dang_ky, trang_thai, ly_do, nguoi_duyet, thoi_gian_duyet
   HopDong id, ma_hop_dong, sinh_vien_id, phong_id, ngay_bat_dau, ngay_ket_thuc, tien_phong, tien_dat_coc, trang_thai
   LichSuPhong id, sinh_vien_id, phong_cu, phong_moi, thoi_gian, ly_do, nguoi_xu_ly
   ChiSoDien id, phong_id, ky_thang, chi_so_cu, chi_so_moi, don_gia, tien_dien
   ChiSoNuoc id, phong_id, ky_thang, chi_so_cu, chi_so_moi, don_gia, tien_nuoc
   KhoanPhi id, ten_khoan_phi, don_gia, don_vi_tinh, trang_thai
   HoaDon id, ma_hoa_don, sinh_vien_id, ky_thanh_toan, tien_phong, tien_dien, tien_nuoc, tong_phi, tong_tien, han_thanh_toan, so_lan_nhac, trang_thai
   ThanhToan id, hoa_don_id, so_tien, phuong_thuc, ma_giao_dich, thoi_gian, nguoi_xac_nhan
   TaiSan id, phong_id, ten_tai_san, so_luong, tinh_trang
   YeuCauSuaChua id, sinh_vien_id, phong_id, tai_san_id, loai_yeu_cau, noi_dung, trang_thai, phan_hoi, thoi_gian
   ThongBao id, nguoi_nhan_id, tieu_de, noi_dung, loai, da_doc, thoi_gian
   LichSuNhacNo id, sinh_vien_id/hoa_don_id, lan_nhac, noi_dung, thoi_gian
   KhoanPhiHoaDon id, hoa_don_id, khoan_phi_id, so_luong, don_gia, thanh_tien
7. Yêu cầu phi chức năng
   Mã Nhóm Yêu cầu
   NFR-01 Bảo mật Mật khẩu phải được lưu dưới dạng hash; phân quyền theo vai trò; người dùng không được truy cập trực tiếp chức năng ngoài quyền.
   NFR-02 Toàn vẹn dữ liệu Dùng khóa chính/ngoại, unique, not null và transaction JDBC cho các nghiệp vụ cập nhật nhiều bảng.
   NFR-03 Hiệu năng Các danh sách lớn phải có tìm kiếm, lọc và phân trang; truy vấn phải có index phù hợp.
   NFR-04 Khả dụng Giao diện web phải có thông báo rõ ràng khi thao tác thành công/thất bại.
   NFR-05 Khả năng bảo trì Tổ chức mã theo mô hình Servlet/Service/DAO/Model/JSP hoặc cấu trúc tương đương; hạn chế SQL trong JSP.
   NFR-06 Tương thích Ứng dụng chạy trên trình duyệt web phổ biến và máy chủ Java Servlet Container.
   NFR-07 Sao lưu Cơ sở dữ liệu phải có phương án sao lưu/khôi phục để tránh mất dữ liệu.
   NFR-08 Audit Các thao tác quan trọng như duyệt đăng ký, thanh toán, khóa tài khoản và thay đổi hợp đồng nên lưu người thực hiện và thời gian.
8. Phân quyền
   Chức năng Admin Quản lý Nhân viên Sinh viên
   Tài khoản & phân quyền Toàn quyền Theo quyền được cấp Theo quyền Đổi mật khẩu
   Sinh viên CRUD Quản lý Xem/hỗ trợ Xem hồ sơ của mình
   Khu/Tòa/Tầng/Phòng CRUD CRUD Xem/cập nhật nghiệp vụ Xem phòng phù hợp
   Đăng ký/chuyển/hủy Toàn quyền Duyệt/xử lý Hỗ trợ Gửi yêu cầu
   Hợp đồng CRUD CRUD Xem/hỗ trợ Xem
   Điện nước CRUD cấu hình CRUD Nhập chỉ số Xem hóa đơn
   Hóa đơn/thanh toán Toàn quyền Quản lý Xác nhận theo quyền Xem/thanh toán
   Tài sản/sửa chữa Toàn quyền Quản lý Xử lý Báo hỏng
   Khiếu nại Toàn quyền Phản hồi/xử lý Hỗ trợ Gửi/xem phản hồi
   Thống kê/báo cáo Toàn quyền Theo quyền Theo quyền Xem dữ liệu cá nhân
9. Dashboard và báo cáo
   Tổng số sinh viên.
   Tổng số phòng.
   Số phòng trống.
   Số phòng đang cho thuê.
   Số phòng bảo trì.
   Doanh thu theo tháng và khoảng thời gian.
   Tiền chưa thu/công nợ.
   Số hợp đồng sắp hết hạn và đã hết hạn.
   Nợ xấu theo tiêu chí quản lý cấu hình.
   Thống kê đăng ký/chuyển/hủy phòng.
   Thống kê yêu cầu sửa chữa/khiếu nại.
   Xuất báo cáo Excel và PDF.
10. Luồng nghiệp vụ tổng quát
    Sinh viên mới: Đến trực tiếp → xem/chốt phòng → quản lý tạo hồ sơ → ký hợp đồng → ghi nhận tiền đặt cọc → cấp tài khoản → sinh viên đăng nhập.
    Sinh viên đang ở: Đăng nhập → xem phòng trống → gửi yêu cầu đăng ký/chuyển phòng → quản lý kiểm tra → duyệt → cập nhật phòng/hợp đồng/lịch sử → gửi thông báo.
    Thanh toán: Hệ thống lập hóa đơn → sinh viên nhận thông báo → thanh toán chuyển khoản hoặc tiền mặt → hệ thống/nhân viên xác nhận → cập nhật hóa đơn → nếu quá hạn thì nhắc nợ theo quy định.
    Điện nước: Nhân viên/quản lý nhập chỉ số cuối kỳ → hệ thống tính mức tiêu thụ → áp đơn giá → đưa tiền điện/nước vào hóa đơn.
    Tài sản/sửa chữa: Sinh viên gửi báo hỏng/mất → nhân viên tiếp nhận → xử lý → cập nhật trạng thái → quản lý/sinh viên nhận phản hồi.
11. Các điểm cần cấu hình trong phiên bản triển khai
    Thời gian cho phép hủy phòng sau đăng ký.
    Số ngày trước hạn dùng để cảnh báo hợp đồng.
    Ngày đến hạn thanh toán.
    Khoảng thời gian và số lần gửi nhắc thanh toán.
    Tiêu chí xác định 'nợ xấu'.
    Quy trình và người có quyền xác nhận việc khóa tài khoản/chấm dứt quyền ở sau quá 3 lần nhắc.
    Đơn giá điện theo kWh và nước theo m³ theo từng thời kỳ.
    Danh sách khoản phí bổ sung và đơn giá.
    Quy tắc hoàn/trừ tiền đặt cọc khi hủy hoặc chấm dứt hợp đồng.
    Quy định cụ thể về việc đồng ý của người đang ở khi ghép sinh viên mới.
    Phương thức và dữ liệu tích hợp thanh toán chuyển khoản nếu triển khai tự động.
12. Tiêu chí nghiệm thu mức nghiệp vụ
    Đăng nhập đúng vai trò và không truy cập được chức năng ngoài quyền.
    Quản lý tạo được sinh viên, tài khoản, khu/tòa/tầng/phòng và hợp đồng.
    Sinh viên đang ở xem được phòng trống và gửi yêu cầu; quản lý duyệt được.
    Chuyển/hủy phòng cập nhật chính xác trạng thái, số người và lịch sử.
    Chỉ số điện/nước được kiểm tra và tính tiền chính xác.
    Hóa đơn tổng hợp đúng tiền phòng, điện, nước và các khoản phí.
    Thanh toán được ghi nhận và trạng thái hóa đơn cập nhật đúng.
    Hệ thống phát cảnh báo công nợ và hợp đồng theo cấu hình.
    Yêu cầu sửa chữa/khiếu nại có vòng đời và phản hồi.
    Dashboard và báo cáo phản ánh dữ liệu trong cơ sở dữ liệu.
    Excel/PDF xuất đúng phạm vi dữ liệu và quyền truy cập.
13. Ghi chú thiết kế cho Java Web
    Để phù hợp yêu cầu môn học, có thể tổ chức ứng dụng theo mô hình MVC: Servlet làm Controller, JSP + JSTL làm View, JavaBean/POJO làm Model, DAO dùng JDBC để truy cập MySQL và Service xử lý nghiệp vụ. Các nghiệp vụ như duyệt đăng ký, chuyển phòng, tạo hợp đồng và xác nhận thanh toán nên dùng transaction để tránh dữ liệu phòng/hợp đồng/hóa đơn bị cập nhật không đồng bộ.
    Tài liệu này cố ý tách các thông số chưa được chốt (đơn giá, thời hạn hủy, ngưỡng cảnh báo, tiêu chí nợ xấu...) thành cấu hình nghiệp vụ để hệ thống có thể phát triển thành dự án thực tế mà không phải sửa mã nguồn cho từng thay đổi.
14. Kết luận
    Hệ thống được định hướng là một nền tảng quản lý nhà ở sinh viên cho thuê, trong đó trọng tâm là quản lý vòng đời sinh viên – phòng – hợp đồng – hóa đơn – công nợ, đồng thời hỗ trợ vận hành điện nước, tài sản, sửa chữa, khiếu nại, thông báo và báo cáo. Các yêu cầu trong tài liệu là cơ sở cho bước tiếp theo: thiết kế Use Case Diagram, ERD/cơ sở dữ liệu MySQL, sơ đồ lớp, sơ đồ hoạt động và thiết kế giao diện JSP.
