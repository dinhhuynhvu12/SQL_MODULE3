<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.productapp.model.Product" %>
<%@ page import="com.example.productapp.util.WebUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
</head>
<body>
<h1>Products</h1>
<% String message = (String) request.getAttribute("message"); if (message != null) { %>
    <p style="color:green"><%= WebUtils.escapeHtml(message) %></p>
<% } %>
<form action="<%=request.getContextPath()%>/products" method="get" style="margin-bottom:10px;">
    <input type="text" name="q" value="<%=WebUtils.escapeHtml((String)request.getAttribute("query"))%>" placeholder="Search by name"/>
    <input type="submit" value="Search"/>
    <a href="<%=request.getContextPath()%>/products">Clear</a>
</form>
<a href="<%=request.getContextPath()%>/products/create">Create new product</a>
<table border="1" cellpadding="4" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null) {
            for (Product p : products) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><a href="<%=request.getContextPath()%>/products/view?id=<%=p.getId()%>"><%= WebUtils.escapeHtml(p.getName()) %></a></td>
        <td><%= WebUtils.escapeHtml(p.getDescription()) %></td>
        <td><%= p.getPrice() == null ? "" : p.getPrice().toString() %></td>
        <td>
            <a href="<%=request.getContextPath()%>/products/edit?id=<%=p.getId()%>">Edit</a>
            <form action="<%=request.getContextPath()%>/products/delete" method="post" style="display:inline">
                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                <input type="submit" value="Delete" onclick="return confirm('Delete product?');"/>
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>
</body>
</html>
