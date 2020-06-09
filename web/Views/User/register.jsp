<%-- 
    Document   : register
    Created on : Apr 28, 2020, 4:55:42 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    <jsp:attribute name="title">Create new account</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">
                <h1>Đăng ký tài khoản</h1>
                <form id="registerForm" action="" method="POST">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="fullname">Họ và tên:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname">
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Nhập lại mật khẩu:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                    </div>          
                    <button type="submit" class="primary-button">Đăng ký</button>
                </form>
            </div>
        </div>
    </jsp:body>    
</t:layout>
