package com.example.productapp.service;

import com.example.productapp.model.Product;

import java.util.List;
import java.util.Optional;

public interface ProductService {
    List<Product> findAll();
    Optional<Product> findById(int id);
    List<Product> findByName(String name);
    Product create(Product product);
    boolean update(Product product);
    boolean delete(int id);
    void clear();
}
