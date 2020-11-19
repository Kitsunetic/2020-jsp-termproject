<%--
  Created by IntelliJ IDEA.
  User: shim
  Date: 11/19/20
  Time: 4:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<html>
<head>
    <title>Session Test</title>
</head>
<body>
<%
    if(session.isNew()) {
        out.println("New Session!!");
        session.setAttribute("login", "logined");
    }
%>

<%=session.getAttribute("login")%><br>
1. Session ID: <%=session.getId()%><br>
2. session time: <%=session.getMaxInactiveInterval()%><br>
</body>
</html>
