<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>


<html>
<head>
    <title>Title</title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>
<div class="container">
    <%
        Connection conn = DBConn.getConnection();
        out.print("DB connection: " + conn + "<br>");

        if (conn == null) {
            out.print("Cannot connect to DB!!<br>");
        } else {
            try {
                Statement stmt = conn.createStatement();
                String sql = "select * from user";
                stmt.executeQuery(sql);
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    do {
                        out.print("user: " + rs.getString("_id") + ", " + rs.getString("name") + ", " + rs.getString("password") + "<br>");
                    } while (rs.next());
                } else {
                    out.print("검색 결과가 없습니다.");
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
    %>
</div>
</body>
</html>
