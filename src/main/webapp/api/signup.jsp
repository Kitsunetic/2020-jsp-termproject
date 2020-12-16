<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.Encryption" %>

<%
    if (session.getAttribute("_id") != null) {
        response.setStatus(400);
    }

    String nickname = request.getParameter("nickname");
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String pw_enc = Encryption.sha256(pw);

    try (Connection conn = DBConn.getConnection()) {
        // 사용자가 이미 있는지 확인
        {
            String sql = "SELECT 1 FROM user WHERE name = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                response.setStatus(401);
                return;
            }
        }

        // 사용자 insert
        String sql = "INSERT INTO user (name, nickname, password) VALUES (?, ?, ?)";
        PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        st.setString(1, id);
        st.setString(2, nickname);
        st.setString(3, pw_enc);
        st.executeUpdate();

        // 로그인 결과 확인
        ResultSet rs = st.getGeneratedKeys();
        if (rs.next()) {
            session.setAttribute("_id", rs.getInt(1));
            session.setAttribute("nickname", nickname);
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
