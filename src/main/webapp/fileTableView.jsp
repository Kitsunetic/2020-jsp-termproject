<%--
Requirements:
    - fileCodes (ArrayList<String>)
    - fileOriginalNames (ArrayList<String>)
    - fileNames (ArrayList<String>)
    - fileSizes (ArrayList<Integer>)
    - showImageWhenEmpty (boolean)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.StringUtils" %>

<%
    boolean onlyOneFile = fileCodes.size() == 1;
%>

<style>
    .col-filesize {
        width: 128px;
    }

    .col-qr {
        width: 128px;
    }

    .mini-button {
        cursor: pointer;
        color: black;
    }
</style>

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
        document.getElementById('downloader').src = 'api/download.jsp?q=<%=fileCodes.get(0)%>'
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
        let url = "http://" + host + ":" + port + "/demo_war/api/download.jsp?q=<%=fileCodes.get(0)%>"
        $('#txt-copy-url').val(url)

        // Set QRCode
        $.ajax({
            url: './api/getQR.jsp?q=' + url,
            success: function (data) {
                let imgqr = $('#img-qr')
                imgqr.attr('src', data)
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
        <th scope="col" class="col-qr"></th>
    </tr>
    </thead>
    <tbody>
    <% for (int i = 0; i < fileCodes.size(); i++) { %>
    <tr id="item-<%=fileCodes.get(i)%>">
        <th>
            <a href="api/download.jsp?q=<%=fileCodes.get(i)%>" style="color: black">
                <%=fileOriginalNames.get(i)%>
            </a>
        </th>
        <th class="col-filesize">
            <%=StringUtils.fileSizeToString(fileSizes.get(i))%>
        </th>
        <th class="col-qr">
            <a class="qr mini-button" data-toggle="popover-toggle"
               title="" file-id="<%=fileCodes.get(i)%>">
                <img src="img/qrcode.png">
            </a>
            &nbsp;
            <a class="btn-delete mini-button" data-toggle="tooltip" title="Delete" code="<%=fileCodes.get(i)%>">
                <img src="img/delete.png">
            </a>
        </th>
    </tr>
    <% } %>
    </tbody>
</table>

<script>
    $(document).ready(function () {
        let host = window.location.hostname
        let port = window.location.port
        let qr = $('.qr')
        qr.each(function (index, item) {
            let filfId = item.getAttribute('file-id')
            let url = 'http://' + host + ':' + port + '/demo_war/api/download.jsp?q=' + filfId
            item.setAttribute('title', '<img src="api/getQR.jsp?q=' + url + '" />')
        })

        qr.tooltip({
            animated: 'fade',
            placement: 'left',
            html: true
        })
    })

    $('.btn-delete').click(function () {
        let code = $(this).attr('code')
        let url = './api/delete.jsp?q=' + code
        console.log(url)

        $.ajax({
            url: url,
            statusCode: {
                200: function () {
                    // 파일을 목록에서 제거
                    $('#item-' + code).remove()
                },
                401: function () {
                    // 오류 메세지
                    alert("파일의 주인만 파일을 삭제할 수 있습니다!!")
                },
                500: function () {
                    // 오류 메세지
                    alert("내부 오류")
                }
            }
        })
    })
</script>
<% } %>
