<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title><c:choose><c:when test="${action == 'edit'}">Edit</c:when><c:otherwise>Create</c:otherwise></c:choose> Product</title>
</head>
<body>
<h1><c:choose><c:when test="${action == 'edit'}">Edit</c:when><c:otherwise>Create</c:otherwise></c:choose> Product</h1>

<c:if test="${not empty errors}">
    <ul style="color:red">
        <c:forEach var="e" items="${errors}">
            <li>${e.value}</li>
        </c:forEach>
    </ul>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/products/${action}">
    <c:if test="${action == 'edit'}">
        <input type="hidden" name="id" value="${product.id}" />
    </c:if>
    <div>
        <label>Name</label>
        <input type="text" name="name" value="${product.name}" />
    </div>
    <div>
        <label>Description</label>
        <textarea name="description">${product.description}</textarea>
    </div>
    <div>
        <label>Price</label>
        <input type="text" name="price" value="${product.price}" />
    </div>
    <div>
        <button type="submit">Save</button>
        <a href="${pageContext.request.contextPath}/products">Back</a>
    </div>
</form>

</body>
</html>
