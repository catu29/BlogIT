<%-- 
    Document   : login
    Created on : Jun 2, 2020, 5:01:46 PM
    Author     : TranCamTu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login Result page</h1>
        <% session = request.getSession(true);
            boolean isLogined = false;
            isLogined = (Boolean) session.getAttribute("isLogined");
            
            if (isLogined) {
                out.println("Login succeeded");
            } else {
                out.println("Login failed");
            }
        %>
    </body>
</html>
