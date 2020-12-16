<%--
Requirements:
    - fileKeys (ArrayList<Integer>)
    - fileCodes (ArrayList<String>)
    - fileOriginalNames (ArrayList<String>)
    - fileNames (ArrayList<String>)
    - fileSizes (ArrayList<Integer>)
    - showImageWhenEmpty (boolean)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.StringUtils" %>

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

<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">파일 이름</th>
        <th scope="col" class="col-filesize">파일 코드</th>
        <th scope="col" class="col-filesize">파일 용량</th>
        <th scope="col" class="col-qr"></th>
    </tr>
    </thead>
    <tbody>
    <% for (int i = 0; i < fileKeys.size(); i++) { %>
    <tr id="item-<%=fileKeys.get(i)%>">
        <th>
            <a href="api/download.jsp?q=<%=fileKeys.get(i)%>" style="color: black">
                <%=fileOriginalNames.get(i)%>
            </a>
        </th>
        <th class="col-filesize">
            <%=fileCodes.get(i)%>
        </th>
        <th class="col-filesize">
            <%=StringUtils.fileSizeToString(fileSizes.get(i))%>
        </th>
        <th class="col-qr">
            <a class="qr mini-button" data-toggle="popover-toggle"
               title="" file-id="<%=fileKeys.get(i)%>">
                <img src="img/qrcode.png">
            </a>
            &nbsp;
            <a class="btn-delete mini-button" data-toggle="tooltip" title="Delete" code="<%=fileKeys.get(i)%>">
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
