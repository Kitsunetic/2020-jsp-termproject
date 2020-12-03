<%@ page import="db.DBConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    String q = request.getParameter("q");

    // DB에서 파일 키 q에 해당하는 파일들 검색
    Connection conn = DBConn.getConnection();
    PreparedStatement st = conn.prepareStatement(
            "select a._id, a.file_name, a.original_name, a.file_size " +
                    "from items as a " +
                    "left join file_id as b on a.file_id = b._id " +
                    "where b.name = ? " +
                    "order by a.original_name ");
    st.setString(1, q);
    ResultSet rs = st.executeQuery();

    // 파일이 있는지
    int item_id = -1;
    boolean fileExist = false;
    String file_name, original_name = null;
    long file_size = -1;
    String file_size_str = null;
    String owner_name = null;
    if (rs.next()) {
        item_id = rs.getInt("_id");
        fileExist = item_id != -1;
        file_name = rs.getString("file_name");
        original_name = rs.getString("original_name");

        file_size = rs.getLong("file_size");

        if (file_size > 1024 * 1024 * 1024) file_size_str = Long.toString(file_size / 1024 / 1024 / 1024) + " GB";
        else if (file_size > 1024 * 1024) file_size_str = Long.toString(file_size / 1024 / 1024) + " MB";
        else if (file_size > 1024) file_size_str = Long.toString(file_size / 1024) + " KB";
        else file_size_str = Long.toString(file_size) + " Bytes";
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% if (fileExist) { %>
    <title>
        <%=original_name%>
    </title>
    <% } else { %>
    <title>TUNG</title>
    <%}%>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<div class="container text-center justify-content-center align-content-center py-md-5">
    <%if (fileExist) { // 파일이 있으면 %>

    <img src="img/file.png">
    <div class="my-3"></div>
    <div class="d-inline">
        <b>
            <%=original_name%>
        </b>
        <button id="btn-download" class="btn btn-outline-primary ml-4">다운로드</button>
        <iframe id="downloader" style="display: none"></iframe>
    </div>
    <div class="mt-2 mr-5">
        <p style="color: gray">
            Size: <%=file_size_str%>
        </p>
    </div>

    <%} else { // 없는 파일인 경우 %>

    <img src="img/xjd.png">
    <div class="my-5"></div>
    <b style="color: gray">파일이 텅 비었 ... ㅠ _ T</b>

    <%}%>
</div>

<script>
    $('#btn-download').on('click', function () {
        document.getElementById('downloader').src = 'api/download.jsp?q=<%=item_id%>'
    })
</script>

</body>
</html>
