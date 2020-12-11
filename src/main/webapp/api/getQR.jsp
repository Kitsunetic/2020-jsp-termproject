<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="com.google.zxing.WriterException" %>

<%
    String q = request.getParameter("q");
    if (q == null || q.equals("") || !q.startsWith("http")) {
        return;
    }

    QRCodeWriter writer = new QRCodeWriter();
    String outString = null;

    try {
        BitMatrix qrCode = writer.encode(q, BarcodeFormat.QR_CODE, 200, 200);
        BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(qrCode);

        ByteArrayOutputStream os = new ByteArrayOutputStream();

        ImageIO.write(qrImage, "png", os);
        byte[] imageBytes = os.toByteArray();
        outString = Base64.getEncoder().encodeToString(imageBytes);
    } catch (WriterException e) {
        e.printStackTrace();
    }

    out.print("data:image/png;base64," + outString);
%>
