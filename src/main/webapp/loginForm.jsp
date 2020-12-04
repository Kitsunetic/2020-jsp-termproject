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
    <title>로그인</title>

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
</head>
<body>

<div class="container pt-md-5">
    <div class="card bg-light">
        <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title mt-3 text-center">로그인</h4>
            <form action="api/login.jsp" method="post">
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                    </div>
                    <input name="id" id="login" class="form-control" placeholder="아이디" type="text">
                </div>
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                    </div>
                    <input name="pw" id="password" class="form-control" placeholder="비밀번호" type="password">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">로그인</button>
                </div>
            </form>
        </article>
    </div>
</div>

<script>
    $('#login').on('keypress', function (e) {
        if (e.which === 13) document.getElementById('password').focus()
    })
    $('#password').on('keypress', function (e) {
        if (e.which === 13) document.getElementById('btn-login').click()
    })
</script>

</body>
</html>
