<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

<%@ include file="navbar.jsp"%>

<div class="container text-center justify-content-center align-content-center py-md-5">
    <img src="img/xjd.png">
    <div class="my-5"></div>
    <b style="color: gray">파일 업로드에 실패했습니다 ...</b>
</div>

</body>
</html>
