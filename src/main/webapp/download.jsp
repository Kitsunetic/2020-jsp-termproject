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

<%
    request.setCharacterEncoding("UTF-8");

    String root = request.getSession().getServletContext().getRealPath("/");
    out.println(root);

    String filename = "amu.png";
    String filePath = root + "img/" + filename;

    File file = new File(filePath);
    InputStream ins = new FileInputStream(file);
    String client = request.getHeader("User-Agent");
    response.reset();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Description", "JSP Generated Data");

    // IE
    if (client.contains("MSIE")) {
        String fname = new String(filename.getBytes("KSC5601"), "ISO8859_1");
        response.setHeader("Content-Disposition", "attachment; filename=" + fname);
    } else {
        String fname = new String(filename.getBytes("UTF-8"), "ISO_8859_1");
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
