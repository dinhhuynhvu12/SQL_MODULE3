package com.example.demo2;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "calculatorServlet", value = "/calculate")
public class CalculatorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Redirect GET requests to the calculator form
        response.sendRedirect("calculator.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String s1 = request.getParameter("operand1");
        String s2 = request.getParameter("operand2");
        String op = request.getParameter("operation");

        String error = null;
        Double result = null;
        double a = 0.0, b = 0.0;

        try {
            if (s1 == null || s1.trim().isEmpty() || s2 == null || s2.trim().isEmpty()) {
                throw new NumberFormatException("Missing operand");
            }
            a = Double.parseDouble(s1.trim());
            b = Double.parseDouble(s2.trim());

            if (op == null) {
                error = "No operation selected.";
            } else {
                switch (op) {
                    case "add":
                        result = a + b;
                        break;
                    case "sub":
                        result = a - b;
                        break;
                    case "mul":
                        result = a * b;
                        break;
                    case "div":
                        if (b == 0.0) {
                            error = "Cannot divide by zero.";
                        } else {
                            result = a / b;
                        }
                        break;
                    default:
                        error = "Unknown operation.";
                }
            }
        } catch (NumberFormatException e) {
            error = "Invalid number format.";
        }

        if (error != null) {
            request.setAttribute("errorMessage", error);
        } else {
            request.setAttribute("result", result);
            request.setAttribute("operand1", a);
            request.setAttribute("operand2", b);
            request.setAttribute("operation", op);
        }

        RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
        rd.forward(request, response);
    }
}
