<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.DBConn" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%
    String q_ = request.getParameter("q");
    if (q_ == null || q_.length() == 0) {
        response.sendRedirect("sorry.jsp");
        System.out.print("[filePasswordInputForm.jsp] Illegal file id: ");
        System.out.println(q_);
        return;
    }
    int q = Integer.parseInt(q_);

    String name = null;
    try (Connection conn = DBConn.getConnection()) {
        String sql = "SELECT original_name FROM items WHERE _id = ? LIMIT 1";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, q);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            name = rs.getString("original_name");
        } else {
            response.sendRedirect("sorry.jsp");
            System.out.print("[filePasswordInputForm.jsp] Unknown file id: ");
            System.out.println(q_);
            return;
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
        response.sendRedirect("sorry.jsp");
        return;
    }
%>
<html>
<head>
    <title>Input Password</title>
    <%@include file="html/bootstrap4.html" %>
</head>
<body>
<div class="pt-5"></div>
<div class="container">
    <h4><%=name%></h4>
    <form action="api/download.jsp" method="post">
        <input type="hidden" name="q" value="<%=q%>">
        <div class="input-group">
            <input type="password" class="form-control" placeholder="Password">
        </div>
        <div class="input-group float-right pt-1" style="max-width: 200px">
            <button type="submit" class="form-control btn btn-primary">Submit</button>
        </div>
    </form>
</div>
</body>
</html>
