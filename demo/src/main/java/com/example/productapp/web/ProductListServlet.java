package com.example.productapp.web;

import com.example.productapp.model.Product;
import com.example.productapp.service.ProductService;
import com.example.productapp.service.ProductServiceFactory;
import com.example.productapp.util.WebUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListServlet", urlPatterns = {"/products"})
public class ProductListServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        List<Product> products;
        if (q != null && !q.trim().isEmpty()) {
            products = productService.findByName(q);
            req.setAttribute("query", q);
        } else {
            products = productService.findAll();
        }
        String message = req.getParameter("message");
        if (message != null) req.setAttribute("message", message);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(req, resp);
    }
}
