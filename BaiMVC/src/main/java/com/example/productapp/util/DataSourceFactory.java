package com.example.productapp.util;

import org.h2.jdbcx.JdbcDataSource;

import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

public class DataSourceFactory {
    private static final JdbcDataSource ds = new JdbcDataSource();
    static {
        ds.setURL("jdbc:h2:mem:productdb;DB_CLOSE_DELAY=-1");
        ds.setUser("sa");
        ds.setPassword("");
        // initialize schema
        try (Connection c = ds.getConnection()) {
            InputStream is = DataSourceFactory.class.getResourceAsStream("/schema.sql");
            if (is != null) {
                String sql = new BufferedReader(new InputStreamReader(is))
                        .lines().collect(Collectors.joining("\n"));
                try (Statement st = c.createStatement()) {
                    for (String stmt : sql.split(";")) {
                        String s = stmt.trim();
                        if (!s.isEmpty()) st.execute(s);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize database", e);
        }
    }

    public static DataSource getDataSource() {
        return ds;
    }
}
