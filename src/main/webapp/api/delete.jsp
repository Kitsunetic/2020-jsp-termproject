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

    int file_id = Integer.parseInt(q);

    // DB에서 q로 검색
    String file_name = null;
    int file_key = -1, key_count = -1, owner = -1;
    try (Connection conn = DBConn.getConnection()) {
        // 지정된 키와 같은 파일 찾기
        String sql = "SELECT a.file_name, a.file_id, a.owner, " +
                "(SELECT COUNT(*) FROM items AS b WHERE b.file_id = a.file_id) AS key_count " +
                "FROM items AS a WHERE a._id = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, file_id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            file_name = rs.getString("file_name");
            file_key = rs.getInt("file_id");
            key_count = rs.getInt("key_count");
            owner = rs.getInt("owner");
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
                int uid = Integer.parseInt((String) uid_);
                if (uid != owner) {
                    response.setStatus(401); // Unauthorized access
                    return;
                }
            }
        }

        // 찾은 파일이 있으면 DB 삭제
        System.out.println("Delete items " + file_id);
        sql = "DELETE FROM items WHERE _id = ?";
        st = conn.prepareStatement(sql);
        st.setLong(1, file_id);
        st.executeUpdate();
        st.close();

        // 키가 하나 뿐이었으면 키도 삭제
        if (key_count == 1) {
            System.out.println("Delete key " + file_key);
            sql = "DELETE FROM file_id WHERE _id = ?";
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
