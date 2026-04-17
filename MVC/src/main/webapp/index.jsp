<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
<%
    java.util.List<String> errors = (java.util.List<String>) request.getAttribute("errors");
    String productDescription = (String) request.getAttribute("productDescription");
    String listPrice = (String) request.getAttribute("listPrice");
    String discountPercent = (String) request.getAttribute("discountPercent");
%>

<h1>Product Discount Calculator</h1>

<% if (errors != null && !errors.isEmpty()) { %>
    <div style="color: red;">
        <ul>
            <% for (String e : errors) { %>
                <li><%= e %></li>
            <% } %>
        </ul>
    </div>
<% } %>

<form action="display-discount" method="post">
    <label for="productDescription">Product Description:</label><br/>
    <input type="text" id="productDescription" name="productDescription" value="<%= productDescription != null ? productDescription : "" %>" size="50" /><br/><br/>

    <label for="listPrice">List Price:</label><br/>
    <input type="text" id="listPrice" name="listPrice" value="<%= listPrice != null ? listPrice : "" %>" /><br/><br/>

    <label for="discountPercent">Discount Percent:</label><br/>
    <input type="text" id="discountPercent" name="discountPercent" value="<%= discountPercent != null ? discountPercent : "" %>" /><br/><br/>

    <button type="submit">Calculate Discount</button>
</form>

</body>
</html>