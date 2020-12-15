<%
    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sorry, Something went wrong</title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container py-5">
    <div class="text-center">
        <b>Sorry, Something went wrong</b>
        <hr>
        <p>Go to <a href="./index.jsp">main page</a></p>
    </div>
</div>
</body>
</html>
