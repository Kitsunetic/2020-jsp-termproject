<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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
<%@ include file="navbar.jsp"%>

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
