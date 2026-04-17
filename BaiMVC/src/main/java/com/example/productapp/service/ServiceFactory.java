package com.example.productapp.service;

// Simple factory to choose the implementation: in-memory or JDBC
public class ServiceFactory {
    private static final ProductService service = choose();

    private static ProductService choose() {
        // change here to switch implementations
        // return InMemoryProductService.getInstance();
        return JdbcProductService.getInstance();
    }

    public static ProductService getService() { return service; }
}
