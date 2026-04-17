package com.example.productapp.service;

import com.example.productapp.model.Product;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.atomic.AtomicInteger;

public class InMemoryProductServiceImpl implements ProductService {
    private final ConcurrentMap<Integer, Product> store = new ConcurrentHashMap<>();
    private final AtomicInteger idGen = new AtomicInteger(0);

    public InMemoryProductServiceImpl() {
        Product p = new Product();
        p.setId(idGen.incrementAndGet());
        p.setName("Sample product");
        p.setDescription("This is a sample product.");
        p.setPrice(new BigDecimal("9.99"));
        p.setCreatedAt(LocalDateTime.now());
        store.put(p.getId(), p);
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(store.values());
    }

    @Override
    public Optional<Product> findById(int id) {
        return Optional.ofNullable(store.get(id));
    }

    @Override
    public List<Product> findByName(String name) {
        List<Product> out = new ArrayList<>();
        if (name == null) return out;
        String q = name.trim().toLowerCase();
        if (q.isEmpty()) return out;
        for (Product p : store.values()) {
            if (p.getName() != null && p.getName().toLowerCase().contains(q)) {
                out.add(p);
            }
        }
        return out;
    }

    @Override
    public Product create(Product product) {
        int id = idGen.incrementAndGet();
        product.setId(id);
        product.setCreatedAt(LocalDateTime.now());
        store.put(id, product);
        return product;
    }

    @Override
    public boolean update(Product product) {
        int id = product.getId();
        return store.computeIfPresent(id, (k, existing) -> {
            existing.setName(product.getName());
            existing.setDescription(product.getDescription());
            existing.setPrice(product.getPrice());
            return existing;
        }) != null;
    }

    @Override
    public boolean delete(int id) {
        return store.remove(id) != null;
    }

    @Override
    public void clear() {
        store.clear();
        idGen.set(0);
    }
}
