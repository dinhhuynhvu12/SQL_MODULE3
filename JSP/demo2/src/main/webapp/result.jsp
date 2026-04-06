<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Result</title>
</head>
<body>
<h1>Result:</h1>
<%
    Object error = request.getAttribute("errorMessage");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    } else {
        Double result = (Double) request.getAttribute("result");
        Object op = request.getAttribute("operation");
        Object a = request.getAttribute("operand1");
        Object b = request.getAttribute("operand2");
%>
    <p><%= a %> <%= ("add".equals(op) ? "+" : ("sub".equals(op) ? "-" : ("mul".equals(op) ? "*" : ("div".equals(op) ? "/" : "?")))) %> <%= b %> = <%= result %></p>
<%
    }
%>
<br/>
<a href="calculator.jsp">Back</a>
</body>
</html>
