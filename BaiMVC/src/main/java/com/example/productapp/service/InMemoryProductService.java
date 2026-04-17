package com.example.productapp.service;

import com.example.productapp.model.Product;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public class InMemoryProductService implements ProductService {
    private final ConcurrentMap<Integer, Product> store = new ConcurrentHashMap<>();
    private final AtomicInteger seq = new AtomicInteger(0);

    // simple singleton for example app
    private static final InMemoryProductService INSTANCE = new InMemoryProductService();

    private InMemoryProductService() {
        // seed sample data
        Product p1 = new Product(seq.incrementAndGet(), "Apple iPhone", "Smartphone", new BigDecimal("799.99"), LocalDateTime.now());
        Product p2 = new Product(seq.incrementAndGet(), "Samsung TV", "55 inch LED TV", new BigDecimal("499.99"), LocalDateTime.now());
        store.put(p1.getId(), p1);
        store.put(p2.getId(), p2);
    }

    public static InMemoryProductService getInstance() {
        return INSTANCE;
    }

    @Override
    public List<Product> listAll() {
        return new ArrayList<>(store.values());
    }

    @Override
    public Product findById(int id) {
        return store.get(id);
    }

    @Override
    public Product create(Product p) {
        int id = seq.incrementAndGet();
        p.setId(id);
        if (p.getCreatedAt() == null) p.setCreatedAt(LocalDateTime.now());
        store.put(id, p);
        return p;
    }

    @Override
    public Product update(Product p) {
        int id = p.getId();
        if (!store.containsKey(id)) return null;
        // preserve createdAt if not set
        if (p.getCreatedAt() == null) p.setCreatedAt(store.get(id).getCreatedAt());
        store.put(id, p);
        return p;
    }

    @Override
    public boolean deleteById(int id) {
        return store.remove(id) != null;
    }

    @Override
    public List<Product> searchByName(String fragment) {
        if (fragment == null || fragment.isEmpty()) return listAll();
        String f = fragment.toLowerCase();
        return store.values().stream()
                .filter(p -> p.getName() != null && p.getName().toLowerCase().contains(f))
                .collect(Collectors.toList());
    }
}
