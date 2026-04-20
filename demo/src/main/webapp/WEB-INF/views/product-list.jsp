<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
</head>
<body>
<h1>Products</h1>
<c:if test="${not empty message}">
    <p style="color:green"><c:out value="${message}"/></p>
</c:if>
<form action="${pageContext.request.contextPath}/products" method="get" style="margin-bottom:10px;">
    <input type="text" name="q" value="${fn:escapeXml(query)}" placeholder="Search by name"/>
    <select name="category">
        <option value="">-- all categories --</option>
        <c:forEach var="c" items="${categories}">
            <option value="${c.id}" <c:if test="${selectedCategory == c.id}">selected</c:if>>
                <c:out value="${c.name}"/>
            </option>
        </c:forEach>
    </select>
    <input type="submit" value="Search"/>
    <a href="${pageContext.request.contextPath}/products">Clear</a>
</form>
<a href="${pageContext.request.contextPath}/products/create">Create new product</a>
<table border="1" cellpadding="4" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="p" items="${products}">
        <tr>
            <td><c:out value="${p.id}"/></td>
            <td><a href="${pageContext.request.contextPath}/products/view?id=${p.id}"><c:out value="${p.name}"/></a></td>
            <td><c:out value="${p.description}"/></td>
            <td><c:out value="${p.price}"/></td>
            <td>
                <a href="${pageContext.request.contextPath}/products/edit?id=${p.id}">Edit</a>
                <button type="button" onclick="showDeleteModal(${p.id})">Delete</button>
            </td>
        </tr>
    </c:forEach>
</table>

<c:set var="pageNum" value="${page != null ? page : 1}" />
<c:set var="totalPagesNum" value="${totalPages != null ? totalPages : 1}" />

<div style="margin-top:10px;">
    <c:if test="${pageNum > 1}">
        <a href="${pageContext.request.contextPath}/products?page=${pageNum - 1}&q=${fn:escapeXml(query)}${selectedCategory != null ? '&category=' + selectedCategory : ''}">Prev</a>
    </c:if>
    Page <c:out value="${pageNum}"/> of <c:out value="${totalPagesNum}"/>
    <c:if test="${pageNum < totalPagesNum}">
        <a href="${pageContext.request.contextPath}/products?page=${pageNum + 1}&q=${fn:escapeXml(query)}${selectedCategory != null ? '&category=' + selectedCategory : ''}">Next</a>
    </c:if>
</div>

<div id="deleteModal" style="display:none; position:fixed; left:0; top:0; right:0; bottom:0; background:rgba(0,0,0,0.5)">
    <div style="background:#fff; width:300px; margin:100px auto; padding:20px;">
        <p>Are you sure you want to delete this product?</p>
        <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/products/delete">
            <input type="hidden" name="id" id="deleteId" value=""/>
            <button type="submit">Yes, delete</button>
            <button type="button" onclick="hideDeleteModal()">Cancel</button>
        </form>
    </div>
</div>

<script>
    function showDeleteModal(id) { document.getElementById('deleteId').value = id; document.getElementById('deleteModal').style.display = 'block'; }
    function hideDeleteModal() { document.getElementById('deleteModal').style.display = 'none'; }
</script>
</body>
</html>
