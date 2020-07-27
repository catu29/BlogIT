<%-- 
    Document   : register
    Created on : Apr 28, 2020, 4:55:42 PM
    Author     : Tin Bui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<c:set var="isExisting" value="${requestScope.isExisting}" />
<c:set var="userDTO" value="${requestScope.userDTO}" />
<c:set var="confirmPassword" value="${requestScope.confirmPassword}" />
<c:set var="isInvalid" value="${requestScope.isInvalid}" />
<c:set var="message" value="${requestScope.message}" />


<t:layout>
    <jsp:attribute name="title">Create new account</jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">               
                <h1>Đăng ký tài khoản</h1>
                <p style="color: red;"><c:out value="${message}" /></p>
                <form id="registerForm" action="" method="POST">                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="${userDTO.email}" required
                               oninvalid="this.setCustomValidity('Trường không được để trống.')">
                        <p style="color: red;">
                            <c:choose>
                                <c:when test="${isExisting == true}">
                                    <c:out value="Email đã tồn tại"/>  
                                </c:when>
                                <c:when test="${empty userDTO.email && isInvalid}">
                                    <c:out value="Trường không được để trống"/>
                                </c:when>
                            </c:choose>
                        </p>
                    </div>
                    <div class="form-group">
                        <label for="fullname">Họ và tên:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" value="${userDTO.fullname}" required>
                        <p style="color: red;">    
                            <c:if test="${empty userDTO.fullname && isInvalid}">
                                <c:out value="Trường không được để trống"/>
                            </c:if>
                        </p>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" class="form-control" id="password" name="password" value="${userDTO.password}" required>
                        <p style="color: red;">
                            <c:if test="${empty userDTO.password && isInvalid}">
                                <c:out value="Trường không được để trống"/>
                            </c:if>
                        </p>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Nhập lại mật khẩu:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" value="${confirmPassword}" required>
                        <p style="color: red;">
                            <c:choose>
                                <c:when test="${empty confirmPassword && isInvalid}">
                                    <c:out value="Trường không được để trống"/>  
                                </c:when>
                                <c:when test="${userDTO.password != confirmPassword && isInvalid}">
                                    <c:out value="Mật khẩu xác nhận chưa đúng"/>
                                </c:when>
                            </c:choose>
                        </p>
                    </div>          
                    <button type="submit" class="primary-button">Đăng ký</button>
                </form>
            </div>
        </div>
    </jsp:body>    
</t:layout>
