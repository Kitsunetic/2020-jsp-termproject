<%--
  Created by IntelliJ IDEA.
  User: shim
  Date: 11/9/20
  Time: 7:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>파일 업로드 테스트</title>
</head>
<body>

Hello World!!

<form action="api/upload.jsp" method="post" enctype="multipart/form-data">
    file: <input type="file" name="file">
    <input type="submit" value="file upload">
</form>
</body>
</html>
