package com.example.property.management.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/property_management"
            + "?useSSL=false"
            + "&serverTimezone=Asia/Ho_Chi_Minh"
            + "&allowPublicKeyRetrieval=true";

    private static final String USER = "root";
    private static final String PASSWORD = "123456789";

    // Nạp JDBC Driver khi class được nạp
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy Driver MySQL JDBC!");
            e.printStackTrace();
        }
    }

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}