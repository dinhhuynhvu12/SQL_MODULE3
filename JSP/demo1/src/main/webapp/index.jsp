<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <style>
        table { border-collapse: collapse; width: 70%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #f4f4f4; }
        img { max-width: 60px; }
    </style>
</head>
<body>
<h1>Danh sách khách hàng</h1>

<c:choose>
    <c:when test="${not empty customers}">
        <table>
            <thead>
            <tr>
                <th>Tên</th>
                <th>Ngày sinh</th>
                <th>Địa chỉ</th>
                <th>Ảnh</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cust" items="${customers}">
                <tr>
                    <td><c:out value="${cust.name}"/></td>
                    <td><fmt:formatDate value="${cust.birthDate}" pattern="yyyy-MM-dd"/></td>
                    <td><c:out value="${cust.address}"/></td>
                    <td><img src="${pageContext.request.contextPath}/${cust.imageURL}" alt="ảnh"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p>Không có khách hàng để hiển thị. <a href="customers">Tải dữ liệu mẫu</a></p>
    </c:otherwise>
</c:choose>

</body>
</html>