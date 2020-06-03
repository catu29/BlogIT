<%-- 
    Document   : register
    Created on : Apr 28, 2020, 4:55:42 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Create new account</jsp:attribute>
    <jsp:body>
        <h1>Đăng ký tài khoản</h1>
        <form id="registerForm" action="" method="POST">
            <label>Email: </label></br>
            <input type="text" name="username"></br>
            <label>Họ và tên: </label></br>
            <input type="text" name="fullname"></br>
            <label>Mật khẩu: </label></br>
            <input type="password" name="password"></br>
            <label>Nhập lại mật khẩu: </label></br>
            <input type="password" name="repassword"></br>            
            <input type="submit" name="btnSubmit" value="Đăng ký">
        </form>
    </jsp:body>    
</t:layout>
