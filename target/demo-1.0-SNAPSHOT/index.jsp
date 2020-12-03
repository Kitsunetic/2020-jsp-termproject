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
            <input id="idbox" type="text" class="form-control w-100" placeholder="Search your file...">
        </div>
        <button id="btn-login" class="btn btn-outline-success my-2 my-sm-0 mr-2" type="submit">Login</button>
        <button id="btn-signup" class="btn btn-warning my-2 my-sm-0" type="submit">Sign Up</button>
    </div>
</nav>

<%-- Login Form --%>
<%
    if (alreadyLoggedIn) {
%>
<div class="container pt-md-5 pt-sm-2">
    <div class="float-right" style="max-width: 1000px">
        <button id="logout-button" class="btn btn-secondary float-right">Logout</button>
    </div>
</div>
<%
} else {
%>
<div class="container pt-md-5 pt-sm-2">
    <div class="text-center">
        <h2><b>Login</b></h2>
    </div>

    <div class="row align-items-center justify-content-center">
        <div id="formContent" class="p-3">
            <form action="api/login.jsp" method="post">
                <input type="text" id="login" class="loginform-input" name="id" placeholder="Login">
                <input type="password" id="password" class="loginform-input" name="pw" placeholder="Password">
                <input type="submit" id="loginButton" class="login-button" value="Login">
            </form>
        </div>
    </div>
</div>
<%
    }
%>

<!-- Padding -->
<div class="py-5"></div>

<!-- Upload Form -->
<div class="container" style="max-width: 1000px">
    <div class="mb-2"></div>
    <div id="popup-zone" class="mb-1">
        <%
            String result = request.getParameter("result");
            if (result != null) {
                if (result.equals("200")) { %>
        <div class="alert alert-success fade show" role="alert200">
            <strong>Suceess!!</strong> Upload Succeeded.<br>
            <%
                String file_id = request.getParameter("file_id");
                out.print("File ID: ");
                out.println(file_id);
            %>
            <button type="button" class="close" data-dismiss="alert200" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%} else if (result.equals("400")) {%>
        <div class="alert alert-danger fade show" role="alert400">
            <strong>Failed!!</strong> File ID is wrong.
            <button type="button" class="close" data-dismiss="alert400" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%} else if (result.equals("401")) {%>
        <div class="alert alert-danger fade show" role="alert401">
            <strong>Failed!!</strong> File ID already exists!!
            <button type="button" class="close" data-dismiss="alert401" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%} else if (result.equals("403")) {%>
        <div class="alert alert-danger fade show" role="alert403">
            <strong>Failed!!</strong> No File!!
            <button type="button" class="close" data-dismiss="alert403" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%} else if (result.equals("404")) {%>
        <div class="alert alert-danger fade show" role="alert404">
            <strong>Failed!!</strong> Unknown Error!!
            <button type="button" class="close" data-dismiss="alert404" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
<div class="container" style="max-width: 1000px">
    <form id="upload-form" action="./api/upload.jsp" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <div id="file-pool" class="custom-file">
                <input type="file" class="custom-file-input my-file-input" id="input-file-0" name="file">
                <label class="custom-file-label" for="input-file-0">Choose File</label>
            </div>
            <!--div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button">-</button>
            </div-->
        </div>

        <div class="float-right">
            <div class="input-group pt-2 float-right" style="max-width: 500px">
                <input type="text" class="form-control" name="file_id"
                       placeholder="File Access Key ..." maxlength="36">
                <div class="input-group-append">
                    <input type="submit" id="upload-button" class="btn btn-outline-secondary" value="Upload File">
                </div>
            </div>
        </div>
    </form>
</div>

<script src="./js/index.js"></script>

</body>
</html>
