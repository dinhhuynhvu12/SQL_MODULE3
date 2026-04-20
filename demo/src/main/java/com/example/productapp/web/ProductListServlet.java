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
import java.util.List;

@WebServlet(name = "ProductListServlet", urlPatterns = {"/products"})
public class ProductListServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    private CategoryService getCategoryService(HttpServletRequest req) {
        Object o = req.getServletContext().getAttribute("categoryService");
        return o instanceof CategoryService ? (CategoryService) o : new JdbcCategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = WebUtils.orEmpty(req.getParameter("q")).trim();
        int categoryId = WebUtils.parseIntSafe(req.getParameter("category"), -1);
        int page = Math.max(1, WebUtils.parseIntSafe(req.getParameter("page"), 1));
        int size = Math.max(1, WebUtils.parseIntSafe(req.getParameter("size"), 10));
        int offset = (page - 1) * size;

        Integer catId = categoryId > 0 ? categoryId : null;
        List<Product> products = productService.search(q.isEmpty() ? null : q, catId, offset, size);
        int total = productService.countSearch(q.isEmpty() ? null : q, catId);
        int totalPages = (int) Math.ceil((double) total / size);

        req.setAttribute("products", products);
        req.setAttribute("query", q);
        req.setAttribute("selectedCategory", catId);
        req.setAttribute("categories", getCategoryService(req).findAll());
        req.setAttribute("page", page);
        req.setAttribute("size", size);
        req.setAttribute("totalPages", totalPages);

        String message = req.getParameter("message");
        if (message != null) req.setAttribute("message", message);

        req.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(req, resp);
    }
}
