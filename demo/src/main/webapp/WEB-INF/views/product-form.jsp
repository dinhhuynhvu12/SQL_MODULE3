<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.productapp.model.Product" %>
<%@ page import="com.example.productapp.util.WebUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Form</title>
</head>
<body>
<h1>Product</h1>
<% String error = (String) request.getAttribute("error"); if (error != null) { %>
    <p style="color:red"><%= WebUtils.escapeHtml(error) %></p>
<% } %>
<%
    Product p = (Product) request.getAttribute("product");
    String action = (String) request.getAttribute("action");
    if (p == null) p = new Product();
    if (action == null) action = "create";
    String postUrl = "create".equals(action) ? (request.getContextPath() + "/products/create") : (request.getContextPath() + "/products/edit");
%>
<form action="<%=postUrl%>" method="post">
    <% if ("update".equals(action)) { %>
        <input type="hidden" name="id" value="<%=p.getId()%>"/>
    <% } %>
    <label>Name: <input type="text" name="name" value="<%=WebUtils.escapeHtml(p.getName())%>"/></label><br/>
    <label>Description:<br/>
        <textarea name="description" rows="4" cols="50"><%=WebUtils.escapeHtml(p.getDescription())%></textarea>
    </label><br/>
    <label>Category:
        <select name="category_id">
            <option value="">-- none --</option>
            <% java.util.List<com.example.productapp.model.Category> cats = (java.util.List<com.example.productapp.model.Category>) request.getAttribute("categories");
               if (cats != null) {
                   for (com.example.productapp.model.Category c : cats) {
                       String sel = (p.getCategoryId() != null && p.getCategoryId().intValue() == c.getId()) ? "selected" : "";
            %>
            <option value="<%=c.getId()%>" <%=sel%>><%=WebUtils.escapeHtml(c.getName())%></option>
            <%   }
               }
            %>
        </select>
    </label><br/>
    <label>Price: <input type="text" name="price" value="<%=p.getPrice()==null?"":p.getPrice()%>"/></label><br/>
    <input type="submit" value="Save"/>
</form>
</body>
</html>
