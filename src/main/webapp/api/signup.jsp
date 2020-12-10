<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.Encryption" %>

<%
    if (session.getAttribute("_id") != null) {
        response.sendRedirect("index.jsp");
    }

    String nickname = request.getParameter("nickname");
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String pw_enc = Encryption.sha256(pw);

    try (Connection conn = DBConn.getConnection()) {
        // 사용자가 이미 있는지 확인
        {
            String sql = "select 1 from user where name = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
%>
<script>
    alert('이미 존재하는 아이디입니다!!')
    document.location.href = '../index.jsp'
</script>
<%
                return;
            }
        }

        // 사용자 insert
        String sql = "insert into user (name, nickname, password) values (?, ?, ?)";
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
            session.setAttribute("name", id);
        }

        response.sendRedirect("../index.jsp");
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
