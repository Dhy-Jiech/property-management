package com.example.property.management.model.enums;

public enum LoaiPhong {
    _4_NGUOI(4),
    _6_NGUOI(6),
    _8_NGUOI(8);

    private final int sucChua;

    LoaiPhong(int sucChua) {
        this.sucChua = sucChua;
    }

    public int getSucChua() {
        return sucChua;
    }

    public String getDbValue() {
        return name().startsWith("_") ? name().substring(1) : name();
    }

    // Hàm đọc an toàn từ chuỗi DB (xử lý cả "4_NGUOI" lẫn "_4_NGUOI")
    public static LoaiPhong fromString(String text) {
        if (text == null)
            return _4_NGUOI;
        String formatted = text.trim();
        if (!formatted.startsWith("_")) {
            formatted = "_" + formatted; // Tự thêm dấu '_' nếu thiếu
        }
        try {
            return LoaiPhong.valueOf(formatted);
        } catch (IllegalArgumentException e) {
            return _4_NGUOI; // Mặc định nếu không tìm thấy
        }
    }
}
