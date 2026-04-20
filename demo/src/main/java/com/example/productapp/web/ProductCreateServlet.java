package com.example.productapp.web;

import com.example.productapp.model.Product;
import com.example.productapp.service.ProductService;
import com.example.productapp.service.ProductServiceFactory;
import com.example.productapp.service.CategoryService;
import com.example.productapp.service.JdbcCategoryServiceImpl;
import com.example.productapp.util.WebUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "ProductCreateServlet", urlPatterns = {"/products/create"})
public class ProductCreateServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    private CategoryService getCategoryService(HttpServletRequest req) {
        Object o = req.getServletContext().getAttribute("categoryService");
        return o instanceof CategoryService ? (CategoryService) o : new JdbcCategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("product", new Product());
        req.setAttribute("action", "create");
        req.setAttribute("categories", getCategoryService(req).findAll());
        req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = WebUtils.orEmpty(req.getParameter("name")).trim();
        String description = WebUtils.orEmpty(req.getParameter("description")).trim();
        String priceStr = WebUtils.orEmpty(req.getParameter("price")).trim();

        if (name.isEmpty()) {
            req.setAttribute("error", "Name is required");
            req.setAttribute("product", new Product());
            req.setAttribute("action", "create");
            req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            return;
        }

        BigDecimal price = null;
        try {
            if (!priceStr.isEmpty()) price = new BigDecimal(priceStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid price");
            req.setAttribute("product", new Product());
            req.setAttribute("action", "create");
            req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            return;
        }

        Product p = new Product();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        String catStr = WebUtils.orEmpty(req.getParameter("category_id")).trim();
        int catId = WebUtils.parseIntSafe(catStr, -1);
        if (catId > 0) p.setCategoryId(catId);
        productService.create(p);
        resp.sendRedirect(req.getContextPath() + "/products?message=Created");
    }
}
