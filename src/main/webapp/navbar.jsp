<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
