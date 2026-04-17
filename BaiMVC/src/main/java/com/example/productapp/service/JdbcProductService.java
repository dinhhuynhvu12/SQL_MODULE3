package com.example.productapp.service;

import com.example.productapp.model.Product;
import com.example.productapp.repo.JdbcProductRepository;
import com.example.productapp.repo.ProductRepository;

import java.util.List;

public class JdbcProductService implements ProductService {
    private final ProductRepository repo = new JdbcProductRepository();

    // singleton
    private static final JdbcProductService INSTANCE = new JdbcProductService();
    private JdbcProductService() {}
    public static JdbcProductService getInstance() { return INSTANCE; }

    @Override
    public List<Product> listAll() { return repo.listAll(); }

    @Override
    public Product findById(int id) { return repo.findById(id); }

    @Override
    public Product create(Product p) { return repo.create(p); }

    @Override
    public Product update(Product p) { return repo.update(p); }

    @Override
    public boolean deleteById(int id) { return repo.deleteById(id); }

    @Override
    public List<Product> searchByName(String fragment) { return repo.searchByName(fragment); }
}
