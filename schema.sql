-- CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ NHÀ Ở SINH VIÊN (PROPERTY MANAGEMENT)
-- Khởi tạo Database & Schema theo đặc tả README.md

CREATE DATABASE IF NOT EXISTS property_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE property_management;

-- 1. Bảng Sinh Viên
CREATE TABLE IF NOT EXISTS sinh_vien (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    ngay_sinh DATE,
    gioi_tinh VARCHAR(10),
    cccd VARCHAR(20) UNIQUE,
    so_dien_thoai VARCHAR(20),
    email VARCHAR(100),
    dia_chi_que_quan VARCHAR(255),
    truong VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng Tài Khoản
CREATE TABLE IF NOT EXISTS tai_khoan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    vai_tro ENUM('ADMIN', 'QUAN_LY', 'NHAN_VIEN', 'SINH_VIEN') NOT NULL DEFAULT 'SINH_VIEN',
    trang_thai VARCHAR(50) NOT NULL DEFAULT 'HOAT_DONG',
    sinh_vien_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng Khu
CREATE TABLE IF NOT EXISTS khu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ma_khu VARCHAR(20) UNIQUE NOT NULL,
    ten_khu VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng Tòa
CREATE TABLE IF NOT EXISTS toa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    khu_id INT NOT NULL,
    ma_toa VARCHAR(20) UNIQUE NOT NULL,
    ten_toa VARCHAR(100) NOT NULL,
    FOREIGN KEY (khu_id) REFERENCES khu(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng Tầng
CREATE TABLE IF NOT EXISTS tang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    toa_id INT NOT NULL,
    so_tang INT NOT NULL,
    ten_tang VARCHAR(50) NOT NULL,
    FOREIGN KEY (toa_id) REFERENCES toa(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Bảng Phòng
CREATE TABLE IF NOT EXISTS phong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tang_id INT NOT NULL,
    ma_phong VARCHAR(20) UNIQUE NOT NULL,
    ten_phong VARCHAR(100) NOT NULL,
    loai_phong ENUM('PHONG_4', 'PHONG_6', 'PHONG_8') NOT NULL DEFAULT 'PHONG_4',
    suc_chua INT NOT NULL DEFAULT 4,
    so_nguoi_hien_tai INT NOT NULL DEFAULT 0,
    gia_thang DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    trang_thai ENUM('TRONG', 'DANG_DAT_COC', 'DANG_CHO_THUE', 'BAO_TRI') NOT NULL DEFAULT 'TRONG',
    FOREIGN KEY (tang_id) REFERENCES tang(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Bảng Đăng Ký Phòng
CREATE TABLE IF NOT EXISTS dang_ky_phong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sinh_vien_id INT NOT NULL,
    phong_id INT NOT NULL,
    loai_yeu_cau ENUM('DANG_KY_MOI', 'CHUYEN_PHONG', 'HUY_PHONG') NOT NULL DEFAULT 'DANG_KY_MOI',
    thoi_gian_dang_ky TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trang_thai ENUM('CHO_DUYET', 'DA_DUYET', 'TU_CHOI') NOT NULL DEFAULT 'CHO_DUYET',
    ly_do TEXT,
    nguoi_duyet VARCHAR(50),
    thoi_gian_duyet TIMESTAMP NULL,
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE CASCADE,
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Bảng Hợp Đồng
CREATE TABLE IF NOT EXISTS hop_dong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ma_hop_dong VARCHAR(50) UNIQUE NOT NULL,
    sinh_vien_id INT NOT NULL,
    phong_id INT NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    tien_phong DECIMAL(12,2) NOT NULL,
    tien_dat_coc DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    trang_thai ENUM('CHUA_KICH_HOAT', 'DANG_HIEU_LUC', 'SAP_HET_HAN', 'DA_HET_HAN', 'DA_HUY') NOT NULL DEFAULT 'DANG_HIEU_LUC',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE CASCADE,
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Bảng Lịch Sử Phòng
CREATE TABLE IF NOT EXISTS lich_su_phong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sinh_vien_id INT NOT NULL,
    phong_cu INT NULL,
    phong_moi INT NULL,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ly_do VARCHAR(255),
    nguoi_xu_ly VARCHAR(50),
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bảng Chỉ Số Điện
CREATE TABLE IF NOT EXISTS chi_so_dien (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phong_id INT NOT NULL,
    ky_thang VARCHAR(7) NOT NULL, -- Định dạng YYYY-MM
    chi_so_cu INT NOT NULL DEFAULT 0,
    chi_so_moi INT NOT NULL DEFAULT 0,
    don_gia DECIMAL(10,2) NOT NULL DEFAULT 3500.00,
    tien_dien DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    ngay_nhap DATE NOT NULL,
    nguoi_nhap VARCHAR(50),
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Bảng Chỉ Số Nước
CREATE TABLE IF NOT EXISTS chi_so_nuoc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phong_id INT NOT NULL,
    ky_thang VARCHAR(7) NOT NULL, -- Định dạng YYYY-MM
    chi_so_cu INT NOT NULL DEFAULT 0,
    chi_so_moi INT NOT NULL DEFAULT 0,
    don_gia DECIMAL(10,2) NOT NULL DEFAULT 10000.00,
    tien_nuoc DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    ngay_nhap DATE NOT NULL,
    nguoi_nhap VARCHAR(50),
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Bảng Khoản Phí
CREATE TABLE IF NOT EXISTS khoan_phi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten_khoan_phi VARCHAR(100) NOT NULL,
    don_gia DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    don_vi_tinh VARCHAR(20) DEFAULT 'Tháng',
    trang_thai VARCHAR(20) DEFAULT 'HOAT_DONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Bảng Hóa Đơn
CREATE TABLE IF NOT EXISTS hoa_don (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ma_hoa_don VARCHAR(50) UNIQUE NOT NULL,
    sinh_vien_id INT NOT NULL,
    phong_id INT NULL,
    ky_thanh_toan DATE NOT NULL,
    tien_phong DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    tien_dien DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    tien_nuoc DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    tong_phi DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    tong_tien DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    han_thanh_toan DATE NOT NULL,
    so_lan_nhac INT DEFAULT 0,
    trang_thai ENUM('CHUA_THANH_TOAN', 'DA_THANH_TOAN', 'QUAN_HAN') NOT NULL DEFAULT 'CHUA_THANH_TOAN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Bảng Thanh Toán
CREATE TABLE IF NOT EXISTS thanh_toan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hoa_don_id INT NOT NULL,
    so_tien DECIMAL(12,2) NOT NULL,
    phuong_thuc ENUM('TIEN_MAT', 'CHUYEN_KHOAN') NOT NULL DEFAULT 'CHUYEN_KHOAN',
    ma_giao_dich VARCHAR(100),
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nguoi_xac_nhan VARCHAR(50),
    FOREIGN KEY (hoa_don_id) REFERENCES hoa_don(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Bảng Tài Sản
CREATE TABLE IF NOT EXISTS tai_san (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phong_id INT NOT NULL,
    ten_tai_san VARCHAR(100) NOT NULL,
    so_luong INT NOT NULL DEFAULT 1,
    tinh_trang VARCHAR(100) DEFAULT 'Tốt',
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. Bảng Yêu Cầu Sửa Chữa / Khiếu Nại
CREATE TABLE IF NOT EXISTS yeu_cau_sua_chua (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sinh_vien_id INT NOT NULL,
    phong_id INT NULL,
    tai_san_id INT NULL,
    loai_yeu_cau VARCHAR(50) DEFAULT 'SUA_CHUA', -- SUA_CHUA / KHIEU_NAI
    noi_dung TEXT NOT NULL,
    trang_thai ENUM('CHO_XU_LY', 'DANG_XU_LY', 'DA_XU_LY') NOT NULL DEFAULT 'CHO_XU_LY',
    phan_hoi TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. Bảng Thông Báo
CREATE TABLE IF NOT EXISTS thong_bao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nguoi_nhan_id INT NULL, -- NULL nghĩa là tất cả người dùng
    tieu_de VARCHAR(200) NOT NULL,
    noi_dung TEXT NOT NULL,
    loai VARCHAR(50) DEFAULT 'THONG_TIN',
    da_doc TINYINT(1) DEFAULT 0,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SEED DATA BAN ĐẦU FOR 4 ROLES: ADMIN, QUAN_LY, NHAN_VIEN, SINH_VIEN

-- Seed Khu, Tòa, Tầng, Phòng
INSERT IGNORE INTO khu (id, ma_khu, ten_khu) VALUES (1, 'KHU_A', 'Khu A - Nam');
INSERT IGNORE INTO toa (id, khu_id, ma_toa, ten_toa) VALUES (1, 1, 'TOA_A1', 'Tòa A1');
INSERT IGNORE INTO tang (id, toa_id, so_tang, ten_tang) VALUES (1, 1, 1, 'Tầng 1');

INSERT IGNORE INTO phong (id, tang_id, ma_phong, ten_phong, loai_phong, suc_chua, so_nguoi_hien_tai, gia_thang, trang_thai)
VALUES
(1, 1, 'A101', 'Phòng A101', 'PHONG_4', 4, 1, 1500000.00, 'DANG_CHO_THUE'),
(2, 1, 'A102', 'Phòng A102', 'PHONG_4', 4, 0, 1500000.00, 'TRONG'),
(3, 1, 'A103', 'Phòng A103', 'PHONG_6', 6, 0, 1200000.00, 'TRONG');

-- Seed Sinh Viên mẫu
INSERT IGNORE INTO sinh_vien (id, ho_ten, ngay_sinh, gioi_tinh, cccd, so_dien_thoai, email, dia_chi_que_quan, truong)
VALUES (1, 'Nguyễn Văn Sinh Viên', '2003-05-15', 'Nam', '012345678901', '0987654321', 'sinhvien@example.com', 'Hà Nội', 'Đại Học Công Nghệ');

-- Seed Tài Khoản 4 vai trò
INSERT IGNORE INTO tai_khoan (username, password_hash, vai_tro, trang_thai, sinh_vien_id) VALUES
('admin', 'admin123', 'ADMIN', 'HOAT_DONG', NULL),
('quanly', 'quanly123', 'QUAN_LY', 'HOAT_DONG', NULL),
('nhanvien', 'nhanvien123', 'NHAN_VIEN', 'HOAT_DONG', NULL),
('sinhvien', 'sinhvien123', 'SINH_VIEN', 'HOAT_DONG', 1);

-- Seed Hợp đồng cho Sinh viên mẫu
INSERT IGNORE INTO hop_dong (id, ma_hop_dong, sinh_vien_id, phong_id, ngay_bat_dau, ngay_ket_thuc, tien_phong, tien_dat_coc, trang_thai)
VALUES (1, 'HD-2026-001', 1, 1, '2026-01-01', '2026-12-31', 1500000.00, 1500000.00, 'DANG_HIEU_LUC');

-- Seed Tài sản phòng A101
INSERT IGNORE INTO tai_san (id, phong_id, ten_tai_san, so_luong, tinh_trang)
VALUES
(1, 1, 'Giường tầng', 2, 'Tốt'),
(2, 1, 'Bàn học', 4, 'Tốt'),
(3, 1, 'Quạt trần', 1, 'Tốt');

ALTER TABLE thong_bao
  ADD COLUMN pham_vi ENUM('TAT_CA','PHONG','CA_NHAN') NOT NULL DEFAULT 'TAT_CA',
  ADD COLUMN phong_id BIGINT NULL,
  ADD COLUMN nguoi_gui_id INT NULL,
  ADD CONSTRAINT fk_tb_phong FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE;
  
UPDATE thong_bao 
SET pham_vi = IF(nguoi_nhan_id IS NULL, 'TAT_CA', 'CA_NHAN')
WHERE id > 0;

ALTER TABLE hoa_don MODIFY sinh_vien_id bigINT NULL;
ALTER TABLE hoa_don add phong_id bigint;
ALTER TABLE hoa_don ADD CONSTRAINT fk_hd_phong
    FOREIGN KEY (phong_id) REFERENCES phong(id) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS hoa_don_chi_tiet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hoa_don_id bigINT NOT NULL,
    ten_khoan_phi VARCHAR(100) NOT NULL,
    don_vi_tinh VARCHAR(20),
    thanh_tien DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (hoa_don_id) REFERENCES hoa_don(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE thanh_toan
  ADD COLUMN trang_thai ENUM('CHO_XAC_NHAN','DA_XAC_NHAN') NOT NULL DEFAULT 'DA_XAC_NHAN',
  ADD COLUMN nguoi_gui_id bigINT NULL,
  ADD COLUMN nguoi_gui VARCHAR(100) NULL;
ALTER TABLE tai_khoan ADD COLUMN ho_ten VARCHAR(100) NULL;
UPDATE tai_khoan SET ho_ten = 'Nguyễn Văn Quản Lý' WHERE username = 'quanly';
UPDATE tai_khoan SET ho_ten = 'Trần Thị Nhân Viên' WHERE username = 'nhanvien';
ALTER TABLE tai_khoan MODIFY COLUMN trang_thai VARCHAR(50) NOT NULL DEFAULT 'HOAT_DONG';