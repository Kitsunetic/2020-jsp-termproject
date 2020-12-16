<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("_id") != null) {
        response.sendRedirect("index.jsp");
    }
%>

<html>
<head>
    <title>회원가입</title>

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<body>


<div class="container pt-md-5">
    <div class="card bg-light">
        <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title mt-3 text-center">회원가입</h4>
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                </div>
                <input id="txt-nickname" name="nickname" class="form-control" placeholder="닉네임" type="text">
            </div>
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                </div>
                <input id="txt-id" name="id" class="form-control" placeholder="아이디" type="text">
            </div>
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input id="txt-pw" name="pw" class="form-control" placeholder="비밀번호" type="password">
            </div>
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input id="txt-pw2" class="form-control" placeholder="비밀번호 재입력" type="password">
            </div>
            <div id="pw-alert" class="fade"><b style="color: #ff0000; font-size: 11px">비밀번호가 다릅니다</b></div>
            <div class="form-group">
                <button id="btn-submit" class="btn btn-primary btn-block">계정 생성</button>
            </div>
        </article>
    </div>
</div>

<script>
    const onPasswordChanged = function () {
        let pw1 = $('#txt-pw').val()
        let pw2 = $('#txt-pw2').val()
        let pwAlert = $('#pw-alert')
        if (pw1 !== pw2 && pw2) {
            if (!pwAlert.hasClass('show'))
                pwAlert.addClass('show')
        } else if (pwAlert.hasClass('show')) {
            pwAlert.removeClass('show')
        }
    }
    $('#txt-pw').change(onPasswordChanged)
    $('#txt-pw2').change(onPasswordChanged)

    $(document).ready(function () {
        const submitReaction = function (e, xhr, settings) {
            switch (e.status) {
                case 200:
                    document.location.href = 'index.jsp'
                    break
                case 400:
                    alert("잘못된 접근입니다.")
                    document.location.href = 'index.jsp'
                    break
                case 401:
                    alert('이미 존재하는 아이디입니다')
                    break
                default:
                    document.location.href = 'sorry.jsp'
            }
        }
        $('#btn-submit').click(function () {
            let formData = {
                nickname: $('#txt-nickname').val(),
                id: $('#txt-id').val(),
                pw: $('#txt-pw').val()
            }
            $.ajax({
                url: './api/signup.jsp',
                type: 'POST',
                data: formData,
                complete: submitReaction
            })
        })
    })
</script>

</body>
</html>
