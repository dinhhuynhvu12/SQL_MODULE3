<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Products</title>
</head>
<body>
<h1>Products</h1>
<form method="get" action="${pageContext.request.contextPath}/products">
    <input type="text" name="q" value="${fn:escapeXml(q)}" placeholder="Search by name..." />
    <input type="submit" value="Search" />
    <a href="${pageContext.request.contextPath}/products/create">Create new</a>
</form>

<table border="1" cellpadding="4" cellspacing="0">
    <tr><th>ID</th><th>Name</th><th>Price</th><th>Actions</th></tr>
    <c:forEach var="p" items="${products}">
        <tr>
            <td>${p.id}</td>
            <td><c:out value="${p.name}"/></td>
            <td><c:out value="${p.price}"/></td>
            <td>
                <a href="${pageContext.request.contextPath}/products/view?id=${p.id}">View</a>
                <a href="${pageContext.request.contextPath}/products/edit?id=${p.id}">Edit</a>
                <form method="post" action="${pageContext.request.contextPath}/products/delete" style="display:inline">
                    <input type="hidden" name="id" value="${p.id}" />
                    <button type="submit" onclick="return confirm('Delete?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
