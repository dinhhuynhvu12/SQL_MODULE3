package com.example.demo3;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "displayDiscountServlet", value = "/display-discount")
public class DisplayDiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String productDescription = request.getParameter("productDescription");
        String listPriceStr = request.getParameter("listPrice");
        String discountPercentStr = request.getParameter("discountPercent");

        List<String> errors = new ArrayList<>();

        if (productDescription == null || productDescription.trim().isEmpty()) {
            errors.add("Product Description is required.");
        }
        double listPrice = 0.0;
        double discountPercent = 0.0;
        if (listPriceStr == null || listPriceStr.trim().isEmpty()) {
            errors.add("List Price is required.");
        } else {
            try {
                listPrice = Double.parseDouble(listPriceStr);
                if (listPrice < 0) {
                    errors.add("List Price must be non-negative.");
                }
            } catch (NumberFormatException e) {
                errors.add("List Price must be a valid number.");
            }
        }

        if (discountPercentStr == null || discountPercentStr.trim().isEmpty()) {
            errors.add("Discount Percent is required.");
        } else {
            try {
                discountPercent = Double.parseDouble(discountPercentStr);
                if (discountPercent < 0 || discountPercent > 100) {
                    errors.add("Discount Percent must be between 0 and 100.");
                }
            } catch (NumberFormatException e) {
                errors.add("Discount Percent must be a valid number.");
            }
        }
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("productDescription", productDescription);
            request.setAttribute("listPrice", listPriceStr);
            request.setAttribute("discountPercent", discountPercentStr);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        double discountAmount = listPrice * discountPercent * 0.01;
        double discountPrice = listPrice - discountAmount;

        DecimalFormat df = new DecimalFormat("0.00");

        request.setAttribute("productDescription", productDescription);
        request.setAttribute("listPrice", df.format(listPrice));
        request.setAttribute("discountPercent", df.format(discountPercent));
        request.setAttribute("discountAmount", df.format(discountAmount));
        request.setAttribute("discountPrice", df.format(discountPrice));

        request.getRequestDispatcher("/display-discount.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
