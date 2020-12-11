<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.concurrent.Callable" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String uploadPath = "/g/jspUpload";

    int maxSize = 1024 * 1024 * 10;
    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    Enumeration files = multi.getFileNames();
    String file_id = multi.getParameter("file_id");
    if (file_id == null || file_id.length() >= 36 || file_id.length() <= 0) {
        response.sendRedirect("../index.jsp?result=400");
        return;
    }

    Object s_user_id = session.getAttribute("_id");
    int user_id = -1;
    if (s_user_id != null) {
        user_id = Integer.parseInt((String) s_user_id);
    }

    int _id = -1;

    // DB 연결
    try (Connection conn = DBConn.getConnection()) {
        // 이미 등록되어있는 file_id인지 확인
        String sql = "select _id from file_id where name=?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, file_id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            _id = rs.getInt(1);
        }

        // file_id 생성
        if (_id != -1) {
            sql = "insert into file_id (name) values (?)";
            st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, file_id);
            st.executeUpdate();
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                _id = rs.getInt(1);
            } else {
                response.sendRedirect("../index.jsp");
                return;
            }
        }

        // items 생성
        sql = "insert into items " +
                "(owner, file_id, file_name, original_name, file_size) " +
                "values (?, ?, ?, ?, ?)";
        st = conn.prepareStatement(sql);
        boolean noFile = true;

        while (files.hasMoreElements()) {
            String fileElement = (String) files.nextElement();
            String originalName = multi.getOriginalFileName(fileElement);
            String fileName = multi.getFilesystemName(fileElement);
            //String fileType = multi.getContentType(fileElement);
            File file = multi.getFile(fileElement);
            long fileSize = file.length();

            // 파일 정보를 DB에 등록
            if (user_id == -1) st.setNull(1, Types.INTEGER);
            else st.setInt(1, user_id);
            st.setInt(2, _id);
            st.setString(3, fileName);
            st.setString(4, originalName);
            st.setLong(5, fileSize);
            st.addBatch();
            st.clearParameters();

            noFile = false;
        }

        st.executeBatch();
        conn.commit();

        assert noFile;
        
        session.setAttribute("upload", 1);
        response.sendRedirect("../fileForm.jsp?q=" + file_id);
    } catch (SQLException throwables) {
        throwables.printStackTrace();
        session.setAttribute("uploadFailed", 1);
        response.sendRedirect("../index.jsp");
    }
%>
