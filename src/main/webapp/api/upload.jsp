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
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //String uploadPath = request.getSession().getServletContext().getRealPath("/uploadFiles");
    String uploadPath = "/g/pds";

    int maxSize = 1024 * 1024 * 10;
    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    // parameter 가져옴
    String name = multi.getParameter("name");
    String subject = multi.getParameter("subject");
    Enumeration files = multi.getFileNames();

    ArrayList<String> fileNames = new ArrayList<>();

    while (files.hasMoreElements()) {
        String fileElement = (String) files.nextElement();
        String originalName = multi.getOriginalFileName(fileElement);
        String fileName = multi.getFilesystemName(fileElement);
        String fileType = multi.getContentType(fileElement);
        File file = multi.getFile(fileElement);
        long fileSize = file.length();

        fileNames.add(fileName);
    }
%>

<%for (String fileName : fileNames) {%>
<%=fileName%>
<%}%>
