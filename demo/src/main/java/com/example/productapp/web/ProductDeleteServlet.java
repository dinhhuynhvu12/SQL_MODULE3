package com.example.productapp.web;

import com.example.productapp.service.ProductService;
import com.example.productapp.service.ProductServiceFactory;
import com.example.productapp.util.WebUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ProductDeleteServlet", urlPatterns = {"/products/delete"})
public class ProductDeleteServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = WebUtils.parseIntSafe(req.getParameter("id"), -1);
        boolean ok = productService.delete(id);
        if (ok) resp.sendRedirect(req.getContextPath() + "/products?message=Deleted");
        else resp.sendRedirect(req.getContextPath() + "/products?message=Not+found");
    }
}
