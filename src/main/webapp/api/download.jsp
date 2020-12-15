<%--
  Created by IntelliJ IDEA.
  User: shim
  Date: 11/9/20
  Time: 5:10 PM

  파일 다운로드 구현...
  참조: https://fruitdev.tistory.com/48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="utils.Encryption" %>

<%
    request.setCharacterEncoding("UTF-8");
    String q = request.getParameter("q"); // q = file_id._id
    if (q == null || q.length() <= 0) {
        response.setStatus(400);
        return;
    }
    long fileKey = Long.parseLong(q);
    String pw = request.getParameter("pw"); // 유저 비밀번호가 아니라 파일 비밀번호임
    String pw_enc = Encryption.sha256(pw);

    // DB에서 q로 검색
    String original_name = null;
    String file_name = null;
    long owner = -1;
    boolean owner_only = false;
    String password = null;
    try (Connection conn = DBConn.getConnection()) {
        String sql = "select original_name, file_name, owner, owner_only, password from items where _id = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setLong(1, fileKey);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            original_name = rs.getString("original_name");
            file_name = rs.getString("file_name");
            owner = rs.getLong("owner");
            if (rs.wasNull()) owner = -1;
            owner_only = rs.getBoolean("owner_only");
            password = rs.getString("password");
        } else {
            response.setStatus(404);
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
        response.setStatus(500);
    }

    // 파일 경로 설정 오류
    if (original_name == null || file_name == null) {
        response.setStatus(500);
        return;
    }

    // 비밀번호 체크
    if (password != null && !password.equals(pw_enc)) {
        response.setStatus(403);
        return;
    }

    // owner 체크
    if (owner_only) {
        Object currentUser_ = session.getAttribute("_id");
        if (currentUser_ == null) {
            response.setStatus(500);
            return;
        }

        // owner가 다름
        long currentUser = (Long) currentUser_;
        if (owner != -1 && owner != currentUser) {
            response.setStatus(403);
            return;
        }
    }

    String filePath = "/g/jspUpload/" + file_name;
    File file = new File(filePath);
    InputStream ins = new FileInputStream(file);
    String client = request.getHeader("User-Agent");
    response.reset();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Description", "JSP Generated Data");

    // IE
    if (client.contains("MSIE")) {
        String fname = new String(original_name.getBytes("KSC5601"), "ISO8859_1");
        response.setHeader("Content-Disposition", "attachment; filename=" + fname);
    } else {
        String fname = new String(original_name.getBytes("UTF-8"), "ISO_8859_1");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fname + "\"");
        response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
    }

    response.setHeader("Content-Length", "" + file.length());

    OutputStream os = response.getOutputStream();
    byte b[] = new byte[(int) file.length()];
    int len = 0;

    while ((len = ins.read(b)) > 0) {
        os.write(b, 0, len);
    }

    ins.close();
    os.close();
%>
