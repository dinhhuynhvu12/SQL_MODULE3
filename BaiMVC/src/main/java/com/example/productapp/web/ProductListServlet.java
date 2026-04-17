package com.example.productapp.web;

import com.example.productapp.service.ServiceFactory;
import com.example.productapp.service.ProductService;
import com.example.productapp.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products"})
public class ProductListServlet extends HttpServlet {
    private final ProductService service = ServiceFactory.getService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        List<Product> products = (q == null || q.isEmpty()) ? service.listAll() : service.searchByName(q);
        req.setAttribute("products", products);
        req.setAttribute("q", q);
        req.getRequestDispatcher("/WEB-INF/jsp/list.jsp").forward(req, resp);
    }
}
