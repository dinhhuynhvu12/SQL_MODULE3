package com.example.productapp.service;

public class ProductServiceFactory {
    private static final ProductService INSTANCE = new InMemoryProductServiceImpl();

    private ProductServiceFactory() {}

    public static ProductService getInstance() {
        return INSTANCE;
    }
}
