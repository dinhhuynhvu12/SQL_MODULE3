package com.example.productapp.service;

import com.example.productapp.model.Product;

import java.util.List;

public interface ProductService {
    List<Product> listAll();
    Product findById(int id);
    Product create(Product p);
    Product update(Product p);
    boolean deleteById(int id);
    List<Product> searchByName(String fragment);
}
