<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="utils.Encryption" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // Login 정보 받기
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    // DB 접속
    try (Connection conn = DBConn.getConnection()) {
        // SHA5 변환 / id;pw 맞는 유저가 있는지 확인
        String pw_enc = Encryption.sha256(pw);
        String sql = "select _id, name, nickname from user where name='" + id + "' and password='" + pw_enc + "'";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            session.setAttribute("_id", rs.getString("_id"));
            session.setAttribute("name", rs.getString("name"));
            session.setAttribute("nickname", rs.getString("nickname"));
            response.sendRedirect("../");
        } else {
%>
<script>
    alert('로그인에 실패했습니다!!')
    document.location.href = '../'
</script>
<%
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
