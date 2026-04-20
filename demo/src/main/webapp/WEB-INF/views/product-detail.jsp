<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.productapp.model.Product" %>
<%@ page import="com.example.productapp.util.WebUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Detail</title>
</head>
<body>
<%
    Product p = (Product) request.getAttribute("product");
    if (p == null) {
%>
    <p>Product not found.</p>
<% } else { %>
    <h1><%= WebUtils.escapeHtml(p.getName()) %></h1>
    <p><strong>ID:</strong> <%= p.getId() %></p>
    <p><strong>Description:</strong> <%= WebUtils.escapeHtml(p.getDescription()) %></p>
    <p><strong>Price:</strong> <%= p.getPrice() == null ? "" : p.getPrice().toString() %></p>
    <% String catName = (String) request.getAttribute("categoryName"); if (catName != null) { %>
    <p><strong>Category:</strong> <%= WebUtils.escapeHtml(catName) %></p>
    <% } %>
    <p><a href="<%=request.getContextPath()%>/products">Back to list</a> | <a href="<%=request.getContextPath()%>/products/edit?id=<%=p.getId()%>">Edit</a></p>
<% } %>
</body>
</html>
