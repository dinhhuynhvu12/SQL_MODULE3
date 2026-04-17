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
import java.math.BigDecimal;
import java.util.Optional;

@WebServlet(name = "ProductEditServlet", urlPatterns = {"/products/edit"})
public class ProductEditServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = WebUtils.parseIntSafe(req.getParameter("id"), -1);
        Optional<Product> p = productService.findById(id);
        if (p.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products?message=Not+found");
            return;
        }
        req.setAttribute("product", p.get());
        req.setAttribute("action", "update");
        req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = WebUtils.parseIntSafe(req.getParameter("id"), -1);
        Optional<Product> existing = productService.findById(id);
        if (existing.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products?message=Not+found");
            return;
        }
        String name = WebUtils.orEmpty(req.getParameter("name")).trim();
        String description = WebUtils.orEmpty(req.getParameter("description")).trim();
        String priceStr = WebUtils.orEmpty(req.getParameter("price")).trim();

        if (name.isEmpty()) {
            req.setAttribute("error", "Name is required");
            req.setAttribute("product", existing.get());
            req.setAttribute("action", "update");
            req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            return;
        }

        BigDecimal price = null;
        try {
            if (!priceStr.isEmpty()) price = new BigDecimal(priceStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid price");
            req.setAttribute("product", existing.get());
            req.setAttribute("action", "update");
            req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            return;
        }

        Product p = existing.get();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        productService.update(p);
        resp.sendRedirect(req.getContextPath() + "/products?message=Updated");
    }
}
