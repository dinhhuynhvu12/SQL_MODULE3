<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Discount Result</title>
</head>
<body>
<%
    String productDescription = (String) request.getAttribute("productDescription");
    String listPrice = (String) request.getAttribute("listPrice");
    String discountPercent = (String) request.getAttribute("discountPercent");
    String discountAmount = (String) request.getAttribute("discountAmount");
    String discountPrice = (String) request.getAttribute("discountPrice");
    java.util.List<String> errors = (java.util.List<String>) request.getAttribute("errors");
%>

<h1>Discount Result</h1>

<% if (errors != null && !errors.isEmpty()) { %>
    <div style="color: red;">
        <ul>
            <% for (String e : errors) { %>
                <li><%= e %></li>
            <% } %>
        </ul>
    </div>
<% } %>

<table>
    <tr>
        <td>Product Description:</td>
        <td><%= productDescription != null ? productDescription : "" %></td>
    </tr>
    <tr>
        <td>List Price:</td>
        <td><%= listPrice != null ? listPrice : "" %></td>
    </tr>
    <tr>
        <td>Discount Percent:</td>
        <td><%= discountPercent != null ? discountPercent : "" %> %</td>
    </tr>
    <tr>
        <td>Discount Amount:</td>
        <td><%= discountAmount != null ? discountAmount : "" %></td>
    </tr>
    <tr>
        <td>Discount Price:</td>
        <td><%= discountPrice != null ? discountPrice : "" %></td>
    </tr>
</table>

<br/>
<a href="index.jsp">Back</a>

</body>
</html>
