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

    // parameter 가져옴
    Enumeration files = multi.getFileNames();
    String file_id = multi.getParameter("file_id");
    if (file_id == null || file_id.length() >= 36 || file_id.length() <= 0) {
        response.sendRedirect("../index.jsp?result=400");
        return;
    }

    // DB 연결
    Connection conn = DBConn.getConnection();
    if (conn == null) {
        out.println("Cannot connect to database!!");
        return;
    }
    Object s_user_id = session.getAttribute("_id");
    int user_id = -1;
    if (s_user_id != null) {
        user_id = Integer.parseInt((String) s_user_id);
    }

    try {
        // 사용가능한 file_id인지 확인
        PreparedStatement stmt = conn.prepareStatement("select _id from file_id where name=?");
        stmt.setString(1, file_id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            response.sendRedirect("../index.jsp?result=401");
            return;
        }

        // file_id 생성
        stmt = conn.prepareStatement("insert into file_id (name) values (?)", Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, file_id);
        stmt.executeUpdate();
        rs = stmt.getGeneratedKeys();
        int file_id_num = 0;
        if (rs.next()) {
            file_id_num = rs.getInt(1);
        } else {
            response.sendRedirect("../index.jsp?result=401");
            return;
        }

        /*
        stmt = conn.prepareStatement("select _id from file_id where name=?");
        stmt.setString(1, file_id);
        rs = stmt.executeQuery();
        int file_id_num = rs.getInt("_id");
        */

        // items 생성
        String sql2 = new StringBuilder()
                .append("insert into items ")
                .append("(owner, file_id, file_name, original_name, file_size) ")
                .append("values (?, ?, ?, ?, ?)").toString();
        PreparedStatement pstmt2 = conn.prepareStatement(sql2);

        boolean noFile = true;

        while (files.hasMoreElements()) {
            String fileElement = (String) files.nextElement();
            String originalName = multi.getOriginalFileName(fileElement);
            String fileName = multi.getFilesystemName(fileElement);
            //String fileType = multi.getContentType(fileElement);
            File file = multi.getFile(fileElement);
            long fileSize = file.length();

            // 파일 정보를 DB에 등록
            if (user_id == -1) pstmt2.setNull(1, Types.INTEGER);
            else pstmt2.setInt(1, user_id);
            pstmt2.setInt(2, file_id_num);
            pstmt2.setString(3, fileName);
            pstmt2.setString(4, originalName);
            pstmt2.setLong(5, fileSize);
            pstmt2.addBatch();
            pstmt2.clearParameters();

            noFile = false;
        }

        pstmt2.executeBatch();
        conn.commit();

        if (noFile) {
            response.sendRedirect("../index.jsp?result=403");
        } else {
            response.sendRedirect("../index.jsp?result=200&file_id=" + file_id);
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
        response.sendRedirect("../index.jsp?result=404");
    }
%>
