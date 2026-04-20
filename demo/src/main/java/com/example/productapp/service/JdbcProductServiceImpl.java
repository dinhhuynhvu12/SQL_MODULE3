package com.example.productapp.service;

import com.example.productapp.model.Product;
import com.example.productapp.util.JdbcUtils;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class JdbcProductServiceImpl implements ProductService {
    @Override
    public List<Product> findAll() {
        List<Product> out = new ArrayList<>();
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("SELECT id, name, description, price, category_id, created_at FROM product ORDER BY id")) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    out.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return out;
    }

    @Override
    public Optional<Product> findById(int id) {
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("SELECT id, name, description, price, category_id, created_at FROM product WHERE id = ?")) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }

    @Override
    public List<Product> findByName(String name) {
        List<Product> out = new ArrayList<>();
        if (name == null || name.trim().isEmpty()) return out;
        String q = "%" + name.trim().toLowerCase() + "%";
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("SELECT id, name, description, price, category_id, created_at FROM product WHERE LOWER(name) LIKE ? ORDER BY id")) {
            st.setString(1, q);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) out.add(mapRow(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return out;
    }

    @Override
    public List<Product> search(String name, Integer categoryId, int offset, int limit) {
        List<Product> out = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT id, name, description, price, category_id, created_at FROM product");
        List<Object> params = new ArrayList<>();
        boolean where = false;
        if (name != null && !name.trim().isEmpty()) {
            sql.append(where ? " AND" : " WHERE");
            sql.append(" LOWER(name) LIKE ?");
            params.add("%" + name.trim().toLowerCase() + "%");
            where = true;
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(where ? " AND" : " WHERE");
            sql.append(" category_id = ?");
            params.add(categoryId);
            where = true;
        }
        sql.append(" ORDER BY id LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object v = params.get(i);
                if (v instanceof String) st.setString(i + 1, (String) v);
                else if (v instanceof Integer) st.setInt(i + 1, (Integer) v);
                else if (v instanceof Long) st.setLong(i + 1, (Long) v);
                else st.setObject(i + 1, v);
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) out.add(mapRow(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return out;
    }

    @Override
    public int countSearch(String name, Integer categoryId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product");
        List<Object> params = new ArrayList<>();
        boolean where = false;
        if (name != null && !name.trim().isEmpty()) {
            sql.append(where ? " AND" : " WHERE");
            sql.append(" LOWER(name) LIKE ?");
            params.add("%" + name.trim().toLowerCase() + "%");
            where = true;
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(where ? " AND" : " WHERE");
            sql.append(" category_id = ?");
            params.add(categoryId);
            where = true;
        }
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object v = params.get(i);
                if (v instanceof String) st.setString(i + 1, (String) v);
                else if (v instanceof Integer) st.setInt(i + 1, (Integer) v);
                else st.setObject(i + 1, v);
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public Product create(Product product) {
        String sql = "INSERT INTO product (name, description, price, category_id, created_at) VALUES (?, ?, ?, ?, ? )";
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, product.getName());
            st.setString(2, product.getDescription());
            if (product.getPrice() != null) st.setBigDecimal(3, product.getPrice()); else st.setNull(3, Types.DECIMAL);
            if (product.getCategoryId() != null) st.setInt(4, product.getCategoryId()); else st.setNull(4, Types.INTEGER);
            st.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            int rows = st.executeUpdate();
            if (rows == 0) throw new SQLException("Insert failed");
            try (ResultSet keys = st.getGeneratedKeys()) {
                if (keys.next()) product.setId(keys.getInt(1));
            }
            product.setCreatedAt(LocalDateTime.now());
            return product;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean update(Product product) {
        String sql = "UPDATE product SET name = ?, description = ?, price = ?, category_id = ? WHERE id = ?";
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, product.getName());
            st.setString(2, product.getDescription());
            if (product.getPrice() != null) st.setBigDecimal(3, product.getPrice()); else st.setNull(3, Types.DECIMAL);
            if (product.getCategoryId() != null) st.setInt(4, product.getCategoryId()); else st.setNull(4, Types.INTEGER);
            st.setInt(5, product.getId());
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(int id) {
        try (Connection c = JdbcUtils.getConnection(); PreparedStatement st = c.prepareStatement("DELETE FROM product WHERE id = ?")) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void clear() {
        try (Connection c = JdbcUtils.getConnection(); Statement st = c.createStatement()) {
            st.executeUpdate("DELETE FROM product");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        BigDecimal bd = rs.getBigDecimal("price");
        p.setPrice(bd);
        int catId = rs.getInt("category_id");
        if (rs.wasNull()) p.setCategoryId(null); else p.setCategoryId(catId);
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());
        return p;
    }
}
