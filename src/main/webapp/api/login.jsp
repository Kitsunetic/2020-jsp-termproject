<%--
유저의 로그인 정보를 받아서 로그인 정보가 맞으면 세션을 핧당해준다.
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="db.Encryption" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login test</title>
</head>
<body>
</body>
</html>


<%
    // TODO: originated_from(기존 URL)을 받아서 redirect를 할지, 말지 결정(REST-API이냐, 그냥 접속이냐)

    // Login 정보 받기
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    // TODO: login 정보에 잘못된 문자 등이 포함되었는지 확인

    // DB 접속
    Connection conn = DBConn.getConnection();
    if (conn == null) {
        out.print("Cannot connect to database!!");
        return;
    }

    try {
        // SHA5 변환 / id;pw 맞는 유저가 있는지 확인
        String pw_enc = Encryption.sha256(pw);
        out.print("name: " + id + "<br>");
        out.print("pw: " + pw + "<br>");

        String sql = "select _id from user where name='" + id + "' and password='" + pw_enc + "'";
        out.print("pw enc: " + pw_enc + "<br>");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            String _id = rs.getString("_id");
            session.setAttribute("_id", _id);
            out.print("Login!!");
        } else {
            out.print("No User or worng password!!");
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
