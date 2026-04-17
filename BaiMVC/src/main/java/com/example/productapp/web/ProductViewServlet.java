package com.example.productapp.web;

import com.example.productapp.model.Product;
import com.example.productapp.service.ProductService;
import com.example.productapp.service.ServiceFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {"/products/view"})
public class ProductViewServlet extends HttpServlet {
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
            req.getRequestDispatcher("/WEB-INF/jsp/view.jsp").forward(req, resp);
        } catch (NumberFormatException ex) {
            req.setAttribute("message", "Invalid id");
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
        }
    }
}
