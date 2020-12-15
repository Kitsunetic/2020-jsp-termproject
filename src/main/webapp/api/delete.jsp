<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("UTF-8");
    String q = request.getParameter("q"); // q = file_id._id
    if (q == null || q.length() <= 0) {
        response.setStatus(400);
        return;
    }

    long file_id = Long.parseLong(q);

    // DB에서 q로 검색
    String file_name = null;
    long file_key = -1, key_count = -1, owner = -1;
    try (Connection conn = DBConn.getConnection()) {
        // 지정된 키와 같은 파일 찾기
        String sql = "SELECT file_name, file_id, owner, " +
                "(SELECT COUNT(*) FROM file_id AS b WHERE b._id = a.file_id) AS key_count " +
                "FROM items AS a WHERE a._id = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setLong(1, file_id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            file_name = rs.getString("file_name");
            file_key = rs.getLong("file_id");
            key_count = rs.getLong("key_count");
            owner = rs.getLong("owner");
            if (rs.wasNull()) owner = -1;
        } else {
            response.setStatus(404);
        }
        rs.close();
        st.close();

        // 주인이 아니면 삭제 못함
        if (owner != -1) {
            Object uid_ = session.getAttribute("_id");
            if (uid_ != null) {
                Long uid = (Long) uid_;
                if (uid != owner) {
                    response.setStatus(401); // Unauthorized access
                    return;
                }
            }
        }

        // 찾은 파일이 있으면 DB 삭제
        sql = "delete from items where _id = ?";
        st = conn.prepareStatement(sql);
        st.setLong(1, file_id);
        st.executeUpdate();
        st.close();

        // 키가 하나 뿐이었으면 키도 삭제
        if (key_count == 1) {
            sql = "delete from file_id where _id = ?";
            st = conn.prepareStatement(sql);
            st.setLong(1, file_key);
            st.executeUpdate();
            st.close();
        }

        conn.commit();

        // 찾은 파일이 있으면 파일 삭제
        String filePath = "/g/jspUpload/" + file_name;
        File f = new File(filePath);
        if (f.exists()) {
            f.delete();
        }

        response.setStatus(200);

    } catch (SQLException throwables) {
        throwables.printStackTrace();
        response.setStatus(500);
    }
%>
