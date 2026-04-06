<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Simple Calculator</title>
</head>
<body>
<h1>Simple Calculator</h1>
<form method="post" action="calculate">
    <label>First operand: <input type="text" name="operand1"/></label><br/>
    <label>Operator:
        <select name="operation">
            <option value="add">Addition</option>
            <option value="sub">Subtraction</option>
            <option value="mul">Multiplication</option>
            <option value="div">Division</option>
        </select>
    </label>
    <br/>
    <label>Second operand: <input type="text" name="operand2"/></label>
    <br/>
    <input type="submit" value="Calculate"/>
</form>
<br/>
<a href="index.jsp">Home</a>
</body>
</html>
