<%--
  Created by IntelliJ IDEA.
  User: shim
  Date: 11/19/20
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Form</title>
</head>
<body>
<form action="api/login.jsp" method="post">
    ID: <input type="text" name="id"><br>
    PW: <input type="password" name="pw"><br>
    <input type="submit" value="Login">
</form>

</body>
</html>
