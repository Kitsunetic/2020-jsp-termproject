<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
%>

<html>
<head>
    <title>Login or Upload File</title>
    <link rel="stylesheet" type="text/css" href="css/loginForm.css"/>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<%
    if(alreadyLoggedIn) {
%><%@include file="html/loginForm.html" %><%
    } else {
        // 로그아웃 출력
%><%
    }
%>

<%--TODO: 로그인 이미 됐으면 로그아웃 UI로 바꾸기--%>





<%--TODO: 여기에 파일 업로드 UI 추가--%>

</body>
</html>
