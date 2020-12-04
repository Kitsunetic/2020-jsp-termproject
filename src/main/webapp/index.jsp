<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
%>

<html>
<head>
    <title>Login or Upload File</title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./index.jsp">FileCoder</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <div class="container" style="max-width: 600px">
            <input id="idbox" type="text" class="form-control w-100" placeholder="파일 키로 검색">
        </div>
        <% if (alreadyLoggedIn) { %>
        <a class="navbar-brand">
            <%=(String) session.getAttribute("nickname")%>
        </a>
        <button id="btn-logout" class="btn btn-outline-success my-2 my-sm-0 mr-2">로그아웃</button>
        <% } else { %>
        <button id="btn-login" class="btn btn-outline-success my-2 my-sm-0 mr-2">로그인</button>
        <button id="btn-signup" class="btn btn-warning my-2 my-sm-0">회원가입</button>
        <% } %>
    </div>
</nav>

<!-- Padding -->
<div style="height: 25vh"></div>

<!-- Upload Form -->
<div class="container" style="max-width: 700px">
    <form id="upload-form" action="./api/upload.jsp" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <div id="file-pool" class="custom-file">
                <input type="file" class="custom-file-input my-file-input" id="input-file-0" name="file">
                <label class="custom-file-label" for="input-file-0">파일을 업로드하고 키로 다운로드 하세요</label>
            </div>
            <!--div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button">-</button>
            </div-->
        </div>

        <div class="float-right">
            <div class="input-group pt-2 float-right" style="max-width: 500px">
                <input type="text" class="form-control" name="file_id"
                       placeholder="파일 접근 키" maxlength="36">
                <div class="input-group-append">
                    <input type="submit" id="upload-button" class="btn btn-outline-secondary" value="파일 업로드">
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // Logout button
    $('#logout-button').on('click', function () {
        window.location.href = './api/logout.jsp'
    })

    // File choose box
    $("#input-file-0").on("change", function () {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    // login + signup button
    $('#btn-login').on('click', function () {
        window.location.href = './loginForm.jsp'
    })
    $('#btn-signup').on('click', function () {
        window.location.href = './signUpForm.jsp'
    })
    $('#btn-logout').on('click', function () {
        window.location.href = './api/logout.jsp'
    })

    // filekey search textbox
    $('#idbox').on('keypress', function (e) {
        if (e.which == 13) {
            var filekey = $('#idbox').val()
            window.location.href = 'fileForm.jsp?q=' + encodeURI(filekey)
        }
    })
</script>

</body>
</html>
