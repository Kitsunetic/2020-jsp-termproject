<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    String v = request.getParameter("name");

    try (Connection conn = DBConn.getConnection()) {
        String sql = "select 1 from user where name=?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, v);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            rs.getInt(1);
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }

    // TODO: json return
%>
