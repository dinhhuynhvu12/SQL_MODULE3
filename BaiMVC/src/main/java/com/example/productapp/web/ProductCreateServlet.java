package com.example.productapp.web;

import com.example.productapp.model.Product;
import com.example.productapp.service.InMemoryProductService;
import com.example.productapp.service.ProductService;
import com.example.productapp.service.ServiceFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/products/create"})
public class ProductCreateServlet extends HttpServlet {
    private final ProductService service = ServiceFactory.getService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("action", "create");
        req.getRequestDispatcher("/WEB-INF/jsp/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> errors = new HashMap<>();
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        String priceStr = req.getParameter("price");

        if (name == null || name.trim().isEmpty()) errors.put("name", "Name is required");
        BigDecimal price = null;
        if (priceStr == null || priceStr.trim().isEmpty()) {
            errors.put("price", "Price is required");
        } else {
            try {
                price = new BigDecimal(priceStr.trim());
            } catch (NumberFormatException ex) {
                errors.put("price", "Invalid price format");
            }
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("product", new Product());
            req.setAttribute("action", "create");
            req.getRequestDispatcher("/WEB-INF/jsp/form.jsp").forward(req, resp);
            return;
        }

        Product p = new Product();
        p.setName(name);
        p.setDescription(desc);
        p.setPrice(price);
        p.setCreatedAt(LocalDateTime.now());
        service.create(p);
        resp.sendRedirect(req.getContextPath() + "/products");
    }
}
