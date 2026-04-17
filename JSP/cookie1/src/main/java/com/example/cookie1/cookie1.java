package com.example.cookie1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
@WebServlet(urlPatterns = {"/cookie1"})
public class cookie1 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter printWriter =  resp.getWriter();
        printWriter.println("xin chao be nha");
        Cookie cookie = new Cookie("name","trung tam java ne be");
        cookie.setMaxAge(60);
            resp.addCookie(cookie);
        Cookie cookie1 = new Cookie("age", "28");
        cookie1.setMaxAge(60);
        resp.addCookie(cookie1);o
    }
}
