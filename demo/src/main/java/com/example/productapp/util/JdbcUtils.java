package com.example.productapp.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.stream.Collectors;

public class JdbcUtils {
    private static final boolean USE_H2 = Boolean.parseBoolean(System.getProperty("useH2", "false"));

    private static final String MYSQL_URL = "jdbc:mysql://localhost:3306/demo?serverTimezone=UTC&useSSL=false";
    private static final String MYSQL_USER = "root";
    private static final String MYSQL_PASSWORD = "123456";

    private static final String H2_URL = "jdbc:h2:mem:demo;DB_CLOSE_DELAY=-1";
    private static final String H2_USER = "sa";
    private static final String H2_PASSWORD = "";

    static {
        try {
            if (USE_H2) Class.forName("org.h2.Driver");
            else Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (USE_H2) return DriverManager.getConnection(H2_URL, H2_USER, H2_PASSWORD);
        return DriverManager.getConnection(MYSQL_URL, MYSQL_USER, MYSQL_PASSWORD);
    }

    public static void runSqlResource(String resourcePath) {
        try (Connection c = getConnection(); Statement st = c.createStatement()) {
            InputStream in = JdbcUtils.class.getClassLoader().getResourceAsStream(resourcePath);
            if (in == null) return;
            String sql = new BufferedReader(new InputStreamReader(in)).lines().collect(Collectors.joining("\n"));
            for (String stmt : sql.split(";")) {
                String s = stmt.trim();
                if (!s.isEmpty()) st.execute(s);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void runSqlResourceOnServer(String resourcePath) {
        String serverUrl = "jdbc:mysql://localhost:3306/?serverTimezone=UTC&useSSL=false";
        try (Connection c = DriverManager.getConnection(serverUrl, MYSQL_USER, MYSQL_PASSWORD); Statement st = c.createStatement()) {
            InputStream in = JdbcUtils.class.getClassLoader().getResourceAsStream(resourcePath);
            if (in == null) return;
            String sql = new BufferedReader(new InputStreamReader(in)).lines().collect(Collectors.joining("\n"));
            for (String stmt : sql.split(";")) {
                String s = stmt.trim();
                if (!s.isEmpty()) st.execute(s);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
