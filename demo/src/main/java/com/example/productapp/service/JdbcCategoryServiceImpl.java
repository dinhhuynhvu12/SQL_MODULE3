package com.example.productapp.service;

import com.example.productapp.model.Category;
import com.example.productapp.util.JdbcUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class JdbcCategoryServiceImpl implements CategoryService {
    @Override
    public List<Category> findAll() {
        List<Category> out = new ArrayList<>();
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("SELECT id, name FROM category ORDER BY name")) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Category cat = new Category();
                    cat.setId(rs.getInt("id"));
                    cat.setName(rs.getString("name"));
                    out.add(cat);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return out;
    }

    @Override
    public Optional<Category> findById(int id) {
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("SELECT id, name FROM category WHERE id = ?")) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Category cat = new Category();
                    cat.setId(rs.getInt("id"));
                    cat.setName(rs.getString("name"));
                    return Optional.of(cat);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }
}
