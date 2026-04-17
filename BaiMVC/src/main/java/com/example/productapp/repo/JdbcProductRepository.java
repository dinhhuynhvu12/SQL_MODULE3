package com.example.productapp.repo;

import com.example.productapp.model.Product;
import com.example.productapp.util.DataSourceFactory;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class JdbcProductRepository implements ProductRepository {
    private final DataSource ds = DataSourceFactory.getDataSource();

    @Override
    public List<Product> listAll() {
        List<Product> out = new ArrayList<>();
        String sql = "SELECT id, name, description, price, created_at FROM product";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) out.add(map(rs));
        } catch (SQLException e) { throw new RuntimeException(e); }
        return out;
    }

    @Override
    public Product findById(int id) {
        String sql = "SELECT id, name, description, price, created_at FROM product WHERE id = ?";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    @Override
    public Product create(Product p) {
        String sql = "INSERT INTO product (name, description, price, created_at) VALUES (?, ?, ?, ?)";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setTimestamp(4, Timestamp.valueOf(p.getCreatedAt() == null ? LocalDateTime.now() : p.getCreatedAt()));
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) p.setId(keys.getInt(1));
            }
            return p;
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    @Override
    public Product update(Product p) {
        String sql = "UPDATE product SET name=?, description=?, price=?, created_at=? WHERE id=?";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setTimestamp(4, Timestamp.valueOf(p.getCreatedAt() == null ? LocalDateTime.now() : p.getCreatedAt()));
            ps.setInt(5, p.getId());
            int updated = ps.executeUpdate();
            return updated == 1 ? p : null;
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM product WHERE id=?";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    @Override
    public List<Product> searchByName(String fragment) {
        List<Product> out = new ArrayList<>();
        String sql = "SELECT id, name, description, price, created_at FROM product WHERE LOWER(name) LIKE ?";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + fragment.toLowerCase() + "%");
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) out.add(map(rs)); }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return out;
    }

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());
        return p;
    }
}
