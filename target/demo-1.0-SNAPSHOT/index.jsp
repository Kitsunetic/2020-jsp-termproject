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
    if (alreadyLoggedIn) {
%>
<%-- Logout Button --%>
<div class="container  pt-xl-5 pt-1">
    <div style="max-width: 1000px">
        <button id="logout-button" class="btn btn-secondary float-right">Logout</button>
    </div>
</div>
<%
} else {
%>
<%-- Login Form --%>
<div class="container pt-xl-5 pt-1">
    <div class="text-center">
        <h2><b>Login</b></h2>
    </div>

    <div class="row align-items-center justify-content-center">
        <div id="formContent" class="p-3">
            <form action="api/login.jsp" method="post">
                <input type="text" id="login" class="loginform-input" name="id" placeholder="Login">
                <input type="password" id="password" class="loginform-input" name="pw" placeholder="Password">
                <input type="submit" id="loginButton" value="Login">
            </form>
        </div>
    </div>
</div>
<%
    }
%>

<div class="py-5"></div>

<%-- Upload Form --%>
<div class="container">
    <div style="max-width: 1000px">
        <form action="/api/upload.jsp" method="post" enctype="multipart/form-data">
            <div class="input-group mb-3">
                <div id="file-pool" class="custom-file">
                    <input type="file" class="custom-file-input my-file-input" id="input-file-0">
                    <label class="custom-file-label" for="input-file-0">Choose File</label>
                </div>
                <!--div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button">-</button>
                </div-->
            </div>

            <button id="upload-button" class="btn btn-primary float-right" type="button">Upload File</button>

            <% if (alreadyLoggedIn) { %>
            <input name="user_id" type="hidden" value="<%=session.getAttribute("_id")%>">
            <% } %>
        </form>
    </div>
</div>

</body>
</html>
