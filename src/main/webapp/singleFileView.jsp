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
    $(document).ready(function () {
        $('#btn-download').click(function () {
            document.getElementById('downloader').src = 'api/download.jsp?q=<%=fileKeys.get(0)%>'
        })
        $('#btn-copy-url').click(function () {
            let txt = document.getElementById('txt-copy-url')
            txt.select()
            txt.setSelectionRange(0, 99999)
            document.execCommand('copy')
            console.log('Copied')
        })

        let host = window.location.hostname
        let port = window.location.port
        let url = "http://" + host + ":" + port + "/demo_war/api/download.jsp?q=<%=fileKeys.get(0)%>"
        $('#txt-copy-url').val(url)

        // Set QRCode
        $('#img-qr').attr('src', './api/getQR.jsp?q=' + url)
    })
</script>
