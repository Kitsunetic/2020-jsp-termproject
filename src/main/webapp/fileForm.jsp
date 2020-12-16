<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%
    String q = request.getParameter("q");
    Object uid_ = session.getAttribute("_id");
    int uid = uid_ != null ? (int) uid_ : -1;

    ArrayList<Integer> fileKeys = new ArrayList<>();
    ArrayList<String> fileCodes = new ArrayList<>();
    ArrayList<String> fileNames = new ArrayList<>();
    ArrayList<String> fileOriginalNames = new ArrayList<>();
    ArrayList<Integer> fileSizes = new ArrayList<>();

    // DB에서 파일 키 q에 해당하는 파일들 검색
    try (Connection conn = DBConn.getConnection()) {
        String sql = "SELECT a._id, a.file_name, a.original_name, a.file_size " +
                "FROM items AS a " +
                "LEFT JOIN file_id AS b ON a.file_id = b._id " +
                "WHERE b.name = ? AND (NOT a.owner_only OR (a.owner_only AND a.owner = ?)) " +
                "ORDER BY a.original_name ";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, q);
        st.setInt(2, uid);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            fileKeys.add(rs.getInt("_id"));
            fileCodes.add(q);
            fileNames.add(rs.getString("file_name"));
            fileOriginalNames.add(rs.getString("original_name"));
            fileSizes.add(rs.getInt("file_size"));
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }

    boolean fileExist = fileCodes.size() > 0;

    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
    boolean uploadSucceeded = session.getAttribute("upload") != null;
    String uploadSucceededClass = "d-none";
    if (uploadSucceeded) {
        session.removeAttribute("upload");
        uploadSucceededClass = "";
    }

    boolean onlyOneFile = fileCodes.size() == 1;
%>

<html>
<head>
    <title>
        <%=fileExist ? q : "텅~"%>
    </title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>

<%@ include file="navbar.jsp" %>
<script>
    $('#idbox').val('<%=q%>')
</script>

<div class="container text-center justify-content-center align-content-center py-md-5">
    <% if (fileExist) { %>
    <%-- =========================================== --%>
    <%--             파일이 있는 경우                    --%>
    <%-- =========================================== --%>
    <div class="row <%=uploadSucceededClass%>" id="success-message">
        <div class="col pb-2">
            <b style="color: gray">업로드 성공 !!</b>
        </div>
    </div>
    <div class="pb-2">
        <h2>File Key: <%=q%>
        </h2>
    </div>
    <% if (onlyOneFile) { %>
    <%@ include file="singleFileView.jsp" %>
    <% } else { %>
    <%@ include file="fileTableView.jsp" %>
    <% } %>
    <% } else { %>
    <%-- =========================================== --%>
    <%--             파일이 없는 경우                    --%>
    <%-- =========================================== --%>
    <img src="img/xjd.png">
    <div class="my-5"></div>
    <b style="color: gray">파일이 텅 비었 ... ㅠ _ T</b>
    <% } %>
</div>

</body>
</html>
