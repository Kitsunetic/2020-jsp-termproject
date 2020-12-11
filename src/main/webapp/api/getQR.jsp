<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="com.google.zxing.WriterException" %>
<%@ page import="java.io.OutputStream" %>

<%
    String q = request.getParameter("q");
    if (q == null || q.equals("") || !q.startsWith("http")) {
        return;
    }

    QRCodeWriter writer = new QRCodeWriter();

    try {
        BitMatrix qrCode = writer.encode(q, BarcodeFormat.QR_CODE, 200, 200);
        BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(qrCode);

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(qrImage, "png", bos);
        byte[] imageBytes = bos.toByteArray();

        OutputStream os = response.getOutputStream();

        response.reset();
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Description", "JSP Generated Data");
        response.setHeader("Content-Disposition", "attachment; filename=qr.png");
        response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
        response.setHeader("Content-Length", "" + imageBytes.length);
        os.write(imageBytes);
    } catch (WriterException e) {
        e.printStackTrace();
    }
%>
