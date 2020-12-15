<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.DBConn" %>

<%
    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
    int _id = -1;
    int numFiles = -1;
    ArrayList<String> fileCodes = new ArrayList<>();
    ArrayList<String> fileNames = new ArrayList<>();
    ArrayList<String> fileOriginalNames = new ArrayList<>();
    ArrayList<Integer> fileSizes = new ArrayList<>();

    if (alreadyLoggedIn) {
        _id = Integer.parseInt((String) session.getAttribute("_id"));
        try (Connection conn = DBConn.getConnection()) {
            String sql = "select file_name, original_name, file_size, fi.name as file_code from items as i " +
                    "left join file_id as fi on i.file_id = fi._id " +
                    "where owner = ? " +
                    "order by original_name";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, _id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                fileCodes.add(rs.getString("file_code"));
                fileNames.add(rs.getString("file_name"));
                fileOriginalNames.add(rs.getString("original_name"));
                fileSizes.add(rs.getInt("file_size"));
            }
            numFiles = fileNames.size();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
%>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>FileCoder</title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<!-- Navbar -->
<%@ include file="navbar.jsp" %>


<%
    if (session.getAttribute("uploadFailed") != null) {
        session.removeAttribute("uploadFailed");
%>
<!-- Upload Failed Message -->
<div class="container text-center justify-content-center align-content-center py-md-5">
    <img src="img/xjd.png">
    <div class="my-5"></div>
    <b style="color: gray">파일 업로드에 실패했습니다 ... T _ ㅠ</b>
</div>
<% } else if (alreadyLoggedIn) {
// 이미 로그인했다면 하단의 파일 목록 때문에 상단 padding을 작게 준다.
%>
<!-- Padding -->
<div style="height: 8vh"></div>
<% } else { %>
<div style="height: 25vh"></div>
<% } %>

<!-- Upload Form -->
<div class="container" style="max-width: 700px">
    <form id="upload-form" action="./api/upload.jsp" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <div id="file-pool" class="custom-file">
                <input type="file" class="custom-file-input my-file-input" id="input-file-0" name="file">
                <label class="custom-file-label" for="input-file-0">파일을 업로드하고 키로 다운로드 하세요</label>
            </div>
        </div>

        <div class="float-right pt-2 pb-4">
            <div class="input-group float-right" style="max-width: 300px">
                <input type="text" class="form-control" name="file_id"
                       placeholder="파일 접근 키" maxlength="36">
                <div class="input-group-append">
                    <input type="submit" id="upload-button" class="btn btn-outline-secondary" value="파일 업로드">
                </div>
            </div>

            <% if (alreadyLoggedIn) {
                // Only for users logged in
            %>
            <div class="input-group pt-2 float-right" style="max-width: 500px">
                <input type="checkbox" class="form-check-inline"
                       name="ck-file-auth" id="ck-file-auth" value="ckFileAuth">
                <label class="form-check-label" for="ck-file-auth">나만 볼 수 있음</label>
                &nbsp;&nbsp;
                <input type="checkbox" class="form-check-inline"
                       name="ck-file-password" id="ck-file-password" value="ckFilePassword">
                <label class="form-check-label" for="ck-file-password">파일 비밀번호 설정</label>
                &nbsp;&nbsp;
                <input type="password" class="form-control" maxlength="128"
                       placeholder="비밀번호" id="txt-file-password" disabled>
            </div>
            <% } %>
        </div>
    </form>
</div>

<% if (alreadyLoggedIn && numFiles >= 1) { %>
<div class="py-5"></div>
<div class="container">
    <%@include file="fileTableView.jsp" %>
</div>
<% }%>

<script>
    $(document).ready(function () {
        // File choose box
        $("#input-file-0").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });

        let ckFilePassword = $('#ck-file-password')
        ckFilePassword.change(function () {
            txtFilePassword = $('#txt-file-password')
            if (ckFilePassword.is(':checked')) {
                txtFilePassword[0].disabled = false
            } else {
                txtFilePassword[0].disabled = true
                txtFilePassword.val('')
            }
        })
    })
</script>

</body>
</html>
