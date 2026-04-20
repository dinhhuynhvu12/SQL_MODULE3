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
import java.util.Optional;

@WebServlet(name = "ProductViewServlet", urlPatterns = {"/products/view"})
public class ProductViewServlet extends HttpServlet {
    private final ProductService productService = ProductServiceFactory.getInstance();

    private CategoryService getCategoryService(HttpServletRequest req) {
        Object o = req.getServletContext().getAttribute("categoryService");
        return o instanceof CategoryService ? (CategoryService) o : new JdbcCategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = WebUtils.parseIntSafe(req.getParameter("id"), -1);
        Optional<Product> p = productService.findById(id);
        if (p.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products?message=Not+found");
            return;
        }
        req.setAttribute("product", p.get());
        if (p.get().getCategoryId() != null) {
            getCategoryService(req).findById(p.get().getCategoryId()).ifPresent(cat -> req.setAttribute("categoryName", cat.getName()));
        }
        req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
    }
}
