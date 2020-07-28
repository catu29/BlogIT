<%-- 
    Document   : index
    Created on : May 4, 2020, 12:07:18 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ</title>
    </head>
    <body>
        <% response.sendRedirect(getServletContext().getContextPath() + "/home"); %>
    </body>
</html>
