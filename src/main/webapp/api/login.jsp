<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="db.DBConn" %>
<%@ page import="utils.Encryption" %>
<%@ page import="java.sql.*" %>

<%
    // Login 정보 받기
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    // DB 접속
    try (Connection conn = DBConn.getConnection()) {
        // SHA5 변환 / id;pw 맞는 유저가 있는지 확인
        String pw_enc = Encryption.sha256(pw);
        String sql = "SELECT `_id`, `nickname` FROM `user` WHERE `name`=? AND `password`=?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, id);
        st.setString(2, pw_enc);

        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            session.setAttribute("_id", rs.getString("_id"));
            session.setAttribute("nickname", rs.getString("nickname"));

            // API이므로, 렌더링을 지양하고, status로 결과를 return
            response.setStatus(200);
        } else {
            response.setStatus(401);
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
        response.setStatus(500);
    }
%>
