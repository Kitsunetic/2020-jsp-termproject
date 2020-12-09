<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="javax.imageio.ImageIO" %>

<%
    // POST. 다운로드 URL, 직접 다운로드 URL 받기


    // QRCODE 생성
    QRCodeWriter writer = new QRCodeWriter();
    BitMatrix qrCode = writer.encode();

    // QRCODE를 이미지로 표시
    BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(qrCode);
    ImageIO.write(qrImage, "PNG", new File()); // 어딘가에 파일로 저장


%>


<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
