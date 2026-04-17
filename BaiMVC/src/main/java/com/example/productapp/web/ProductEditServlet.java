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
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/products/edit"})
public class ProductEditServlet extends HttpServlet {
    private final ProductService service = ServiceFactory.getService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            Product p = service.findById(id);
            if (p == null) {
                req.setAttribute("message", "Product not found");
                req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("product", p);
            req.setAttribute("action", "edit");
            req.getRequestDispatcher("/WEB-INF/jsp/form.jsp").forward(req, resp);
        } catch (NumberFormatException ex) {
            req.setAttribute("message", "Invalid id");
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> errors = new HashMap<>();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        String priceStr = req.getParameter("price");

        int id = 0;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException ex) {
            req.setAttribute("message", "Invalid id");
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
            return;
        }

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
            Product p = new Product();
            p.setId(id);
            p.setName(name);
            p.setDescription(desc);
            p.setPrice(price);
            req.setAttribute("errors", errors);
            req.setAttribute("product", p);
            req.setAttribute("action", "edit");
            req.getRequestDispatcher("/WEB-INF/jsp/form.jsp").forward(req, resp);
            return;
        }

        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setDescription(desc);
        p.setPrice(price);
        service.update(p);
        resp.sendRedirect(req.getContextPath() + "/products");
    }
}
