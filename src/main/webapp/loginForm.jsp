<%
    // 이미 로그인 됐으면 index로 되돌림
    if (session.getAttribute("_id") != null) {
        response.sendRedirect("./index.jsp");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/loginForm.css"/>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<!-- Top padding -->
<div class="h-25"></div>

<!-- Login Form -->
<div class="container pt-md-5 pt-sm-2">
    <div class="text-center">
        <h2><b></b></h2>
    </div>

    <div class="row align-items-center justify-content-center">
        <div id="formContent" class="p-3">
            <form action="api/login.jsp" method="post">
                <input type="text" id="login" class="loginform-input" name="id" placeholder="아이디">
                <input type="password" id="password" class="loginform-input" name="pw" placeholder="비밀번호">
                <div class="my-2"></div>
                <!--input type="submit" id="loginButton" class="login-button" value="로그인"-->
                <div class="custom-control-inline w-100">
                    <input type="submit" id="btn-login" class="btn btn-primary w-50" value="로그인">
                    <div class="mx-2"></div>
                    <input type="submit" id="btn-signin" class="btn btn-warning w-50" value="회원가입">
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $('#login').on('keypress', function (e) {
        if(e.which == 13) {
            var password = document.getElementById('password')
            password.focus()
        }
    })
    $('#password').on('keypress', function (e) {
        if(e.which == 13) {
            var btn_login = document.getElementById('btn-login')
            btn_login.click()
        }
    })
</script>

</body>
</html>
