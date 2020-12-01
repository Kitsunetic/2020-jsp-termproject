<%--
  Created by IntelliJ IDEA.
  User: shim
  Date: 11/9/20
  Time: 5:33 PM

  파일 업로드 구현...
--%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //String uploadPath = request.getSession().getServletContext().getRealPath("/uploadFiles");
    String uploadPath = "/g/jspUpload";

    int maxSize = 1024 * 1024 * 10;
    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    // parameter 가져옴
    Enumeration files = multi.getFileNames();

    // DB 연결
    Connection conn = DBConn.getConnection();
    if (conn == null) {
        out.println("Cannot connect to database!!");
        return;
    }
    int user_id = Integer.parseInt((String) session.getAttribute("_id"));
    String sql = new StringBuilder()
            .append("insert into items ")
            .append("(owner, file_name, original_name, file_size) ")
            .append("vals (?, ?, ?, ?)").toString();
    PreparedStatement pstmt = conn.prepareStatement(sql);

    try {
        while (files.hasMoreElements()) {
            String fileElement = (String) files.nextElement();
            String originalName = multi.getOriginalFileName(fileElement);
            String fileName = multi.getFilesystemName(fileElement);
            //String fileType = multi.getContentType(fileElement);
            File file = multi.getFile(fileElement);
            long fileSize = file.length();

            // 파일 정보를 DB에 등록

            pstmt.setInt(1, user_id);
            pstmt.setString(2, fileName);
            pstmt.setString(3, originalName);
            pstmt.setLong(4, fileSize);
            pstmt.addBatch();
            pstmt.clearParameters();
        }

        pstmt.executeBatch();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>
