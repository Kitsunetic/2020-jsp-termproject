<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.DBConn" %>
<%@ page import="utils.StringUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%
    String q = request.getParameter("q");

    ArrayList<Integer> itemIds = new ArrayList<>();
    ArrayList<String> fileNames = new ArrayList<>();
    ArrayList<Long> fileSizes = new ArrayList<>();

    // DB에서 파일 키 q에 해당하는 파일들 검색
    try (Connection conn = DBConn.getConnection()) {
        PreparedStatement st = null;
        st = conn.prepareStatement(
                "select a._id, a.file_name, a.file_size " +
                        "from items as a " +
                        "left join file_id as b on a.file_id = b._id " +
                        "where b.name = ? " +
                        "order by a.original_name ");
        st.setString(1, q);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            itemIds.add(rs.getInt("_id"));
            fileNames.add(rs.getString("file_name"));
            fileSizes.add(rs.getLong("file_size"));
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }

    boolean fileExist = itemIds.size() > 0;
    boolean onlyOneFile = itemIds.size() == 1;

    boolean alreadyLoggedIn = session.getAttribute("_id") != null;
    boolean uploadSucceeded = session.getAttribute("upload") != null;
    String uploadSucceededClass = "d-none";
    if (uploadSucceeded) {
        session.removeAttribute("upload");
        uploadSucceededClass = "";
    }
%>

<html>
<head>
    <title>
        <%=fileExist ? q : "텅~"%>
    </title>
    <%@include file="html/bootstrap4.html" %>

    <style>
        .col-filesize {
            width: 128px;
        }

        .col-qr {
            width: 64px;
        }

        .qr {
            cursor: pointer;
            color: black;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container text-center justify-content-center align-content-center py-md-5">
    <% if (fileExist) { %>

    <div class="row <%=uploadSucceededClass%>" id="success-message">
        <div class="col pb-2">
            <b style="color: gray">업로드 성공 !!</b>
        </div>
    </div>

    <% if (onlyOneFile) { %>
    <%-- =========================================== --%>
    <%--             파일이 한 개인 경우                 --%>
    <%-- =========================================== --%>
    <div class="row pt-2">
        <div class="col-md-6">
            <div class="row">
                <div class="col">
                    <img src="img/file.png">
                </div>
            </div>
            <div class="row">
                <div class="col d-inline">
                    <div class="d-inline">
                        <b>
                            <%=fileNames.get(0)%>
                        </b>
                        <button id="btn-download" class="btn btn-outline-primary ml-4">다운로드</button>
                        <iframe id="downloader" style="display: none"></iframe>
                    </div>
                    <div class="d-inline">
                        <p style="color: gray">
                            Size: <%=StringUtils.fileSizeToString(fileSizes.get(0))%>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="col">
                    <!-- QRCODE -->
                    <img id="img-qr" width="256" height="256" src="">
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="input-group pt-2 float-right" style="max-width: 500px">
                        <input type="text" id="txt-copy-url" class="form-control" name="file_id" readonly>
                        <div class="input-group-append">
                            <button id="btn-copy-url" class="btn btn-outline-secondary">복사</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('#btn-download').click(function () {
            document.getElementById('downloader').src = 'api/downloadw.jsp?q=<%=q%>'
        })
        $('#btn-copy-url').click(function () {
            let txt = document.getElementById('txt-copy-url')
            txt.select()
            txt.setSelectionRange(0, 99999)
            document.execCommand('copy')
            console.log('Copied')
        })
        $(document).ready(function () {
            let host = window.location.hostname
            let port = window.location.port
            let url = "http://" + host + ":" + port + "/demo_war/api/downloadw.jsp?q=<%=q%>"
            $('#txt-copy-url').val(url)

            // Set QRCode
            $.ajax({
                url: './api/getQR.jsp?q=' + url,
                success: function (data) {
                    let imgqr = $('#img-qr')
                    imgqr.attr('src', 'data:image/png;base64,' + data)
                }
            })
        })
    </script>

    <% } else { %>
    <%-- =========================================== --%>
    <%--             파일이 여러개인 경우                --%>
    <%-- =========================================== --%>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">파일 이름</th>
            <th scope="col" class="col-filesize">파일 용량</th>
            <th scope="col" class="col-qr">QR</th>
        </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < itemIds.size(); i++) { %>
        <tr>
            <th>
                <%=fileNames.get(i)%>
            </th>
            <th class="col-filesize">
                <%=StringUtils.fileSizeToString(fileSizes.get(i))%>
            </th>
            <th class="col-qr"><b>
                <a class="qr" data-toggle="tooltip" data-placement="top" file-id="<%=itemIds.get(i)%>">QR코드</a>
            </b></th>
        </tr>
        <% } %>
        </tbody>
    </table>

    <script>
        $(document).ready(function () {
            let host = window.location.hostname
            let port = window.location.port
            $('a.qr').each(function (index, item) {
                let filfId = item.getAttribute('file-id')
                let url = 'http://' + host + ':' + port + '/demo_war/api/download.jsp?q=' + filfId
                item.setAttribute('title', '<img src="./api/getQR.jsp?q=' + url + '"')
            })
        })
    </script>
    <% } %>
    <% } else { %>
    <%-- =========================================== --%>
    <%--             파일이 없는 경우                    --%>
    <%-- =========================================== --%>
    <img src="img/xjd.png">
    <div class="my-5"></div>
    <b style="color: gray">파일이 텅 비었 ... ㅠ _ T</b>
    <% } %>
</div>

</body>
</html>
